Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08134C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 15:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFAC42077C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 15:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="GTw+U7Uq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732184AbfKFP5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 10:57:06 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43154 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727231AbfKFP5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 10:57:05 -0500
Received: by mail-oi1-f195.google.com with SMTP id l20so9323783oie.10
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 07:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cVWhQ7pk8kVnjo6deuYig81i/tXV4OF/4yQUgh5RwQM=;
        b=GTw+U7UqwU6wESYuDmDzklHmTueMwVcboSvhkrl6oVTwevzsH8xvPPZY6JDnlIBr6A
         Xc9gZzri4CZ8IsqTISVOpHEuZpMIpWnCTXx6J2Oc9gQKI4QX/b930uAhHL+sA3/1/gSF
         stnw1f0mrCPfD+81NeFb1hHy1LYb+HNDRrq78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cVWhQ7pk8kVnjo6deuYig81i/tXV4OF/4yQUgh5RwQM=;
        b=Mdl8OzavremAMPeSChuVCbNq1n95M34Vebz6VQCsXsb6CPArVdy3hWT5kxl+SCpFiY
         MSMpRQRwF822i4XQadzitUk5hYi8k6L1mtceDpeQY2hU1bMwTNvyF1YbzEdoMcySJrcH
         NEdL1/inyBuExVP9jeFJO2H4QX+cPK04OVX+bL0WIOf8lwKsDaJUvolHOY3fp7Aa1OXr
         NKewIoYKSPxl8UeJrGkiFSJaUKfxu+ZKMzAlmyYEa9/oHgT+T3GY0Tl5gBKbaQCJTLS2
         XxH0D37ED0HQS0CmLnDW5cPxPF1w2w0eRBtwo2pxocrGx0/F5bUSk+JNQXef7pffUX/Q
         CMRg==
X-Gm-Message-State: APjAAAUTY1RD0NQ7848URU0/1XrbUYFXjIZKYlM439VIWzJUPzDS/tBN
        55+LIKeWve6tYpnxr6qd72IWhYMXovCEiZ/I2oozlg==
X-Google-Smtp-Source: APXvYqxWZ3zXckrmFK4mvZ6HnP+S4jmeZzRQaFdfvEHEOwY3cd1HWh+A+DJnwvkN2zLL6UZ7CdZB8LR+SG3932ooGig=
X-Received: by 2002:aca:ead7:: with SMTP id i206mr2917301oih.128.1573055823820;
 Wed, 06 Nov 2019 07:57:03 -0800 (PST)
MIME-Version: 1.0
References: <000000000000b2de3a0594d8b4ca@google.com> <00000000000012ff570596af15cc@google.com>
 <CAKMK7uFQt+=7XMo9jvz77QvDWLAAU_V7-_qZ=iKe-GXG7cqeJg@mail.gmail.com>
 <CAKMK7uEeQnxMXeyMTvqJ-8H3wFeSexkbL1OJ0oJeUoep=YXcVg@mail.gmail.com> <CACT4Y+b1yx9cYAtedSv+D4utu+MF_3uJt5oKmcQs7qDBrPx2=w@mail.gmail.com>
In-Reply-To: <CACT4Y+b1yx9cYAtedSv+D4utu+MF_3uJt5oKmcQs7qDBrPx2=w@mail.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 6 Nov 2019 16:56:50 +0100
Message-ID: <CAKMK7uEuJ3Huq9HxV+FTqmgito6273_8oytdjADZP2-HXYw+CA@mail.gmail.com>
Subject: Re: WARNING in drm_mode_createblob_ioctl
To:     Dmitry Vyukov <dvyukov@google.com>
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

On Wed, Nov 6, 2019 at 4:33 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Wed, Nov 6, 2019 at 4:28 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> >
> > On Wed, Nov 6, 2019 at 4:23 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> > >
> > > On Wed, Nov 6, 2019 at 4:20 PM syzbot
> > > <syzbot+fb77e97ebf0612ee6914@syzkaller.appspotmail.com> wrote:
> > > >
> > > > syzbot has bisected this bug to:
> > > >
> > > > commit 9e5a64c71b2f70ba530f8156046dd7dfb8a7a0ba
> > > > Author: Kees Cook <keescook@chromium.org>
> > > > Date:   Mon Nov 4 22:57:23 2019 +0000
> > > >
> > > >      uaccess: disallow > INT_MAX copy sizes
> > >
> > > Ah cool, this explains it.
> > >
> > > fwiw I never managed to get the WARNING in the backtrace to lign up
> > > with any code. No idea what's been going on.
> >
> > Ok I think I have an idea, the above commit isn't in the linux-next I
> > have here. Where is this from?
> > -Daniel
>
> You need to fetch tags to linux-next. syzbot started bisecting from
> the commit where the crash happened, and it is now probably not the
> current tag.

Indeed it's an -mm patch so rebases every day. I tried looking for it,
but found nothing, not sure what exactly I screwed up. Patch on the
way.
-Daniel

>
> linux$ git show 9e5a64c71b2f70ba530f8156046dd7dfb8a7a0ba
> commit 9e5a64c71b2f70ba530f8156046dd7dfb8a7a0ba
> Author: Kees Cook <keescook@chromium.org>
> Date:   Tue Nov 5 09:57:23 2019 +1100
>
>     uaccess: disallow > INT_MAX copy sizes
>
>     As we've done with VFS, string operations, etc, reject usercopy sizes
>     larger than INT_MAX, which would be nice to have for catching bugs related
>     to size calculation overflows[1].
>
>     This adds 10 bytes to x86_64 defconfig text and 1980 bytes to the data
>     section:
>
>        text    data     bss     dec     hex filename
>     19691167        5134320 1646664 26472151        193eed7 vmlinux.before
>     19691177        5136300 1646664 26474141        193f69d vmlinux.after
>
>     [1] https://marc.info/?l=linux-s390&m=156631939010493&w=2
>
>     Link: http://lkml.kernel.org/r/201908251612.F9902D7A@keescook
>     Signed-off-by: Kees Cook <keescook@chromium.org>
>     Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
>     Cc: Alexander Viro <viro@zeniv.linux.org.uk>
>     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>     Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
>
> diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
> index 659a4400517b2..e93e249a4e9bf 100644
> --- a/include/linux/thread_info.h
> +++ b/include/linux/thread_info.h
> @@ -147,6 +147,8 @@ check_copy_size(const void *addr, size_t bytes,
> bool is_source)
>                         __bad_copy_to();
>                 return false;
>         }
> +       if (WARN_ON_ONCE(bytes > INT_MAX))
> +               return false;
>         check_object_size(addr, bytes, is_source);
>         return true;
>  }
>
>
> > > I'll type a patch to paper over this.
> > > -Daniel
> > >
> > > >
> > > > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=125fe6dce00000
> > > > start commit:   51309b9d Add linux-next specific files for 20191105
> > > > git tree:       linux-next
> > > > final crash:    https://syzkaller.appspot.com/x/report.txt?x=115fe6dce00000
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=165fe6dce00000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=a9b1a641c1f1fc52
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=fb77e97ebf0612ee6914
> > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1212dc3ae00000
> > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=145f604ae00000
> > > >
> > > > Reported-by: syzbot+fb77e97ebf0612ee6914@syzkaller.appspotmail.com
> > > > Fixes: 9e5a64c71b2f ("uaccess: disallow > INT_MAX copy sizes")
> > > >
> > > > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> > >
> > >
> > >
> > > --
> > > Daniel Vetter
> > > Software Engineer, Intel Corporation
> > > +41 (0) 79 365 57 48 - http://blog.ffwll.ch
> >
> >
> >
> > --
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > +41 (0) 79 365 57 48 - http://blog.ffwll.ch



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
