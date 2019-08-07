Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA8AC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 08:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF08C223B9
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 08:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H3swZwOc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728957AbfHGIwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 04:52:25 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40453 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbfHGIwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 04:52:25 -0400
Received: by mail-wm1-f68.google.com with SMTP id v19so79161174wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 01:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=WZhZ/Mz+hS9BkCT+OjM+njIOBnNzukH3KufvaiYnvw8=;
        b=H3swZwOcXQx7tB7XCeGdoZ8t3UwIPZE3LvtFVRMCOKaFZz/AHSm0b3w/e23HSot3oy
         H5BCNioOVFRBIDfWrn9KfvPQy0T1RkoglWhkPzqGXDjf0qdYJRxN7bzjJCwXd6Zc3WvD
         k7Y6E1asqe8h83O1b8EDg8c5x87be1YC05I6mD/3UM+H2mcEgs+/Rc+Q0i64zC57uDNj
         OKzL1StpPB9zvh4NtfOA3FThCS7SW1sFH1BRvnViFEJIXpdt/y/NZriwU52MFj4I5UZv
         AdGrkK4bboWf5GEX7gqjH36lNnGlCjp3Nbzs1jemjNlSA3fdo1++F5EnQa/Lm+RgMy5e
         50mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WZhZ/Mz+hS9BkCT+OjM+njIOBnNzukH3KufvaiYnvw8=;
        b=SbDQyNc2WxxamxGxkZVELrfpQTYX8Ft3tiyYMYfGGnEjeENVxnP0RiRDQpyjvWZDL+
         wbEUVKn/aFLM6nJql4HXOM/6Z5uX5xAbebNbx8IZBbIOFRaqN4+nja0EBhohJ7aCEmZY
         7rKYmza5WYl9aP2gsi7HR7inX26jWYi3Pd37p5g+3hzYaTCW/ncO59wiZHcz8vZZ9o4W
         rHvTCxKyifMOInFF99uLt5UOw9GjDrmM1Sju331ZAOmSdym2NImj0RiFyIJ2C7SIJw+G
         JOXIflSMJ2Fny7jZoM9F4hS9VDDlSWlwPd0DNqpMoJefPFAJgpl8YkHqkrM1h4zvZgD/
         DMeA==
X-Gm-Message-State: APjAAAUblOXbrpJUpAIATNTV3JfxoI7qtVkWuWF/KJ1ak9H4dzHlapEW
        3HHTwVE3R598oM0iSb/MkGdFWtaXEcM=
X-Google-Smtp-Source: APXvYqwoUyDAD79G7N+ff80C+yNvtsF1NA93EGrsdopOkcuZE11V1IydzzP6dblibAVWwFHu6h9ung==
X-Received: by 2002:a7b:cd8e:: with SMTP id y14mr9405494wmj.155.1565167942064;
        Wed, 07 Aug 2019 01:52:22 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id x24sm88519035wmh.5.2019.08.07.01.52.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 01:52:21 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, Ben Segal <bpsegal20@gmail.com>
Subject: [PATCH 1/2] habanalabs: fix endianness handling for packets from user
Date:   Wed,  7 Aug 2019 11:52:16 +0300
Message-Id: <20190807085217.28488-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Segal <bpsegal20@gmail.com>

Packets that arrive from the user and need to be parsed by the driver are
assumed to be in LE format.

This patch fix all the places where the code handles these packets and use
the correct endianness macros to handle them, as the driver handles the
packets in CPU format (LE or BE depending on the arch).

Signed-off-by: Ben Segal <bpsegal20@gmail.com>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/goya/goya.c           | 32 +++++++++++--------
 .../habanalabs/include/goya/goya_packets.h    | 13 ++++++++
 2 files changed, 32 insertions(+), 13 deletions(-)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index a0e181714891..e8b1142910e0 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -3428,12 +3428,13 @@ static int goya_validate_cb(struct hl_device *hdev,
 	while (cb_parsed_length < parser->user_cb_size) {
 		enum packet_id pkt_id;
 		u16 pkt_size;
-		void *user_pkt;
+		struct goya_packet *user_pkt;
 
-		user_pkt = (void *) (uintptr_t)
+		user_pkt = (struct goya_packet *) (uintptr_t)
 			(parser->user_cb->kernel_address + cb_parsed_length);
 
-		pkt_id = (enum packet_id) (((*(u64 *) user_pkt) &
+		pkt_id = (enum packet_id) (
+				(le64_to_cpu(user_pkt->header) &
 				PACKET_HEADER_PACKET_ID_MASK) >>
 					PACKET_HEADER_PACKET_ID_SHIFT);
 
@@ -3453,7 +3454,8 @@ static int goya_validate_cb(struct hl_device *hdev,
 			 * need to validate here as well because patch_cb() is
 			 * not called in MMU path while this function is called
 			 */
-			rc = goya_validate_wreg32(hdev, parser, user_pkt);
+			rc = goya_validate_wreg32(hdev,
+				parser, (struct packet_wreg32 *) user_pkt);
 			break;
 
 		case PACKET_WREG_BULK:
@@ -3481,10 +3483,10 @@ static int goya_validate_cb(struct hl_device *hdev,
 		case PACKET_LIN_DMA:
 			if (is_mmu)
 				rc = goya_validate_dma_pkt_mmu(hdev, parser,
-						user_pkt);
+					(struct packet_lin_dma *) user_pkt);
 			else
 				rc = goya_validate_dma_pkt_no_mmu(hdev, parser,
-						user_pkt);
+					(struct packet_lin_dma *) user_pkt);
 			break;
 
 		case PACKET_MSG_LONG:
@@ -3657,15 +3659,16 @@ static int goya_patch_cb(struct hl_device *hdev,
 		enum packet_id pkt_id;
 		u16 pkt_size;
 		u32 new_pkt_size = 0;
-		void *user_pkt, *kernel_pkt;
+		struct goya_packet *user_pkt, *kernel_pkt;
 
-		user_pkt = (void *) (uintptr_t)
+		user_pkt = (struct goya_packet *) (uintptr_t)
 			(parser->user_cb->kernel_address + cb_parsed_length);
-		kernel_pkt = (void *) (uintptr_t)
+		kernel_pkt = (struct goya_packet *) (uintptr_t)
 			(parser->patched_cb->kernel_address +
 					cb_patched_cur_length);
 
-		pkt_id = (enum packet_id) (((*(u64 *) user_pkt) &
+		pkt_id = (enum packet_id) (
+				(le64_to_cpu(user_pkt->header) &
 				PACKET_HEADER_PACKET_ID_MASK) >>
 					PACKET_HEADER_PACKET_ID_SHIFT);
 
@@ -3680,15 +3683,18 @@ static int goya_patch_cb(struct hl_device *hdev,
 
 		switch (pkt_id) {
 		case PACKET_LIN_DMA:
-			rc = goya_patch_dma_packet(hdev, parser, user_pkt,
-						kernel_pkt, &new_pkt_size);
+			rc = goya_patch_dma_packet(hdev, parser,
+					(struct packet_lin_dma *) user_pkt,
+					(struct packet_lin_dma *) kernel_pkt,
+					&new_pkt_size);
 			cb_patched_cur_length += new_pkt_size;
 			break;
 
 		case PACKET_WREG_32:
 			memcpy(kernel_pkt, user_pkt, pkt_size);
 			cb_patched_cur_length += pkt_size;
-			rc = goya_validate_wreg32(hdev, parser, kernel_pkt);
+			rc = goya_validate_wreg32(hdev, parser,
+					(struct packet_wreg32 *) kernel_pkt);
 			break;
 
 		case PACKET_WREG_BULK:
diff --git a/drivers/misc/habanalabs/include/goya/goya_packets.h b/drivers/misc/habanalabs/include/goya/goya_packets.h
index a14407b975e4..ef54bad20509 100644
--- a/drivers/misc/habanalabs/include/goya/goya_packets.h
+++ b/drivers/misc/habanalabs/include/goya/goya_packets.h
@@ -52,6 +52,19 @@ enum goya_dma_direction {
 #define GOYA_PKT_CTL_MB_SHIFT		31
 #define GOYA_PKT_CTL_MB_MASK		0x80000000
 
+/* All packets have, at least, an 8-byte header, which contains
+ * the packet type. The kernel driver uses the packet header for packet
+ * validation and to perform any necessary required preparation before
+ * sending them off to the hardware.
+ */
+struct goya_packet {
+	__le64 header;
+	/* The rest of the packet data follows. Use the corresponding
+	 * packet_XXX struct to deference the data, based on packet type
+	 */
+	u8 contents[0];
+};
+
 struct packet_nop {
 	__le32 reserved;
 	__le32 ctl;
-- 
2.17.1

