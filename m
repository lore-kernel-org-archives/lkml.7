Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1934C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 15:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0D662067D
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 15:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="plCQiKwv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729912AbfHMPIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 11:08:34 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44781 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729580AbfHMPIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 11:08:34 -0400
Received: by mail-pl1-f195.google.com with SMTP id t14so49369535plr.11
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 08:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kvzvYiVI29Y9ntn+ryKpnR+ICsnBopPzX57yon+8Oy4=;
        b=plCQiKwvw2+YgYk60znqOklxNzoI7y84NBD+ZHbfdiHskhSGauDzPp6ohFNvBjG/D2
         PtAVMUuNgg5qL0KfC7RvCRdYBC8Kz61qHA4Iqyz8refbx5B1NnaVnhTDZ7nt+UDWJXx6
         9u04By1ECDXLLmx5PDqTizk80kcVAnmf9+NK74krT+RraUpDWqJ1+Uod284ljJxj2qyC
         1dx0g8CV06IzwzisfjPCTaeWhXpw+nzmDE4PDC5D6jpeWLBi0i7qua+HsTlsDpTDDCAY
         NSC5N+SdZY8ly6wloFBiTnZzy/w9GRmVk78hsdYfSB7o4Rp+ozdMa1IKvAcQ3Tlf/xlJ
         2Pjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kvzvYiVI29Y9ntn+ryKpnR+ICsnBopPzX57yon+8Oy4=;
        b=GOrSBvwQwwAuagggSud9O88iUAQwEOWMG/8c21EPfYQfqz6giMPq1slGUHfX0Y58av
         NdefQBHE/Lh9SEnFinj/AHzZeplDV37BH5wamKz1qWvzFIxQaUXH6QcnnMkvRiJqcL8c
         mw7R6Y7AHhxsnQJmUxLjstIbeimMKxeoK/FCjEL5pmuurKAdqFnUR3OlPSynjTwksb07
         iBegCv3ga+2Q0vqUV9nH9H8MTUqFn78uHuSihTl2bIDEnEIj5Ds9ZaxIqsa2rF+3ECQA
         zI1ivNjtiVM/y8Uu4QuAMZOfoOOUL0aQH5WswIpPySMcMi0Xeu0pJUA/zh6b0xG1IKju
         FKBg==
X-Gm-Message-State: APjAAAVH/+u4zi3/On1DqTzCIO6gAr0bkn3um40HS/SP6l5UVwGlT3a0
        o3U3ojlemPjxEL4yaNwCQHBxBkhoM64dioSrBOhx2w==
X-Google-Smtp-Source: APXvYqzdoi8AKGpLReePEcFTfBvkJgD5Tp6bChwGAluy0B2KObFT7If8UITqQVL8NbmfkPj0Yz0aMOom+0YYfU3SXOc=
X-Received: by 2002:a17:902:8649:: with SMTP id y9mr10521777plt.252.1565708913012;
 Tue, 13 Aug 2019 08:08:33 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000009f4316058fab3bd7@google.com> <1565700220.7043.8.camel@suse.com>
In-Reply-To: <1565700220.7043.8.camel@suse.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 13 Aug 2019 17:08:21 +0200
Message-ID: <CAAeHK+zzj_+Qvm217KO2OHnfBMWbepP0Y-OYTWpOw3ghe5ji=g@mail.gmail.com>
Subject: Re: KMSAN: uninit-value in smsc75xx_bind
To:     Oliver Neukum <oneukum@suse.com>
Cc:     syzbot <syzbot+6966546b78d050bb0b5d@syzkaller.appspotmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexander Potapenko <glider@google.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        steve.glendinning@shawell.net, LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 2:43 PM Oliver Neukum <oneukum@suse.com> wrote:
>
> Am Freitag, den 09.08.2019, 01:48 -0700 schrieb syzbot:
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    beaab8a3 fix KASAN build
> > git tree:       kmsan
>
> [..]
> > Call Trace:
> >   __dump_stack lib/dump_stack.c:77 [inline]
> >   dump_stack+0x191/0x1f0 lib/dump_stack.c:113
> >   kmsan_report+0x162/0x2d0 mm/kmsan/kmsan_report.c:109
> >   __msan_warning+0x75/0xe0 mm/kmsan/kmsan_instr.c:294
> >   smsc75xx_wait_ready drivers/net/usb/smsc75xx.c:976 [inline]
> >   smsc75xx_bind+0x541/0x12d0 drivers/net/usb/smsc75xx.c:1483
>
> >
> > Local variable description: ----buf.i93@smsc75xx_bind
> > Variable was created at:
> >   __smsc75xx_read_reg drivers/net/usb/smsc75xx.c:83 [inline]
> >   smsc75xx_wait_ready drivers/net/usb/smsc75xx.c:969 [inline]
> >   smsc75xx_bind+0x44c/0x12d0 drivers/net/usb/smsc75xx.c:1483
> >   usbnet_probe+0x10d3/0x3950 drivers/net/usb/usbnet.c:1722
>
> Hi,
>
> this looks like a false positive to me.
> The offending code is likely this:
>
>         if (size) {
>                 buf = kmalloc(size, GFP_KERNEL);
>                 if (!buf)
>                         goto out;
>         }
>
>         err = usb_control_msg(dev->udev, usb_rcvctrlpipe(dev->udev, 0),
>                               cmd, reqtype, value, index, buf, size,
>                               USB_CTRL_GET_TIMEOUT);
>
> which uses 'buf' uninitialized. But it is used for input.
> What is happening here?

AFAICS, the uninitialized use of buf that KMSAN points out is in the
"if (buf & PMT_CTL_DEV_RDY)"  statement in smsc75xx_wait_ready(). Does
__smsc75xx_read_reg/usb_control_msg() always initialize buf? Can it
just initialize the first few bytes for example?
