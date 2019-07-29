Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70375C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 11:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ED5721655
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 11:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387704AbfG2L0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 07:26:09 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:37086 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387483AbfG2L0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 07:26:08 -0400
Received: by mail-io1-f70.google.com with SMTP id v3so67254564ios.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 04:26:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc;
        bh=CiTsFwy01HY+45xZWkPRSyqJ30c3ZUdDwfNLV3u64lQ=;
        b=ofTIiRKCk2hHpHBWV0ZorvgwIf10ROak7n744jPywglTfVWhbJDz8/Jvp3y07UAOfe
         gRCiSOXmrgoct6yN3Ds/rd14bdL81+P4R/aK97ZzyS8jpUprHJckbG3M+Vu4EypMCehG
         pEAu5F4GcM7nXo+pdeLYjuPjWMxdna1h0X4R1fz75KktcnGaucWUI9CRFfBAaF9CGRin
         mVJhliwRlSGM5eIyInfLDWlra88a0l7LTyKa6S3721IVk+claEsQoFH2g6UKGZe1TvNJ
         Js2vk6TRGBvKlKKdQ5usXvr1mkVAGQWTV8u4UBDqoenq/e6Qqimifbgqg2+x5EjGrC81
         l+Vg==
X-Gm-Message-State: APjAAAWeT1etOivg4we0492BMNl2UpU+v8tvcp0avGue6hdOOhV4IGcW
        Dr9HEkvSC6KDrqRdwiyzAKMmEXhUbR/1/TPsboDx3d73PR+f
X-Google-Smtp-Source: APXvYqwO0ePpVSbSPAM3YZRYg1LDnzHtT0mXbTayoB4XQ1/jhncoTw791M2ecgXMexBfnxEQMcp11YASrxIWfcVCHWUqTzs/m9gD
MIME-Version: 1.0
X-Received: by 2002:a5d:9c46:: with SMTP id 6mr43195713iof.6.1564399567073;
 Mon, 29 Jul 2019 04:26:07 -0700 (PDT)
Date:   Mon, 29 Jul 2019 04:26:07 -0700
In-Reply-To: <1564399552.25582.8.camel@suse.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007b7990058ed028d0@google.com>
Subject: Re: Re: WARNING in iguanair_probe/usb_submit_urb
From:   syzbot <syzbot+01a77b82edaa374068e1@syzkaller.appspotmail.com>
To:     Oliver Neukum <oneukum@suse.com>
Cc:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, oneukum@suse.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Am Freitag, den 26.07.2019, 05:28 -0700 schrieb syzbot:
>> Hello,

>> syzbot found the following crash on:

>> HEAD commit:    6a3599ce usb-fuzzer: main usb gadget fuzzer driver
>> git tree:       https://github.com/google/kasan.git usb-fuzzer
>> console output: https://syzkaller.appspot.com/x/log.txt?x=164ab1f0600000
>> kernel config:   
>> https://syzkaller.appspot.com/x/.config?x=700ca426ab83faae
>> dashboard link:  
>> https://syzkaller.appspot.com/bug?extid=01a77b82edaa374068e1
>> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>> syz repro:       
>> https://syzkaller.appspot.com/x/repro.syz?x=143d7978600000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=134623f4600000

>> IMPORTANT: if you fix the bug, please add the following tag to the  
>> commit:
>> Reported-by: syzbot+01a77b82edaa374068e1@syzkaller.appspotmail.com

> #syz test: https://github.com/google/kasan.git  
> usb-fuzzer-usb-testing-2019.07.11]

"usb-fuzzer-usb-testing-2019.07.11]" does not look like a valid git branch  
or commit.


>  From 0b0a7f7e980973e0c0d17f1dfe2bd7742492bfcc Mon Sep 17 00:00:00 2001
> From: Oliver Neukum <oneukum@suse.com>
> Date: Mon, 29 Jul 2019 11:49:00 +0200
> Subject: [PATCH] iguanair: add sanity checks

> The driver needs to check the endpoint types, too, as opposed
> to the number of endpoints. This also requires moving the check earlier.

> Reported-by: syzbot+01a77b82edaa374068e1@syzkaller.appspotmail.com
> Signed-off-by: Oliver Neukum <oneukum@suse.com>
> ---
>   drivers/media/rc/iguanair.c | 15 +++++++--------
>   1 file changed, 7 insertions(+), 8 deletions(-)

> diff --git a/drivers/media/rc/iguanair.c b/drivers/media/rc/iguanair.c
> index ea05e125016a..663083a6b399 100644
> --- a/drivers/media/rc/iguanair.c
> +++ b/drivers/media/rc/iguanair.c
> @@ -413,6 +413,10 @@ static int iguanair_probe(struct usb_interface *intf,
>   	int ret, pipein, pipeout;
>   	struct usb_host_interface *idesc;

> +	idesc = intf->altsetting;
> +	if (idesc->desc.bNumEndpoints < 2)
> +		return -ENODEV;
> +
>   	ir = kzalloc(sizeof(*ir), GFP_KERNEL);
>   	rc = rc_allocate_device(RC_DRIVER_IR_RAW);
>   	if (!ir || !rc) {
> @@ -427,18 +431,13 @@ static int iguanair_probe(struct usb_interface  
> *intf,
>   	ir->urb_in = usb_alloc_urb(0, GFP_KERNEL);
>   	ir->urb_out = usb_alloc_urb(0, GFP_KERNEL);

> -	if (!ir->buf_in || !ir->packet || !ir->urb_in || !ir->urb_out) {
> +	if (!ir->buf_in || !ir->packet || !ir->urb_in || !ir->urb_out ||
> +			!usb_endpoint_is_int_in(&idesc->endpoint[0].desc) ||
> +			!usb_endpoint_is_int_out(&idesc->endpoint[1].desc)) {
>   		ret = -ENOMEM;
>   		goto out;
>   	}

> -	idesc = intf->altsetting;
> -
> -	if (idesc->desc.bNumEndpoints < 2) {
> -		ret = -ENODEV;
> -		goto out;
> -	}
> -
>   	ir->rc = rc;
>   	ir->dev = &intf->dev;
>   	ir->udev = udev;
> --
> 2.16.4

