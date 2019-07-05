Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED0CC46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 16:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55D5E20843
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 16:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a0ThgoYR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbfGEQok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 12:44:40 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35500 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfGEQoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 12:44:39 -0400
Received: by mail-pl1-f195.google.com with SMTP id w24so4845385plp.2;
        Fri, 05 Jul 2019 09:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KJ5855deFkI0inaFjcxUiNCdDNOUCPkIvrgPZx7bNIE=;
        b=a0ThgoYRFV/ytab7vokWaj9VAKN2cyDr/TGN5sa4JoUx8IRqV2Wu9JRXXYgG8e7FsT
         zX9zAeEjU+O21xRuLZ7jVPFeoutpPopij/qlPo2yftLtFtZDRoNAZE/XShe3FFSwM7EO
         wZnoZeTi2J3Xp7qh3PtB3ZiBNK3frgoptEJhyG0uCSu7A5faXtwZM9kuW9KTQnx2uJEp
         MhKiyQuoTwkRsVLOoEsya20cLz0x0xTs8AOeh71CVF/2U9B5KNyxZSitwk2/oONgaYZO
         KdA0b7Qj1y5+TwhbuwCQj3gAckffCUJEWLWCRrd0Rk58WlMHkjprr1lrmwIkM7BWsg0r
         7IcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KJ5855deFkI0inaFjcxUiNCdDNOUCPkIvrgPZx7bNIE=;
        b=iI4xFvzKjlXV5tR1oQ3QcNR4Dw5s7hVEd9gO4XU6mGYlOaV+0zpGpqEgmbai2ygbaA
         gkVqMGFEa8foBbqlGXbbZT+wG+IjjFIDM+2YYgGXlQcd62E4RYpbkOlFmDqAHIX+dZqs
         PaZf5z6DTc4uiTNg7g2RU6O0ggioSnJS3xC3jtBJ+8S+Lbr/BAzCG8/DiKE0zJwDVwgw
         /xTHEybD8ROjzQ+6wiE+iWO3uwG7NsholOJKkNdOFwaqBtbI09am+szWwYPRs/JWq1Tq
         Vq4RewaSfPRB2sX16bTX6SBSQCTZUOh23oQ8egjhR/v3iutSXYdsmGJSn+cuF3F2DKhf
         j9lg==
X-Gm-Message-State: APjAAAVcbmINNgBg0DDStH20Up2VRb8/wGf6aPbcMHQCL+25C+w8D2gc
        RWaJgR+VNz6P442XjGxi6l2sWqw+tz0=
X-Google-Smtp-Source: APXvYqzA4CjtUmonkmE6WlmahmYMEC6TzLuD4lEyNozg6RdTqpz4bEqwTOm4+5FzVKQg0pgwyoOznw==
X-Received: by 2002:a17:902:b215:: with SMTP id t21mr6785513plr.123.1562345078611;
        Fri, 05 Jul 2019 09:44:38 -0700 (PDT)
Received: from localhost.localdomain ([125.142.23.13])
        by smtp.googlemail.com with ESMTPSA id n89sm22033297pjc.0.2019.07.05.09.44.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Jul 2019 09:44:38 -0700 (PDT)
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     shuah@kernel.org, valentina.manea.m@gmail.com,
        stern@rowland.harvard.edu, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Suwan Kim <suwan.kim027@gmail.com>
Subject: [PATCH v2 2/2] usbip: Implement SG support to vhci
Date:   Sat,  6 Jul 2019 01:43:55 +0900
Message-Id: <20190705164355.14025-3-suwan.kim027@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190705164355.14025-1-suwan.kim027@gmail.com>
References: <20190705164355.14025-1-suwan.kim027@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are bugs on vhci with usb 3.0 storage device. Originally, vhci
doesn't supported SG, so USB storage driver on vhci breaks SG list
into multiple URBs and it causes error that a transfer got terminated
too early because the transfer length for one of the URBs was not
divisible by the maxpacket size.

In this patch, vhci basically support SG and it sends each SG list
entry to the stub driver. Then, the stub driver sees the total length
of the buffer and allocates SG table and pages according to the total
buffer length calling sgl_alloc(). After the stub driver receives
completed URB, it again sends each SG list entry to vhci.

If HCD of the server doesn't support SG, the stub driver breaks a
single SG reqeust into several URBs and submit them to the server's
HCD. When all the split URBs are completed, the stub driver
reassembles the URBs into a single return command and sends it to
vhci.

Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
---
 drivers/usb/usbip/stub.h         |   7 +-
 drivers/usb/usbip/stub_main.c    |  52 +++++---
 drivers/usb/usbip/stub_rx.c      | 207 ++++++++++++++++++++++---------
 drivers/usb/usbip/stub_tx.c      | 108 +++++++++++-----
 drivers/usb/usbip/usbip_common.c |  60 +++++++--
 drivers/usb/usbip/vhci_hcd.c     |  10 +-
 drivers/usb/usbip/vhci_tx.c      |  49 ++++++--
 7 files changed, 372 insertions(+), 121 deletions(-)

diff --git a/drivers/usb/usbip/stub.h b/drivers/usb/usbip/stub.h
index 35618ceb2791..d11270560c24 100644
--- a/drivers/usb/usbip/stub.h
+++ b/drivers/usb/usbip/stub.h
@@ -52,7 +52,11 @@ struct stub_priv {
 	unsigned long seqnum;
 	struct list_head list;
 	struct stub_device *sdev;
-	struct urb *urb;
+	struct urb **urbs;
+	struct scatterlist *sgl;
+	int num_urbs;
+	int completed_urbs;
+	int urb_status;
 
 	int unlinking;
 };
@@ -86,6 +90,7 @@ extern struct usb_device_driver stub_driver;
 struct bus_id_priv *get_busid_priv(const char *busid);
 void put_busid_priv(struct bus_id_priv *bid);
 int del_match_busid(char *busid);
+void stub_free_priv_and_urb(struct stub_priv *priv);
 void stub_device_cleanup_urbs(struct stub_device *sdev);
 
 /* stub_rx.c */
diff --git a/drivers/usb/usbip/stub_main.c b/drivers/usb/usbip/stub_main.c
index 2e4bfccd4bfc..dec5af9f7179 100644
--- a/drivers/usb/usbip/stub_main.c
+++ b/drivers/usb/usbip/stub_main.c
@@ -6,6 +6,7 @@
 #include <linux/string.h>
 #include <linux/module.h>
 #include <linux/device.h>
+#include <linux/scatterlist.h>
 
 #include "usbip_common.h"
 #include "stub.h"
@@ -288,6 +289,39 @@ static struct stub_priv *stub_priv_pop_from_listhead(struct list_head *listhead)
 	return NULL;
 }
 
+void stub_free_priv_and_urb(struct stub_priv *priv)
+{
+	struct urb *urb;
+	int i;
+
+	for (i = 0; i < priv->num_urbs; i++) {
+		urb = priv->urbs[i];
+		if (urb->setup_packet) {
+			kfree(urb->setup_packet);
+			urb->setup_packet = NULL;
+		}
+
+		if (urb->transfer_buffer && !priv->sgl) {
+			kfree(urb->transfer_buffer);
+			urb->transfer_buffer = NULL;
+		}
+
+		if (urb->num_sgs) {
+			sgl_free(urb->sg);
+			urb->sg = NULL;
+			urb->num_sgs = 0;
+		}
+
+		usb_free_urb(urb);
+	}
+
+	list_del(&priv->list);
+	if (priv->sgl)
+		sgl_free(priv->sgl);
+	kfree(priv->urbs);
+	kmem_cache_free(stub_priv_cache, priv);
+}
+
 static struct stub_priv *stub_priv_pop(struct stub_device *sdev)
 {
 	unsigned long flags;
@@ -314,25 +348,15 @@ static struct stub_priv *stub_priv_pop(struct stub_device *sdev)
 void stub_device_cleanup_urbs(struct stub_device *sdev)
 {
 	struct stub_priv *priv;
-	struct urb *urb;
+	int i;
 
 	dev_dbg(&sdev->udev->dev, "Stub device cleaning up urbs\n");
 
 	while ((priv = stub_priv_pop(sdev))) {
-		urb = priv->urb;
-		dev_dbg(&sdev->udev->dev, "free urb seqnum %lu\n",
-			priv->seqnum);
-		usb_kill_urb(urb);
-
-		kmem_cache_free(stub_priv_cache, priv);
-
-		kfree(urb->transfer_buffer);
-		urb->transfer_buffer = NULL;
+		for (i = 0; i < priv->num_urbs; i++)
+			usb_kill_urb(priv->urbs[i]);
 
-		kfree(urb->setup_packet);
-		urb->setup_packet = NULL;
-
-		usb_free_urb(urb);
+		stub_free_priv_and_urb(priv);
 	}
 }
 
diff --git a/drivers/usb/usbip/stub_rx.c b/drivers/usb/usbip/stub_rx.c
index b0a855acafa3..8e32697acabb 100644
--- a/drivers/usb/usbip/stub_rx.c
+++ b/drivers/usb/usbip/stub_rx.c
@@ -7,6 +7,7 @@
 #include <linux/kthread.h>
 #include <linux/usb.h>
 #include <linux/usb/hcd.h>
+#include <linux/scatterlist.h>
 
 #include "usbip_common.h"
 #include "stub.h"
@@ -201,7 +202,7 @@ static void tweak_special_requests(struct urb *urb)
 static int stub_recv_cmd_unlink(struct stub_device *sdev,
 				struct usbip_header *pdu)
 {
-	int ret;
+	int ret, i;
 	unsigned long flags;
 	struct stub_priv *priv;
 
@@ -246,12 +247,13 @@ static int stub_recv_cmd_unlink(struct stub_device *sdev,
 		 * so a driver in a client host will know the failure
 		 * of the unlink request ?
 		 */
-		ret = usb_unlink_urb(priv->urb);
-		if (ret != -EINPROGRESS)
-			dev_err(&priv->urb->dev->dev,
-				"failed to unlink a urb # %lu, ret %d\n",
-				priv->seqnum, ret);
-
+		for (i = priv->completed_urbs; i < priv->num_urbs; i++) {
+			ret = usb_unlink_urb(priv->urbs[i]);
+			if (ret != -EINPROGRESS)
+				dev_err(&priv->urbs[i]->dev->dev,
+					"failed to unlink a urb # %lu, ret %d\n",
+					priv->seqnum, ret);
+		}
 		return 0;
 	}
 
@@ -433,14 +435,36 @@ static void masking_bogus_flags(struct urb *urb)
 	urb->transfer_flags &= allowed;
 }
 
+static int stub_recv_xbuff(struct usbip_device *ud, struct stub_priv *priv)
+{
+	int ret;
+	int i;
+
+	for (i = 0; i < priv->num_urbs; i++) {
+		ret = usbip_recv_xbuff(ud, priv->urbs[i]);
+		if (ret < 0)
+			break;
+	}
+
+	return ret;
+}
+
 static void stub_recv_cmd_submit(struct stub_device *sdev,
 				 struct usbip_header *pdu)
 {
-	int ret;
 	struct stub_priv *priv;
 	struct usbip_device *ud = &sdev->ud;
 	struct usb_device *udev = sdev->udev;
+	struct scatterlist *sgl = NULL, *sg;
+	void *buffer = NULL;
+	unsigned long long buf_len;
+	int nents;
+	int num_urbs = 1;
 	int pipe = get_pipe(sdev, pdu);
+	int use_sg = pdu->u.cmd_submit.transfer_flags & URB_DMA_MAP_SG;
+	int support_sg = 1;
+	int np = 0;
+	int ret, i;
 
 	if (pipe == -1)
 		return;
@@ -449,76 +473,143 @@ static void stub_recv_cmd_submit(struct stub_device *sdev,
 	if (!priv)
 		return;
 
-	/* setup a urb */
-	if (usb_pipeisoc(pipe))
-		priv->urb = usb_alloc_urb(pdu->u.cmd_submit.number_of_packets,
-					  GFP_KERNEL);
-	else
-		priv->urb = usb_alloc_urb(0, GFP_KERNEL);
+	buf_len = (unsigned long long)pdu->u.cmd_submit.transfer_buffer_length;
 
-	if (!priv->urb) {
-		usbip_event_add(ud, SDEV_EVENT_ERROR_MALLOC);
-		return;
+	/* allocate urb transfer buffer, if needed */
+	if (buf_len) {
+		if (use_sg) {
+			sgl = sgl_alloc(buf_len, GFP_KERNEL, &nents);
+			if (!sgl)
+				goto err_malloc;
+		} else {
+			buffer = kzalloc(buf_len, GFP_KERNEL);
+			if (!buffer)
+				goto err_malloc;
+		}
 	}
 
-	/* allocate urb transfer buffer, if needed */
-	if (pdu->u.cmd_submit.transfer_buffer_length > 0) {
-		priv->urb->transfer_buffer =
-			kzalloc(pdu->u.cmd_submit.transfer_buffer_length,
-				GFP_KERNEL);
-		if (!priv->urb->transfer_buffer) {
+	/* Check if the server's HCD supports SG */
+	if (use_sg && !udev->bus->sg_tablesize) {
+		/* If the server's HCD doesn't support SG, break a single SG
+		 * reqeust into several URBs and map the each SG list entry to
+		 * the each URB buffer. The previously allocated SG list is
+		 * stored in priv->sgl (If the server's HCD support SG, SG list
+		 * is stored only in urb->sg) and it is used as an indicator
+		 * that the server split single SG request into several URBs.
+		 * Later, priv->sgl is used by stub_complete() and
+		 * stub_send_ret_submit() to reassemble the divied URBs.
+		 */
+		support_sg = 0;
+		num_urbs = nents;
+		priv->completed_urbs = 0;
+		pdu->u.cmd_submit.transfer_flags &= ~URB_DMA_MAP_SG;
+	}
+
+	/* allocate urb array */
+	priv->num_urbs = num_urbs;
+	priv->urbs = kmalloc_array(num_urbs, sizeof(*priv->urbs), GFP_KERNEL);
+	if (!priv->urbs)
+		goto err_urbs;
+
+	/* setup a urb */
+	if (support_sg) {
+		if (usb_pipeisoc(pipe))
+			np = pdu->u.cmd_submit.number_of_packets;
+
+		priv->urbs[0] = usb_alloc_urb(np, GFP_KERNEL);
+		if (!priv->urbs[0])
+			goto err_urb;
+
+		if (buf_len) {
+			if (use_sg) {
+				priv->urbs[0]->sg = sgl;
+				priv->urbs[0]->num_sgs = nents;
+				priv->urbs[0]->transfer_buffer = NULL;
+			}
+			else {
+				priv->urbs[0]->transfer_buffer = buffer;
+			}
+		}
+
+		/* copy urb setup packet */
+		priv->urbs[0]->setup_packet = kmemdup(&pdu->u.cmd_submit.setup,
+					8, GFP_KERNEL);
+		if (!priv->urbs[0]->setup_packet) {
+			dev_err(&udev->dev, "allocate setup_packet\n");
 			usbip_event_add(ud, SDEV_EVENT_ERROR_MALLOC);
 			return;
 		}
-	}
 
-	/* copy urb setup packet */
-	priv->urb->setup_packet = kmemdup(&pdu->u.cmd_submit.setup, 8,
-					  GFP_KERNEL);
-	if (!priv->urb->setup_packet) {
-		dev_err(&udev->dev, "allocate setup_packet\n");
-		usbip_event_add(ud, SDEV_EVENT_ERROR_MALLOC);
-		return;
+		usbip_pack_pdu(pdu, priv->urbs[0], USBIP_CMD_SUBMIT, 0);
+	} else {
+		for_each_sg(sgl, sg, nents, i) {
+			priv->urbs[i] = usb_alloc_urb(0, GFP_KERNEL);
+			/* The URBs which is previously allocated will be freed
+			 * in stub_device_cleanup_urbs() if error occurs.
+			 */
+			if (!priv->urbs[i])
+				goto err_urb;
+
+			usbip_pack_pdu(pdu, priv->urbs[i], USBIP_CMD_SUBMIT, 0);
+			priv->urbs[i]->transfer_buffer = sg_virt(sg);
+			priv->urbs[i]->transfer_buffer_length = sg->length;
+		}
+		priv->sgl = sgl;
 	}
 
-	/* set other members from the base header of pdu */
-	priv->urb->context                = (void *) priv;
-	priv->urb->dev                    = udev;
-	priv->urb->pipe                   = pipe;
-	priv->urb->complete               = stub_complete;
+	for (i = 0; i < num_urbs; i++) {
+		/* set other members from the base header of pdu */
+		priv->urbs[i]->context = (void *) priv;
+		priv->urbs[i]->dev = udev;
+		priv->urbs[i]->pipe = pipe;
+		priv->urbs[i]->complete = stub_complete;
 
-	usbip_pack_pdu(pdu, priv->urb, USBIP_CMD_SUBMIT, 0);
+		/* no need to submit an intercepted request, but harmless? */
+		tweak_special_requests(priv->urbs[i]);
 
+		masking_bogus_flags(priv->urbs[i]);
+	}
 
-	if (usbip_recv_xbuff(ud, priv->urb) < 0)
+	if (stub_recv_xbuff(ud, priv) < 0)
 		return;
 
-	if (usbip_recv_iso(ud, priv->urb) < 0)
+	if (usbip_recv_iso(ud, priv->urbs[0]) < 0)
 		return;
 
-	/* no need to submit an intercepted request, but harmless? */
-	tweak_special_requests(priv->urb);
-
-	masking_bogus_flags(priv->urb);
 	/* urb is now ready to submit */
-	ret = usb_submit_urb(priv->urb, GFP_KERNEL);
-
-	if (ret == 0)
-		usbip_dbg_stub_rx("submit urb ok, seqnum %u\n",
-				  pdu->base.seqnum);
-	else {
-		dev_err(&udev->dev, "submit_urb error, %d\n", ret);
-		usbip_dump_header(pdu);
-		usbip_dump_urb(priv->urb);
-
-		/*
-		 * Pessimistic.
-		 * This connection will be discarded.
-		 */
-		usbip_event_add(ud, SDEV_EVENT_ERROR_SUBMIT);
+	for (i = 0; i < priv->num_urbs; i++) {
+		ret = usb_submit_urb(priv->urbs[i], GFP_KERNEL);
+
+		if (ret == 0)
+			usbip_dbg_stub_rx("submit urb ok, seqnum %u\n",
+					pdu->base.seqnum);
+		else {
+			dev_err(&udev->dev, "submit_urb error, %d\n", ret);
+			usbip_dump_header(pdu);
+			usbip_dump_urb(priv->urbs[i]);
+
+			/*
+			* Pessimistic.
+			* This connection will be discarded.
+			*/
+			usbip_event_add(ud, SDEV_EVENT_ERROR_SUBMIT);
+			break;
+		}
 	}
 
 	usbip_dbg_stub_rx("Leave\n");
+	return;
+
+err_urb:
+	kfree(priv->urbs);
+err_urbs:
+	if (buffer)
+		kfree(buffer);
+	if (sgl)
+		sgl_free(sgl);
+err_malloc:
+	usbip_event_add(ud, SDEV_EVENT_ERROR_MALLOC);
+	return;
 }
 
 /* recv a pdu */
diff --git a/drivers/usb/usbip/stub_tx.c b/drivers/usb/usbip/stub_tx.c
index f0ec41a50cbc..4561147ec1a1 100644
--- a/drivers/usb/usbip/stub_tx.c
+++ b/drivers/usb/usbip/stub_tx.c
@@ -5,25 +5,11 @@
 
 #include <linux/kthread.h>
 #include <linux/socket.h>
+#include <linux/scatterlist.h>
 
 #include "usbip_common.h"
 #include "stub.h"
 
-static void stub_free_priv_and_urb(struct stub_priv *priv)
-{
-	struct urb *urb = priv->urb;
-
-	kfree(urb->setup_packet);
-	urb->setup_packet = NULL;
-
-	kfree(urb->transfer_buffer);
-	urb->transfer_buffer = NULL;
-
-	list_del(&priv->list);
-	kmem_cache_free(stub_priv_cache, priv);
-	usb_free_urb(urb);
-}
-
 /* be in spin_lock_irqsave(&sdev->priv_lock, flags) */
 void stub_enqueue_ret_unlink(struct stub_device *sdev, __u32 seqnum,
 			     __u32 status)
@@ -85,6 +71,21 @@ void stub_complete(struct urb *urb)
 		break;
 	}
 
+	/* If the server break single SG reqeust into the several URBs, the
+	 * URBs must be reassembled before sending completed URB to the vhci.
+	 * Don't wake up the tx thread until all the URBs are completed.
+	 */
+	if (priv->sgl) {
+		priv->completed_urbs++;
+
+		/* Only save the first error status */
+		if (urb->status && !priv->urb_status)
+			priv->urb_status = urb->status;
+
+		if (priv->completed_urbs != priv->num_urbs)
+			return;
+	}
+
 	/* link a urb to the queue of tx. */
 	spin_lock_irqsave(&sdev->priv_lock, flags);
 	if (sdev->ud.tcp_socket == NULL) {
@@ -149,33 +150,40 @@ static int stub_send_ret_submit(struct stub_device *sdev)
 {
 	unsigned long flags;
 	struct stub_priv *priv, *tmp;
-
 	struct msghdr msg;
 	size_t txsize;
-
 	size_t total_size = 0;
 
 	while ((priv = dequeue_from_priv_tx(sdev)) != NULL) {
-		int ret;
-		struct urb *urb = priv->urb;
+		struct urb *urb = priv->urbs[0];
 		struct usbip_header pdu_header;
 		struct usbip_iso_packet_descriptor *iso_buffer = NULL;
 		struct kvec *iov = NULL;
+		struct scatterlist *sg;
+		u32 actual_length = 0;
 		int iovnum = 0;
+		int ret;
+		int i;
 
-		txsize = 0;
-		memset(&pdu_header, 0, sizeof(pdu_header));
-		memset(&msg, 0, sizeof(msg));
-
-		if (urb->actual_length > 0 && !urb->transfer_buffer) {
+		if (urb->actual_length > 0 && !urb->transfer_buffer &&
+		   !urb->num_sgs) {
 			dev_err(&sdev->udev->dev,
 				"urb: actual_length %d transfer_buffer null\n",
 				urb->actual_length);
 			return -1;
 		}
 
+		txsize = 0;
+		memset(&pdu_header, 0, sizeof(pdu_header));
+		memset(&msg, 0, sizeof(msg));
+
 		if (usb_pipetype(urb->pipe) == PIPE_ISOCHRONOUS)
 			iovnum = 2 + urb->number_of_packets;
+		else if (usb_pipein(urb->pipe) && urb->actual_length > 0
+				&& urb->num_sgs)
+			iovnum = 1 + urb->num_sgs;
+		else if (usb_pipein(urb->pipe) && priv->sgl)
+			iovnum = 1 + priv->num_urbs;
 		else
 			iovnum = 2;
 
@@ -192,6 +200,15 @@ static int stub_send_ret_submit(struct stub_device *sdev)
 		setup_ret_submit_pdu(&pdu_header, urb);
 		usbip_dbg_stub_tx("setup txdata seqnum: %d\n",
 				  pdu_header.base.seqnum);
+
+		if (priv->sgl) {
+			for (i = 0; i < priv->num_urbs; i++)
+				actual_length += priv->urbs[i]->actual_length;
+
+			pdu_header.u.ret_submit.status = priv->urb_status;
+			pdu_header.u.ret_submit.actual_length = actual_length;
+		}
+
 		usbip_header_correct_endian(&pdu_header, 1);
 
 		iov[iovnum].iov_base = &pdu_header;
@@ -200,12 +217,47 @@ static int stub_send_ret_submit(struct stub_device *sdev)
 		txsize += sizeof(pdu_header);
 
 		/* 2. setup transfer buffer */
-		if (usb_pipein(urb->pipe) &&
+		if (usb_pipein(urb->pipe) && priv->sgl) {
+			/* If the server split a single SG request into several
+			 * URBs because the server's HCD doesn't support SG,
+			 * reassemble the split URB buffers into a single
+			 * return command.
+			 */
+			for (i = 0; i < priv->num_urbs; i++) {
+				iov[iovnum].iov_base =
+					priv->urbs[i]->transfer_buffer;
+				iov[iovnum].iov_len =
+					priv->urbs[i]->actual_length;
+				iovnum++;
+			}
+			txsize += actual_length;
+		} else if (usb_pipein(urb->pipe) &&
 		    usb_pipetype(urb->pipe) != PIPE_ISOCHRONOUS &&
 		    urb->actual_length > 0) {
-			iov[iovnum].iov_base = urb->transfer_buffer;
-			iov[iovnum].iov_len  = urb->actual_length;
-			iovnum++;
+			if (urb->num_sgs) {
+				unsigned int copy = urb->actual_length;
+				int size;
+
+				for_each_sg(urb->sg, sg, urb->num_sgs ,i) {
+					if (copy == 0)
+						break;
+
+					if (copy < sg->length)
+						size = copy;
+					else
+						size = sg->length;
+
+					iov[iovnum].iov_base = sg_virt(sg);
+					iov[iovnum].iov_len = size;
+
+					iovnum++;
+					copy -= size;
+				}
+			} else {
+				iov[iovnum].iov_base = urb->transfer_buffer;
+				iov[iovnum].iov_len  = urb->actual_length;
+				iovnum++;
+			}
 			txsize += urb->actual_length;
 		} else if (usb_pipein(urb->pipe) &&
 			   usb_pipetype(urb->pipe) == PIPE_ISOCHRONOUS) {
diff --git a/drivers/usb/usbip/usbip_common.c b/drivers/usb/usbip/usbip_common.c
index 45da3e01c7b0..6affbfcfc927 100644
--- a/drivers/usb/usbip/usbip_common.c
+++ b/drivers/usb/usbip/usbip_common.c
@@ -680,8 +680,12 @@ EXPORT_SYMBOL_GPL(usbip_pad_iso);
 /* some members of urb must be substituted before. */
 int usbip_recv_xbuff(struct usbip_device *ud, struct urb *urb)
 {
-	int ret;
+	struct scatterlist *sg;
+	int ret = 0;
+	int recv;
 	int size;
+	int copy;
+	int i;
 
 	if (ud->side == USBIP_STUB || ud->side == USBIP_VUDC) {
 		/* the direction of urb must be OUT. */
@@ -712,14 +716,52 @@ int usbip_recv_xbuff(struct usbip_device *ud, struct urb *urb)
 		}
 	}
 
-	ret = usbip_recv(ud->tcp_socket, urb->transfer_buffer, size);
-	if (ret != size) {
-		dev_err(&urb->dev->dev, "recv xbuf, %d\n", ret);
-		if (ud->side == USBIP_STUB || ud->side == USBIP_VUDC) {
-			usbip_event_add(ud, SDEV_EVENT_ERROR_TCP);
-		} else {
-			usbip_event_add(ud, VDEV_EVENT_ERROR_TCP);
-			return -EPIPE;
+	if (urb->num_sgs) {
+		copy = size;
+		for_each_sg(urb->sg, sg, urb->num_sgs, i) {
+			int recv_size;
+
+			if (copy < sg->length)
+				recv_size = copy;
+			else
+				recv_size = sg->length;
+
+			recv = usbip_recv(ud->tcp_socket, sg_virt(sg),
+						recv_size);
+
+			if (recv != recv_size) {
+				dev_err(&urb->dev->dev, "recv xbuf, %d\n", ret);
+				if (ud->side == USBIP_STUB ||
+				    ud->side == USBIP_VUDC) {
+					usbip_event_add(ud, SDEV_EVENT_ERROR_TCP);
+				} else {
+					usbip_event_add(ud, VDEV_EVENT_ERROR_TCP);
+					return -EPIPE;
+				}
+			}
+			copy -= recv;
+			ret += recv;
+		}
+
+		if (ret != size) {
+			dev_err(&urb->dev->dev, "recv xbuf, %d\n", ret);
+			if (ud->side == USBIP_STUB || ud->side == USBIP_VUDC) {
+				usbip_event_add(ud, SDEV_EVENT_ERROR_TCP);
+			} else {
+				usbip_event_add(ud, VDEV_EVENT_ERROR_TCP);
+				return -EPIPE;
+			}
+		}
+	} else {
+		ret = usbip_recv(ud->tcp_socket, urb->transfer_buffer, size);
+		if (ret != size) {
+			dev_err(&urb->dev->dev, "recv xbuf, %d\n", ret);
+			if (ud->side == USBIP_STUB || ud->side == USBIP_VUDC) {
+				usbip_event_add(ud, SDEV_EVENT_ERROR_TCP);
+			} else {
+				usbip_event_add(ud, VDEV_EVENT_ERROR_TCP);
+				return -EPIPE;
+			}
 		}
 	}
 
diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index 14fc6d9f4e6a..b5fe85adb42b 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -697,7 +697,8 @@ static int vhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
 	}
 	vdev = &vhci_hcd->vdev[portnum-1];
 
-	if (!urb->transfer_buffer && urb->transfer_buffer_length) {
+	if (!urb->transfer_buffer && !urb->num_sgs &&
+	     urb->transfer_buffer_length) {
 		dev_dbg(dev, "Null URB transfer buffer\n");
 		return -EINVAL;
 	}
@@ -1143,6 +1144,13 @@ static int vhci_setup(struct usb_hcd *hcd)
 		hcd->speed = HCD_USB3;
 		hcd->self.root_hub->speed = USB_SPEED_SUPER;
 	}
+
+	/* support SG.
+	 * sg_tablesize is an arbitrary vaule to alleviate memory pressure
+	 * on the host. */
+	hcd->self.sg_tablesize = 32;
+	hcd->self.no_sg_constraint = 1;
+
 	return 0;
 }
 
diff --git a/drivers/usb/usbip/vhci_tx.c b/drivers/usb/usbip/vhci_tx.c
index 2fa26d0578d7..3472180f5af8 100644
--- a/drivers/usb/usbip/vhci_tx.c
+++ b/drivers/usb/usbip/vhci_tx.c
@@ -5,6 +5,7 @@
 
 #include <linux/kthread.h>
 #include <linux/slab.h>
+#include <linux/scatterlist.h>
 
 #include "usbip_common.h"
 #include "vhci.h"
@@ -51,12 +52,13 @@ static struct vhci_priv *dequeue_from_priv_tx(struct vhci_device *vdev)
 static int vhci_send_cmd_submit(struct vhci_device *vdev)
 {
 	struct vhci_priv *priv = NULL;
-
+	struct scatterlist *sg;
 	struct msghdr msg;
-	struct kvec iov[3];
+	struct kvec *iov;
 	size_t txsize;
-
 	size_t total_size = 0;
+	int iovnum;
+	int i;
 
 	while ((priv = dequeue_from_priv_tx(vdev)) != NULL) {
 		int ret;
@@ -72,18 +74,41 @@ static int vhci_send_cmd_submit(struct vhci_device *vdev)
 		usbip_dbg_vhci_tx("setup txdata urb seqnum %lu\n",
 				  priv->seqnum);
 
+		if (urb->num_sgs && usb_pipeout(urb->pipe))
+			iovnum = 2 + urb->num_sgs;
+		else
+			iovnum = 3;
+
+		iov = kzalloc(iovnum * sizeof(*iov), GFP_KERNEL);
+		if (!iov) {
+			usbip_event_add(&vdev->ud,
+						SDEV_EVENT_ERROR_MALLOC);
+			return -ENOMEM;
+		}
+
 		/* 1. setup usbip_header */
 		setup_cmd_submit_pdu(&pdu_header, urb);
 		usbip_header_correct_endian(&pdu_header, 1);
+		iovnum = 0;
 
-		iov[0].iov_base = &pdu_header;
-		iov[0].iov_len  = sizeof(pdu_header);
+		iov[iovnum].iov_base = &pdu_header;
+		iov[iovnum].iov_len  = sizeof(pdu_header);
 		txsize += sizeof(pdu_header);
+		iovnum++;
 
 		/* 2. setup transfer buffer */
 		if (!usb_pipein(urb->pipe) && urb->transfer_buffer_length > 0) {
-			iov[1].iov_base = urb->transfer_buffer;
-			iov[1].iov_len  = urb->transfer_buffer_length;
+			if (urb->num_sgs && !usb_endpoint_xfer_isoc(&urb->ep->desc)) {
+				for_each_sg(urb->sg, sg, urb->num_sgs ,i) {
+					iov[iovnum].iov_base = sg_virt(sg);
+					iov[iovnum].iov_len = sg->length;
+					iovnum++;
+				}
+			} else {
+				iov[iovnum].iov_base = urb->transfer_buffer;
+				iov[iovnum].iov_len  = urb->transfer_buffer_length;
+				iovnum++;
+			}
 			txsize += urb->transfer_buffer_length;
 		}
 
@@ -93,25 +118,29 @@ static int vhci_send_cmd_submit(struct vhci_device *vdev)
 
 			iso_buffer = usbip_alloc_iso_desc_pdu(urb, &len);
 			if (!iso_buffer) {
+				kfree(iov);
 				usbip_event_add(&vdev->ud,
 						SDEV_EVENT_ERROR_MALLOC);
 				return -1;
 			}
 
-			iov[2].iov_base = iso_buffer;
-			iov[2].iov_len  = len;
+			iov[iovnum].iov_base = iso_buffer;
+			iov[iovnum].iov_len  = len;
+			iovnum++;
 			txsize += len;
 		}
 
-		ret = kernel_sendmsg(vdev->ud.tcp_socket, &msg, iov, 3, txsize);
+		ret = kernel_sendmsg(vdev->ud.tcp_socket, &msg, iov, iovnum, txsize);
 		if (ret != txsize) {
 			pr_err("sendmsg failed!, ret=%d for %zd\n", ret,
 			       txsize);
+			kfree(iov);
 			kfree(iso_buffer);
 			usbip_event_add(&vdev->ud, VDEV_EVENT_ERROR_TCP);
 			return -1;
 		}
 
+		kfree(iov);
 		kfree(iso_buffer);
 		usbip_dbg_vhci_tx("send txdata\n");
 
-- 
2.20.1

