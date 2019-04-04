Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B79DC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF2F3205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554370239;
	bh=0/RRNqm7tPFECMaigc6o6BjWHq9V9ZjdVP0WmyENq4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SUa0SKndu+sZjrHv6cYyW2+TlcfkAguYb13mViiNaLjLnAkzGZ2ctIr67IWjEyHlj
	 PmAixRjnIDaEbD21cyYCqi1RHGtg9zGGXWuAaWQZ8XPRGjVy39dnamesqw/UF555f0
	 0rhL8EW81RLhuuVBmKZPXiKpzkqZ6x22dv9vyHhQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732905AbfDDJah (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:30:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:49420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732260AbfDDJKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:10:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 871DA2075E;
        Thu,  4 Apr 2019 09:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369002;
        bh=0/RRNqm7tPFECMaigc6o6BjWHq9V9ZjdVP0WmyENq4Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GCBEhdIzyTvEiD6xWHXaS0EuX7tkKzf6rtWmP8hFW4tPwXMrbXR8v5UYkMCVpIeXL
         urde07QWHIVrFzkZvldBJWI0QJ7dfInrIPg4YeJajtgho7+Pl6wY/6xSUgO3Gu+CJH
         fLMxtVid3MSpsOUSFyPm94qU1axw1Wx4e6Rbu4dY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Surabhi Vishnoi <svishnoi@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 061/246] ath10k: Fix the wrong updation of BW in tx_stats debugfs entry
Date:   Thu,  4 Apr 2019 10:46:01 +0200
Message-Id: <20190404084621.305852815@linuxfoundation.org>
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

[ Upstream commit ef9051c72ab7bc664e8047c55ac74bdb1c7fa3ee ]

Currently, the bandwidth is updated wrongly in BW table in tx_stats
debugfs per sta as there is difference in number of bandwidth type
in mac80211 and driver stats table. This leads to bandwidth getting
updated at wrong index in bandwidth table in tx_stats.

Fix this index mismatch between mac80211 and driver stats table (BW table)
by making the number of bandwidth type in driver compatible with mac80211.

Tested HW: WCN3990
Tested FW: WLAN.HL.3.1-00784-QCAHLSWMTPLZ-1

Fixes: a904417fc876 ("ath10k: add extended per sta tx statistics support")
Signed-off-by: Surabhi Vishnoi <svishnoi@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath10k/debugfs_sta.c | 7 ++++---
 drivers/net/wireless/ath/ath10k/wmi.h         | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/debugfs_sta.c b/drivers/net/wireless/ath/ath10k/debugfs_sta.c
index 4778a455d81a..068f1a7e07d3 100644
--- a/drivers/net/wireless/ath/ath10k/debugfs_sta.c
+++ b/drivers/net/wireless/ath/ath10k/debugfs_sta.c
@@ -696,11 +696,12 @@ static ssize_t ath10k_dbg_sta_dump_tx_stats(struct file *file,
 						 "  %llu ", stats->ht[j][i]);
 			len += scnprintf(buf + len, size - len, "\n");
 			len += scnprintf(buf + len, size - len,
-					" BW %s (20,40,80,160 MHz)\n", str[j]);
+					" BW %s (20,5,10,40,80,160 MHz)\n", str[j]);
 			len += scnprintf(buf + len, size - len,
-					 "  %llu %llu %llu %llu\n",
+					 "  %llu %llu %llu %llu %llu %llu\n",
 					 stats->bw[j][0], stats->bw[j][1],
-					 stats->bw[j][2], stats->bw[j][3]);
+					 stats->bw[j][2], stats->bw[j][3],
+					 stats->bw[j][4], stats->bw[j][5]);
 			len += scnprintf(buf + len, size - len,
 					 " NSS %s (1x1,2x2,3x3,4x4)\n", str[j]);
 			len += scnprintf(buf + len, size - len,
diff --git a/drivers/net/wireless/ath/ath10k/wmi.h b/drivers/net/wireless/ath/ath10k/wmi.h
index 2034ccc7cc72..1d5d0209ebeb 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.h
+++ b/drivers/net/wireless/ath/ath10k/wmi.h
@@ -5003,7 +5003,7 @@ enum wmi_rate_preamble {
 #define ATH10K_FW_SKIPPED_RATE_CTRL(flags)	(((flags) >> 6) & 0x1)
 
 #define ATH10K_VHT_MCS_NUM	10
-#define ATH10K_BW_NUM		4
+#define ATH10K_BW_NUM		6
 #define ATH10K_NSS_NUM		4
 #define ATH10K_LEGACY_NUM	12
 #define ATH10K_GI_NUM		2
-- 
2.19.1



