Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC96BC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 14:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBBF620659
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 14:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dyrBL+wP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730972AbfG3OUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 10:20:15 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42116 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbfG3OUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 10:20:15 -0400
Received: by mail-pf1-f194.google.com with SMTP id q10so29910324pff.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 07:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VxDw0/AhSqBc+UFZUyCqEn82uv1wGE11yVcaX4Q0n6o=;
        b=dyrBL+wPYhegsmZBAGBP2FqAXypY3hXlWpWfsF+mgCyBUA0/oMiPQvycFXN3A1WD6J
         +p+u3fsrMWUaxUiUcxPnAs5SCfDBt+ULGVIV6tyT2heZPE/D/ZSTK7yWZ1liHqzaBCeI
         GqOCLj9pi0x6QeBwfFWNB98qCgd+OKBwTzrNBkt4M4H7/CKhRQN0o2AAMiBz01SL2OgA
         JggS6g7grF/FxS9rPQmJSJdGrkcVDLjHDHfgRkq3gUZGpR8l9ZQIsECyJBV9LVbSQyQs
         dljp8qX7VRXub5gq5qdPbxIxvuvHMDhuSsQZUy0ci+TpaaLJ+55tcy03sueidlVCczJi
         Iv7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VxDw0/AhSqBc+UFZUyCqEn82uv1wGE11yVcaX4Q0n6o=;
        b=VDPeKy47xcWwHstzN2vgtuXSGOtEUHDFG2SKTJFMCmeet1o4iI39nwDKdWZ4he0Hk5
         7oBQ+qfmFhTX7qMpHtdzVY/knXoeRN22Z+g5GbN3iyjFg/r2TIl+p7aszOVP8SNcULuK
         qPm2uNssHvX6RHSZ2NlnEGtZik6zT3RwSstVz6umuOlyzjUCVb4th0ed0f61b6j8vkpG
         hWxlJrng5eiZJbKuamBdZNZXD5eZMlSNqEA78GXGaThCsMA836iVdc1I2+tslq+pyW0d
         eYZ4L2+BACe2bsORUd4XNOdoTM8TMA2E4zCbrBIEOiYguIdyRw74BZfmwVWnwjYbv9Dr
         ydpw==
X-Gm-Message-State: APjAAAVTSVs5vFu4PA/hoW2GWwrfsW0DEx3JbwbBFePMxSL444kNm7XR
        gX7hHpfRQi8HlFOr+KrcAWcMZBYOgLISeJDQeTy/MA==
X-Google-Smtp-Source: APXvYqyvBs8WO4qGUlFCXZ9vDpUjAUxiMdKSUdDNg2hJRew4ETs8qJMLqcasMg/Komef7BsJUXiDvqfz3domfp3/OGQ=
X-Received: by 2002:a17:90a:a116:: with SMTP id s22mr116488183pjp.47.1564496413927;
 Tue, 30 Jul 2019 07:20:13 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000014c877058ee2c4a6@google.com> <Pine.LNX.4.44L0.1907301011100.1507-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1907301011100.1507-100000@iolanthe.rowland.org>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 30 Jul 2019 16:20:02 +0200
Message-ID: <CAAeHK+wnhfMvoMbuv3Oco1eH35BL5tdR9-X5erEJmKLS1finAg@mail.gmail.com>
Subject: Re: KMSAN: kernel-usb-infoleak in pcan_usb_pro_send_req
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     syzbot <syzbot+513e4d0985298538bf9b@syzkaller.appspotmail.com>,
        Alexander Potapenko <glider@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 4:17 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Tue, 30 Jul 2019, syzbot wrote:
>
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    41550654 [UPSTREAM] KVM: x86: degrade WARN to pr_warn_rate..
> > git tree:       kmsan
> > console output: https://syzkaller.appspot.com/x/log.txt?x=13e95183a00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=40511ad0c5945201
> > dashboard link: https://syzkaller.appspot.com/bug?extid=513e4d0985298538bf9b
> > compiler:       clang version 9.0.0 (/home/glider/llvm/clang
> > 80fee25776c2fb61e74c1ecb1a523375c2500b69)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17eafa1ba00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17b87983a00000
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+513e4d0985298538bf9b@syzkaller.appspotmail.com
> >
> > usb 1-1: config 0 has no interface number 0
> > usb 1-1: New USB device found, idVendor=0c72, idProduct=0014,
> > bcdDevice=8b.53
> > usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> > usb 1-1: config 0 descriptor??
> > peak_usb 1-1:0.146: PEAK-System PCAN-USB X6 v0 fw v0.0.0 (2 channels)
> > ==================================================================
> > BUG: KMSAN: kernel-usb-infoleak in usb_submit_urb+0x7ef/0x1f50
> > drivers/usb/core/urb.c:405
>
> What does "kernel-usb-infoleak" mean?

That means that the kernel put some uninitialized data into a request
that was sent to a USB device.

>
> Alan Stern
>
