Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2827C4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 19:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA4482077B
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 19:10:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mS7P9O3Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfJFTKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 15:10:34 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36685 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfJFTKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 15:10:34 -0400
Received: by mail-qt1-f194.google.com with SMTP id o12so16223532qtf.3
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2019 12:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tCwKqi1o+pVk0eCqSLaVvuDUC0Ngrzkx/4GvgrlbAtI=;
        b=mS7P9O3YIav8KEuZm3+CXz4iU8nGdp24dICzN6qTpCAj4FyyDIKphC91akWM3JaX3B
         NlHUo+PhefyQp5gX1NvaEIbsb77IcnHVcrt5lrCN8LLmWTkwyUmuepDsxxyghv/q8PE2
         ijoeLEBozBqnRaz+blVh4hzLwGgrNd6JeQAaCFF2edWP3/Esr06CZYIcFS8s4a7ajZeW
         2GOZ8vRTaeI8yQo0j0n+d6vCTbkzWv3MRQoDynqv5Hiu1AVON2pdtuwEs8dlH0zwtoqo
         cVeiSRmFWCq6nHnrPYHb5WfSy2xLWNCiJYD96V7SC48PGSGhYHZ8dz8/PdXLtZzUuXK2
         yIig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tCwKqi1o+pVk0eCqSLaVvuDUC0Ngrzkx/4GvgrlbAtI=;
        b=T/mKqx/sPRX00xeaBp31sHca4/bbdWvvQkryus+fgVPgcb6oPzAz7JuhMuuQLkY0mQ
         tO8DarwKQhGlFZto8e+zBR1fg3YIBbyekmtaj3jhMM9JFk2BMIxRo2jFx4+ujIDyHTla
         NCNGHLOD5w/v1ZTPI4nyYXRaW0Rq58BJWKn9B0tRuimCgHEjT2s2BfjSOPporugjE7av
         MMHQKaVnXJxMa23D4OT+AekJ8KjEZFvkyuoXqOZ95A9sJkZxMCZskj6JpyjavwYEhN79
         hEpyvDh/7l+BCnCuCPN1f3zGgGQe539LRR9/XNiYy8fRQpQlTHWzyhyfDQEfMRmbQFY4
         jsbg==
X-Gm-Message-State: APjAAAX5eIrXqKsN6ZNS+YNvtAj4xfdPOm2GmNbUC8VB0D/mrqO/HoTu
        uODZ3mb5SAOHLWofCfo+eIY=
X-Google-Smtp-Source: APXvYqwItOihsdzixZc6jmQdw0tZ+tKPcvSFsFBLii45UJYEemCFuLZyIDxttd4Gab/5f51kePxx1A==
X-Received: by 2002:ac8:6e8b:: with SMTP id c11mr26342411qtv.77.1570389031557;
        Sun, 06 Oct 2019 12:10:31 -0700 (PDT)
Received: from GBdebian.terracota.local ([177.103.155.130])
        by smtp.gmail.com with ESMTPSA id u132sm6577518qka.50.2019.10.06.12.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2019 12:10:30 -0700 (PDT)
From:   Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
To:     outreachy-kernel@googlegroups.com, forest@alittletooquiet.net,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
Subject: [PATCH] staging: vt6656: align arguments with open parenthesis
Date:   Sun,  6 Oct 2019 16:10:20 -0300
Message-Id: <20191006191020.7435-1-gabrielabittencourt00@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleans up CHECKs of "Alignment should match open parenthesis"

Signed-off-by: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
---
 drivers/staging/vt6656/rxtx.c | 63 +++++++++++++++++++++++------------
 1 file changed, 41 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/vt6656/rxtx.c b/drivers/staging/vt6656/rxtx.c
index 9def0748ffee..c7522841c8cf 100644
--- a/drivers/staging/vt6656/rxtx.c
+++ b/drivers/staging/vt6656/rxtx.c
@@ -285,14 +285,15 @@ static u16 vnt_rxtx_datahead_g(struct vnt_usb_send_context *tx_context,
 		buf->duration_b = dur;
 	} else {
 		buf->duration_a = vnt_get_duration_le(priv,
-						tx_context->pkt_type, need_ack);
+						      tx_context->pkt_type,
+						      need_ack);
 		buf->duration_b = vnt_get_duration_le(priv,
-							PK_TYPE_11B, need_ack);
+						      PK_TYPE_11B, need_ack);
 	}
 
 	buf->time_stamp_off_a = vnt_time_stamp_off(priv, rate);
 	buf->time_stamp_off_b = vnt_time_stamp_off(priv,
-					priv->top_cck_basic_rate);
+						   priv->top_cck_basic_rate);
 
 	tx_context->tx_hdr_size = vnt_mac_hdr_pos(tx_context, &buf->hdr);
 
@@ -325,7 +326,7 @@ static u16 vnt_rxtx_datahead_g_fb(struct vnt_usb_send_context *tx_context,
 
 	buf->time_stamp_off_a = vnt_time_stamp_off(priv, rate);
 	buf->time_stamp_off_b = vnt_time_stamp_off(priv,
-						priv->top_cck_basic_rate);
+						   priv->top_cck_basic_rate);
 
 	tx_context->tx_hdr_size = vnt_mac_hdr_pos(tx_context, &buf->hdr);
 
@@ -595,17 +596,24 @@ static u16 vnt_rxtx_rts(struct vnt_usb_send_context *tx_context,
 	u8 need_ack = tx_context->need_ack;
 
 	buf->rts_rrv_time_aa = vnt_get_rtscts_rsvtime_le(priv, 2,
-			tx_context->pkt_type, frame_len, current_rate);
+							 tx_context->pkt_type,
+							 frame_len,
+							 current_rate);
 	buf->rts_rrv_time_ba = vnt_get_rtscts_rsvtime_le(priv, 1,
-			tx_context->pkt_type, frame_len, current_rate);
+							 tx_context->pkt_type,
+							 frame_len,
+							 current_rate);
 	buf->rts_rrv_time_bb = vnt_get_rtscts_rsvtime_le(priv, 0,
-			tx_context->pkt_type, frame_len, current_rate);
+							 tx_context->pkt_type,
+							 frame_len,
+							 current_rate);
 
 	buf->rrv_time_a = vnt_rxtx_rsvtime_le16(priv, tx_context->pkt_type,
 						frame_len, current_rate,
 						need_ack);
 	buf->rrv_time_b = vnt_rxtx_rsvtime_le16(priv, PK_TYPE_11B, frame_len,
-					priv->top_cck_basic_rate, need_ack);
+						priv->top_cck_basic_rate,
+						need_ack);
 
 	if (need_mic)
 		head = &tx_head->tx_rts.tx.mic.head;
@@ -627,12 +635,16 @@ static u16 vnt_rxtx_cts(struct vnt_usb_send_context *tx_context,
 	u8 need_ack = tx_context->need_ack;
 
 	buf->rrv_time_a = vnt_rxtx_rsvtime_le16(priv, tx_context->pkt_type,
-					frame_len, current_rate, need_ack);
-	buf->rrv_time_b = vnt_rxtx_rsvtime_le16(priv, PK_TYPE_11B,
-				frame_len, priv->top_cck_basic_rate, need_ack);
+						frame_len, current_rate,
+						need_ack);
+	buf->rrv_time_b = vnt_rxtx_rsvtime_le16(priv, PK_TYPE_11B, frame_len,
+						priv->top_cck_basic_rate,
+						need_ack);
 
 	buf->cts_rrv_time_ba = vnt_get_rtscts_rsvtime_le(priv, 3,
-			tx_context->pkt_type, frame_len, current_rate);
+							 tx_context->pkt_type,
+							 frame_len,
+							 current_rate);
 
 	if (need_mic)
 		head = &tx_head->tx_cts.tx.mic.head;
@@ -655,18 +667,25 @@ static u16 vnt_rxtx_ab(struct vnt_usb_send_context *tx_context,
 	u8 need_ack = tx_context->need_ack;
 
 	buf->rrv_time = vnt_rxtx_rsvtime_le16(priv, tx_context->pkt_type,
-			frame_len, current_rate, need_ack);
+					      frame_len, current_rate,
+					      need_ack);
 
 	if (need_mic)
 		head = &tx_head->tx_ab.tx.mic.head;
 
 	if (need_rts) {
 		if (tx_context->pkt_type == PK_TYPE_11B)
-			buf->rts_rrv_time = vnt_get_rtscts_rsvtime_le(priv, 0,
-				tx_context->pkt_type, frame_len, current_rate);
+			buf->rts_rrv_time =
+				vnt_get_rtscts_rsvtime_le(priv, 0,
+							  tx_context->pkt_type,
+							  frame_len,
+							  current_rate);
 		else /* PK_TYPE_11A */
-			buf->rts_rrv_time = vnt_get_rtscts_rsvtime_le(priv, 2,
-				tx_context->pkt_type, frame_len, current_rate);
+			buf->rts_rrv_time =
+				vnt_get_rtscts_rsvtime_le(priv, 2,
+							  tx_context->pkt_type,
+							  frame_len,
+							  current_rate);
 
 		if (tx_context->fb_option &&
 		    tx_context->pkt_type == PK_TYPE_11A)
@@ -767,10 +786,10 @@ static void vnt_fill_txkey(struct vnt_usb_send_context *tx_context,
 		ether_addr_copy(mic_hdr->addr2, hdr->addr2);
 		ether_addr_copy(mic_hdr->addr3, hdr->addr3);
 
-		mic_hdr->frame_control = cpu_to_le16(
-			le16_to_cpu(hdr->frame_control) & 0xc78f);
-		mic_hdr->seq_ctrl = cpu_to_le16(
-				le16_to_cpu(hdr->seq_ctrl) & 0xf);
+		mic_hdr->frame_control =
+			cpu_to_le16(le16_to_cpu(hdr->frame_control) & 0xc78f);
+		mic_hdr->seq_ctrl =
+			cpu_to_le16(le16_to_cpu(hdr->seq_ctrl) & 0xf);
 
 		if (ieee80211_has_a4(hdr->frame_control))
 			ether_addr_copy(mic_hdr->addr4, hdr->addr4);
@@ -1036,7 +1055,7 @@ static int vnt_beacon_xmit(struct vnt_private *priv, struct sk_buff *skb)
 
 		/* Get Duration and TimeStampOff */
 		short_head->duration = vnt_get_duration_le(priv,
-						PK_TYPE_11B, false);
+							   PK_TYPE_11B, false);
 		short_head->time_stamp_off =
 			vnt_time_stamp_off(priv, current_rate);
 	}
-- 
2.20.1

