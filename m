Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F9BC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7700323400
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566496050;
	bh=9wy+n8dSBS6TzbMdKj/1fdDR1OssBlS0d1bS0Qh32tg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SLG7mLtTSaQ5wLR1cB9Ny1A6+e2/ULAcgogmcWzN5uUVp8Z6UtAlAAb/abdAVaWAT
	 ABxiZkWG7urHyWkjq0XT0hfGEeF2KfIcObHU3p2YMcxGNAfNhXTeXOCJCzitETpd7K
	 hI32AvoC0332vFPBkBVTI+lHIbM7fW1Ls3tC6Nr0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393197AbfHVRr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:47:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:41022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391388AbfHVRWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:22:36 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E4F2233FD;
        Thu, 22 Aug 2019 17:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566494555;
        bh=9wy+n8dSBS6TzbMdKj/1fdDR1OssBlS0d1bS0Qh32tg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kMvhU1+HbAAscoGzf1pOqOEP+Pjdvf6XVS9hXiEffVDRKSc8yfR1p7LB4hfWTiO76
         V//bNDfZ38zEqR0f6dE+VqaxWWM43UeeXfXtmz19ixJTSt1eH05qq/2cfgOXRo5UHa
         vmPbhkoSx4Qtl4ocJ6/FcjQH8ME1FoNeBXuiVaqc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+c7df50363aaff50aa363@syzkaller.appspotmail.com,
        Oliver Neukum <oneukum@suse.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.4 41/78] Input: kbtab - sanity check for endpoint type
Date:   Thu, 22 Aug 2019 10:18:45 -0700
Message-Id: <20190822171833.231567998@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190822171832.012773482@linuxfoundation.org>
References: <20190822171832.012773482@linuxfoundation.org>
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
@@ -125,6 +125,10 @@ static int kbtab_probe(struct usb_interf
 	if (intf->cur_altsetting->desc.bNumEndpoints < 1)
 		return -ENODEV;
 
+	endpoint = &intf->cur_altsetting->endpoint[0].desc;
+	if (!usb_endpoint_is_int_in(endpoint))
+		return -ENODEV;
+
 	kbtab = kzalloc(sizeof(struct kbtab), GFP_KERNEL);
 	input_dev = input_allocate_device();
 	if (!kbtab || !input_dev)
@@ -164,8 +168,6 @@ static int kbtab_probe(struct usb_interf
 	input_set_abs_params(input_dev, ABS_Y, 0, 0x1750, 4, 0);
 	input_set_abs_params(input_dev, ABS_PRESSURE, 0, 0xff, 0, 0);
 
-	endpoint = &intf->cur_altsetting->endpoint[0].desc;
-
 	usb_fill_int_urb(kbtab->irq, dev,
 			 usb_rcvintpipe(dev, endpoint->bEndpointAddress),
 			 kbtab->data, 8,


