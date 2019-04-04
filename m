Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A507DC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71AC0205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554370194;
	bh=YZLmMM1vsCYCByao2kmZm7n2bZsIjGobZyFMdl/NU9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AaNqbHxEqY4IxLHraPpkUAijtZ0Uk1FsjnjNYCf52e1Fx1sxzBXvOTNjZ5piAbU6V
	 /mVhBknclfwkW1HiluBvifNTXt37ejdSGnLhcgDIMuNZY1NxO7cv70wEu2+sMARCGc
	 aWPiFJJyT/Zf2Ukc/jnMhEBVKLWt0otzeD83yfFw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387450AbfDDJ3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:29:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:50294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732126AbfDDJKf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:10:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E79D52054F;
        Thu,  4 Apr 2019 09:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369034;
        bh=YZLmMM1vsCYCByao2kmZm7n2bZsIjGobZyFMdl/NU9M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kuiHAIkWKoigB3hYNn2mJe1gVLyBy/KM/VDbxWfkexFMWzXwk1w6Nxftzy0TTLz1V
         nvo4nNxqqxj2XPb/RtF+PCOWD9qxTEK8buHaMfETEy5kFeKfBSVyG6qFt+ATzXe5z1
         EhpK5+2c4+azIcMacQ8mxmh6Z/Po7NY7KwqLG8y8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alagu Sankar <alagusankar@silex-india.com>,
        Wen Gong <wgong@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 073/246] ath10k: dont report unset rssi values to mac80211
Date:   Thu,  4 Apr 2019 10:46:13 +0200
Message-Id: <20190404084621.694111562@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
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

[ Upstream commit 7d444522303177f3a3c09b9abb104ddeea470a70 ]

The SDIO firmware does not provide RSSI value to the host, it's only set to
zero. In that case don't report the value to mac80211. One risk here is that
value zero might be a valid value with other firmware, currently there's no way
to detect that.

Without the fix, the rssi value indicated by iw changes between the actual
value and -95.

Tested with QCA6174 SDIO with firmware WLAN.RMH.4.4.1-00005-QCARMSWP-1.

Co-developed-by: Wen Gong <wgong@codeaurora.org>
Signed-off-by: Alagu Sankar <alagusankar@silex-india.com>
Signed-off-by: Wen Gong <wgong@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath10k/htt_rx.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/htt_rx.c b/drivers/net/wireless/ath/ath10k/htt_rx.c
index f42bac204ef8..ecf34ce7acf0 100644
--- a/drivers/net/wireless/ath/ath10k/htt_rx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_rx.c
@@ -2130,9 +2130,15 @@ static bool ath10k_htt_rx_proc_rx_ind_hl(struct ath10k_htt *htt,
 	hdr = (struct ieee80211_hdr *)skb->data;
 	rx_status = IEEE80211_SKB_RXCB(skb);
 	rx_status->chains |= BIT(0);
-	rx_status->signal = ATH10K_DEFAULT_NOISE_FLOOR +
-			    rx->ppdu.combined_rssi;
-	rx_status->flag &= ~RX_FLAG_NO_SIGNAL_VAL;
+	if (rx->ppdu.combined_rssi == 0) {
+		/* SDIO firmware does not provide signal */
+		rx_status->signal = 0;
+		rx_status->flag |= RX_FLAG_NO_SIGNAL_VAL;
+	} else {
+		rx_status->signal = ATH10K_DEFAULT_NOISE_FLOOR +
+			rx->ppdu.combined_rssi;
+		rx_status->flag &= ~RX_FLAG_NO_SIGNAL_VAL;
+	}
 
 	spin_lock_bh(&ar->data_lock);
 	ch = ar->scan_channel;
-- 
2.19.1



