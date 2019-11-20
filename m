Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 091F9C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 08:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1117223D1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 08:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dqT08KsS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbfKTIyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 03:54:05 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46538 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727950AbfKTIyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 03:54:05 -0500
Received: by mail-qt1-f193.google.com with SMTP id r20so28047017qtp.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 00:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iVr27vX4o2E5/GQrHJJ9cVmU51kjWygjKwdOBs2whhY=;
        b=dqT08KsSqfx1MfqUFTqObFohRzV73HC5YU7JEzmzR95uf8vWx63TNX4X29donu9M5b
         oPGzbD0EBKelh+8oExj7oAMOE1kxWO90t6FYcJZeejepwszwvC9WH6xsUjumhoAT863/
         hlsgZr2AjOgsWL3X+N5IYISSYMWgTvj7paetMBqESNiiLLdKOdb3lGtxchSaB6FCN2wH
         /QhRg5dsmmZOvXbEmSB2KpUxL5sPtVp8rP2+Wkc6dxhugLaMpCbZXYa3GinCqov+fVRy
         YuYdGROVPQZ/CYbBTNIAb+5YIv9smOXteeF8LFHi/lXNBZ+HaWbgGSOyBsfrG6jIN8yf
         5/8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iVr27vX4o2E5/GQrHJJ9cVmU51kjWygjKwdOBs2whhY=;
        b=ikp+SuALNjaIHSt78fhjdcpp1WWBeo/ozg00ZBJfiydlI8dUcp2teJaE4Xwx85dGu1
         5zBRXoEm11736IO2Mb49+N2Xl5lJtcHdZE+h04fAHt1Y2C/jEF0M4FoxNnIr12mVOD+m
         4n+zyjexzDCz2XKDaix41BCucWA3mSN/HO6rCpmPiBXot1j4v+V9/7bE7dcJZ9mL0ryK
         mcqj8CfiV/FwuxPasU3MRHOqQgyiMCPYw76o2A5T4rZcy8jt4iU3wrtjEZCo7FhGYB/B
         I4RwU7VOoXDcDtTcfqEbGAGLs5ZU7ot/jG6I41eaaYjhCeWoP0JNrZsKs81nZBnJFX6J
         e5Pw==
X-Gm-Message-State: APjAAAUcAjJjKRZoFS06ZwPX9gkp7G+AyA089mF2nZiOwIlA/5gFD3Xd
        sWavOBzRB6m3iYpAEJd0XZ5ttSJr5iuiwDrxX8RCaFVmLY0=
X-Google-Smtp-Source: APXvYqw04brF+3wMJNjaYdZj0/tu7RiJMeNLlKl8WC2x/YHNi3/vk8xC7jhYgwPtsc0O44Y3KofT/jLPDvgBCi4vp1o=
X-Received: by 2002:ac8:4157:: with SMTP id e23mr1527362qtm.158.1574240042336;
 Wed, 20 Nov 2019 00:54:02 -0800 (PST)
MIME-Version: 1.0
References: <000000000000f921ae05757f567c@google.com> <0000000000001da6b60597c2ce91@google.com>
 <20191120082958.GB2862348@kroah.com>
In-Reply-To: <20191120082958.GB2862348@kroah.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 20 Nov 2019 09:53:51 +0100
Message-ID: <CACT4Y+amS4Dj99FE1h-e+5dV=q74_ueWiL-vX70RjMMhR5GLdw@mail.gmail.com>
Subject: Re: WARNING in kernfs_get
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     syzbot <syzbot+3dcb532381f98c86aeb1@syzkaller.appspotmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        rafael@kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Tejun Heo <tj@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 9:30 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Nov 20, 2019 at 12:17:01AM -0800, syzbot wrote:
> > syzbot has bisected this bug to:
> >
> > commit 726e41097920a73e4c7c33385dcc0debb1281e18
> > Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Date:   Tue Jul 10 00:29:10 2018 +0000
> >
> >     drivers: core: Remove glue dirs from sysfs earlier
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17a101cee00000
> > start commit:   9a568276 Merge branch 'x86-urgent-for-linus' of git://git...
> > git tree:       upstream
> > final crash:    https://syzkaller.appspot.com/x/report.txt?x=146101cee00000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=106101cee00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=8f59875069d721b6
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3dcb532381f98c86aeb1
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12657f0a400000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=117728ae400000
> >
> > Reported-by: syzbot+3dcb532381f98c86aeb1@syzkaller.appspotmail.com
> > Fixes: 726e41097920 ("drivers: core: Remove glue dirs from sysfs earlier")
> >
> > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
>
> Again, I think this should be resolved with ac43432cb1f5 ("driver core:
> Fix use-after-free and double free on glue directory")
>
> Is there any way to run the reproducer on a newer tree?

The generic fix testing instruction should work:
https://github.com/google/syzkaller/blob/master/docs/syzbot.md#testing-patches
Note: you don't need to attach any patch, just pointing to a
tree/branch works too.
