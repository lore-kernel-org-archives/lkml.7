Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DEFAC2D0BF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED6AD206EC
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576521340;
	bh=mg2DCLQ8QFo+1Hd5CR7rqVt1ibBM/8B3A2AtloUxIbo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xMhjn1rEFoZe96l1ctzRZVNnnwHSga02PFrVxcrSbT9GS5ef6XIWsdMXmLePUZY4/
	 3dQ8SqBd+yYjtiZEHL+J58Mm+8Rmmr46bO7ndad+I+9jrZoj1gh+pbQkIgEHMwEGZa
	 7Hi/Iz1RBJSkPP+Fz9GssVb40RbbBAkXkeajJId0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730190AbfLPSHt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:07:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:48942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730180AbfLPSHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:07:45 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FE7F20700;
        Mon, 16 Dec 2019 18:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576519664;
        bh=mg2DCLQ8QFo+1Hd5CR7rqVt1ibBM/8B3A2AtloUxIbo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G/p8yfaHeKpWiT29rIG68THUlgrkiNNy8zf5kTICWZ0AGr/moV26j/V2gnuxD6jhc
         r7/9Mben0X7fzcn/xC4vIPYkLgBtf9C5bPSGo5HJjcW4AidBmO1P2FXGdnsgQZNHBZ
         tHS/bE3ntFP7cURxHGRTEJlAZi0Ax2ZVKWBiLn0M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 5.3 019/180] staging: gigaset: add endpoint-type sanity check
Date:   Mon, 16 Dec 2019 18:47:39 +0100
Message-Id: <20191216174810.567713865@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174806.018988360@linuxfoundation.org>
References: <20191216174806.018988360@linuxfoundation.org>
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
 drivers/staging/isdn/gigaset/usb-gigaset.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/drivers/staging/isdn/gigaset/usb-gigaset.c
+++ b/drivers/staging/isdn/gigaset/usb-gigaset.c
@@ -705,6 +705,12 @@ static int gigaset_probe(struct usb_inte
 
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
@@ -724,6 +730,12 @@ static int gigaset_probe(struct usb_inte
 
 	endpoint = &hostif->endpoint[1].desc;
 
+	if (!usb_endpoint_is_int_in(endpoint)) {
+		dev_err(&interface->dev, "missing int-in endpoint\n");
+		retval = -ENODEV;
+		goto error;
+	}
+
 	ucs->busy = 0;
 
 	ucs->read_urb = usb_alloc_urb(0, GFP_KERNEL);


