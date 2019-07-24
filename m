Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332FBC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3AE3218EA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563996202;
	bh=b9TOP3Xn3cc3W5pR2KgfKQ1bc00mbBY4OpSSUmZjhzo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KxkaAPAZFq5FFNU/k9MVjjpWOR4kQUbrM1PrdEi0v+rgb3pQmpuO1FtTER6+v93Qb
	 jZ2Lw3Vyn4CVj3ALEJPZDRjTyaMPWmfmDXEHfaO5ZwU3UZdVd42g+gJ9gT/Z2OHotE
	 iwyztsGolQDeXIXj0g4It2cTT7Ooxd9tx5TQVJ8U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387781AbfGXTXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:23:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:38938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387747AbfGXTXS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:23:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E994218EA;
        Wed, 24 Jul 2019 19:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563996197;
        bh=b9TOP3Xn3cc3W5pR2KgfKQ1bc00mbBY4OpSSUmZjhzo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vp8rgVT424fkQnyaFjWVOTOBaWPxTjJHcfhht3ntZ0XRlYhKYRcSWY56C4Znlkdzs
         m8BzRJe5cSvGDq3d0p3Wylb3rdhDHzydTtNDa6G/KjOi4RlbI5OpqBjf11przL6+7o
         jzKYehEa/5LvBVqE1Awn5POAlMeRUV8qF056QWGk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rakesh Pillai <pillair@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 015/413] ath10k: Fix encoding for protected management frames
Date:   Wed, 24 Jul 2019 21:15:06 +0200
Message-Id: <20190724191736.520771439@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191735.096702571@linuxfoundation.org>
References: <20190724191735.096702571@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 42f1bc43e6a97b9ddbe976eba9bd05306c990c75 ]

Currently the protected management frames are
not appended with the MIC_LEN which results in
the protected management frames being encoded
incorrectly.

Add the extra space at the end of the protected
management frames to fix this encoding error for
the protected management frames.

Tested HW: WCN3990
Tested FW: WLAN.HL.3.1-00784-QCAHLSWMTPLZ-1

Fixes: 1807da49733e ("ath10k: wmi: add management tx by reference support over wmi")
Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath10k/wmi-tlv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/wmi-tlv.c b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
index 582fb11f648a..02709fc99034 100644
--- a/drivers/net/wireless/ath/ath10k/wmi-tlv.c
+++ b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
@@ -2840,8 +2840,10 @@ ath10k_wmi_tlv_op_gen_mgmt_tx_send(struct ath10k *ar, struct sk_buff *msdu,
 	if ((ieee80211_is_action(hdr->frame_control) ||
 	     ieee80211_is_deauth(hdr->frame_control) ||
 	     ieee80211_is_disassoc(hdr->frame_control)) &&
-	     ieee80211_has_protected(hdr->frame_control))
+	     ieee80211_has_protected(hdr->frame_control)) {
+		skb_put(msdu, IEEE80211_CCMP_MIC_LEN);
 		buf_len += IEEE80211_CCMP_MIC_LEN;
+	}
 
 	buf_len = min_t(u32, buf_len, WMI_TLV_MGMT_TX_FRAME_MAX_LEN);
 	buf_len = round_up(buf_len, 4);
-- 
2.20.1



