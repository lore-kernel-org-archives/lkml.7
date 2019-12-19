Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5465C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C43C2465E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576781158;
	bh=Q6IPlbKphm9Ek82Zr/DSnj+WRQWNrsOn12LL6QQn+jg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fYB93VFVUdL/z6pN3R6LZDHX2NWMgq6KWati0Y8bVxa7i7DF9aWxZatkZJLqAxc7B
	 EHzWgakHT3zeRN1TCk+EhircUqt2ZjPLSWTRCG0CvgF3tAV7pY2MUm+pBc3foyA4Td
	 GIKt9m883d1pzE9oEVu/4HKQGmfZ+1BQKNekeD2k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729262AbfLSSp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:45:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:38414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728736AbfLSSpx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:45:53 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9058824679;
        Thu, 19 Dec 2019 18:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576781153;
        bh=Q6IPlbKphm9Ek82Zr/DSnj+WRQWNrsOn12LL6QQn+jg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d23EYSXK5qxfTHU/HdGT7hJNH+PEKLYOe4xrnajc+tZennVXWwB1Ffa0m4zcbhzzS
         nQwkbKe89SSvZnuwu8ekuyxpbuhu0R32Z2Eq3VItqfXARGeBPcbe2J+WhA/IBIdyKu
         VT1v2Wu8LFE0t84XeXUieXkfbxHSvR8krv1U7VKU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.9 104/199] staging: gigaset: add endpoint-type sanity check
Date:   Thu, 19 Dec 2019 19:33:06 +0100
Message-Id: <20191219183220.650160944@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219183214.629503389@linuxfoundation.org>
References: <20191219183214.629503389@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

commit ed9ed5a89acba51b82bdff61144d4e4a4245ec8a upstream.

Add missing endpoint-type sanity checks to probe.

This specifically prevents a warning in USB core on URB submission when
fuzzing USB descriptors.

Signed-off-by: Johan Hovold <johan@kernel.org>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20191202085610.12719-4-johan@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/isdn/gigaset/usb-gigaset.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/drivers/isdn/gigaset/usb-gigaset.c
+++ b/drivers/isdn/gigaset/usb-gigaset.c
@@ -708,6 +708,12 @@ static int gigaset_probe(struct usb_inte
 
 	endpoint = &hostif->endpoint[0].desc;
 
+	if (!usb_endpoint_is_bulk_out(endpoint)) {
+		dev_err(&interface->dev, "missing bulk-out endpoint\n");
+		retval = -ENODEV;
+		goto error;
+	}
+
 	buffer_size = le16_to_cpu(endpoint->wMaxPacketSize);
 	ucs->bulk_out_size = buffer_size;
 	ucs->bulk_out_epnum = usb_endpoint_num(endpoint);
@@ -727,6 +733,12 @@ static int gigaset_probe(struct usb_inte
 
 	endpoint = &hostif->endpoint[1].desc;
 
+	if (!usb_endpoint_is_int_in(endpoint)) {
+		dev_err(&interface->dev, "missing int-in endpoint\n");
+		retval = -ENODEV;
+		goto error;
+	}
+
 	ucs->busy = 0;
 
 	ucs->read_urb = usb_alloc_urb(0, GFP_KERNEL);


