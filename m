Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E7AC48BE0
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 17:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DE7F208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 17:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBraKN+c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbfFURqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 13:46:22 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36007 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbfFURqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 13:46:22 -0400
Received: by mail-pf1-f193.google.com with SMTP id r7so3979740pfl.3;
        Fri, 21 Jun 2019 10:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zs0kNZNNoUc7N4dz+w+/CiCgaH4yp8GIZqF753EpFHc=;
        b=NBraKN+c+0j8KPdhHAXnHyqHbGgjKhZlapnMeB9PkKcXiQNQTF740Dw8sgfooDyVVN
         AR2lvCl8oJ7/tSPC6JWdN7vFu7fZpzFXcelk7uyyakLgr4Pzi2BY1V0WYSUOTbVJaXvo
         Th2M0BaIlxz4rg8i87toYVaw+axwV2doF8ckiql6H7PDVeE2EhrbIRZwX+6xbJpzRk3B
         c+QMHszq50RT+eRwKIlGhTGcrIWFe0pNxX+nqe6GD3mR5boBmBqYtQmRyYmXQQwcltTa
         VHcuLwniHNq2t9DrOMi6AKmKSnKYrwQ0R7q7haAoLyt+H3eCJ1crD94S2zMF2MFRCdiA
         8f7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zs0kNZNNoUc7N4dz+w+/CiCgaH4yp8GIZqF753EpFHc=;
        b=APPaoJmSZKJm56cqLpype6wAeHlWi0UbFGw3YXId70zxe0S7tYaVTZAF0JgfgLfbBL
         pZa3mcXoqURwMlLCgPPF7xuZWGmUjqXcCWMpBUSoliPHk4SeeO4wAfLaygYaqBu35juh
         zKjVhwozRPALBFpH9b7THj4chNRCaiL7Ay3UR6k7MjjNWmiPUPKOLGzim8JcuPt+MaHv
         nnlNM0/1Bv8NZFF6eR19VbKmggRHs2iVYJ7aN9cQBu3RpwvJh82LpB0JnHYNe7ZXBBAk
         pA5bbXsxVi96gwINcFdb6aJpvbw+GcPa5QdIc04zIoSVWs2ZK+GmF66AijjxmVhf6R7f
         gSdQ==
X-Gm-Message-State: APjAAAVL590vvsQ7OoHIZ5Djx2bPU685jja9v1kNpd3HHoAfWYbMSF37
        GrrjcNHZsIvffoGRyOGcZoY=
X-Google-Smtp-Source: APXvYqyAzd9jJ9pK//914wgZMlAsXlnkzeQN2nBWJSXKSHyYUeURSeDUAl8sZzVeLeD/jVCZZ1FTAQ==
X-Received: by 2002:a17:90a:ac13:: with SMTP id o19mr8159265pjq.143.1561139181500;
        Fri, 21 Jun 2019 10:46:21 -0700 (PDT)
Received: from localhost.localdomain ([125.142.23.13])
        by smtp.googlemail.com with ESMTPSA id e6sm3884820pfn.71.2019.06.21.10.46.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 10:46:21 -0700 (PDT)
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     shuah@kernel.org, stern@rowland.harvard.edu,
        valentina.manea.m@gmail.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Suwan Kim <suwan.kim027@gmail.com>
Subject: [PATCH 2/2] usbip: Implement SG support to vhci
Date:   Sat, 22 Jun 2019 02:45:53 +0900
Message-Id: <20190621174553.28862-3-suwan.kim027@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190621174553.28862-1-suwan.kim027@gmail.com>
References: <20190621174553.28862-1-suwan.kim027@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are bugs on vhci with usb 3.0 storage device. Originally, vhci
doesn't supported SG. So, USB storage driver on vhci divides SG list
into multiple URBs and it causes buffer overflow on the xhci of the
server. So we need to add SG support to vhci

In this patch, vhci basically support SG and it sends each SG list
entry to the stub driver. Then, the stub driver sees total length of
the buffer and allocates SG table and pages according to the total
buffer length calling sgl_alloc(). After the stub driver receives
completed URB, it again sends each SG list entry to the vhci.

If HCD of server doesn't support SG, the stub driver allocates
big buffer using kmalloc() instead of using sgl_alloc() which
allocates SG list and pages.

Alan fixed vhci bug with the USB 3.0 storage device by modifying
USB storage driver.
("usb-storage: Set virt_boundary_mask to avoid SG overflows")
But the fundamental solution of it is to add SG support to vhci.

This patch works well with the USB 3.0 storage devices without Alan's
patch, and we can revert Alan's patch if it causes some troubles.

Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
---
 drivers/usb/usbip/stub_rx.c      | 32 +++++++++++++----
 drivers/usb/usbip/stub_tx.c      | 53 +++++++++++++++++++++++-----
 drivers/usb/usbip/usbip_common.c | 60 +++++++++++++++++++++++++++-----
 drivers/usb/usbip/usbip_common.h |  2 ++
 drivers/usb/usbip/vhci_hcd.c     |  8 ++++-
 drivers/usb/usbip/vhci_tx.c      | 49 ++++++++++++++++++++------
 6 files changed, 169 insertions(+), 35 deletions(-)

diff --git a/drivers/usb/usbip/stub_rx.c b/drivers/usb/usbip/stub_rx.c
index 97b09a42a10c..798854b9bbc8 100644
--- a/drivers/usb/usbip/stub_rx.c
+++ b/drivers/usb/usbip/stub_rx.c
@@ -7,6 +7,7 @@
 #include <linux/kthread.h>
 #include <linux/usb.h>
 #include <linux/usb/hcd.h>
+#include <linux/scatterlist.h>
 
 #include "usbip_common.h"
 #include "stub.h"
@@ -446,7 +447,11 @@ static void stub_recv_cmd_submit(struct stub_device *sdev,
 	struct stub_priv *priv;
 	struct usbip_device *ud = &sdev->ud;
 	struct usb_device *udev = sdev->udev;
+	struct scatterlist *sgl;
+	int nents;
 	int pipe = get_pipe(sdev, pdu);
+	unsigned long long buf_len;
+	int use_sg;
 
 	if (pipe == -1)
 		return;
@@ -455,6 +460,10 @@ static void stub_recv_cmd_submit(struct stub_device *sdev,
 	if (!priv)
 		return;
 
+	buf_len = (unsigned long long)pdu->u.cmd_submit.transfer_buffer_length;
+	/* Check if the server's HCD supprot sg */
+	use_sg = pdu->u.cmd_submit.num_sgs && udev->bus->sg_tablesize;
+
 	/* setup a urb */
 	if (usb_pipeisoc(pipe))
 		priv->urb = usb_alloc_urb(pdu->u.cmd_submit.number_of_packets,
@@ -468,13 +477,22 @@ static void stub_recv_cmd_submit(struct stub_device *sdev,
 	}
 
 	/* allocate urb transfer buffer, if needed */
-	if (pdu->u.cmd_submit.transfer_buffer_length > 0) {
-		priv->urb->transfer_buffer =
-			kzalloc(pdu->u.cmd_submit.transfer_buffer_length,
-				GFP_KERNEL);
-		if (!priv->urb->transfer_buffer) {
-			usbip_event_add(ud, SDEV_EVENT_ERROR_MALLOC);
-			return;
+	if (buf_len > 0) {
+		if (use_sg) {
+			sgl = sgl_alloc(buf_len, GFP_KERNEL, &nents);
+			if (!sgl) {
+				usbip_event_add(ud, SDEV_EVENT_ERROR_MALLOC);
+				return;
+			}
+			priv->urb->sg = sgl;
+			priv->urb->num_sgs = nents;
+			priv->urb->transfer_buffer = NULL;
+		} else {
+			priv->urb->transfer_buffer = kzalloc(buf_len, GFP_KERNEL);
+			if (!priv->urb->transfer_buffer) {
+				usbip_event_add(ud, SDEV_EVENT_ERROR_MALLOC);
+				return;
+			}
 		}
 	}
 
diff --git a/drivers/usb/usbip/stub_tx.c b/drivers/usb/usbip/stub_tx.c
index f0ec41a50cbc..ece129cd0b28 100644
--- a/drivers/usb/usbip/stub_tx.c
+++ b/drivers/usb/usbip/stub_tx.c
@@ -5,6 +5,7 @@
 
 #include <linux/kthread.h>
 #include <linux/socket.h>
+#include <linux/scatterlist.h>
 
 #include "usbip_common.h"
 #include "stub.h"
@@ -13,11 +14,21 @@ static void stub_free_priv_and_urb(struct stub_priv *priv)
 {
 	struct urb *urb = priv->urb;
 
-	kfree(urb->setup_packet);
-	urb->setup_packet = NULL;
+	if (urb->setup_packet) {
+		kfree(urb->setup_packet);
+		urb->setup_packet = NULL;
+	}
+
+	if (urb->transfer_buffer) {
+		kfree(urb->transfer_buffer);
+		urb->transfer_buffer = NULL;
+	}
 
-	kfree(urb->transfer_buffer);
-	urb->transfer_buffer = NULL;
+	if (urb->num_sgs) {
+		sgl_free(urb->sg);
+		urb->sg = NULL;
+		urb->num_sgs = 0;
+	}
 
 	list_del(&priv->list);
 	kmem_cache_free(stub_priv_cache, priv);
@@ -161,13 +172,16 @@ static int stub_send_ret_submit(struct stub_device *sdev)
 		struct usbip_header pdu_header;
 		struct usbip_iso_packet_descriptor *iso_buffer = NULL;
 		struct kvec *iov = NULL;
+		struct scatterlist *sg;
 		int iovnum = 0;
+		int i;
 
 		txsize = 0;
 		memset(&pdu_header, 0, sizeof(pdu_header));
 		memset(&msg, 0, sizeof(msg));
 
-		if (urb->actual_length > 0 && !urb->transfer_buffer) {
+		if (urb->actual_length > 0 && !urb->transfer_buffer &&
+		   !urb->num_sgs) {
 			dev_err(&sdev->udev->dev,
 				"urb: actual_length %d transfer_buffer null\n",
 				urb->actual_length);
@@ -176,6 +190,8 @@ static int stub_send_ret_submit(struct stub_device *sdev)
 
 		if (usb_pipetype(urb->pipe) == PIPE_ISOCHRONOUS)
 			iovnum = 2 + urb->number_of_packets;
+		else if (usb_pipein(urb->pipe) && urb->actual_length > 0 && urb->num_sgs)
+			iovnum = 1 + urb->num_sgs;
 		else
 			iovnum = 2;
 
@@ -203,9 +219,30 @@ static int stub_send_ret_submit(struct stub_device *sdev)
 		if (usb_pipein(urb->pipe) &&
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
index 45da3e01c7b0..56b2a1fbe0bf 100644
--- a/drivers/usb/usbip/usbip_common.c
+++ b/drivers/usb/usbip/usbip_common.c
@@ -365,6 +365,7 @@ static void usbip_pack_cmd_submit(struct usbip_header *pdu, struct urb *urb,
 		spdu->start_frame		= urb->start_frame;
 		spdu->number_of_packets		= urb->number_of_packets;
 		spdu->interval			= urb->interval;
+		spdu->num_sgs			= urb->num_sgs;
 	} else  {
 		urb->transfer_flags         = spdu->transfer_flags;
 		urb->transfer_buffer_length = spdu->transfer_buffer_length;
@@ -434,6 +435,7 @@ static void correct_endian_cmd_submit(struct usbip_header_cmd_submit *pdu,
 {
 	if (send) {
 		pdu->transfer_flags = cpu_to_be32(pdu->transfer_flags);
+		pdu->num_sgs = cpu_to_be32(pdu->num_sgs);
 
 		cpu_to_be32s(&pdu->transfer_buffer_length);
 		cpu_to_be32s(&pdu->start_frame);
@@ -441,6 +443,7 @@ static void correct_endian_cmd_submit(struct usbip_header_cmd_submit *pdu,
 		cpu_to_be32s(&pdu->interval);
 	} else {
 		pdu->transfer_flags = be32_to_cpu(pdu->transfer_flags);
+		pdu->num_sgs = be32_to_cpu(pdu->num_sgs);
 
 		be32_to_cpus(&pdu->transfer_buffer_length);
 		be32_to_cpus(&pdu->start_frame);
@@ -680,8 +683,12 @@ EXPORT_SYMBOL_GPL(usbip_pad_iso);
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
@@ -712,14 +719,49 @@ int usbip_recv_xbuff(struct usbip_device *ud, struct urb *urb)
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
+			recv = usbip_recv(ud->tcp_socket, sg_virt(sg), recv_size);
+			if (recv != recv_size) {
+				dev_err(&urb->dev->dev, "recv xbuf, %d\n", ret);
+				if (ud->side == USBIP_STUB || ud->side == USBIP_VUDC) {
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
 
diff --git a/drivers/usb/usbip/usbip_common.h b/drivers/usb/usbip/usbip_common.h
index bf8afe9b5883..b395946c4d03 100644
--- a/drivers/usb/usbip/usbip_common.h
+++ b/drivers/usb/usbip/usbip_common.h
@@ -143,6 +143,7 @@ struct usbip_header_basic {
  * struct usbip_header_cmd_submit - USBIP_CMD_SUBMIT packet header
  * @transfer_flags: URB flags
  * @transfer_buffer_length: the data size for (in) or (out) transfer
+ * @num_sgs: the number of scatter gather list of URB
  * @start_frame: initial frame for isochronous or interrupt transfers
  * @number_of_packets: number of isochronous packets
  * @interval: maximum time for the request on the server-side host controller
@@ -151,6 +152,7 @@ struct usbip_header_basic {
 struct usbip_header_cmd_submit {
 	__u32 transfer_flags;
 	__s32 transfer_buffer_length;
+	__u32 num_sgs;
 
 	/* it is difficult for usbip to sync frames (reserved only?) */
 	__s32 start_frame;
diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index be87c8a63e24..cc93c1a87a3e 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -696,7 +696,8 @@ static int vhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
 	}
 	vdev = &vhci_hcd->vdev[portnum-1];
 
-	if (!urb->transfer_buffer && urb->transfer_buffer_length) {
+	if (!urb->transfer_buffer && !urb->num_sgs &&
+	     urb->transfer_buffer_length) {
 		dev_dbg(dev, "Null URB transfer buffer\n");
 		return -EINVAL;
 	}
@@ -1142,6 +1143,11 @@ static int vhci_setup(struct usb_hcd *hcd)
 		hcd->speed = HCD_USB3;
 		hcd->self.root_hub->speed = USB_SPEED_SUPER;
 	}
+
+	/* support sg */
+	hcd->self.sg_tablesize = ~0;
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

