Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4263C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7549A222A5
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mIh147tK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbfKSOld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 09:41:33 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:45263 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbfKSOlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 09:41:32 -0500
Received: by mail-pj1-f65.google.com with SMTP id m71so2728287pjb.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 06:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OSYfTpCeLoiCz6ar4Y5YCkx3V+95c+mgOu5iGHlEmLs=;
        b=mIh147tKxoB5iHq6Sr1ixvt392/H81YC4txurdUXGO4fdsuRJsZfRNmzjoYizdd6rX
         nGc7h+zlPVktQFpLiQCQMN3PAFS85Dc7P9Kxb0HSfmfILyTZUvPAs1NQw4Y8IvKGbRvP
         u8vGOxhGMWYqNB7ep+7hpo7JbeAgD6vTzGFYgpT+zXXPXmS2m7UdGtylxU5Gl12pacO/
         vdh65ZlWJk3w/TT+waRzqqrvSRtVQ7nq+jLQa2pND8LEO5bvL03GQhgZuqOoxWWukfrS
         5ZYiJKH1QsdRlqIi3oHjLKCdCUPhkRQKuvHk0iQbmgwAHmdIzHXBYH1YE9Ne1xMF16gz
         oXCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OSYfTpCeLoiCz6ar4Y5YCkx3V+95c+mgOu5iGHlEmLs=;
        b=kRO+iMic4TU4w/nGbEAWG1ZejZ22nvukCcRJDtbHiolyV6B/Cq4Ukm72FAFmIqVcBy
         Spt/dnk9cDnEyychlL9as+CtEjMTshWO1yigo6xfvyjJAklhgKYwjDyNDX2avWt5Hn8w
         IfO3Rlcnvt/7RZgH3tYI1jRSIJUcbDl0abehb1N77PRTYQOADnl3oXbMnaM1z1cFIxHm
         NgmgDvMpkHc03pD2ypHdTckUOerHc7dTCh+8/HYQYEk4vLkIlqIubC6Rlv5pG3u58b9d
         2Wt1XQxk1XZp089d7JQUdYkM8wxXHQ9q+shRvvWPDR1Z1QqP5lz8f4zPmJyJrFRBR2EH
         gS0w==
X-Gm-Message-State: APjAAAWxIz96Uab83YeLrSkbHxgV1cvEXgvpJbNb+y19sncrIy630h+2
        uGi8ZbAfOW35oEFaoI3WcVsa/2nLAaVd9jA3cyOToA==
X-Google-Smtp-Source: APXvYqwNT/0sPHSivxokIq2Ao+cp8Lh+ljvm77BDSPn8sYnI3sbqDNPMhQ1jWCaHD21W7sfzidfYsTd4IcmvXsUCiK0=
X-Received: by 2002:a17:902:9682:: with SMTP id n2mr31713409plp.336.1574174491437;
 Tue, 19 Nov 2019 06:41:31 -0800 (PST)
MIME-Version: 1.0
References: <000000000000d5795d0596acbc93@google.com>
In-Reply-To: <000000000000d5795d0596acbc93@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 19 Nov 2019 15:41:19 +0100
Message-ID: <CAAeHK+w599vgUcfDMtK+HDfQRw6Xnt-RzaVzeqGKJuoLf81_EA@mail.gmail.com>
Subject: Re: BUG: bad host security descriptor; not enough data (2 vs 5 left)
To:     syzbot <syzbot+8a8429a8b80280ff1c80@syzkaller.appspotmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 6, 2019 at 1:32 PM syzbot
<syzbot+8a8429a8b80280ff1c80@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    b1aa9d83 usb: raw: add raw-gadget interface
> git tree:       https://github.com/google/kasan.git usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D153a1f8ae0000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D79de80330003b=
5f7
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D8a8429a8b80280f=
f1c80
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D10893fcce00=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D15bbaa62e0000=
0
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit=
:
> Reported-by: syzbot+8a8429a8b80280ff1c80@syzkaller.appspotmail.com
>
> usb 1-1: config 0 interface 0 altsetting 0 has 3 endpoint descriptors,
> different from the interface descriptor's value: 4
> usb 1-1: New USB device found, idVendor=3D13dc, idProduct=3D5611,
> bcdDevice=3D40.15
> usb 1-1: New USB device strings: Mfr=3D0, Product=3D0, SerialNumber=3D0
> usb 1-1: config 0 descriptor??
> hwa-hc 1-1:0.0: Wire Adapter v106.52 newer than groked v1.0
> hwa-hc 1-1:0.0: FIXME: USB_MAXCHILDREN too low for WUSB adapter (194 port=
s)
> usb 1-1: BUG: bad host security descriptor; not enough data (2 vs 5 left)
> usb 1-1: supported encryption types: =EF=BF=BD=EF=BF=BD=CF=81=EF=BF=BD=EF=
=BF=BD=EF=BF=BD|=EF=BF=BD=EF=BF=BD=CF=81=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=CF=81=EF=BF=BD=EF=BF=BD=EF=BF=BD
> usb 1-1: E: host doesn't support CCM-1 crypto
> hwa-hc 1-1:0.0: Cannot initialize internals: -19
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches

#syz dup: BUG: bad host security descriptor; not enough data (4 vs 5 left)
