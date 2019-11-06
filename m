Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FA5C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 15:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8D712166E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 15:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="LB3Yx/BI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732014AbfKFP26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 10:28:58 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39806 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731947AbfKFP26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 10:28:58 -0500
Received: by mail-ot1-f67.google.com with SMTP id e17so12629759otk.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 07:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DbAyue93JyznNmIkmVtLZ6UFGX/hYzHCJSClDp//lSU=;
        b=LB3Yx/BIrvYNHBhojEUI5CCO9pO+SgV4R6zirmvgFlVakaQAKRibjBYbNVvzoG/bfB
         csaWoZma1z+qD+QlIIgAA2uI7p8yPXjS5CwnFBh3sBDf9JN05pnOQw8w5NPLzfaLi7Gq
         mGL6cYrgTYF9CcStKGZZ01c2XmYvB4tYTxqFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DbAyue93JyznNmIkmVtLZ6UFGX/hYzHCJSClDp//lSU=;
        b=LCCNEMENgMBY+lYhxuDLzHKzBePpKvBZAuSYZF+zaGHIIPMph2z7vwzfaJFpUzyboj
         vqlS7nW3dirCY6YhMwKUiNvZEGgYHHIAFGTh4BB8OqQKKH4uzcrG9I2h3fBSBI5ikQUS
         iLmg7hGUfRTnhEWqb0zmQxO8ASXHHvJhkgWzqlmX+GldqjSw4jfFwS2tbp3virIDPMzw
         squHtHLSWl7ZQSBy4TRsW447hK6WG8Hc4c/MwlG3gqvEwDhoU2ERmm/SJ9HybB7m9TTw
         sWoWw4ziNkW8eEK+bJOSF2m4s4qYqki50lTaOll+Lw823M7beTRbiP4wESxl16WqDJ6+
         8NoA==
X-Gm-Message-State: APjAAAXtZShFLddnz1cZGgiMWcoA1j3T+o7mZR5Kggq37hLzqsY2ZCt1
        HPkS/OPqA4emDnfx/2giz/CySKB7JiVeOS8yxhyi3w==
X-Google-Smtp-Source: APXvYqyxueFwRfdmFPePSR8qR4fActa/wTsu04mQA4xgR708Ttyv/aa8hlt4sEajeG3ZyaEmp+JOrKN82PphiaNMMs8=
X-Received: by 2002:a05:6830:1649:: with SMTP id h9mr2347792otr.281.1573054137416;
 Wed, 06 Nov 2019 07:28:57 -0800 (PST)
MIME-Version: 1.0
References: <000000000000b2de3a0594d8b4ca@google.com> <00000000000012ff570596af15cc@google.com>
 <CAKMK7uFQt+=7XMo9jvz77QvDWLAAU_V7-_qZ=iKe-GXG7cqeJg@mail.gmail.com>
In-Reply-To: <CAKMK7uFQt+=7XMo9jvz77QvDWLAAU_V7-_qZ=iKe-GXG7cqeJg@mail.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 6 Nov 2019 16:28:46 +0100
Message-ID: <CAKMK7uEeQnxMXeyMTvqJ-8H3wFeSexkbL1OJ0oJeUoep=YXcVg@mail.gmail.com>
Subject: Re: WARNING in drm_mode_createblob_ioctl
To:     syzbot <syzbot+fb77e97ebf0612ee6914@syzkaller.appspotmail.com>
Cc:     Dave Airlie <airlied@linux.ie>,
        Andrew Morton <akpm@linux-foundation.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Dmitry Vyukov <dvyukov@google.com>,
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

On Wed, Nov 6, 2019 at 4:23 PM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Wed, Nov 6, 2019 at 4:20 PM syzbot
> <syzbot+fb77e97ebf0612ee6914@syzkaller.appspotmail.com> wrote:
> >
> > syzbot has bisected this bug to:
> >
> > commit 9e5a64c71b2f70ba530f8156046dd7dfb8a7a0ba
> > Author: Kees Cook <keescook@chromium.org>
> > Date:   Mon Nov 4 22:57:23 2019 +0000
> >
> >      uaccess: disallow > INT_MAX copy sizes
>
> Ah cool, this explains it.
>
> fwiw I never managed to get the WARNING in the backtrace to lign up
> with any code. No idea what's been going on.

Ok I think I have an idea, the above commit isn't in the linux-next I
have here. Where is this from?
-Daniel

>
> I'll type a patch to paper over this.
> -Daniel
>
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=125fe6dce00000
> > start commit:   51309b9d Add linux-next specific files for 20191105
> > git tree:       linux-next
> > final crash:    https://syzkaller.appspot.com/x/report.txt?x=115fe6dce00000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=165fe6dce00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=a9b1a641c1f1fc52
> > dashboard link: https://syzkaller.appspot.com/bug?extid=fb77e97ebf0612ee6914
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1212dc3ae00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=145f604ae00000
> >
> > Reported-by: syzbot+fb77e97ebf0612ee6914@syzkaller.appspotmail.com
> > Fixes: 9e5a64c71b2f ("uaccess: disallow > INT_MAX copy sizes")
> >
> > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
>
>
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> +41 (0) 79 365 57 48 - http://blog.ffwll.ch



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
