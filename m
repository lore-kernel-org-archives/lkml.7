Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A45C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 12:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EEB720578
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 12:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b9T8E9jV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbfHMMmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 08:42:54 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46792 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728210AbfHMMmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 08:42:54 -0400
Received: by mail-pg1-f195.google.com with SMTP id w3so14001553pgt.13
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 05:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iO0r/Q2PTTwanUo9MrAAWEPPhwUQzV3Z9Y9H9xAeP7k=;
        b=b9T8E9jVho/EQNCmNV8iS9GfM6aXWy0Hj/VX+6h0ie8h6BvidP8lRLw40xn3qrXGvd
         apTKLJFia8aGPXmsFDWR4qrpJ0QxBns/zkoG3fbkwH+uriyuKuCCPNbVM/GN9CSHPV38
         yw7bgqUBvApPBwwf1Uk6JZq9OtZ/Yr2I07QL3IPHvy67cItD9dAX93jbw4XT2ajNgc1T
         TlBv7R9p3+n2dkCKqh68vqyYQZS0jimoaQJ+SPjbA9gbUaUkl0eVxhy/WFe7SiuxqTAF
         pRTpcpyLusAjdbEqyK5QdOKJOrD0az8wlWBdcV1Mr09IpaH7hOylx8GmLmGFc6cY0WPo
         NtrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iO0r/Q2PTTwanUo9MrAAWEPPhwUQzV3Z9Y9H9xAeP7k=;
        b=Ux8hiImHQOMKCRSrrkP+tVv7sbxOK8UkGkViH8lw9bj8ABD5zp2/7Chmya/wgCF4+8
         uzkaBhgOy1ysNjMANoWk6wiVD3f3pZjp53XRJGavWvXKZ9+OMpBMjR0pB4U4UWwGrWQY
         GvkMLwkO2474xO+bcdcGx2rlM8pj4Jh6MXFIGpKPcfk+/nrPXW3fIs2x5ftPKtOjd9NJ
         kuLFgW7B527YuP4qFMYakQ5MZoFWVp6+GEdtz3srq4gRKZ01I+baJ6LYe/jIJYDhq5Zk
         EJWZrjkmRh86K3170x5vY7sgSUGuZUTFv4atm3/+Q1ZaizcHXi/udY/cglH18aIAFKnf
         b93Q==
X-Gm-Message-State: APjAAAX+scNYv6xEKhuCnQl1KG6ZIxweM68LTBkhuJnNALqqQa5297BO
        tzIkvlpffgEM14khC98EtDig1m6FFT7HYF9ECDFb6A==
X-Google-Smtp-Source: APXvYqxa3byCY4w2HG9zH/Hbxmm5K9jdz8LpPEd7hGPB9p5lN4woqcQivgp6jZJcyFjAqpWDcM/eQ7QZE5NbYFr8WFo=
X-Received: by 2002:a63:3006:: with SMTP id w6mr34717214pgw.440.1565700173316;
 Tue, 13 Aug 2019 05:42:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAAeHK+yPJR2kZ5Mkry+bGFVuedF9F76=5GdKkF1eLkr9FWyvqA@mail.gmail.com>
 <Pine.LNX.4.44L0.1908080958380.1652-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1908080958380.1652-100000@iolanthe.rowland.org>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 13 Aug 2019 14:42:42 +0200
Message-ID: <CAAeHK+xVKZ-pnGcijYJPpWQ_haWbuVSpD81TJhtRosOZsg-Rwg@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in device_release_driver_internal
To:     Alan Stern <stern@rowland.harvard.edu>,
        Oliver Neukum <oneukum@suse.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+1b2449b7b5dc240d107a@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 8, 2019 at 4:00 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Thu, 8 Aug 2019, Andrey Konovalov wrote:
>
> > On Thu, Aug 8, 2019 at 2:44 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> > >
> > > On Thu, Aug 8, 2019 at 2:28 PM Andrey Konovalov <andreyknvl@google.com> wrote:
> > > >
> > > > On Wed, Aug 7, 2019 at 8:31 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> > > > >
> > > > > On Wed, 7 Aug 2019, syzbot wrote:
> > > > >
> > > > > > Hello,
> > > > > >
> > > > > > syzbot has tested the proposed patch and the reproducer did not trigger
> > > > > > crash:
> > > > > >
> > > > > > Reported-and-tested-by:
> > > > > > syzbot+1b2449b7b5dc240d107a@syzkaller.appspotmail.com
> > > > > >
> > > > > > Tested on:
> > > > > >
> > > > > > commit:         6a3599ce usb-fuzzer: main usb gadget fuzzer driver
> > > > > > git tree:       https://github.com/google/kasan.git
> > > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=700ca426ab83faae
> > > > > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > > > > patch:          https://syzkaller.appspot.com/x/patch.diff?x=132eec8c600000
> > > > > >
> > > > > > Note: testing is done by a robot and is best-effort only.
> > > > >
> > > > > Andrey, is there any way to get the console output from this test?
> > > >
> > > > Dmitry, would it be possible to link console log for successful tests as well?
> > >
> > > Yes. Start by filing a feature request at
> > > https://github.com/google/syzkaller/issues
> >
> > Filed https://github.com/google/syzkaller/issues/1322
> >
> > Alan, for now I've applied your patch and run the reproducer manually:
> >
> > [   90.844643][   T74] usb 1-1: new high-speed USB device number 2
> > using dummy_hcd
> > [   91.085789][   T74] usb 1-1: Using ep0 maxpacket: 16
> > [   91.204698][   T74] usb 1-1: config 0 has an invalid interface
> > number: 234 but max is 0
> > [   91.209137][   T74] usb 1-1: config 0 has no interface number 0
> > [   91.211599][   T74] usb 1-1: config 0 interface 234 altsetting 0
> > endpoint 0x8D has an inva1
> > [   91.216162][   T74] usb 1-1: config 0 interface 234 altsetting 0
> > endpoint 0x7 has invalid 4
> > [   91.218211][   T74] usb 1-1: config 0 interface 234 altsetting 0
> > bulk endpoint 0x7 has inv4
> > [   91.220131][   T74] usb 1-1: config 0 interface 234 altsetting 0
> > bulk endpoint 0x8F has in0
> > [   91.222052][   T74] usb 1-1: New USB device found, idVendor=0421,
> > idProduct=0486, bcdDevic7
> > [   91.223851][   T74] usb 1-1: New USB device strings: Mfr=0,
> > Product=0, SerialNumber=0
> > [   91.233180][   T74] usb 1-1: config 0 descriptor??
> > [   91.270222][   T74] rndis_wlan 1-1:0.234: Refcount before probe: 3
> > [   91.275464][   T74] rndis_wlan 1-1:0.234: invalid descriptor buffer length
> > [   91.277558][   T74] usb 1-1: bad CDC descriptors
> > [   91.279716][   T74] rndis_wlan 1-1:0.234: Refcount after probe: 3
> > [   91.281378][   T74] rndis_host 1-1:0.234: Refcount before probe: 3
> > [   91.283303][   T74] rndis_host 1-1:0.234: invalid descriptor buffer length
> > [   91.284724][   T74] usb 1-1: bad CDC descriptors
> > [   91.286004][   T74] rndis_host 1-1:0.234: Refcount after probe: 3
> > [   91.287318][   T74] cdc_acm 1-1:0.234: Refcount before probe: 3
> > [   91.288513][   T74] cdc_acm 1-1:0.234: invalid descriptor buffer length
> > [   91.289835][   T74] cdc_acm 1-1:0.234: No union descriptor, testing
> > for castrated device
> > [   91.291555][   T74] cdc_acm 1-1:0.234: Refcount after probe: 3
> > [   91.292766][   T74] cdc_acm: probe of 1-1:0.234 failed with error -12
> > [   92.001549][   T96] usb 1-1: USB disconnect, device number 2
>
> Ah, that looks right, thank you.  The patch worked correctly -- good
> work Oliver!

Great! Just a reminder to submit the fix :)
