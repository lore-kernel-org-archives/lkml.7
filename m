Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD38FC5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 15:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D45C21848
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 15:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iXsO6yva"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731993AbfKFPdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 10:33:24 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:41765 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727345AbfKFPdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 10:33:24 -0500
Received: by mail-qv1-f66.google.com with SMTP id g18so1573600qvp.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 07:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zdno54+YrnAis2IfaLsHue6J0VhFxBM3FnDvV7pWPE0=;
        b=iXsO6yva0aQZuX4+y9BQ7GZSJYcllIFyCdyEQ+l7gHjC4BzR1seiva0AMKvEye11VM
         2v108y0tDdwffVHSNTuDS5sgUowcAVOHrjbokW2Ve1V936IfXcW/6Nnu/seNTsntGB5O
         VFIqon8WatW0MXEXrc2nocVfBM8DeEr/oCWMoy8tAnOAOS9Errt/BWfx6hJE2+7Z2v1I
         jFUph1pn5NaZkSpXREX7oxCb4siXnY7OEV4983VXJWvu769VI3eGrUcZR3/D7Cvne9Ne
         vFDkEZmbEKMIaISAxO0ffPp/5qbBRJGzHpEPnhIE0F87jguXcOm2DOv33KLfZobGf0y/
         ZtdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zdno54+YrnAis2IfaLsHue6J0VhFxBM3FnDvV7pWPE0=;
        b=EgndqXWRBNXX+aEvubm8d1Cuq0BEKJqEY8kZDhnf206Rfy0cTSfgrA0VeeS61WDrDP
         xv7mcQyllkLVQLLpWvHEft5aIKYkfPHUL/MdXZM5Zoh/BS3UQ/zDtI04u4/DRZNMZi7Y
         tytZ1Tc8okp7ZSmLJeQ6WWuGhJTuuflsdFDB2Dv5J4NwmclYTiRMA+G3b8BlP0iIXVYL
         NYsxpdhG4p95orr/SMnyHmEEeJBFNrOwG0q40xlEBYjtMMQeim7OHVSQ7G0Lwr6h6c+B
         EHSB+/CtEjtgjoJrds8W/2dUi71o2+gClJkhI2C3mH5Nk6dCBodk9mT7fBtwzrMXrj8N
         Jbvw==
X-Gm-Message-State: APjAAAUC04EtsSHid0bcYqpPwCBV+L8zr/fS6L2Zc6nGVaA2Yyr2Ho6f
        SjSyt+0LNWA9kw2yf0f7QFD/ZEIvCDdjWoAidOCt7A==
X-Google-Smtp-Source: APXvYqyLSem31h83DgUIYvdHHQeKGyX/qiJCt7AlY4nkLyEIHADw27IRWEXv92THikVCLb+PUsaN/wYsMyEz7dLBjDM=
X-Received: by 2002:a0c:b064:: with SMTP id l33mr2823588qvc.34.1573054402522;
 Wed, 06 Nov 2019 07:33:22 -0800 (PST)
MIME-Version: 1.0
References: <000000000000b2de3a0594d8b4ca@google.com> <00000000000012ff570596af15cc@google.com>
 <CAKMK7uFQt+=7XMo9jvz77QvDWLAAU_V7-_qZ=iKe-GXG7cqeJg@mail.gmail.com> <CAKMK7uEeQnxMXeyMTvqJ-8H3wFeSexkbL1OJ0oJeUoep=YXcVg@mail.gmail.com>
In-Reply-To: <CAKMK7uEeQnxMXeyMTvqJ-8H3wFeSexkbL1OJ0oJeUoep=YXcVg@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 6 Nov 2019 16:33:11 +0100
Message-ID: <CACT4Y+b1yx9cYAtedSv+D4utu+MF_3uJt5oKmcQs7qDBrPx2=w@mail.gmail.com>
Subject: Re: WARNING in drm_mode_createblob_ioctl
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     syzbot <syzbot+fb77e97ebf0612ee6914@syzkaller.appspotmail.com>,
        Dave Airlie <airlied@linux.ie>,
        Andrew Morton <akpm@linux-foundation.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 6, 2019 at 4:28 PM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Wed, Nov 6, 2019 at 4:23 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> >
> > On Wed, Nov 6, 2019 at 4:20 PM syzbot
> > <syzbot+fb77e97ebf0612ee6914@syzkaller.appspotmail.com> wrote:
> > >
> > > syzbot has bisected this bug to:
> > >
> > > commit 9e5a64c71b2f70ba530f8156046dd7dfb8a7a0ba
> > > Author: Kees Cook <keescook@chromium.org>
> > > Date:   Mon Nov 4 22:57:23 2019 +0000
> > >
> > >      uaccess: disallow > INT_MAX copy sizes
> >
> > Ah cool, this explains it.
> >
> > fwiw I never managed to get the WARNING in the backtrace to lign up
> > with any code. No idea what's been going on.
>
> Ok I think I have an idea, the above commit isn't in the linux-next I
> have here. Where is this from?
> -Daniel

You need to fetch tags to linux-next. syzbot started bisecting from
the commit where the crash happened, and it is now probably not the
current tag.

linux$ git show 9e5a64c71b2f70ba530f8156046dd7dfb8a7a0ba
commit 9e5a64c71b2f70ba530f8156046dd7dfb8a7a0ba
Author: Kees Cook <keescook@chromium.org>
Date:   Tue Nov 5 09:57:23 2019 +1100

    uaccess: disallow > INT_MAX copy sizes

    As we've done with VFS, string operations, etc, reject usercopy sizes
    larger than INT_MAX, which would be nice to have for catching bugs related
    to size calculation overflows[1].

    This adds 10 bytes to x86_64 defconfig text and 1980 bytes to the data
    section:

       text    data     bss     dec     hex filename
    19691167        5134320 1646664 26472151        193eed7 vmlinux.before
    19691177        5136300 1646664 26474141        193f69d vmlinux.after

    [1] https://marc.info/?l=linux-s390&m=156631939010493&w=2

    Link: http://lkml.kernel.org/r/201908251612.F9902D7A@keescook
    Signed-off-by: Kees Cook <keescook@chromium.org>
    Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
    Cc: Alexander Viro <viro@zeniv.linux.org.uk>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index 659a4400517b2..e93e249a4e9bf 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -147,6 +147,8 @@ check_copy_size(const void *addr, size_t bytes,
bool is_source)
                        __bad_copy_to();
                return false;
        }
+       if (WARN_ON_ONCE(bytes > INT_MAX))
+               return false;
        check_object_size(addr, bytes, is_source);
        return true;
 }


> > I'll type a patch to paper over this.
> > -Daniel
> >
> > >
> > > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=125fe6dce00000
> > > start commit:   51309b9d Add linux-next specific files for 20191105
> > > git tree:       linux-next
> > > final crash:    https://syzkaller.appspot.com/x/report.txt?x=115fe6dce00000
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=165fe6dce00000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=a9b1a641c1f1fc52
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=fb77e97ebf0612ee6914
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1212dc3ae00000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=145f604ae00000
> > >
> > > Reported-by: syzbot+fb77e97ebf0612ee6914@syzkaller.appspotmail.com
> > > Fixes: 9e5a64c71b2f ("uaccess: disallow > INT_MAX copy sizes")
> > >
> > > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> >
> >
> >
> > --
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > +41 (0) 79 365 57 48 - http://blog.ffwll.ch
>
>
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> +41 (0) 79 365 57 48 - http://blog.ffwll.ch
