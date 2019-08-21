Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF52C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 16:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91985206DD
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 16:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AF+IIIeH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbfHUQ0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 12:26:45 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44370 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbfHUQ0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 12:26:45 -0400
Received: by mail-pl1-f194.google.com with SMTP id t14so1580242plr.11
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 09:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/lziEAnWIs7T/IMh7pvLAYKgxF1M/6L6xhkZk+PTzZo=;
        b=AF+IIIeHIq+dPK6gk+aCsHN2vKnAjqwvZuihG7Jet3NEoV5OgjEnchuWOGClLLH3iq
         Y4Jnmi7hlWG/Dn3ztrc+tWsOnALWnOX5vVTc1NtSiBX9F+jscmLYIJAQKZ5aQuAVYUG4
         0pRL70xnZAqBDUxRuuiTOIoV5mxKFMBLMtgYBwhHD/J2P/q3YXL66kEZXDdcTTLVlCf3
         HD4U4ZX4KkNuDt4YoJUbWJjJUOjBsfecG7bJFG/0BfxboCKOMO8unm3Y0oMLn27x/LOK
         BJgmeln/fKlN1V1JE43IY+76dixpXtcEDvQb7zOeu7A6BMVZ8Ayzq3Q9hyDlGxGu8Y04
         dffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/lziEAnWIs7T/IMh7pvLAYKgxF1M/6L6xhkZk+PTzZo=;
        b=Bxn4XlRiCgS8jpQC3/TQCquAVWW2Gtczoos7pBgwM5qsmQyEWOwNDpFkwPSBGvFuqK
         EOHLwx+DBUr13OzsHwbxcyrM8K5vy26xjLp2Gwp4jKdjGMZBTYu7ii+mJh/3dV7/+0ek
         s/MWJzbVvUHIWCv0hNfBFVdp5xXA/8DwET2O4CAp7/hoQLNalxCkx6pubxJQpNoh0VOV
         0oIVRi5JSG91VwFe9EEE695TM/m/C4a+OPv4x7ts3U1VPYjA3wYYdmM0IizYL6R72Mtj
         gT4UgPbkhCwwTjit/cU9k5PaYmSONdsYT5tg+q6+j0TTqSvCAB9iY2YQU4CCGbtKJsC0
         E0cw==
X-Gm-Message-State: APjAAAVEyxwR6lin4fxn9eKryLZmbFo9LrlHJ2zM6xqB7hQo69UcYDIa
        dSqCjyn5QRGEMdIHLW2pz+gyBFWz+73VnUwCTB23V/NIcD0HWA==
X-Google-Smtp-Source: APXvYqyWzm3ttwJ/qs5oATy4yQcZ4ErWYetxTfgsGlousGVCvxLNjVvJ3uxvSFrniw99IHUPTyRiot8PZ7LI3jrN8T0=
X-Received: by 2002:a17:902:bb94:: with SMTP id m20mr34062684pls.336.1566404804399;
 Wed, 21 Aug 2019 09:26:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAAeHK+xQc5Ce6TwtERTmQ+6qSbuAmGikxCU5SNTdcDAynDEiig@mail.gmail.com>
 <Pine.LNX.4.44L0.1908211223070.1816-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1908211223070.1816-100000@iolanthe.rowland.org>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 21 Aug 2019 18:26:33 +0200
Message-ID: <CAAeHK+z-o9naQXZoxwTXRh2WWQzFiRU9XruabNTTm31_1AbjAw@mail.gmail.com>
Subject: Re: KASAN: slab-out-of-bounds Read in hidraw_ioctl
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     syzbot <syzbot+5a6c4ec678a0c6ee84ba@syzkaller.appspotmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 6:24 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Wed, 21 Aug 2019, Andrey Konovalov wrote:
>
> > On Wed, Aug 21, 2019 at 3:37 PM syzbot
> > <syzbot+5a6c4ec678a0c6ee84ba@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot has tested the proposed patch but the reproducer still triggered
> > > crash:
> > > KASAN: slab-out-of-bounds Read in hidraw_ioctl
> >
> > Same here, a different bug.
>
> It looks like I've got the fix for both these bugs.  Testing now...

Great! Do you think "BUG: bad usercopy in hidraw_ioctl" can also be
fixed by one of those fixes?

>
> > > Tested on:
> > >
> > > commit:         e96407b4 usb-fuzzer: main usb gadget fuzzer driver
> > > git tree:       https://github.com/google/kasan.git
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=14f14a1e600000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=cfa2c18fb6a8068e
> > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > patch:          https://syzkaller.appspot.com/x/patch.diff?x=171cd95a600000
>
> Why don't these patch-test reports include the dashboard link?  It sure
> would be handy to have a copy of it here.
>
> Alan Stern
>
