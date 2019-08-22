Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92FBCC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60A572064A
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566495194;
	bh=H9PxVcmkwzH7ZZsM5nkJr9QnieR3VHq7pO6yyAPZ9XM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=e6kRUxYDqMxZX9TCqQuype0e8dtLw0Ge5TCOOckwg+jOzeD94M0vcUfxSlIn6a1fz
	 7chMV8OS4o3mb4bVIZUgadPR+9CY2l54eBBbucp7slRgEEgV43iGTcJ+Xrk6IqA0qh
	 A9MoYGhw9SCcGWJl2DAogd1Sc2Sy8G8a5u8hP2PU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404018AbfHVRdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:33:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:49230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391842AbfHVRZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:25:32 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9F3C2341E;
        Thu, 22 Aug 2019 17:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566494730;
        bh=H9PxVcmkwzH7ZZsM5nkJr9QnieR3VHq7pO6yyAPZ9XM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aCi7tSu0+LWSh7WZQjPGGU/Iw8ce6snzAnQMvvBeW2LMsYHoyTP+T2p9xT3EShLol
         V4vp/L83LPpFKSkGkeMs4Sm0PA0szWJ9WHOBwEqFuNgtqsFoqrb9cr0+/8qYN5reB8
         bCarBRCWp9WTPexOiWioqbxKTqhlRogma9coIHbk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+c7df50363aaff50aa363@syzkaller.appspotmail.com,
        Oliver Neukum <oneukum@suse.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.19 21/85] Input: kbtab - sanity check for endpoint type
Date:   Thu, 22 Aug 2019 10:18:54 -0700
Message-Id: <20190822171732.079738646@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190822171731.012687054@linuxfoundation.org>
References: <20190822171731.012687054@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oliver Neukum <oneukum@suse.com>

commit c88090dfc84254fa149174eb3e6a8458de1912c4 upstream.

The driver should check whether the endpoint it uses has the correct
type.

Reported-by: syzbot+c7df50363aaff50aa363@syzkaller.appspotmail.com
Signed-off-by: Oliver Neukum <oneukum@suse.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/tablet/kbtab.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/input/tablet/kbtab.c
+++ b/drivers/input/tablet/kbtab.c
@@ -116,6 +116,10 @@ static int kbtab_probe(struct usb_interf
 	if (intf->cur_altsetting->desc.bNumEndpoints < 1)
 		return -ENODEV;
 
+	endpoint = &intf->cur_altsetting->endpoint[0].desc;
+	if (!usb_endpoint_is_int_in(endpoint))
+		return -ENODEV;
+
 	kbtab = kzalloc(sizeof(struct kbtab), GFP_KERNEL);
 	input_dev = input_allocate_device();
 	if (!kbtab || !input_dev)
@@ -154,8 +158,6 @@ static int kbtab_probe(struct usb_interf
 	input_set_abs_params(input_dev, ABS_Y, 0, 0x1750, 4, 0);
 	input_set_abs_params(input_dev, ABS_PRESSURE, 0, 0xff, 0, 0);
 
-	endpoint = &intf->cur_altsetting->endpoint[0].desc;
-
 	usb_fill_int_urb(kbtab->irq, dev,
 			 usb_rcvintpipe(dev, endpoint->bEndpointAddress),
 			 kbtab->data, 8,


