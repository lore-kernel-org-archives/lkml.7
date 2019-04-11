Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E730C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 04:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AA8D2133D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 04:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="muYigyzb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfDKExN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 00:53:13 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40015 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfDKExN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 00:53:13 -0400
Received: by mail-pg1-f194.google.com with SMTP id d31so2880938pgl.7;
        Wed, 10 Apr 2019 21:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=H9nY8iNaZVs1gJ4a8s1vdIeA0z1Cjhl83ySRigIl/zY=;
        b=muYigyzbLhAtC4O6/zUYRpb0j+skor1QhAWT4b9r1/FsQheJMx3o/OWCBTkrJJw5CF
         ahkGe+3DMqBwj5Z9rl4n9XoeA9kc4KIX0Oe2BFZhrCdhs4OMpW3SunBYQEf26GG/EuyK
         MdMeeizGU7cQPdBFDa1roE5B03ocj/9Ck9w5d3z2NAvgAgPQRDdp8BdgUBw97i0AD4uL
         HJLc7PtBnggJEFUeg4bh3QoXkgUj9/Thteew8vE4hWw98bSaf6t22WSaCt4AAWytJz6p
         zRY7R/KdIgjRtXxBrLW0R/hxkAmjXPv5VBfbfgFJ2vpcuVoTpdBxZdK7LDfAaE8G9nGU
         MmOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=H9nY8iNaZVs1gJ4a8s1vdIeA0z1Cjhl83ySRigIl/zY=;
        b=sha5Tt9YaTEFGUWCXUom/Nr9WM/6F+cVw3ShH1NjrSuszJg9Xb6vZl8zRuuYgV0kQB
         S7dXN1vQqbGoMPODBmcPlIwpxuKrsaRV3UUyYr0tGF9I5d6fT8pniyn15U7qxueKcPty
         tTkUNyM2j9WEy5kpQ2ffeSZd4928Nj4OK//Ubg0XKsgUEvEi2oHxaNZ56E7k1LQ8U61x
         Y7h7xTt0AjekTl5D1FrG5AImiKo/stz4oSqlnCQxDL8zK2/kUyn0CEvdFQ8yGSjvFDwF
         b+ex6ZbnPGxBMbhbVH64mUctZqKPD2aLjyUy1S/1nOVRvM72bL28bvVePs/u3XtAgGEE
         qNVw==
X-Gm-Message-State: APjAAAVUuvMFg0fv1tAidb/GYjhJDYJUMUk4NznRtdBoZ7PDmY2UscD1
        XNNUrxjjWmLMERqgUOpGaQPCcKDD2+EYTA==
X-Google-Smtp-Source: APXvYqx37fQ3MuLvZ6Oa9BIG+ZcRGILC6u/rUvVls9NOpYP5ssm9rbeTuKWMVHC3o3NWU0jSToSd1w==
X-Received: by 2002:aa7:8282:: with SMTP id s2mr47948072pfm.7.1554958392497;
        Wed, 10 Apr 2019 21:53:12 -0700 (PDT)
Received: from xy-data.openstacklocal (ecs-159-138-22-150.compute.hwclouds-dns.com. [159.138.22.150])
        by smtp.gmail.com with ESMTPSA id b72sm77974736pga.86.2019.04.10.21.53.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 10 Apr 2019 21:53:12 -0700 (PDT)
From:   Young Xiao <92siuyang@gmail.com>
To:     linux-usb@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, greg@kroah.com
Cc:     mchehab@kernel.org, keescook@chromium.org, hans.verkuil@cisco.com,
        Young Xiao <YangX92@hotmail.com>
Subject: [PATCH] USB: s2255 & stkwebcam: fix oops with malicious USB descriptors
Date:   Thu, 11 Apr 2019 12:54:12 +0800
Message-Id: <1554958452-29794-1-git-send-email-92siuyang@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Young Xiao <YangX92@hotmail.com>

The driver expects at least one valid endpoint. If given
malicious descriptors that specify 0 for the number of endpoints,
it will crash in the probe function.  Ensure there is at least
one endpoint on the interface before using it.

This vulnerability is same as CVE-2016-2188.

Signed-off-by: Young Xiao <YangX92@hotmail.com>
---
 drivers/media/usb/s2255/s2255drv.c       | 7 +++++++
 drivers/media/usb/stkwebcam/stk-webcam.c | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/media/usb/s2255/s2255drv.c b/drivers/media/usb/s2255/s2255drv.c
index 5b3e54b..7fdf159 100644
--- a/drivers/media/usb/s2255/s2255drv.c
+++ b/drivers/media/usb/s2255/s2255drv.c
@@ -2263,6 +2263,13 @@ static int s2255_probe(struct usb_interface *interface,
 	iface_desc = interface->cur_altsetting;
 	dev_dbg(&interface->dev, "num EP: %d\n",
 		iface_desc->desc.bNumEndpoints);
+
+	if (iface_desc->desc.bNumEndpoints < 1) {
+		dev_err(&interface->dev, "Invalid number of endpoints\n");
+		retval = -EINVAL;
+		goto error;
+	}
+
 	for (i = 0; i < iface_desc->desc.bNumEndpoints; ++i) {
 		endpoint = &iface_desc->endpoint[i].desc;
 		if (!dev->read_endpoint && usb_endpoint_is_bulk_in(endpoint)) {
diff --git a/drivers/media/usb/stkwebcam/stk-webcam.c b/drivers/media/usb/stkwebcam/stk-webcam.c
index 8f54586..d2a4785 100644
--- a/drivers/media/usb/stkwebcam/stk-webcam.c
+++ b/drivers/media/usb/stkwebcam/stk-webcam.c
@@ -1350,6 +1350,12 @@ static int stk_camera_probe(struct usb_interface *interface,
 	 * for the current alternate setting */
 	iface_desc = interface->cur_altsetting;
 
+	if (iface_desc->desc.bNumEndpoints < 1) {
+		dev_err(&interface->dev, "Invalid number of endpoints\n");
+		retval = -EINVAL;
+		goto error;
+	}
+
 	for (i = 0; i < iface_desc->desc.bNumEndpoints; ++i) {
 		endpoint = &iface_desc->endpoint[i].desc;
 
-- 
1.9.1

