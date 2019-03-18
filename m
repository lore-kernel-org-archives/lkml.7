Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE853C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 18:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 747B520811
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 18:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LMDKVKJk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbfCRS13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 14:27:29 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:39189 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbfCRS12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 14:27:28 -0400
Received: by mail-ua1-f67.google.com with SMTP id m11so2657769uad.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 11:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PuCt0PzUD5fbqjENB8IuxZ3dh4ClcFnedV0Eb6S5Bu0=;
        b=LMDKVKJkAJCEfVXUtZx8wKZPJF4T0ITB1guKXbjJsIWiI/S+O0f0QMBmDfTodm/0Z8
         5TzWTjY5DiccDr6mG6FegSzV6lLOw9cvkO2LrEMffbQtyICuuUE2RK/wjlAsasxN5jy+
         efUFUGnrapbA1y0mFC25azVdfLJCFeJf+6FDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PuCt0PzUD5fbqjENB8IuxZ3dh4ClcFnedV0Eb6S5Bu0=;
        b=fx5fH0W2V4oqoY3Lx1hUfFGUKAnSlu0Bh9DvPNCBzlIXwxp5jbrPLzGqnT/6vNnxBn
         lhDRv9kbRiGTPL0EP5F+WawESuOjo6tOtvSDGabiP21IC1EWINgcOHE1V4cB/uH/StEA
         Iuq2p6SEaDtlJD2FPbDjhRWOvr1tX6KNJQ25SMuga6hY9GJZkJl9NsDIY1Mz9LOOGoL9
         OLRoRBT5/x9oJDhZRcTSVX5KVCR+8J3UBNbXtdh0Rx1wldTZLlFqId1/1J/vARaR0lk/
         2Db2qMw997qQlyFGZVVnSmYlqAOjVK+dMtenFw1ka/sC6UPwHO9arCut0asbJlApsdRP
         FWMA==
X-Gm-Message-State: APjAAAW8hzuCWFUbFnw/0R6fBM74Aj7EOpwjgkGptxpDaPhNOSEhtr7X
        VeCK2bx/TOQzlyvB5KmVrKvL/UsRWbY=
X-Google-Smtp-Source: APXvYqyUjcZEMd79d7oIf3IPkQe5oiz6FZdSRPgTvJIVsRECNvqCZVcjPJhSnBUi1I4yaA+G6lZi1A==
X-Received: by 2002:ab0:152e:: with SMTP id o43mr6673648uae.101.1552933646669;
        Mon, 18 Mar 2019 11:27:26 -0700 (PDT)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id l14sm6673311vke.54.2019.03.18.11.27.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 11:27:25 -0700 (PDT)
Received: by mail-vs1-f47.google.com with SMTP id e126so9885483vse.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 11:27:25 -0700 (PDT)
X-Received: by 2002:a67:89c9:: with SMTP id l192mr9663718vsd.188.1552933645049;
 Mon, 18 Mar 2019 11:27:25 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000016f7d40583d79bd9@google.com> <CAGXu5jKjWwYk5N3mOH1A8fXX_0BT3r1At_3MzN9M+Ckg5irKXg@mail.gmail.com>
 <20190313143503.GD9108@quack2.suse.cz> <CAGXu5j+_Ao_CU8DG9nrTbx5ioDkJUFw0cGcLBMWnvNLe_eFJ4A@mail.gmail.com>
 <20190313154712.GJ9108@quack2.suse.cz>
In-Reply-To: <20190313154712.GJ9108@quack2.suse.cz>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 18 Mar 2019 11:27:12 -0700
X-Gmail-Original-Message-ID: <CAGXu5jK2cOTm=Ds_NXaCFB4i1d2d0agirHKpshy8q_2KycdnJQ@mail.gmail.com>
Message-ID: <CAGXu5jK2cOTm=Ds_NXaCFB4i1d2d0agirHKpshy8q_2KycdnJQ@mail.gmail.com>
Subject: Re: WARNING: bad usercopy in fanotify_read
To:     Jan Kara <jack@suse.cz>
Cc:     syzbot <syzbot+2c49971e251e36216d1f@syzkaller.appspotmail.com>,
        Amir Goldstein <amir73il@gmail.com>,
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

On Wed, Mar 13, 2019 at 8:47 AM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 13-03-19 08:35:33, Kees Cook wrote:
> > On Wed, Mar 13, 2019 at 7:35 AM Jan Kara <jack@suse.cz> wrote:
> > > On Tue 12-03-19 23:26:22, Kees Cook wrote:
> > > > On Mon, Mar 11, 2019 at 1:42 PM syzbot
> > > > <syzbot+2c49971e251e36216d1f@syzkaller.appspotmail.com> wrote:
> > > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17ee410b200000
> > > > > [...]
> > > > > ------------[ cut here ]------------
> > > > > Bad or missing usercopy whitelist? Kernel memory exposure attempt detected
> > > > > from SLAB object 'fanotify_event' (offset 40, size 8)!
> > > > > [...]
> > > > >   copy_to_user include/linux/uaccess.h:151 [inline]
> > > > >   copy_fid_to_user fs/notify/fanotify/fanotify_user.c:236 [inline]
> > > > >   copy_event_to_user fs/notify/fanotify/fanotify_user.c:294 [inline]
> > > >
> > > > Looks like this is the fh/ext_fh union in struct fanotify_fid, field
> > > > "fid" in struct fanotify_event. Given that "fid" is itself in a union
> > > > against a struct path, I think instead of a whitelist using
> > > > KMEM_CACHE_USERCOPY(), this should just use a bounce buffer to avoid
> > > > leaving a whitelist open for path or ext_fh exposure.
> > >
> > > Do you mean to protect it from a situation when some other code (i.e. not
> > > copy_fid_to_user()) would be tricked into copying ext_fh containing slab
> > > pointer to userspace?
> >
> > Yes. That's the design around the usercopy hardening. The
> > "whitelisting" is either via code (with a bounce buffer, so only the
> > specific "expected" code path can copy it), with a
> > kmem_create_usercopy() range marking (generally best for areas that
> > are not unions or when bounce buffers would be too big/slow), or with
> > implicit whitelisting (via a constant copy size that cannot change at
> > run-time, like: copy_to_user(dst, src, 6)).
> >
> > In this case, since there are multiple unions in place and
> > FANOTIFY_INLINE_FH_LEN is small, it seemed best to go with a bounce
> > buffer.
>
> OK, makes sense. I'll replace tha patch using kmem_create_usercopy() in my
> tree with a variant you've suggested.

Thanks! If you're able to update the patch, it would be nice to include:

Reported-by: syzbot+2c49971e251e36216d1f@syzkaller.appspotmail.com
Fixes: a8b13aa2 ("fanotify: enable FAN_REPORT_FID init flag")

Regardless, I'll flag the fix for syzbot:

#syz fix: fanotify: Allow copying of file handle to userspace

-- 
Kees Cook
