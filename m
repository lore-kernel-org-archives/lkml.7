Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9CAFC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 06:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8950B2070D
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 06:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEFjcIr+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfCMGmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 02:42:38 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:45721 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfCMGmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 02:42:37 -0400
Received: by mail-yw1-f68.google.com with SMTP id r188so539060ywb.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 23:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ebpiJgvlhqvcNtW6hg58h6gWxH/SKgRPsgHGklpT0Qg=;
        b=EEFjcIr+lwfd1Cx4pjnT1EtEi8PARJhMTqsIZKBxkN+m0X070i0faGadPIcZIKNafz
         PoE8PEYBMme5n9glPItiAHV0BiNjSxTEWHLJP1JjpgdVUgP0qfyKwDUF20wlwciGfJl1
         jPDtVtvEH7UIhx9gb3H3esJUXWOhu2X9vvW3ZIpKB1FGeJwHM5a5hM4vGSWxcwaWamjc
         ojokiqD3oHRtf+7r74rguxyJ3zqFByHYyURp/a4rc0QIfNZ/5BjgOEB+HtttfJUmOmm4
         /N4WF3xPNp7TsaoQyQEIfFFehqrjV8jcOzD7lmpc29N4vpjav6EZzJnSZm4z6ybd4dDF
         iDFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ebpiJgvlhqvcNtW6hg58h6gWxH/SKgRPsgHGklpT0Qg=;
        b=ECMgvERvQ32MzAo5Q1KeVD4a5c5vXpbPt0zoTfCpuU0zWOMVN/k0j5LPgz4Wj9R9S2
         TEgQMgCDx8YjZBRrkSXRkPonuJcnIGcOHFNXQ5qRn3n2TIsu6QOSfbAnOgST10uxArgs
         sXB59kefsz/fYu/2Rr1BhiUUAB6wHbzNIwllYLFUtFfukUff9fTLlx6DfUGg5yCioEZW
         TrPl9OCgkovoe7SbwCDSDl//zVO+CWJngr4DPh6m37eZNhPmhpEkFXqgEgKxFX8IImsE
         Zk+s5S4uUMK8ZOJRNPDiYAlMLn+9OudVg5CP6Bp7PcI+GLtdgjJvNGimPAmLyEG6SCac
         tlHQ==
X-Gm-Message-State: APjAAAVvR96Kcrxt3qVIasGf09ZKH0yZkj0F+KTeHA/nltXgFknBwxXA
        s+xN6NgJ6CFvO6kzSALxHHGmKAsENk7/LDlXbio=
X-Google-Smtp-Source: APXvYqwQeGKKSYay1hQBMGZoL/nZ9eWqlMHPqwQLiC+Fn1ydNPDfN9i3J7vyKAUj2qiz70vUnuQGcP96J1k9gw+CS0k=
X-Received: by 2002:a25:4643:: with SMTP id t64mr36139215yba.462.1552459356096;
 Tue, 12 Mar 2019 23:42:36 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000016f7d40583d79bd9@google.com> <CAGXu5jKjWwYk5N3mOH1A8fXX_0BT3r1At_3MzN9M+Ckg5irKXg@mail.gmail.com>
In-Reply-To: <CAGXu5jKjWwYk5N3mOH1A8fXX_0BT3r1At_3MzN9M+Ckg5irKXg@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 13 Mar 2019 08:42:25 +0200
Message-ID: <CAOQ4uxgQf=-swzH_D6cXofXSwXdnpEUsYZ-5q2a_fOZZJy5oRQ@mail.gmail.com>
Subject: Re: WARNING: bad usercopy in fanotify_read
To:     Kees Cook <keescook@chromium.org>
Cc:     syzbot <syzbot+2c49971e251e36216d1f@syzkaller.appspotmail.com>,
        Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>, cai@lca.pw,
        Chris von Recklinghausen <crecklin@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 8:26 AM Kees Cook <keescook@chromium.org> wrote:
>
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
>
> Maybe something like this (untested):

I tested. Patch is fine by me with minor nit.
You may add:
Reviewed-by: Amir Goldstein <amir73il@gmail.com>


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

Prefer <= FANOTIFY_INLINE_FH_LEN

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
