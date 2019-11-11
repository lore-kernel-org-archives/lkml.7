Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61AF0C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 350DD21925
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYQYWxaw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfKKOLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 09:11:04 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42306 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfKKOLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 09:11:03 -0500
Received: by mail-pg1-f196.google.com with SMTP id q17so9535529pgt.9;
        Mon, 11 Nov 2019 06:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rI5QC9ISB879Ba1DyMVl2oGSc/o9FCdZnmRMtbc4lMk=;
        b=iYQYWxawSmVE3P2Gsfi6nXJ4i08atEe1waG4+4z0bVa+k5GKm+PtIZoDiXhGzrI+z/
         uACnGvZq5WTh7UxDOm673vKaqRCECsucIfs7fmqbMsIbwLoQQcVstbWsAUdIyim4GH6u
         G/1Cxs+6uZF/T/ELfZ0QINl4nHsZkKVQP5x0j9uBnAFL5+GRujVpK7oKgB4m+WGRax4K
         GHvp75+CfzCQWNgFS9RYN1yji/XN1DJGXWZLeEpVc1gRGeI9d3SmOBYEMrjXyZyb+WTU
         VokhWtmvHNKH5m0wUSLHDmZ79K+J1URGbonSJPlFzP6XOhqkYEV2NbznJkdmEu0hVZVB
         /8ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rI5QC9ISB879Ba1DyMVl2oGSc/o9FCdZnmRMtbc4lMk=;
        b=RNCW3fsggiFLExLqjH1NPydEJ+OEcq3fmUZD17bUzvSpYhtEbVHXH+xUmH/iGbjySy
         MhWY9F6t7l5WMUMhSEvNtRNqydSLZRu/6AleniYum8dgYxCs52IF9aZiUG3QNhc6MlsU
         fhwVdndnlw4UZptcO9GvGFQ5ywHT4CR0BaQBrVgISLv7U3WYtSqXgW50/m0PNk6tj3wx
         W8q1+hM/t/P7cqNhBRpZB87xYG8iRR24LX2jXRuy1hIQYDCDEvyIrsfm1iTP/zWNY/9e
         D2zCdQzH9IKf1xQUJpoHPCCZyMh0an70WA63vbBkKLy+jLLdyxs3/L8nk4kJ+rayidWK
         ZmfA==
X-Gm-Message-State: APjAAAV8NrDXa3Pt2bAB5eDoU3xXEJgPF4SUm28RDEmegfJB5WB3lFO1
        NI1ZHXLhtSNIu6x44DlSK5c=
X-Google-Smtp-Source: APXvYqxk3KtKKsslHqhzEITqYs0MBUgnmFsfR3PUYFJIXyhbNnl+dx7JNv8qvgw/aG4JjYXyue9+jg==
X-Received: by 2002:a63:3c6:: with SMTP id 189mr28773962pgd.4.1573481462969;
        Mon, 11 Nov 2019 06:11:02 -0800 (PST)
Received: from localhost.localdomain ([221.155.202.134])
        by smtp.gmail.com with ESMTPSA id 206sm2875318pfu.45.2019.11.11.06.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 06:11:02 -0800 (PST)
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     shuah@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        dan.carpenter@oracle.com, valentina.manea.m@gmail.com,
        Suwan Kim <suwan.kim027@gmail.com>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH] usbip: Fix uninitialized symbol 'nents' in stub_recv_cmd_submit()
Date:   Mon, 11 Nov 2019 23:10:35 +0900
Message-Id: <20191111141035.27788-1-suwan.kim027@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch reported that nents is not initialized and used in
stub_recv_cmd_submit(). nents is currently initialized by sgl_alloc()
and used to allocate multiple URBs when host controller doesn't
support scatter-gather DMA. The use of uninitialized nents means that
buf_len is zero and use_sg is true. But buffer length should not be
zero when an URB uses scatter-gather DMA.

To prevent this situation, add the conditional that checks buf_len
and use_sg. And move the use of nents right after the sgl_alloc() to
avoid the use of uninitialized nents.

If the error occurs, it adds SDEV_EVENT_ERROR_MALLOC and stub_priv
will be released by stub event handler and connection will be shut
down.

Fixes: ea44d190764b ("usbip: Implement SG support to vhci-hcd and stub driver")
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
---
 drivers/usb/usbip/stub_rx.c | 50 ++++++++++++++++++++++++-------------
 1 file changed, 32 insertions(+), 18 deletions(-)

diff --git a/drivers/usb/usbip/stub_rx.c b/drivers/usb/usbip/stub_rx.c
index 66edfeea68fe..e2b019532234 100644
--- a/drivers/usb/usbip/stub_rx.c
+++ b/drivers/usb/usbip/stub_rx.c
@@ -470,18 +470,50 @@ static void stub_recv_cmd_submit(struct stub_device *sdev,
 	if (pipe == -1)
 		return;
 
+	/*
+	 * Smatch reported the error case where use_sg is true and buf_len is 0.
+	 * In this case, It adds SDEV_EVENT_ERROR_MALLOC and stub_priv will be
+	 * released by stub event handler and connection will be shut down.
+	 */
 	priv = stub_priv_alloc(sdev, pdu);
 	if (!priv)
 		return;
 
 	buf_len = (unsigned long long)pdu->u.cmd_submit.transfer_buffer_length;
 
+	if (use_sg && !buf_len) {
+		dev_err(&udev->dev, "sg buffer with zero length\n");
+		goto err_malloc;
+	}
+
 	/* allocate urb transfer buffer, if needed */
 	if (buf_len) {
 		if (use_sg) {
 			sgl = sgl_alloc(buf_len, GFP_KERNEL, &nents);
 			if (!sgl)
 				goto err_malloc;
+
+			/* Check if the server's HCD supports SG */
+			if (!udev->bus->sg_tablesize) {
+				/*
+				 * If the server's HCD doesn't support SG, break
+				 * a single SG request into several URBs and map
+				 * each SG list entry to corresponding URB
+				 * buffer. The previously allocated SG list is
+				 * stored in priv->sgl (If the server's HCD
+				 * support SG, SG list is stored only in
+				 * urb->sg) and it is used as an indicator that
+				 * the server split single SG request into
+				 * several URBs. Later, priv->sgl is used by
+				 * stub_complete() and stub_send_ret_submit() to
+				 * reassemble the divied URBs.
+				 */
+				support_sg = 0;
+				num_urbs = nents;
+				priv->completed_urbs = 0;
+				pdu->u.cmd_submit.transfer_flags &=
+								~URB_DMA_MAP_SG;
+			}
 		} else {
 			buffer = kzalloc(buf_len, GFP_KERNEL);
 			if (!buffer)
@@ -489,24 +521,6 @@ static void stub_recv_cmd_submit(struct stub_device *sdev,
 		}
 	}
 
-	/* Check if the server's HCD supports SG */
-	if (use_sg && !udev->bus->sg_tablesize) {
-		/*
-		 * If the server's HCD doesn't support SG, break a single SG
-		 * request into several URBs and map each SG list entry to
-		 * corresponding URB buffer. The previously allocated SG
-		 * list is stored in priv->sgl (If the server's HCD support SG,
-		 * SG list is stored only in urb->sg) and it is used as an
-		 * indicator that the server split single SG request into
-		 * several URBs. Later, priv->sgl is used by stub_complete() and
-		 * stub_send_ret_submit() to reassemble the divied URBs.
-		 */
-		support_sg = 0;
-		num_urbs = nents;
-		priv->completed_urbs = 0;
-		pdu->u.cmd_submit.transfer_flags &= ~URB_DMA_MAP_SG;
-	}
-
 	/* allocate urb array */
 	priv->num_urbs = num_urbs;
 	priv->urbs = kmalloc_array(num_urbs, sizeof(*priv->urbs), GFP_KERNEL);
-- 
2.21.0

