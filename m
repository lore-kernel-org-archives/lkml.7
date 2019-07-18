Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56490C76186
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BD072077C
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563419566;
	bh=BXusX6BeYEk8o8nqBnrWgwvg0s0UXy6gsB+OSIHmS4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o7+cOvrvSj+xgxkx9rpJi5jOYuaDvezXa1rr1IaI7Ells4TUba5+aeNR92jzCmyLM
	 Z5bowR2pvFoXCKt28/HxL2k+3ua233sOYtSbct8Hy4QOsCWG4zX2RbzbPTTnC5Igi8
	 zXV0tV8QBuc8SMuL4dqbX9958Ehrjd59/SHvRot0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390075AbfGRDMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 23:12:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:47172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391427AbfGRDMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 23:12:37 -0400
Received: from localhost (115.42.148.210.bf.2iij.net [210.148.42.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 755F92173E;
        Thu, 18 Jul 2019 03:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563419555;
        bh=BXusX6BeYEk8o8nqBnrWgwvg0s0UXy6gsB+OSIHmS4w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iwlHCwEoZHle1j9mWifg62p9UTZnuP6Yv475bL00kwWxKMC4dAWXMlQRAGtKK5TTB
         UwPqIow58qWYiGdCU8AlBpJ/K6YBLU0VoWydJ0N9llIYNu6p0+aVWXImY/m+5+BLRG
         ++iDgxHg5vyQdBxxQq2f4y5VQ/Gdp4nCM1CILK5E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, huangwen <huangwen@venustech.com.cn>,
        Takashi Iwai <tiwai@suse.de>, Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 4.9 26/54] mwifiex: Fix heap overflow in mwifiex_uap_parse_tail_ies()
Date:   Thu, 18 Jul 2019 12:01:56 +0900
Message-Id: <20190718030051.420712506@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190718030048.392549994@linuxfoundation.org>
References: <20190718030048.392549994@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

commit 69ae4f6aac1578575126319d3f55550e7e440449 upstream.

A few places in mwifiex_uap_parse_tail_ies() perform memcpy()
unconditionally, which may lead to either buffer overflow or read over
boundary.

This patch addresses the issues by checking the read size and the
destination size at each place more properly.  Along with the fixes,
the patch cleans up the code slightly by introducing a temporary
variable for the token size, and unifies the error path with the
standard goto statement.

Reported-by: huangwen <huangwen@venustech.com.cn>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/marvell/mwifiex/ie.c |   45 ++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 15 deletions(-)

--- a/drivers/net/wireless/marvell/mwifiex/ie.c
+++ b/drivers/net/wireless/marvell/mwifiex/ie.c
@@ -328,6 +328,8 @@ static int mwifiex_uap_parse_tail_ies(st
 	struct ieee80211_vendor_ie *vendorhdr;
 	u16 gen_idx = MWIFIEX_AUTO_IDX_MASK, ie_len = 0;
 	int left_len, parsed_len = 0;
+	unsigned int token_len;
+	int err = 0;
 
 	if (!info->tail || !info->tail_len)
 		return 0;
@@ -343,6 +345,12 @@ static int mwifiex_uap_parse_tail_ies(st
 	 */
 	while (left_len > sizeof(struct ieee_types_header)) {
 		hdr = (void *)(info->tail + parsed_len);
+		token_len = hdr->len + sizeof(struct ieee_types_header);
+		if (token_len > left_len) {
+			err = -EINVAL;
+			goto out;
+		}
+
 		switch (hdr->element_id) {
 		case WLAN_EID_SSID:
 		case WLAN_EID_SUPP_RATES:
@@ -356,13 +364,16 @@ static int mwifiex_uap_parse_tail_ies(st
 		case WLAN_EID_VENDOR_SPECIFIC:
 			break;
 		default:
-			memcpy(gen_ie->ie_buffer + ie_len, hdr,
-			       hdr->len + sizeof(struct ieee_types_header));
-			ie_len += hdr->len + sizeof(struct ieee_types_header);
+			if (ie_len + token_len > IEEE_MAX_IE_SIZE) {
+				err = -EINVAL;
+				goto out;
+			}
+			memcpy(gen_ie->ie_buffer + ie_len, hdr, token_len);
+			ie_len += token_len;
 			break;
 		}
-		left_len -= hdr->len + sizeof(struct ieee_types_header);
-		parsed_len += hdr->len + sizeof(struct ieee_types_header);
+		left_len -= token_len;
+		parsed_len += token_len;
 	}
 
 	/* parse only WPA vendor IE from tail, WMM IE is configured by
@@ -372,15 +383,17 @@ static int mwifiex_uap_parse_tail_ies(st
 						    WLAN_OUI_TYPE_MICROSOFT_WPA,
 						    info->tail, info->tail_len);
 	if (vendorhdr) {
-		memcpy(gen_ie->ie_buffer + ie_len, vendorhdr,
-		       vendorhdr->len + sizeof(struct ieee_types_header));
-		ie_len += vendorhdr->len + sizeof(struct ieee_types_header);
+		token_len = vendorhdr->len + sizeof(struct ieee_types_header);
+		if (ie_len + token_len > IEEE_MAX_IE_SIZE) {
+			err = -EINVAL;
+			goto out;
+		}
+		memcpy(gen_ie->ie_buffer + ie_len, vendorhdr, token_len);
+		ie_len += token_len;
 	}
 
-	if (!ie_len) {
-		kfree(gen_ie);
-		return 0;
-	}
+	if (!ie_len)
+		goto out;
 
 	gen_ie->ie_index = cpu_to_le16(gen_idx);
 	gen_ie->mgmt_subtype_mask = cpu_to_le16(MGMT_MASK_BEACON |
@@ -390,13 +403,15 @@ static int mwifiex_uap_parse_tail_ies(st
 
 	if (mwifiex_update_uap_custom_ie(priv, gen_ie, &gen_idx, NULL, NULL,
 					 NULL, NULL)) {
-		kfree(gen_ie);
-		return -1;
+		err = -EINVAL;
+		goto out;
 	}
 
 	priv->gen_idx = gen_idx;
+
+ out:
 	kfree(gen_ie);
-	return 0;
+	return err;
 }
 
 /* This function parses different IEs-head & tail IEs, beacon IEs,


