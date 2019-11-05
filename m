Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16995CA9ED3
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 02:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D43AE21882
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 02:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vCVrjbyU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387495AbfKECXc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 21:23:32 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38242 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728987AbfKECXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 21:23:31 -0500
Received: by mail-pl1-f196.google.com with SMTP id w8so8605469plq.5;
        Mon, 04 Nov 2019 18:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=f98IpOl/9+gXYcX8/ivKEdHBj5iW3HvmpYgUIqlIatM=;
        b=vCVrjbyUj+2qAHqMaTKE/b/psTgR3h/GS6T5mraLk6s1vnrkzZczu8UHzD5xSKRXnE
         NO+NvHRHXCDp5zzI+Ua7s3ZNXay6ziN8OiKCSYd8XT5/VoZxxiNhikOmgB8EOMLyEaWY
         6BUMp6nje3RpaMKio6gOADxOizjVfEExDB9x3GU8hialDCkYGmMMuiYU+XCKZPJiME4e
         BKc7WGFcDYRSYO46OtGOdsKSA/ST7Y+rGT+fBwZXUdBfXrT7IJReouvIc8hzlqQX0bEw
         XPLEOTA3BC7S0jo9MNED1oc0G4Utl3kdi/Z4o9P+3LU0eU0Qz3EuPffMfz9SOTpEdQtu
         SzDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=f98IpOl/9+gXYcX8/ivKEdHBj5iW3HvmpYgUIqlIatM=;
        b=e2H3LRs1g9TduLoXWkB5TX5zfpWBb9jQ9YmDZa6nDAl/BmWMzsncGC96k2jAe/gDsq
         GyYJAZK1pPmV7FWeIXppHlcRLoXp2fYBi9tLBzwduQD/9rRNQBM9Fx/YTSkRgcfQsKIQ
         gmp3jErioyWRIeXcNvza/zPVadFRUFqXTasuEy486RuUTx8AbkXAbZUTNB7mvBRhY3iD
         EIiH7MVEVgD2uPl7zGHZ+0ZZKgdNc06G4076PEYwNbOgbQ31GQPDN17yF9bXVvtSGAmr
         cLiaxr+2+YXuU8WWVKF8fMqsMhXMUAG2l7WvbSLeqjFDN4rY1Xv379FT01O+X6sG/fua
         U6VQ==
X-Gm-Message-State: APjAAAU0zxXVjFTP1+p4GKXf9NTzuyWqd9nHpXei3dmJ2/1NBuThes+4
        hod+dK4stPpffsJsUBT4b8E=
X-Google-Smtp-Source: APXvYqzRCgZQeLobXRghsr/IBNxMs6EMO5g8Oevp7vvFgXyxoiL5UzKo+PwRu9BEJfK0wpIiH7KepQ==
X-Received: by 2002:a17:902:6946:: with SMTP id k6mr1009136plt.60.1572920609663;
        Mon, 04 Nov 2019 18:23:29 -0800 (PST)
Received: from jamal-desktop (97-126-66-56.tukw.qwest.net. [97.126.66.56])
        by smtp.gmail.com with ESMTPSA id v14sm11995297pfm.51.2019.11.04.18.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 18:23:29 -0800 (PST)
From:   Jamal Shareef <jamal.k.shareef@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     thierry.reding@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        jonathanh@nvidia.com, dri-devel@lists.freedesktop.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jamal Shareef <jamal.k.shareef@gmail.com>
Subject: [PATCH 2/3] drm/tegra: dsi: Remove space in open parenthesis
Date:   Mon,  4 Nov 2019 18:23:21 -0800
Message-Id: <4357d243bdb0ac22a36f3edb0f08820fbc31348b.1572920482.git.jamal.k.shareef@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1572920482.git.jamal.k.shareef@gmail.com>
References: <cover.1572920482.git.jamal.k.shareef@gmail.com>
In-Reply-To: <cover.1572920482.git.jamal.k.shareef@gmail.com>
References: <cover.1572920482.git.jamal.k.shareef@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removes space after open left parenthesis. Issue found by checkpatch.

Signed-off-by: Jamal Shareef <jamal.k.shareef@gmail.com>
---
 drivers/gpu/drm/tegra/dsi.c | 60 ++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/tegra/dsi.c b/drivers/gpu/drm/tegra/dsi.c
index a5d47e301c5f..5966d33831e4 100644
--- a/drivers/gpu/drm/tegra/dsi.c
+++ b/drivers/gpu/drm/tegra/dsi.c
@@ -283,32 +283,32 @@ static void tegra_dsi_early_unregister(struct drm_connector *connector)
  * non-burst mode with sync pulses
  */
 static const u32 pkt_seq_video_non_burst_sync_pulses[NUM_PKT_SEQ] = {
-	[ 0] = PKT_ID0(MIPI_DSI_V_SYNC_START) | PKT_LEN0(0) |
+	[0] = PKT_ID0(MIPI_DSI_V_SYNC_START) | PKT_LEN0(0) |
 	       PKT_ID1(MIPI_DSI_BLANKING_PACKET) | PKT_LEN1(1) |
 	       PKT_ID2(MIPI_DSI_H_SYNC_END) | PKT_LEN2(0) |
 	       PKT_LP,
-	[ 1] = 0,
-	[ 2] = PKT_ID0(MIPI_DSI_V_SYNC_END) | PKT_LEN0(0) |
+	[1] = 0,
+	[2] = PKT_ID0(MIPI_DSI_V_SYNC_END) | PKT_LEN0(0) |
 	       PKT_ID1(MIPI_DSI_BLANKING_PACKET) | PKT_LEN1(1) |
 	       PKT_ID2(MIPI_DSI_H_SYNC_END) | PKT_LEN2(0) |
 	       PKT_LP,
-	[ 3] = 0,
-	[ 4] = PKT_ID0(MIPI_DSI_H_SYNC_START) | PKT_LEN0(0) |
+	[3] = 0,
+	[4] = PKT_ID0(MIPI_DSI_H_SYNC_START) | PKT_LEN0(0) |
 	       PKT_ID1(MIPI_DSI_BLANKING_PACKET) | PKT_LEN1(1) |
 	       PKT_ID2(MIPI_DSI_H_SYNC_END) | PKT_LEN2(0) |
 	       PKT_LP,
-	[ 5] = 0,
-	[ 6] = PKT_ID0(MIPI_DSI_H_SYNC_START) | PKT_LEN0(0) |
+	[5] = 0,
+	[6] = PKT_ID0(MIPI_DSI_H_SYNC_START) | PKT_LEN0(0) |
 	       PKT_ID1(MIPI_DSI_BLANKING_PACKET) | PKT_LEN1(1) |
 	       PKT_ID2(MIPI_DSI_H_SYNC_END) | PKT_LEN2(0),
-	[ 7] = PKT_ID0(MIPI_DSI_BLANKING_PACKET) | PKT_LEN0(2) |
+	[7] = PKT_ID0(MIPI_DSI_BLANKING_PACKET) | PKT_LEN0(2) |
 	       PKT_ID1(MIPI_DSI_PACKED_PIXEL_STREAM_24) | PKT_LEN1(3) |
 	       PKT_ID2(MIPI_DSI_BLANKING_PACKET) | PKT_LEN2(4),
-	[ 8] = PKT_ID0(MIPI_DSI_H_SYNC_START) | PKT_LEN0(0) |
+	[8] = PKT_ID0(MIPI_DSI_H_SYNC_START) | PKT_LEN0(0) |
 	       PKT_ID1(MIPI_DSI_BLANKING_PACKET) | PKT_LEN1(1) |
 	       PKT_ID2(MIPI_DSI_H_SYNC_END) | PKT_LEN2(0) |
 	       PKT_LP,
-	[ 9] = 0,
+	[9] = 0,
 	[10] = PKT_ID0(MIPI_DSI_H_SYNC_START) | PKT_LEN0(0) |
 	       PKT_ID1(MIPI_DSI_BLANKING_PACKET) | PKT_LEN1(1) |
 	       PKT_ID2(MIPI_DSI_H_SYNC_END) | PKT_LEN2(0),
@@ -321,26 +321,26 @@ static const u32 pkt_seq_video_non_burst_sync_pulses[NUM_PKT_SEQ] = {
  * non-burst mode with sync events
  */
 static const u32 pkt_seq_video_non_burst_sync_events[NUM_PKT_SEQ] = {
-	[ 0] = PKT_ID0(MIPI_DSI_V_SYNC_START) | PKT_LEN0(0) |
+	[0] = PKT_ID0(MIPI_DSI_V_SYNC_START) | PKT_LEN0(0) |
 	       PKT_ID1(MIPI_DSI_END_OF_TRANSMISSION) | PKT_LEN1(7) |
 	       PKT_LP,
-	[ 1] = 0,
-	[ 2] = PKT_ID0(MIPI_DSI_H_SYNC_START) | PKT_LEN0(0) |
+	[1] = 0,
+	[2] = PKT_ID0(MIPI_DSI_H_SYNC_START) | PKT_LEN0(0) |
 	       PKT_ID1(MIPI_DSI_END_OF_TRANSMISSION) | PKT_LEN1(7) |
 	       PKT_LP,
-	[ 3] = 0,
-	[ 4] = PKT_ID0(MIPI_DSI_H_SYNC_START) | PKT_LEN0(0) |
+	[3] = 0,
+	[4] = PKT_ID0(MIPI_DSI_H_SYNC_START) | PKT_LEN0(0) |
 	       PKT_ID1(MIPI_DSI_END_OF_TRANSMISSION) | PKT_LEN1(7) |
 	       PKT_LP,
-	[ 5] = 0,
-	[ 6] = PKT_ID0(MIPI_DSI_H_SYNC_START) | PKT_LEN0(0) |
+	[5] = 0,
+	[6] = PKT_ID0(MIPI_DSI_H_SYNC_START) | PKT_LEN0(0) |
 	       PKT_ID1(MIPI_DSI_BLANKING_PACKET) | PKT_LEN1(2) |
 	       PKT_ID2(MIPI_DSI_PACKED_PIXEL_STREAM_24) | PKT_LEN2(3),
-	[ 7] = PKT_ID0(MIPI_DSI_BLANKING_PACKET) | PKT_LEN0(4),
-	[ 8] = PKT_ID0(MIPI_DSI_H_SYNC_START) | PKT_LEN0(0) |
+	[7] = PKT_ID0(MIPI_DSI_BLANKING_PACKET) | PKT_LEN0(4),
+	[8] = PKT_ID0(MIPI_DSI_H_SYNC_START) | PKT_LEN0(0) |
 	       PKT_ID1(MIPI_DSI_END_OF_TRANSMISSION) | PKT_LEN1(7) |
 	       PKT_LP,
-	[ 9] = 0,
+	[9] = 0,
 	[10] = PKT_ID0(MIPI_DSI_H_SYNC_START) | PKT_LEN0(0) |
 	       PKT_ID1(MIPI_DSI_BLANKING_PACKET) | PKT_LEN1(2) |
 	       PKT_ID2(MIPI_DSI_PACKED_PIXEL_STREAM_24) | PKT_LEN2(3),
@@ -348,16 +348,16 @@ static const u32 pkt_seq_video_non_burst_sync_events[NUM_PKT_SEQ] = {
 };
 
 static const u32 pkt_seq_command_mode[NUM_PKT_SEQ] = {
-	[ 0] = 0,
-	[ 1] = 0,
-	[ 2] = 0,
-	[ 3] = 0,
-	[ 4] = 0,
-	[ 5] = 0,
-	[ 6] = PKT_ID0(MIPI_DSI_DCS_LONG_WRITE) | PKT_LEN0(3) | PKT_LP,
-	[ 7] = 0,
-	[ 8] = 0,
-	[ 9] = 0,
+	[0] = 0,
+	[1] = 0,
+	[2] = 0,
+	[3] = 0,
+	[4] = 0,
+	[5] = 0,
+	[6] = PKT_ID0(MIPI_DSI_DCS_LONG_WRITE) | PKT_LEN0(3) | PKT_LP,
+	[7] = 0,
+	[8] = 0,
+	[9] = 0,
 	[10] = PKT_ID0(MIPI_DSI_DCS_LONG_WRITE) | PKT_LEN0(5) | PKT_LP,
 	[11] = 0,
 };
-- 
2.17.1

