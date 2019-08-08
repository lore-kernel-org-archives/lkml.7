Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6664AC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 13:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FE472171F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 13:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d8fYu5+z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732894AbfHHNEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 09:04:05 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43895 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732429AbfHHNEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 09:04:04 -0400
Received: by mail-pf1-f195.google.com with SMTP id i189so44085404pfg.10
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 06:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5JZUTLmHdma6tGN31r/68Q00SumRXcOKJcsJJ56qTLo=;
        b=d8fYu5+zH0QvJ6tdHCtn9wmhJ6iOadbV/6PoPlxHA7ETmmqHZBlhVdiVKtuBMH8/y3
         zrcs0zHXM3VahG+f354L1rr9cdXhg7S1t9YZccEDK83hhwl0doOsEZBNGheFiZKED8h4
         fyGEOwmVJMJ89HcYlst1pBnHbzLH46Y52INVLIzvR3FNHulcrQHKsQF1tJM/7FIn2VUY
         N1dVufFV9jKoYcaNVwCXohWhfKgf2QVvzXLcINGFNQ4lOPm7/VetoZP04Y74zT3DyWAw
         5meCQ7qeb6dSeRx4X+KzadjB3xd73FFfLs9pdrR/SnKqYceO5KzPA7oZjsHIORc/VUEn
         JggQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5JZUTLmHdma6tGN31r/68Q00SumRXcOKJcsJJ56qTLo=;
        b=fOVVpH/0Qhm9CPyLtrJ8i7KiJRNuExWYs30JjNVxcnJoihRTFBzPVr+v3tG9Hx3JII
         qpOqPsHAftJL4OAUBfUw/c/mhzGdXyzf0RkygwQ/JD8Nnn1KNIMrVOnIHjhoigfQH01d
         kB24xpEDgy0zBTgYcEVufAPXCvHnC99z+9vmdGbVafsO7ae3re2vVHxYkv0m31FpvW2z
         L1kcO1dnW4PyqicJfdOknv9RbgFzdahxT0ipzbyzbwWO+Nza89sY4lmilTTvnC3D5FSV
         LqJYjaI1zjEDWH1iKNmCeLGTZ3CSFRmYFpC/adguNNXvJr7930DdBSW21tpBwFxQZ/k8
         yBtQ==
X-Gm-Message-State: APjAAAWOs35WH/mTI6bBHsmI50cJNOKzfjlXLskMBrFShDPHge3yRL4E
        SUbQuDtfujRPHu+xOCGksGLCJvApkEHlD+73oN1kbA==
X-Google-Smtp-Source: APXvYqze1tdh4/k1fLy0z5pw573eZyhbGcFIKEVhtKivn9GtZHPjML4I21AoZyCfxE2lM/5u+0CWE2mAD5k4AZKL47o=
X-Received: by 2002:a17:90a:2488:: with SMTP id i8mr3894140pje.123.1565269443502;
 Thu, 08 Aug 2019 06:04:03 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000f365b6058f8b07ca@google.com> <Pine.LNX.4.44L0.1908071431050.1514-100000@iolanthe.rowland.org>
 <CAAeHK+xh6h=HBEpwPB7g2=a07+zZ9zS5Cuk0Tpo_+70Bf5j9Tw@mail.gmail.com> <CACT4Y+ZD=YYvLER5jDAvCbw3kBKcNkQJEJN5yFc7O6aLaFORDg@mail.gmail.com>
In-Reply-To: <CACT4Y+ZD=YYvLER5jDAvCbw3kBKcNkQJEJN5yFc7O6aLaFORDg@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 8 Aug 2019 15:03:51 +0200
Message-ID: <CAAeHK+yPJR2kZ5Mkry+bGFVuedF9F76=5GdKkF1eLkr9FWyvqA@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in device_release_driver_internal
To:     Dmitry Vyukov <dvyukov@google.com>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     syzbot <syzbot+1b2449b7b5dc240d107a@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Oliver Neukum <oneukum@suse.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 8, 2019 at 2:44 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Thu, Aug 8, 2019 at 2:28 PM Andrey Konovalov <andreyknvl@google.com> wrote:
> >
> > On Wed, Aug 7, 2019 at 8:31 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> > >
> > > On Wed, 7 Aug 2019, syzbot wrote:
> > >
> > > > Hello,
> > > >
> > > > syzbot has tested the proposed patch and the reproducer did not trigger
> > > > crash:
> > > >
> > > > Reported-and-tested-by:
> > > > syzbot+1b2449b7b5dc240d107a@syzkaller.appspotmail.com
> > > >
> > > > Tested on:
> > > >
> > > > commit:         6a3599ce usb-fuzzer: main usb gadget fuzzer driver
> > > > git tree:       https://github.com/google/kasan.git
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=700ca426ab83faae
> > > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > > patch:          https://syzkaller.appspot.com/x/patch.diff?x=132eec8c600000
> > > >
> > > > Note: testing is done by a robot and is best-effort only.
> > >
> > > Andrey, is there any way to get the console output from this test?
> >
> > Dmitry, would it be possible to link console log for successful tests as well?
>
> Yes. Start by filing a feature request at
> https://github.com/google/syzkaller/issues

Filed https://github.com/google/syzkaller/issues/1322

Alan, for now I've applied your patch and run the reproducer manually:

[   90.844643][   T74] usb 1-1: new high-speed USB device number 2
using dummy_hcd
[   91.085789][   T74] usb 1-1: Using ep0 maxpacket: 16
[   91.204698][   T74] usb 1-1: config 0 has an invalid interface
number: 234 but max is 0
[   91.209137][   T74] usb 1-1: config 0 has no interface number 0
[   91.211599][   T74] usb 1-1: config 0 interface 234 altsetting 0
endpoint 0x8D has an inva1
[   91.216162][   T74] usb 1-1: config 0 interface 234 altsetting 0
endpoint 0x7 has invalid 4
[   91.218211][   T74] usb 1-1: config 0 interface 234 altsetting 0
bulk endpoint 0x7 has inv4
[   91.220131][   T74] usb 1-1: config 0 interface 234 altsetting 0
bulk endpoint 0x8F has in0
[   91.222052][   T74] usb 1-1: New USB device found, idVendor=0421,
idProduct=0486, bcdDevic7
[   91.223851][   T74] usb 1-1: New USB device strings: Mfr=0,
Product=0, SerialNumber=0
[   91.233180][   T74] usb 1-1: config 0 descriptor??
[   91.270222][   T74] rndis_wlan 1-1:0.234: Refcount before probe: 3
[   91.275464][   T74] rndis_wlan 1-1:0.234: invalid descriptor buffer length
[   91.277558][   T74] usb 1-1: bad CDC descriptors
[   91.279716][   T74] rndis_wlan 1-1:0.234: Refcount after probe: 3
[   91.281378][   T74] rndis_host 1-1:0.234: Refcount before probe: 3
[   91.283303][   T74] rndis_host 1-1:0.234: invalid descriptor buffer length
[   91.284724][   T74] usb 1-1: bad CDC descriptors
[   91.286004][   T74] rndis_host 1-1:0.234: Refcount after probe: 3
[   91.287318][   T74] cdc_acm 1-1:0.234: Refcount before probe: 3
[   91.288513][   T74] cdc_acm 1-1:0.234: invalid descriptor buffer length
[   91.289835][   T74] cdc_acm 1-1:0.234: No union descriptor, testing
for castrated device
[   91.291555][   T74] cdc_acm 1-1:0.234: Refcount after probe: 3
[   91.292766][   T74] cdc_acm: probe of 1-1:0.234 failed with error -12
[   92.001549][   T96] usb 1-1: USB disconnect, device number 2
