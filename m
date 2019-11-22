Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FE2C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACD9C20708
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574421814;
	bh=Kahgey2BXK9558I9dynuhjHSzq1L5lj1vi1iv57xIpk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eIRYBySUbzZg21CpR/V++oDYeNy8edJgmkJWxmZBS5xJwd0DR/ay/mKA450Elt+sN
	 QSI8ay73KAHhDzvCLVe1jzF2zNq24xJb8YCJT7wssd9qs9/zTnIwXs9SSCQGh4m1yJ
	 A0/Ugw5t3JLWPxeJVzNs0SSAoIiRCaoDnFCjtsXU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729729AbfKVLXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 06:23:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:45368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728970AbfKVKlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:41:03 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A294420715;
        Fri, 22 Nov 2019 10:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574419262;
        bh=Kahgey2BXK9558I9dynuhjHSzq1L5lj1vi1iv57xIpk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O5LYI1WzFQRgqR+hXSwg/rDegpt84Dm6FBtffc8yB0dkuNtZzMvlKAfvO+UpEdRNf
         UCaDfFq2NUc5rb6bEvvLMfMnPMm8Cta0bdXXVi3IVv8uMr+0Z5hHJi38XZzbUolXyn
         Hxf61bl/7F186VU7nf5AbqG78VnDCfaCBAEN2RuU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 051/222] ath9k: add back support for using active monitor interfaces for tx99
Date:   Fri, 22 Nov 2019 11:26:31 +0100
Message-Id: <20191122100854.810911364@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100830.874290814@linuxfoundation.org>
References: <20191122100830.874290814@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Felix Fietkau <nbd@nbd.name>

[ Upstream commit 6df0580be8bc30803c4d8b2ed9c2230a2740c795 ]

Various documented examples on how to set up tx99 with ath9k rely
on setting up a regular monitor interface for setting the channel.
My previous patch "ath9k: fix tx99 with monitor mode interface" made
it possible to set it up this way again. However, it was removing support
for using an active monitor interface, which is required for controlling
the bitrate as well, since the bitrate is not passed down with a regular
monitor interface.

This patch partially reverts the previous one, but keeps support for using
a regular monitor interface to keep documented steps working in cases
where the bitrate does not matter

Fixes: d9c52fd17cb48 ("ath9k: fix tx99 with monitor mode interface")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath9k/ath9k.h |  1 +
 drivers/net/wireless/ath/ath9k/main.c  | 10 ++++++++--
 drivers/net/wireless/ath/ath9k/tx99.c  |  7 +++++++
 drivers/net/wireless/ath/ath9k/xmit.c  |  2 +-
 4 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/ath9k.h b/drivers/net/wireless/ath/ath9k/ath9k.h
index 51e878a9d5211..7bda18c61eb6e 100644
--- a/drivers/net/wireless/ath/ath9k/ath9k.h
+++ b/drivers/net/wireless/ath/ath9k/ath9k.h
@@ -1033,6 +1033,7 @@ struct ath_softc {
 
 	struct ath_spec_scan_priv spec_priv;
 
+	struct ieee80211_vif *tx99_vif;
 	struct sk_buff *tx99_skb;
 	bool tx99_state;
 	s16 tx99_power;
diff --git a/drivers/net/wireless/ath/ath9k/main.c b/drivers/net/wireless/ath/ath9k/main.c
index fbc34beee1580..f6151a00041d6 100644
--- a/drivers/net/wireless/ath/ath9k/main.c
+++ b/drivers/net/wireless/ath/ath9k/main.c
@@ -1249,8 +1249,13 @@ static int ath9k_add_interface(struct ieee80211_hw *hw,
 	struct ath_vif *avp = (void *)vif->drv_priv;
 	struct ath_node *an = &avp->mcast_node;
 
-	if (IS_ENABLED(CONFIG_ATH9K_TX99))
-		return -EOPNOTSUPP;
+	if (IS_ENABLED(CONFIG_ATH9K_TX99)) {
+		if (sc->cur_chan->nvifs >= 1) {
+			mutex_unlock(&sc->mutex);
+			return -EOPNOTSUPP;
+		}
+		sc->tx99_vif = vif;
+	}
 
 	mutex_lock(&sc->mutex);
 
@@ -1335,6 +1340,7 @@ static void ath9k_remove_interface(struct ieee80211_hw *hw,
 	ath9k_p2p_remove_vif(sc, vif);
 
 	sc->cur_chan->nvifs--;
+	sc->tx99_vif = NULL;
 	if (!ath9k_is_chanctx_enabled())
 		list_del(&avp->list);
 
diff --git a/drivers/net/wireless/ath/ath9k/tx99.c b/drivers/net/wireless/ath/ath9k/tx99.c
index 0cb5b2a873be8..096902e0fdf5c 100644
--- a/drivers/net/wireless/ath/ath9k/tx99.c
+++ b/drivers/net/wireless/ath/ath9k/tx99.c
@@ -54,6 +54,7 @@ static struct sk_buff *ath9k_build_tx99_skb(struct ath_softc *sc)
 	struct ieee80211_hdr *hdr;
 	struct ieee80211_tx_info *tx_info;
 	struct sk_buff *skb;
+	struct ath_vif *avp;
 
 	skb = alloc_skb(len, GFP_KERNEL);
 	if (!skb)
@@ -71,11 +72,17 @@ static struct sk_buff *ath9k_build_tx99_skb(struct ath_softc *sc)
 	memcpy(hdr->addr2, hw->wiphy->perm_addr, ETH_ALEN);
 	memcpy(hdr->addr3, hw->wiphy->perm_addr, ETH_ALEN);
 
+	if (sc->tx99_vif) {
+		avp = (struct ath_vif *) sc->tx99_vif->drv_priv;
+		hdr->seq_ctrl |= cpu_to_le16(avp->seq_no);
+	}
+
 	tx_info = IEEE80211_SKB_CB(skb);
 	memset(tx_info, 0, sizeof(*tx_info));
 	rate = &tx_info->control.rates[0];
 	tx_info->band = sc->cur_chan->chandef.chan->band;
 	tx_info->flags = IEEE80211_TX_CTL_NO_ACK;
+	tx_info->control.vif = sc->tx99_vif;
 	rate->count = 1;
 	if (ah->curchan && IS_CHAN_HT(ah->curchan)) {
 		rate->flags |= IEEE80211_TX_RC_MCS;
diff --git a/drivers/net/wireless/ath/ath9k/xmit.c b/drivers/net/wireless/ath/ath9k/xmit.c
index 2c35819f65426..0ef27d99bef33 100644
--- a/drivers/net/wireless/ath/ath9k/xmit.c
+++ b/drivers/net/wireless/ath/ath9k/xmit.c
@@ -2970,7 +2970,7 @@ int ath9k_tx99_send(struct ath_softc *sc, struct sk_buff *skb,
 		return -EINVAL;
 	}
 
-	ath_set_rates(NULL, NULL, bf);
+	ath_set_rates(sc->tx99_vif, NULL, bf);
 
 	ath9k_hw_set_desc_link(sc->sc_ah, bf->bf_desc, bf->bf_daddr);
 	ath9k_hw_tx99_start(sc->sc_ah, txctl->txq->axq_qnum);
-- 
2.20.1



