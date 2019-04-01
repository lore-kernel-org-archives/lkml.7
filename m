Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C93C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C234621939
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138720;
	bh=2vSYQeiR3+Q2z6Abom2boUDD5oI+wLPNDB1Vcwy0Iw0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1KxY2KWugEvUXpL7bqFvyztdV5CnX5D6xSMCwGwSV+eH3idLto8AO8Xiyv6oQT+7C
	 Yyi0/uJJKfDuyRvbQtvKdYBm7xKmn7hWylQJOkWoFQ4kPV3D+ufCb14xLmuIcM+Z3m
	 EjjRHJdJYDcFh+ybrP7fbxhiycagkRkEfxunsUbQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730296AbfDARL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:11:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:32848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729665AbfDARLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:11:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CECE21924;
        Mon,  1 Apr 2019 17:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138713;
        bh=2vSYQeiR3+Q2z6Abom2boUDD5oI+wLPNDB1Vcwy0Iw0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0vdsXgZsYQ5IhaopRDz1QDMwEe9RV8DauzLJVWDWejQbb4Q/sdcdmEWBN0HviEQqR
         OeKNTpH7clqiEM50ibEOfmgYuweBywWGBEaWSA6T4xZMkoubgDcZWnR8PIsEpcvAO+
         3a9QeJTOjKxy5CkAahfQSGs8fqk4aqs0YMny2v5M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Stanislaw Gruszka <sgruszka@redhat.com>,
        Felix Fietkau <nbd@nbd.name>
Subject: [PATCH 5.0 146/146] mt76x02u: use usb_bulk_msg to upload firmware
Date:   Mon,  1 Apr 2019 19:02:38 +0200
Message-Id: <20190401170100.331341674@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170048.449559024@linuxfoundation.org>
References: <20190401170048.449559024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stanislaw Gruszka <sgruszka@redhat.com>

commit 5de4db8fcb6d6fc7d9064c22841211790c0ab81b upstream.

We don't need to send firmware data asynchronously, much simpler is just
use synchronous usb_bulk_msg().

[ stable note: this patch was originally developed as cleanup, but it
remove incorrect usage of page_frag_alloc(): alloc more than PAGE_SIZE
and create not ARCH_DMA_MINALIGN dma buffers needed at least for
performance reason. Was tested on 5.0 and 4.20, see
https://bugzilla.kernel.org/show_bug.cgi?id=202673 and
https://bugzilla.kernel.org/show_bug.cgi?id=202241 ]

Tested-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/mediatek/mt76/mt76.h            |   13 ++++
 drivers/net/wireless/mediatek/mt76/mt76x02_usb_mcu.c |   52 +++++--------------
 drivers/net/wireless/mediatek/mt76/usb.c             |    1 
 3 files changed, 29 insertions(+), 37 deletions(-)

--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -713,6 +713,19 @@ static inline bool mt76u_check_sg(struct
 		 udev->speed == USB_SPEED_WIRELESS));
 }
 
+static inline int
+mt76u_bulk_msg(struct mt76_dev *dev, void *data, int len, int timeout)
+{
+	struct usb_interface *intf = to_usb_interface(dev->dev);
+	struct usb_device *udev = interface_to_usbdev(intf);
+	struct mt76_usb *usb = &dev->usb;
+	unsigned int pipe;
+	int sent;
+
+	pipe = usb_sndbulkpipe(udev, usb->out_ep[MT_EP_OUT_INBAND_CMD]);
+	return usb_bulk_msg(udev, pipe, data, len, &sent, timeout);
+}
+
 int mt76u_vendor_request(struct mt76_dev *dev, u8 req,
 			 u8 req_type, u16 val, u16 offset,
 			 void *buf, size_t len);
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_mcu.c
@@ -121,18 +121,14 @@ static int
 __mt76x02u_mcu_send_msg(struct mt76_dev *dev, struct sk_buff *skb,
 			int cmd, bool wait_resp)
 {
-	struct usb_interface *intf = to_usb_interface(dev->dev);
-	struct usb_device *udev = interface_to_usbdev(intf);
 	struct mt76_usb *usb = &dev->usb;
-	unsigned int pipe;
-	int ret, sent;
+	int ret;
 	u8 seq = 0;
 	u32 info;
 
 	if (test_bit(MT76_REMOVED, &dev->state))
 		return 0;
 
-	pipe = usb_sndbulkpipe(udev, usb->out_ep[MT_EP_OUT_INBAND_CMD]);
 	if (wait_resp) {
 		seq = ++usb->mcu.msg_seq & 0xf;
 		if (!seq)
@@ -146,7 +142,7 @@ __mt76x02u_mcu_send_msg(struct mt76_dev
 	if (ret)
 		return ret;
 
-	ret = usb_bulk_msg(udev, pipe, skb->data, skb->len, &sent, 500);
+	ret = mt76u_bulk_msg(dev, skb->data, skb->len, 500);
 	if (ret)
 		return ret;
 
@@ -268,14 +264,12 @@ void mt76x02u_mcu_fw_reset(struct mt76x0
 EXPORT_SYMBOL_GPL(mt76x02u_mcu_fw_reset);
 
 static int
-__mt76x02u_mcu_fw_send_data(struct mt76x02_dev *dev, struct mt76u_buf *buf,
+__mt76x02u_mcu_fw_send_data(struct mt76x02_dev *dev, u8 *data,
 			    const void *fw_data, int len, u32 dst_addr)
 {
-	u8 *data = sg_virt(&buf->urb->sg[0]);
-	DECLARE_COMPLETION_ONSTACK(cmpl);
 	__le32 info;
 	u32 val;
-	int err;
+	int err, data_len;
 
 	info = cpu_to_le32(FIELD_PREP(MT_MCU_MSG_PORT, CPU_TX_PORT) |
 			   FIELD_PREP(MT_MCU_MSG_LEN, len) |
@@ -291,25 +285,12 @@ __mt76x02u_mcu_fw_send_data(struct mt76x
 	mt76u_single_wr(&dev->mt76, MT_VEND_WRITE_FCE,
 			MT_FCE_DMA_LEN, len << 16);
 
-	buf->len = MT_CMD_HDR_LEN + len + sizeof(info);
-	err = mt76u_submit_buf(&dev->mt76, USB_DIR_OUT,
-			       MT_EP_OUT_INBAND_CMD,
-			       buf, GFP_KERNEL,
-			       mt76u_mcu_complete_urb, &cmpl);
-	if (err < 0)
-		return err;
-
-	if (!wait_for_completion_timeout(&cmpl,
-					 msecs_to_jiffies(1000))) {
-		dev_err(dev->mt76.dev, "firmware upload timed out\n");
-		usb_kill_urb(buf->urb);
-		return -ETIMEDOUT;
-	}
+	data_len = MT_CMD_HDR_LEN + len + sizeof(info);
 
-	if (mt76u_urb_error(buf->urb)) {
-		dev_err(dev->mt76.dev, "firmware upload failed: %d\n",
-			buf->urb->status);
-		return buf->urb->status;
+	err = mt76u_bulk_msg(&dev->mt76, data, data_len, 1000);
+	if (err) {
+		dev_err(dev->mt76.dev, "firmware upload failed: %d\n", err);
+		return err;
 	}
 
 	val = mt76_rr(dev, MT_TX_CPU_FROM_FCE_CPU_DESC_IDX);
@@ -322,17 +303,16 @@ __mt76x02u_mcu_fw_send_data(struct mt76x
 int mt76x02u_mcu_fw_send_data(struct mt76x02_dev *dev, const void *data,
 			      int data_len, u32 max_payload, u32 offset)
 {
-	int err, len, pos = 0, max_len = max_payload - 8;
-	struct mt76u_buf buf;
+	int len, err = 0, pos = 0, max_len = max_payload - 8;
+	u8 *buf;
 
-	err = mt76u_buf_alloc(&dev->mt76, &buf, 1, max_payload, max_payload,
-			      GFP_KERNEL);
-	if (err < 0)
-		return err;
+	buf = kmalloc(max_payload, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
 
 	while (data_len > 0) {
 		len = min_t(int, data_len, max_len);
-		err = __mt76x02u_mcu_fw_send_data(dev, &buf, data + pos,
+		err = __mt76x02u_mcu_fw_send_data(dev, buf, data + pos,
 						  len, offset + pos);
 		if (err < 0)
 			break;
@@ -341,7 +321,7 @@ int mt76x02u_mcu_fw_send_data(struct mt7
 		pos += len;
 		usleep_range(5000, 10000);
 	}
-	mt76u_buf_free(&buf);
+	kfree(buf);
 
 	return err;
 }
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -326,7 +326,6 @@ int mt76u_buf_alloc(struct mt76_dev *dev
 
 	return mt76u_fill_rx_sg(dev, buf, nsgs, len, sglen);
 }
-EXPORT_SYMBOL_GPL(mt76u_buf_alloc);
 
 void mt76u_buf_free(struct mt76u_buf *buf)
 {


