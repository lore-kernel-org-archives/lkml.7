Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB27DC5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 15:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B1D02173E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 15:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KIqiCb4E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbfKFPg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 10:36:58 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41075 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727129AbfKFPg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 10:36:58 -0500
Received: by mail-qt1-f194.google.com with SMTP id o3so34144123qtj.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 07:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+7KpqrJ6c3XzLpPaCXXTrXg1Ygmesx98ds69e2jPzvI=;
        b=KIqiCb4EgjrA+TaMrhn0slRxX6kGSDTd6hSnfUa+PqzW9hQ1zpnWnfBX4BS2zzsAG7
         wBKeE4HPyBIZtTHUo+7v1b5oC6oyII2rV0Rci3YhCTLDiwjBeEI4Q4yEh3YbwuN50Zgg
         baG35hf1hTnmvnEUkZ2E5ZOy14VYje3Gf/4Q47a+ee+A5y2esrKj3boyv/q8nTffCAcT
         IES2c/qDl1jctBU6y6GZWmXGAS87QvVKSdDrhWwPvJopiIQZkXfhp/xSlm0PsQ1+vxjZ
         orTzsuULz0wyH2lkTDM+qsVJFtZAiMjbnyeoCzjzeA+Qlhqjdv18Zj7p0Eqh458GqQM+
         YjcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+7KpqrJ6c3XzLpPaCXXTrXg1Ygmesx98ds69e2jPzvI=;
        b=rans30Ysn75m6pRtMjD2NT8o0oE7xSY+Diwq64TRkqJUVtTW56e1B10qQBXwFlaPeG
         o0ONPJzNBY6H21AhklCkuwPQyiVzt+YDxzDuc9tBCENwD0brA8xiCta/9bvpKGeSfQRG
         K8N3fKYhyD4DJI8Q+ywg0qg2Fv8JG2z26N7QEm+2mmRq/+wSGl6Aeg3Q68uxTHWHkJHX
         q0cv8cup+ams3dfpG4EXU2IY/qvI1cLZP0jdSVnR343aev0fsqn6zuoDSWYoCAfQSeAS
         1Gf8eSg+6egSr7hC2eTp4kaQSLbeSXMziNZe6lkKK+7QYqqgg4cijnXz7LQXQSX4yyQx
         9MjQ==
X-Gm-Message-State: APjAAAUhE2rEseRFn826FYMv1BheconhqyzaSxlhaBs8NvTx+GUp0Q6h
        D3rGBTSgofX5czIoTZZTtkX79/hcIRuoKA/oXnz6KQ==
X-Google-Smtp-Source: APXvYqx01RSgCCKXEJT1Ax6iIpPZvFs2LcH1CVVGp7m6MH+4R7cQDIoZugPLUrxj4JccnSQWE1vErK43/SZV4av/ho8=
X-Received: by 2002:aed:24af:: with SMTP id t44mr2869020qtc.57.1573054616672;
 Wed, 06 Nov 2019 07:36:56 -0800 (PST)
MIME-Version: 1.0
References: <000000000000b2de3a0594d8b4ca@google.com> <00000000000012ff570596af15cc@google.com>
 <CAKMK7uFQt+=7XMo9jvz77QvDWLAAU_V7-_qZ=iKe-GXG7cqeJg@mail.gmail.com>
In-Reply-To: <CAKMK7uFQt+=7XMo9jvz77QvDWLAAU_V7-_qZ=iKe-GXG7cqeJg@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 6 Nov 2019 16:36:45 +0100
Message-ID: <CACT4Y+a3WWKLPoLD7LC44gaDNQ-p13dW5FT4w1MatcL61u_+XQ@mail.gmail.com>
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

On Wed, Nov 6, 2019 at 4:30 PM Daniel Vetter <daniel@ffwll.ch> wrote:
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
>
> I'll type a patch to paper over this.
> -Daniel

If I get:
git checkout 8ada228a
then include/linux/thread_info.h:150
points right to:
if (WARN_ON_ONCE(bytes > INT_MAX))

Is the size user-controllable here?


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
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/CAKMK7uFQt%2B%3D7XMo9jvz77QvDWLAAU_V7-_qZ%3DiKe-GXG7cqeJg%40mail.gmail.com.
