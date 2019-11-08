Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D89FC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0091A22466
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573215223;
	bh=dcjRh652H+XEuWKwLgX9wdRsjFVakecNt9ObboueuPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ghrqb2umjhXYgQjyEC61BNQufd3cLs+6kIl2LeradwbxrdqJwy4KN5fWGG8g7yuMV
	 qK50pfpf4sIASz5rmVcqVV9hzTrtb/wdN83ymKdgMP/4ddPZCGZVCIEEu76Yr5dztE
	 a8U8rx8CDmt1HNudTy3xxGKkpUpWtq3NWLJ6430A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392032AbfKHMNm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 07:13:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:51294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732532AbfKHLiX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:38:23 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D019020869;
        Fri,  8 Nov 2019 11:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213102;
        bh=dcjRh652H+XEuWKwLgX9wdRsjFVakecNt9ObboueuPk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZYs05gZ1z+kyGt9g1N1zuEacTHmT2yryzCC6N23hU+vJXsytIXNJIbrcm6nZPbmDT
         OxpjCPpKVL0FqqJBhsfOc+q5NDqb3G08dSrz+/L4rFCk3CK6nXegjEClAEDq/YkR2F
         vXW6rNjuAZ+/vUaCFmQ1XTmzg7/XtgDDQB+XO7Xs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Maya Erez <merez@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-wireless@vger.kernel.org, wil6210@qti.qualcomm.com,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 026/205] wil6210: set edma variables only for Talyn-MB devices
Date:   Fri,  8 Nov 2019 06:34:53 -0500
Message-Id: <20191108113752.12502-26-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108113752.12502-1-sashal@kernel.org>
References: <20191108113752.12502-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maya Erez <merez@codeaurora.org>

[ Upstream commit 596bdbcce90fa93f43ebcb99cefea34bd2e27707 ]

use_rx_hw_reordering is already set to true in wil_set_capabilities
for Talyn-MB devices. Remove its setting from wil_priv_init to
prevent its activation for older chips.
Similarly, move the setting of use_compressed_rx_status to
wil_set_capabilities.

Signed-off-by: Maya Erez <merez@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/wil6210/main.c     | 2 --
 drivers/net/wireless/ath/wil6210/pcie_bus.c | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/main.c b/drivers/net/wireless/ath/wil6210/main.c
index a0fe8cbad104f..d186b6886c6bf 100644
--- a/drivers/net/wireless/ath/wil6210/main.c
+++ b/drivers/net/wireless/ath/wil6210/main.c
@@ -653,8 +653,6 @@ int wil_priv_init(struct wil6210_priv *wil)
 
 	/* edma configuration can be updated via debugfs before allocation */
 	wil->num_rx_status_rings = WIL_DEFAULT_NUM_RX_STATUS_RINGS;
-	wil->use_compressed_rx_status = true;
-	wil->use_rx_hw_reordering = true;
 	wil->tx_status_ring_order = WIL_TX_SRING_SIZE_ORDER_DEFAULT;
 
 	/* Rx status ring size should be bigger than the number of RX buffers
diff --git a/drivers/net/wireless/ath/wil6210/pcie_bus.c b/drivers/net/wireless/ath/wil6210/pcie_bus.c
index 89119e7facd00..c8c6613371d1b 100644
--- a/drivers/net/wireless/ath/wil6210/pcie_bus.c
+++ b/drivers/net/wireless/ath/wil6210/pcie_bus.c
@@ -108,6 +108,7 @@ int wil_set_capabilities(struct wil6210_priv *wil)
 		set_bit(hw_capa_no_flash, wil->hw_capa);
 		wil->use_enhanced_dma_hw = true;
 		wil->use_rx_hw_reordering = true;
+		wil->use_compressed_rx_status = true;
 		wil_fw_name = ftm_mode ? WIL_FW_NAME_FTM_TALYN :
 			      WIL_FW_NAME_TALYN;
 		if (wil_fw_verify_file_exists(wil, wil_fw_name))
-- 
2.20.1

