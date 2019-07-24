Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D753BC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A948B20665
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563997936;
	bh=6+Wdk9P84D5keGPfCrFXElQqbeYWyusl5dcj9PAplls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=N3gTK3oFiJP3EFdZGW3cpJr/XQQUrubShcwbMTyN1ioXtsoe6Jclb5TLmOWCK1x/v
	 8/8hTtFEKmeAoVUxY+xAuFS7Yu4RMlrMr+ztXw4oUQ0quqynYUFCDLGmjU2Rjk92RV
	 ZjfnDSbCjE1rK76ctEkAVKAIvFGUfB40j/67g/Ao=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404113AbfGXTwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:52:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:33810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404095AbfGXTwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:52:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55A5A205C9;
        Wed, 24 Jul 2019 19:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563997930;
        bh=6+Wdk9P84D5keGPfCrFXElQqbeYWyusl5dcj9PAplls=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WdlDNtydXlYNOIpE0mpM6LrOddEm+qpwJ35keLkErL2HR8XPgRstJq6vnOl4OqVKL
         WTXLSiTuUHBCEZBKbLtRPrLCIONE2eU6Jg0a7pW6DIt38CQRagI4L9mVwlstUqBWDu
         87K2dun5JtDp9tZlkjc1QVEJg04+381pLaenE7Hg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zefir Kurtisi <zefir.kurtisi@neratec.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 165/371] ath9k: correctly handle short radar pulses
Date:   Wed, 24 Jul 2019 21:18:37 +0200
Message-Id: <20190724191737.611582326@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191724.382593077@linuxfoundation.org>
References: <20190724191724.382593077@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit df5c4150501ee7e86383be88f6490d970adcf157 ]

In commit 3c0efb745a17 ("ath9k: discard undersized packets")
the lower bound of RX packets was set to 10 (min ACK size) to
filter those that would otherwise be treated as invalid at
mac80211.

Alas, short radar pulses are reported as PHY_ERROR frames
with length set to 3. Therefore their detection stopped
working after that commit.

NOTE: ath9k drivers built thereafter will not pass DFS
certification.

This extends the criteria for short packets to explicitly
handle PHY_ERROR frames.

Fixes: 3c0efb745a17 ("ath9k: discard undersized packets")
Signed-off-by: Zefir Kurtisi <zefir.kurtisi@neratec.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath9k/recv.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath9k/recv.c b/drivers/net/wireless/ath/ath9k/recv.c
index 4e97f7f3b2a3..06e660858766 100644
--- a/drivers/net/wireless/ath/ath9k/recv.c
+++ b/drivers/net/wireless/ath/ath9k/recv.c
@@ -815,6 +815,7 @@ static int ath9k_rx_skb_preprocess(struct ath_softc *sc,
 	struct ath_common *common = ath9k_hw_common(ah);
 	struct ieee80211_hdr *hdr;
 	bool discard_current = sc->rx.discard_next;
+	bool is_phyerr;
 
 	/*
 	 * Discard corrupt descriptors which are marked in
@@ -827,8 +828,11 @@ static int ath9k_rx_skb_preprocess(struct ath_softc *sc,
 
 	/*
 	 * Discard zero-length packets and packets smaller than an ACK
+	 * which are not PHY_ERROR (short radar pulses have a length of 3)
 	 */
-	if (rx_stats->rs_datalen < 10) {
+	is_phyerr = rx_stats->rs_status & ATH9K_RXERR_PHY;
+	if (!rx_stats->rs_datalen ||
+	    (rx_stats->rs_datalen < 10 && !is_phyerr)) {
 		RX_STAT_INC(sc, rx_len_err);
 		goto corrupt;
 	}
-- 
2.20.1



