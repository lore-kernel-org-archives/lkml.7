Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BFEC43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 06:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 896DF24679
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 06:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwOh2LW6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbfLFGqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 01:46:49 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:45347 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbfLFGqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 01:46:48 -0500
Received: by mail-yw1-f68.google.com with SMTP id d12so2291707ywl.12;
        Thu, 05 Dec 2019 22:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7gaosEyCtS7figPaTevfhISyTIAcwkXEtc8ItLxSuls=;
        b=NwOh2LW6GvrtCLPiYl0gp4bYM5mcmkPs5GMwnsSHyeOnf11ZgJRAkVQtdsioEwpgbB
         xIaHJyK/DkrNiYHZ/qhBOzG4VtQCIovYFAB2fEtMXc7QG2Cua1pJBkgW0rsf0Mt0Lxn7
         XaBpBbSPR+KJPzqsZvRZdTxy/w60i/sMIUp8LA7CUVC/yt8ap63wgimUM075+kZT6Woi
         hC2SBX1lq/g3rmmNzJ/ggAwDhmMaBEpi9Au3FhiXhPo5F3/PVpAQM3qX7ZzznfsE+tsd
         s76ey9TfKuBCyr2LgmbnE4MFFA3tD14/2Dr3XMdfAKzdPkMCIe/upu512JjlfwDFQ24E
         SC5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7gaosEyCtS7figPaTevfhISyTIAcwkXEtc8ItLxSuls=;
        b=VIMyeHZYpRJIzxiqukOSvy3IRwbWg4MMTcH84VU0nbJu9rSbxsmQvi36KXoywGO81i
         vOXRtWcLJGpV3ZMiJl/lr/wMnQYQGqzTlVXGGyP8prAYBiwUEWjgDvvS2B2ooJma/v1x
         B3Q9tL/rAikJkVSK/7yahXEtI1qLurvrD+w1kBOiC9F7SgcMoua+3WkymmPii28MHMBM
         +wuC6s1ThokYy89Bd/3Hui6TkSF7KMOhPgnaDPu6y4N/PD4tFvMKlRhIoI4eGLQyAK5r
         GlvshhuUdw84Sld1ZuiKd+NniEJPsCej7A4hnx1fi2V0SbJNf8urGwVGNtxjb8ZvzK9W
         2ImQ==
X-Gm-Message-State: APjAAAVB/gTD3/MtF2GGe8Xe+ANQVPMQ/pqpQdEfi00mCsYFHolsQHTz
        1T2Azg6rt/yg8VhI6IztaSPdWmo/GsokACXtoo8=
X-Google-Smtp-Source: APXvYqxZPoGPZ2g12UuMmnRst0eaRP4msgk/8mr3Sw9+PT/0v4fpiG2Jd/uCEF/o8zxSRZZJsFHnZ+hqe3yjhK8ZwpE=
X-Received: by 2002:a81:14d:: with SMTP id 74mr8923710ywb.183.1575614807610;
 Thu, 05 Dec 2019 22:46:47 -0800 (PST)
MIME-Version: 1.0
References: <0000000000002492cc0587d58ed8@google.com> <000000000000db84550598ff519f@google.com>
In-Reply-To: <000000000000db84550598ff519f@google.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 6 Dec 2019 08:46:36 +0200
Message-ID: <CAOQ4uxgzGRJs3o=7_rM3HtdMjEP-Emy=0a98LMVvYa-3==ZpjQ@mail.gmail.com>
Subject: Re: WARNING in ovl_rename
To:     syzbot <syzbot+bb1836a212e69f8e201a@syzkaller.appspotmail.com>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Miklos Szeredi <mszeredi@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 6, 2019 at 3:54 AM syzbot
<syzbot+bb1836a212e69f8e201a@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this bug was fixed by commit:
>
> commit 146d62e5a5867fbf84490d82455718bfb10fe824
> Author: Amir Goldstein <amir73il@gmail.com>
> Date:   Thu Apr 18 14:42:08 2019 +0000
>
>      ovl: detect overlapping layers
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=138841dae00000
> start commit:   037904a2 Merge branch 'x86-urgent-for-linus' of git://git...
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a42d110b47dd6b36
> dashboard link: https://syzkaller.appspot.com/bug?extid=bb1836a212e69f8e201a
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15ba097ca00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10be1ceca00000
>
> If the result looks correct, please mark the bug fixed by replying with:
>
> #syz fix: ovl: detect overlapping layers
>

Not exactly. Depends how you define "the bug".

The actual bug wasn't introduced by:
     ovl: fix EIO from lookup of non-indexed upper

Nor was it fixed by:
     ovl: detect overlapping layers

It would be more accurate to say that the former commit exposed the bug
to this specific repro and the latter commit has masked it from this repro.

The actual bug was introduced by:
    804032fabb3b ("ovl: don't check rename to self")

Which did not take into account hardlinking underneath overlayfs.

I posted a fix to relax this WARN_ON(), which is marked for stable 4.9+,
because I see that the repro is also reported on kernel 4.14.y and
"ovl: detect overlapping layers" is not expected to land in 4.14.y.

Thanks,
Amir.
