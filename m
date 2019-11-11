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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4B3C17445
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 13:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EE26222D2
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 13:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFLFeXWj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbfKKNbW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 08:31:22 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54568 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727385AbfKKNbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 08:31:21 -0500
Received: by mail-wm1-f66.google.com with SMTP id z26so13317982wmi.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 05:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SBThM90ubuVDseSTLIwGRN+Zh5K8pDyfCSWgh066qac=;
        b=UFLFeXWjZpe238nQATmrZSX6QzTo7ltvTj5ThV5ANLfsbDa4iQIt8AaTSGLMJrMnEP
         qxULJX2W3orbIAtdRVN0zW00c6ZBXd2oxXVV1GVDekOOhYFzYWHftwYBqSuGATZBqGhJ
         dmSIJIuDTCJ0LnpR74pvCBYKf41K4TlC42KPIA1Ihq6/6YfyuLyqfu9JlfBIMQtwN2Am
         wtPi+c2FbFmAxObpAKUsonXeBxlIcRDhMTKuTff/UuM/AEohIzqnMJteKC7FQcTKMdP4
         0V357WBwtwfnJX1udTnULxRilUVRR9T+a2fvoZWgLi20nRRHfyOPNwfhNnWNSYVmDiDW
         kuEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SBThM90ubuVDseSTLIwGRN+Zh5K8pDyfCSWgh066qac=;
        b=MZKyLuZSHeCd8jRQJUHqGz55SdZnE8G1NP0xNPl0UWcxPUrdqf/GZqA3qoYDG9l1kw
         eR3tlKP0XvRz8WWlH06d8awrM68PtlpPDV7aVjgNd53iQaa+PCCHSOmTt3uHLJYVtqJv
         bvrx5DkySo5XluiL/51wwDCvXg+4SmM1jt2CrvwOI2Ch5x3JuGg6ruIcvXm2pLiWaybO
         F6o9fiJO0/IeGxN2uOTEqdTPG4VPIxTeA3KAcDdt+CxJ0Q9daCw/U9PRhhVPeAC7Ll27
         N2tEcF4r9DoCYeZbQDW+8gkhsp/nIjMme39alg6/ZLfZ1/whiyRpaP4S7S+asP4Ozu/f
         26ag==
X-Gm-Message-State: APjAAAWjlHfhJZezmPvSBy3gKuCX1sA98CbEEP5nXfQy/Las5wDYFdrm
        e8d3HUvcDQpCHzrEwMAatOp/2eKG/wel
X-Google-Smtp-Source: APXvYqx0odl6vPnAhPz8C9KDrav40rpT5veoN0MIuwZ5rh9JGwF63rEXMH1iPkDRSvb5nvx3BUZVBQ==
X-Received: by 2002:a7b:c347:: with SMTP id l7mr17125411wmj.48.1573479079116;
        Mon, 11 Nov 2019 05:31:19 -0800 (PST)
Received: from ninjahub.lan (79-73-36-243.dynamic.dsl.as9105.com. [79.73.36.243])
        by smtp.googlemail.com with ESMTPSA id w11sm8470143wra.83.2019.11.11.05.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 05:31:18 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     jerome.pouiller@silabs.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Jules Irenge <jbi.octave@gmail.com>
Subject: [PATCH v2 3/3] staging: wfx: replace u32 by __le32
Date:   Mon, 11 Nov 2019 13:30:55 +0000
Message-Id: <20191111133055.214410-3-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191111133055.214410-1-jbi.octave@gmail.com>
References: <20191111133055.214410-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace u32 by __le32 to fix warning of cast from restricted __le32.
Issue detected by sparse tool.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
v1 uses casting to fix the warnings
v2 replace the declaration type of the variables

 drivers/staging/wfx/hif_api_mib.h | 48 +++++++++++++++----------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/staging/wfx/hif_api_mib.h b/drivers/staging/wfx/hif_api_mib.h
index 94b789ceb4ff..e0a67410add2 100644
--- a/drivers/staging/wfx/hif_api_mib.h
+++ b/drivers/staging/wfx/hif_api_mib.h
@@ -295,31 +295,31 @@ struct hif_mib_stats_table {
 } __packed;
 
 struct hif_mib_extended_count_table {
-	u32   count_plcp_errors;
-	u32   count_fcs_errors;
-	u32   count_tx_packets;
-	u32   count_rx_packets;
-	u32   count_rx_packet_errors;
-	u32   count_rx_decryption_failures;
-	u32   count_rx_mic_failures;
-	u32   count_rx_no_key_failures;
-	u32   count_tx_multicast_frames;
-	u32   count_tx_frames_success;
-	u32   count_tx_frame_failures;
-	u32   count_tx_frames_retried;
-	u32   count_tx_frames_multi_retried;
-	u32   count_rx_frame_duplicates;
-	u32   count_rts_success;
-	u32   count_rts_failures;
-	u32   count_ack_failures;
-	u32   count_rx_multicast_frames;
-	u32   count_rx_frames_success;
-	u32   count_rx_cmacicv_errors;
-	u32   count_rx_cmac_replays;
-	u32   count_rx_mgmt_ccmp_replays;
+	__le32   count_plcp_errors;
+	__le32   count_fcs_errors;
+	__le32   count_tx_packets;
+	__le32   count_rx_packets;
+	__le32   count_rx_packet_errors;
+	__le32   count_rx_decryption_failures;
+	__le32   count_rx_mic_failures;
+	__le32   count_rx_no_key_failures;
+	__le32   count_tx_multicast_frames;
+	__le32   count_tx_frames_success;
+	__le32   count_tx_frame_failures;
+	__le32   count_tx_frames_retried;
+	__le32   count_tx_frames_multi_retried;
+	__le32   count_rx_frame_duplicates;
+	__le32   count_rts_success;
+	__le32   count_rts_failures;
+	__le32   count_rx_multicast_frames;
+	__le32   count_rx_cmacicv_errors;
+	__le32   count_rx_cmac_replays;
+	__le32   count_rx_mgmt_ccmp_replays;
+	__le32   count_rx_beacon;
+	__le32   count_miss_beacon;
+	__le32   count_ack_failures;
+	__le32   count_rx_frames_success;
 	u32   count_rx_bipmic_errors;
-	u32   count_rx_beacon;
-	u32   count_miss_beacon;
 	u32   reserved[15];
 } __packed;
 
-- 
2.23.0

