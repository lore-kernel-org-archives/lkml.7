Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A0EAC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D8372089F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561371775;
	bh=SVo2cDBHNSPxRRWoOWenBYh5CpjtewbwIcvBbQUS6gM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aF1Vz4r/ujst5GdpoqXEdZw4E5QHvSEKU1+L6dvpJceVoVivCT3i9jSWdmaQ0gBWZ
	 8c0/yYQ58MWJucnSCf0JIjS5r96drNnnJ+ICWPJo8LSPXxcSUF59KyVhp9ZLm5UFjc
	 htOrm/uVOKCUs9uBP1lbnLLupB2dOHTa+Icr5cEw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730934AbfFXKV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 06:21:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:57722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730881AbfFXKV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 06:21:56 -0400
Received: from localhost (f4.8f.5177.ip4.static.sl-reverse.com [119.81.143.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6DE121537;
        Mon, 24 Jun 2019 10:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561371715;
        bh=SVo2cDBHNSPxRRWoOWenBYh5CpjtewbwIcvBbQUS6gM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wiOa16g8+kmWiOT2jOgSiPxL/9fBkKTek91TTt0bEGOEHUYzcyiRaxCE5f/e6xUhm
         HFAWzemX2qQSbTGH4HlcNsUXnj0r/9qM1C73MbiHrJiotWbaEEda5O0PNNmWXeJak7
         GBG/Pnbk/ezZKT/IZI7ou3vaaMknZORXp9XMXepo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jouni Malinen <j@w1.fi>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 5.1 120/121] mac80211: Do not use stack memory with scatterlist for GMAC
Date:   Mon, 24 Jun 2019 17:57:32 +0800
Message-Id: <20190624092326.739934714@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190624092320.652599624@linuxfoundation.org>
References: <20190624092320.652599624@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jouni Malinen <j@w1.fi>

commit a71fd9dac23613d96ba3c05619a8ef4fd6cdf9b9 upstream.

ieee80211_aes_gmac() uses the mic argument directly in sg_set_buf() and
that does not allow use of stack memory (e.g., BUG_ON() is hit in
sg_set_buf() with CONFIG_DEBUG_SG). BIP GMAC TX side is fine for this
since it can use the skb data buffer, but the RX side was using a stack
variable for deriving the local MIC value to compare against the
received one.

Fix this by allocating heap memory for the mic buffer.

This was found with hwsim test case ap_cipher_bip_gmac_128 hitting that
BUG_ON() and kernel panic.

Cc: stable@vger.kernel.org
Signed-off-by: Jouni Malinen <j@w1.fi>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/mac80211/wpa.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/net/mac80211/wpa.c
+++ b/net/mac80211/wpa.c
@@ -1175,7 +1175,7 @@ ieee80211_crypto_aes_gmac_decrypt(struct
 	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
 	struct ieee80211_key *key = rx->key;
 	struct ieee80211_mmie_16 *mmie;
-	u8 aad[GMAC_AAD_LEN], mic[GMAC_MIC_LEN], ipn[6], nonce[GMAC_NONCE_LEN];
+	u8 aad[GMAC_AAD_LEN], *mic, ipn[6], nonce[GMAC_NONCE_LEN];
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 
 	if (!ieee80211_is_mgmt(hdr->frame_control))
@@ -1206,13 +1206,18 @@ ieee80211_crypto_aes_gmac_decrypt(struct
 		memcpy(nonce, hdr->addr2, ETH_ALEN);
 		memcpy(nonce + ETH_ALEN, ipn, 6);
 
+		mic = kmalloc(GMAC_MIC_LEN, GFP_ATOMIC);
+		if (!mic)
+			return RX_DROP_UNUSABLE;
 		if (ieee80211_aes_gmac(key->u.aes_gmac.tfm, aad, nonce,
 				       skb->data + 24, skb->len - 24,
 				       mic) < 0 ||
 		    crypto_memneq(mic, mmie->mic, sizeof(mmie->mic))) {
 			key->u.aes_gmac.icverrors++;
+			kfree(mic);
 			return RX_DROP_UNUSABLE;
 		}
+		kfree(mic);
 	}
 
 	memcpy(key->u.aes_gmac.rx_pn, ipn, 6);


