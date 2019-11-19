Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594F3C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3120B22316
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d9MCjAtf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbfKSOlu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 09:41:50 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39880 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728122AbfKSOls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 09:41:48 -0500
Received: by mail-pf1-f194.google.com with SMTP id x28so12284423pfo.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 06:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dF+ivxgCTPanWWoF5C1qzzPBT3PQ81LJ6vYrJ5PQ2+o=;
        b=d9MCjAtf3HcUeUDZxHNFN1stQiS49wMgNo3h4H0vX/o9JdElwWX1ywNG2EXThYd0RH
         +8cKRcvYNxir2JGucTC9qDkvAnfhhCW1oUlJ/O7O54NeuGPVjedoqsnoeCxrcFpVizvA
         e+w7+mW0+AabolNy6JD4ke6zN9p31LbQggY5kQ8JJH5DiO/PhH9Ocvt4U7gzuV5NbTqB
         2Tl+GDpnXxH/MIGmfHmZEXkLtrYgADsbvIrmOKswXFE1Jy20uZXQw4639Fr/gpyYG0Br
         Bol0KDBPWw2Wu1jear/lICrDt6UWwzZtAO9ynuu+YUmZA/SrV7YQpcqFK/Ww2iWV50dX
         PElQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dF+ivxgCTPanWWoF5C1qzzPBT3PQ81LJ6vYrJ5PQ2+o=;
        b=dItn9I60DXvnS/ovWTQWQbQYy2ULJjxIOil/7S4itIN6Nr7Ee7t7xkXGDAne1x1BBk
         Lh72ew2tX8BCOWZSZfoV/pG3LNTjaX3J/MPFLoDxCJrhOwpmix8c2V1OcBZMbVGpDEaz
         PJRtCEfJy70T9nZqbgMt01TRCVscCTswPSr5qCiv79oOgtuXFKWHKb9/kH0UmRxwag3s
         ZMXVRuK62qPvMWWREZhdN1FCdbqRvRJxzzOn2J/g0KZAbrF6Z9UC+t1YBNVfaAkPMUkV
         vLlmU2kfhWGHwo2QVenr7d/Bs4OjCF7zQYXjmqfJJtvFf9ux0+g2wJN3YJpnSoEHMCjv
         v5zQ==
X-Gm-Message-State: APjAAAUzGixDiqHwFKcY+0w3YTZ4qeoQv94cEa8KA2NfKRL2p8fJRcDL
        GCW1xRCZHhmm6hfDCEDwADRreF5pXFzvXyr+IwM1yw==
X-Google-Smtp-Source: APXvYqxdXyNFFcj5EZ5h5U7TXLjwCISllyxI/ZtTITEcJUZ+tLMedG7CTEI9fOQY3zr2M8tyq0eamnkb8U+8yPul9Fk=
X-Received: by 2002:a63:c804:: with SMTP id z4mr6093685pgg.440.1574174507326;
 Tue, 19 Nov 2019 06:41:47 -0800 (PST)
MIME-Version: 1.0
References: <000000000000835f920595f81bfa@google.com>
In-Reply-To: <000000000000835f920595f81bfa@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 19 Nov 2019 15:41:34 +0100
Message-ID: <CAAeHK+w6QNoy22Mo1juA-EWUe=zXjOtqmVNC0dWe_3ObUoWUvQ@mail.gmail.com>
Subject: Re: BUG: bad host encryption descriptor; descriptor is too short (0
 vs 5 needed)
To:     syzbot <syzbot+48fbe2f8fdcd2fbc1242@syzkaller.appspotmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 2:02 PM syzbot
<syzbot+48fbe2f8fdcd2fbc1242@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    22be26f7 usb-fuzzer: main usb gadget fuzzer driver
> git tree:       https://github.com/google/kasan.git usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D16eccc0f60000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D5fe29bc39eff9=
627
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D48fbe2f8fdcd2fb=
c1242
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D10d08e4ce00=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D11fb07ff60000=
0
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit=
:
> Reported-by: syzbot+48fbe2f8fdcd2fbc1242@syzkaller.appspotmail.com
>
> usb 1-1: config 0 interface 66 altsetting 0 has 3 endpoint descriptors,
> different from the interface descriptor's value: 4
> usb 1-1: New USB device found, idVendor=3D13dc, idProduct=3D5611,
> bcdDevice=3D40.15
> usb 1-1: New USB device strings: Mfr=3D0, Product=3D0, SerialNumber=3D0
> usb 1-1: config 0 descriptor??
> hwa-hc 1-1:0.66: Wire Adapter v125.52 newer than groked v1.0
> hwa-hc 1-1:0.66: FIXME: USB_MAXCHILDREN too low for WUSB adapter (53 port=
s)
> usb 1-1: BUG: bad host encryption descriptor; descriptor is too short (0 =
vs
> 5 needed)
> usb 1-1: supported encryption types: =EF=BF=BD=EF=BF=BD=EF=BF=BD=CF=81=EF=
=BF=BD=EF=BF=BD=EF=BF=BD|=EF=BF=BD=EF=BF=BD=CF=81=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=CF=81=EF=BF=BD=EF=BF=BD=EF=BF=BD
> usb 1-1: E: host doesn't support CCM-1 crypto
> hwa-hc 1-1:0.66: Cannot initialize internals: -19
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
