Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC64C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 14:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ED3F2087C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 14:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfCMOfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 10:35:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:46188 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726125AbfCMOfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 10:35:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3427DAD55;
        Wed, 13 Mar 2019 14:35:04 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 8490A1E3FE8; Wed, 13 Mar 2019 15:35:03 +0100 (CET)
Date:   Wed, 13 Mar 2019 15:35:03 +0100
From:   Jan Kara <jack@suse.cz>
To:     Kees Cook <keescook@chromium.org>
Cc:     syzbot <syzbot+2c49971e251e36216d1f@syzkaller.appspotmail.com>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>, cai@lca.pw,
        Chris von Recklinghausen <crecklin@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: WARNING: bad usercopy in fanotify_read
Message-ID: <20190313143503.GD9108@quack2.suse.cz>
References: <00000000000016f7d40583d79bd9@google.com>
 <CAGXu5jKjWwYk5N3mOH1A8fXX_0BT3r1At_3MzN9M+Ckg5irKXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jKjWwYk5N3mOH1A8fXX_0BT3r1At_3MzN9M+Ckg5irKXg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 12-03-19 23:26:22, Kees Cook wrote:
> On Mon, Mar 11, 2019 at 1:42 PM syzbot
> <syzbot+2c49971e251e36216d1f@syzkaller.appspotmail.com> wrote:
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17ee410b200000
> > [...]
> > ------------[ cut here ]------------
> > Bad or missing usercopy whitelist? Kernel memory exposure attempt detected
> > from SLAB object 'fanotify_event' (offset 40, size 8)!
> > [...]
> >   copy_to_user include/linux/uaccess.h:151 [inline]
> >   copy_fid_to_user fs/notify/fanotify/fanotify_user.c:236 [inline]
> >   copy_event_to_user fs/notify/fanotify/fanotify_user.c:294 [inline]
> 
> Looks like this is the fh/ext_fh union in struct fanotify_fid, field
> "fid" in struct fanotify_event. Given that "fid" is itself in a union
> against a struct path, I think instead of a whitelist using
> KMEM_CACHE_USERCOPY(), this should just use a bounce buffer to avoid
> leaving a whitelist open for path or ext_fh exposure.

Do you mean to protect it from a situation when some other code (i.e. not
copy_fid_to_user()) would be tricked into copying ext_fh containing slab
pointer to userspace?

								Honza

> 
> Maybe something like this (untested):
> 
> diff --git a/fs/notify/fanotify/fanotify_user.c
> b/fs/notify/fanotify/fanotify_user.c
> index 56992b32c6bb..b87da9580b3c 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -207,6 +207,7 @@ static int process_access_response(struct
> fsnotify_group *group,
>  static int copy_fid_to_user(struct fanotify_event *event, char __user *buf)
>  {
>         struct fanotify_event_info_fid info = { };
> +       unsigned char bounce[FANOTIFY_INLINE_FH_LEN], *fh;
>         struct file_handle handle = { };
>         size_t fh_len = event->fh_len;
>         size_t len = fanotify_event_info_len(event);
> @@ -233,7 +234,18 @@ static int copy_fid_to_user(struct fanotify_event
> *event, char __user *buf)
> 
>         buf += sizeof(handle);
>         len -= sizeof(handle);
> -       if (copy_to_user(buf, fanotify_event_fh(event), fh_len))
> +
> +       /*
> +        * For an inline fh, copy through stack to exclude the copy from
> +        * usercopy hardening protections.
> +        */
> +       fh = fanotify_event_fh(event);
> +       if (fh_len <= sizeof(bounce)) {
> +               memcpy(bounce, fh, fh_len);
> +               fh = bounce;
> +       }
> +
> +       if (copy_to_user(buf, fh, fh_len))
>                 return -EFAULT;
> 
>         /* Pad with 0's */
> 
> 
> -- 
> Kees Cook
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
