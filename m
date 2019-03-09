Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0696EC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 17:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C96C3207E0
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 17:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6woUkqT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfCIR4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 12:56:33 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41716 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfCIR4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 12:56:32 -0500
Received: by mail-qt1-f193.google.com with SMTP id v10so800847qtp.8
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2019 09:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W5zej5E9pjJ5b8B7UIewqjhuZZ6r+Dd/Xdz8yV5jhgw=;
        b=P6woUkqT8imbd3yiW7p4klY72JRarLrrsIMM7L9bqce2WTtiFQ/GVQ7jiK70/QTod7
         x3VAX/JxvPZNBgcW1+yeR8ipzNafXocbU4Gd8xDkylj03iVksPPW5xKd+iInFYHFSryt
         ml1sjE5SAwpFZRaOpbsnUMqNLgsFlSH9ubBl4IneoqAv5mJmAbiRABo+i4utK4M0TqMq
         KkwRccDlf7FNqXsbNTZ7oobaiFvEHLfyvXkcJz9Ntjxz1t6PFcBkxgNFNfoGV2j6SQew
         WHCELrPgkMW2tMCOSTu0EBsaB4CoMNxqlc4VDslH0j+vdmWCIEbc/MynWSwS/pGUNdSv
         Q8HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W5zej5E9pjJ5b8B7UIewqjhuZZ6r+Dd/Xdz8yV5jhgw=;
        b=STMB0u0ni/fLKAMujvi2aJrTKdqHstoo9V6VXQQdsl0acmjIpLXGhRi9OEmzvszpln
         EPHMfqGb8sUNlp6iQEQe3t5cEQAP5h3UZYZ+mppbpjLpJjLWlKWyTNkhdyp3LzYDPk9V
         joeoz8NFxKWmWc/UpTnSnBkKeV46JxmgnTiwP4NS/Q3IESu++5ry+/wmDedK9rJnuK1E
         P4SymhAt3vB5qqdEyTdqmhwmJlbXUWUILIuun0rERuEyBqxwMYkMq8Vpmj6NUqvY7x8n
         QPCaxm7iP+y7SaFPKJSm28zKVLTDNnzgSPAY4bfzjMkzkCeYRQOGJ1AIOGpEtRZkNgtC
         GQNg==
X-Gm-Message-State: APjAAAUtvwBY9VtStJR4NPKPIM4f9mMqYr7Xx2uszrHo0bjPQ1kEUBrh
        ZnbW7jfCeOxMJ9qfmqzytag=
X-Google-Smtp-Source: APXvYqw5Pad8C/xIRDJDwdVhUJxfULd8W121ejS6Pa6sWuuFDerJ/soapG2DjXzMAxZqzMoBiXR5xQ==
X-Received: by 2002:a0c:be91:: with SMTP id n17mr19929617qvi.32.1552154191592;
        Sat, 09 Mar 2019 09:56:31 -0800 (PST)
Received: from mega-tmob.famaf.unc.edu.ar (proxy-4.psi.unc.edu.ar. [200.16.16.13])
        by smtp.gmail.com with ESMTPSA id p35sm608186qte.83.2019.03.09.09.56.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Mar 2019 09:56:31 -0800 (PST)
From:   Ignacio Losiggio <iglosiggio@gmail.com>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     Ignacio Losiggio <iglosiggio@gmail.com>,
        Ignacio Losiggio <iglosiggio@dc.uba.ar>
Subject: [PATCH] staging: gdm724x: Fix alignment in gdm_mux
Date:   Sat,  9 Mar 2019 14:56:14 -0300
Message-Id: <20190309175614.15354-1-iglosiggio@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch modifies the alignment and linebreaks in gdm_mux in order to make
the code more concise.

Signed-off-by: Ignacio Losiggio <iglosiggio@dc.uba.ar>
---
 drivers/staging/gdm724x/gdm_mux.c | 35 ++++++++++++++-----------------
 drivers/staging/gdm724x/gdm_mux.h |  2 +-
 2 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/gdm724x/gdm_mux.c b/drivers/staging/gdm724x/gdm_mux.c
index e2a050ba6fbb..be13de12ce9f 100644
--- a/drivers/staging/gdm724x/gdm_mux.c
+++ b/drivers/staging/gdm724x/gdm_mux.c
@@ -164,8 +164,7 @@ static int up_to_host(struct mux_rx *r)
 
 		total_len = ALIGN(MUX_HEADER_SIZE + payload_size, 4);
 
-		if (len - packet_size_sum <
-			total_len) {
+		if (len - packet_size_sum < total_len) {
 			pr_err("invalid payload : %d %d %04x\n",
 			       payload_size, len, packet_type);
 			break;
@@ -178,11 +177,10 @@ static int up_to_host(struct mux_rx *r)
 		}
 
 		ret = r->callback(mux_header->data,
-				payload_size,
-				index,
-				mux_dev->tty_dev,
-				RECV_PACKET_PROCESS_CONTINUE
-				);
+		                  payload_size,
+				  index,
+				  mux_dev->tty_dev,
+				  RECV_PACKET_PROCESS_CONTINUE);
 		if (ret == TO_HOST_BUFFER_REQUEST_FAIL) {
 			r->offset += packet_size_sum;
 			break;
@@ -191,11 +189,10 @@ static int up_to_host(struct mux_rx *r)
 		packet_size_sum += total_len;
 		if (len - packet_size_sum <= MUX_HEADER_SIZE + 2) {
 			ret = r->callback(NULL,
-					0,
-					index,
-					mux_dev->tty_dev,
-					RECV_PACKET_PROCESS_COMPLETE
-					);
+					  0,
+					  index,
+					  mux_dev->tty_dev,
+					  RECV_PACKET_PROCESS_COMPLETE);
 			break;
 		}
 	}
@@ -376,8 +373,8 @@ static int gdm_mux_send(void *priv_dev, void *data, int len, int tty_index,
 	mux_header->packet_type = __cpu_to_le16(packet_type[tty_index]);
 
 	memcpy(t->buf + MUX_HEADER_SIZE, data, len);
-	memset(t->buf + MUX_HEADER_SIZE + len, 0, total_len - MUX_HEADER_SIZE -
-	       len);
+	memset(t->buf + MUX_HEADER_SIZE + len, 0,
+	       total_len - MUX_HEADER_SIZE - len);
 
 	t->len = total_len;
 	t->callback = cb;
@@ -418,8 +415,7 @@ static int gdm_mux_send_control(void *priv_dev, int request, int value,
 			      2,
 			      buf,
 			      len,
-			      5000
-			     );
+			      5000);
 
 	if (ret < 0)
 		pr_err("usb_control_msg error: %d\n", ret);
@@ -429,9 +425,10 @@ static int gdm_mux_send_control(void *priv_dev, int request, int value,
 
 static void release_usb(struct mux_dev *mux_dev)
 {
-	struct rx_cxt		*rx = &mux_dev->rx;
-	struct mux_rx		*r, *r_next;
-	unsigned long		flags;
+	struct rx_cxt *rx = &mux_dev->rx;
+	struct mux_rx *r;
+	struct mux_rx *r_next;
+	unsigned long flags;
 
 	cancel_delayed_work(&mux_dev->work_rx);
 
diff --git a/drivers/staging/gdm724x/gdm_mux.h b/drivers/staging/gdm724x/gdm_mux.h
index 51c22e3d8aeb..5bfb95be3ed3 100644
--- a/drivers/staging/gdm724x/gdm_mux.h
+++ b/drivers/staging/gdm724x/gdm_mux.h
@@ -13,7 +13,7 @@
 #define PM_NORMAL 0
 #define PM_SUSPEND 1
 
-#define USB_RT_ACM          (USB_TYPE_CLASS | USB_RECIP_INTERFACE)
+#define USB_RT_ACM (USB_TYPE_CLASS | USB_RECIP_INTERFACE)
 
 #define START_FLAG 0xA512485A
 #define MUX_HEADER_SIZE 14
-- 
2.21.0

