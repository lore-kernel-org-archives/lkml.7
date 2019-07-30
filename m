Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B949C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 14:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 095352089E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 14:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KiUYWlMN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729104AbfG3OWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 10:22:19 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45664 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbfG3OWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 10:22:19 -0400
Received: by mail-pf1-f194.google.com with SMTP id r1so29919093pfq.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 07:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aLW6xr/ZT3S3E1+3lAes0TB19oJInjpQS73rS0vOgHQ=;
        b=KiUYWlMNbFKz4eb3Mytz+22rvH2Xd6UXPsyCa66JfHZLSLb4G26Qu8vHXW0ZpObBzZ
         FPbTVY7LqSopBSV6MmE6y5eIRadxDkJQDpdgx9OZud+35RGx2laE1BpO4NykX8vbUOl2
         TdAnO9JH4iyU14KNuSB0TTNIv/z/Pz7r00CT7vDZU2tIPKujob8izh3lVADx53amPwwo
         hGgA9/nyE9v0ZPQrPMfW4MfM3xHDE4CatLOI/Fl7vH7nqY/h0ibcLTW6e6YLx2aSWeLS
         7bdDfH3n/oHlb71fVuCCctVQiK7kc4eC95D5pnXFanLpJBAdNvzpSBmN0EQBSOXZkyD8
         HRdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aLW6xr/ZT3S3E1+3lAes0TB19oJInjpQS73rS0vOgHQ=;
        b=Mhse51KTB+pRrRl6pnIVtMNAhsuKhFMoAi8vD4aBBTdAZ9JRXOknV4wNlgNJVW9wba
         dCB+t+EoXwhMqFhreboPuMWY4/+1yXa3bWt00Xt6SLZWa2O3tr/+2cYgpuyel1/McaTW
         1O9IfIbwyZsp9mwY7+1f3WW3PMYX0rdvnN3Ag6UfjSf2SxOMplpGMYIStd7kaCUvO8fV
         s/pORMZBccJdG5l/HfjNQ07ItkT9D3dmnSo8EUKmY+h6x1pN67kV/KJFoY4clAnVsBCh
         63z35hlBjZztkITLYHTl66DiMX5ordGFmGTdRfIULYpKX0mfxMa9C1nTkhVkeuXhvxmY
         oCiw==
X-Gm-Message-State: APjAAAWKhaTsnbMOf0INmHJn8DDjNCM/V8fpLapjtAdegRV/lFuRA+Hb
        m8BsXq6atowLeYwkfp29t9L+i8pZC0sm4wM6fdD40w==
X-Google-Smtp-Source: APXvYqxvGwGL/Zgjx9+x7nb2dZn445pqTy7pbCMdGEq6lEvNcGmt03iPnohXOD3Yl3jRsmL1B4lBdCu/NNCqrsyk/WQ=
X-Received: by 2002:a65:4b8b:: with SMTP id t11mr108766121pgq.130.1564496538253;
 Tue, 30 Jul 2019 07:22:18 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000014c877058ee2c4a6@google.com> <Pine.LNX.4.44L0.1907301011100.1507-100000@iolanthe.rowland.org>
 <CAAeHK+wnhfMvoMbuv3Oco1eH35BL5tdR9-X5erEJmKLS1finAg@mail.gmail.com>
In-Reply-To: <CAAeHK+wnhfMvoMbuv3Oco1eH35BL5tdR9-X5erEJmKLS1finAg@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 30 Jul 2019 16:22:07 +0200
Message-ID: <CAAeHK+z50rsvQypF5AivYJh0wQ04XAueC=Ms2cPt3+QuN1+KGg@mail.gmail.com>
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

On Tue, Jul 30, 2019 at 4:20 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> On Tue, Jul 30, 2019 at 4:17 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Tue, 30 Jul 2019, syzbot wrote:
> >
> > > Hello,
> > >
> > > syzbot found the following crash on:
> > >
> > > HEAD commit:    41550654 [UPSTREAM] KVM: x86: degrade WARN to pr_warn_rate..
> > > git tree:       kmsan
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=13e95183a00000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=40511ad0c5945201
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=513e4d0985298538bf9b
> > > compiler:       clang version 9.0.0 (/home/glider/llvm/clang
> > > 80fee25776c2fb61e74c1ecb1a523375c2500b69)
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17eafa1ba00000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17b87983a00000
> > >
> > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > Reported-by: syzbot+513e4d0985298538bf9b@syzkaller.appspotmail.com
> > >
> > > usb 1-1: config 0 has no interface number 0
> > > usb 1-1: New USB device found, idVendor=0c72, idProduct=0014,
> > > bcdDevice=8b.53
> > > usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> > > usb 1-1: config 0 descriptor??
> > > peak_usb 1-1:0.146: PEAK-System PCAN-USB X6 v0 fw v0.0.0 (2 channels)
> > > ==================================================================
> > > BUG: KMSAN: kernel-usb-infoleak in usb_submit_urb+0x7ef/0x1f50
> > > drivers/usb/core/urb.c:405
> >
> > What does "kernel-usb-infoleak" mean?
>
> That means that the kernel put some uninitialized data into a request
> that was sent to a USB device.

Here's a better report for this bug:

https://syzkaller.appspot.com/text?tag=CrashReport&x=11dae8ec600000

This is a real bug, I was able to reproduce it with a hardware
reproducer and leak some kernel pointers AFAIR.

>
> >
> > Alan Stern
> >
