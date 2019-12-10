Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E62C00454
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B59F208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576015515;
	bh=bUapwW9hxA9yG13dhWbibDtVoEwpmtvoM5yQzER5YyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=t3M1a4oulNtHd9cceY1J7SYi9vWtD6yLlZVkJaAygrhC2fezoKkIfaFW9rCLcu5HM
	 zVy/xG0rRZF6qGpevzhVUAIWHzD6YOAeBLBxHSnx+jW38BksKWWgWZOED81fVp6WGb
	 Jp4FmHFshz16GbU63zIH6jNeu6ZyFTj2Tpc7850I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbfLJWFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 17:05:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:36076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729262AbfLJWE5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 17:04:57 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3330622B48;
        Tue, 10 Dec 2019 22:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576015497;
        bh=bUapwW9hxA9yG13dhWbibDtVoEwpmtvoM5yQzER5YyQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YNbm2k1Lq9k0015M3DX8Me4Y/mBfil00atsH1qIzv9jg0tpVooqlDmIIRJPdVx3Mz
         s0JzBP0PtfpNCmJimfI0py4YPEicn2O5csEqCwkRvWdfqNoO/BNJT/CW1VlLpOCGpL
         RrSI31T/g0guPdzkM8T+apLL7JxuyoOmyetkuiW4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Miaoqing Pan <miaoqing@codeaurora.org>,
        Hou Bao Hou <houbao@codeaurora.org>,
        Anilkumar Kolli <akolli@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 097/130] ath10k: fix get invalid tx rate for Mesh metric
Date:   Tue, 10 Dec 2019 17:02:28 -0500
Message-Id: <20191210220301.13262-97-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210220301.13262-1-sashal@kernel.org>
References: <20191210220301.13262-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miaoqing Pan <miaoqing@codeaurora.org>

[ Upstream commit 05a11003a56507023f18d3249a4d4d119c0a3e9c ]

ath10k does not provide transmit rate info per MSDU
in tx completion, mark that as -1 so mac80211
will ignore the rates. This fixes mac80211 update Mesh
link metric with invalid transmit rate info.

Tested HW: QCA9984
Tested FW: 10.4-3.9.0.2-00035

Signed-off-by: Hou Bao Hou <houbao@codeaurora.org>
Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
Signed-off-by: Miaoqing Pan <miaoqing@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath10k/txrx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/txrx.c b/drivers/net/wireless/ath/ath10k/txrx.c
index d4986f626c35c..9999c8c40269d 100644
--- a/drivers/net/wireless/ath/ath10k/txrx.c
+++ b/drivers/net/wireless/ath/ath10k/txrx.c
@@ -100,6 +100,8 @@ int ath10k_txrx_tx_unref(struct ath10k_htt *htt,
 
 	info = IEEE80211_SKB_CB(msdu);
 	memset(&info->status, 0, sizeof(info->status));
+	info->status.rates[0].idx = -1;
+
 	trace_ath10k_txrx_tx_unref(ar, tx_done->msdu_id);
 
 	if (tx_done->status == HTT_TX_COMPL_STATE_DISCARD) {
-- 
2.20.1

