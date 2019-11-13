Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2622DC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 14:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED277222C9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 14:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ElBQypso"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbfKMOyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 09:54:11 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42419 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727680AbfKMOyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 09:54:11 -0500
Received: by mail-qk1-f195.google.com with SMTP id m4so1921168qke.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 06:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DBoe09OL4Q7+mtWCD3ILbSfWzN8kQ9HR3nnRkBx9D44=;
        b=ElBQypsonHVrG2c1mTajKm9lYM0q0irKmR1aFy3QR7OPIRJhI+V5rSKJcWMvYxFars
         3KKj0Gk5+Mz0l9QvmartapeEm5BxWJA44BHewXWklqsCDWZ4bfyQeewZJuUXXANQ/7mQ
         AmEIc9jxon/p91MkL2msWciiQ+sVksWmlGLx5kqtewwqd9AtA2IbVsr3ijXJ852eCSGq
         sZp/tnsVukZrvRQFGw3gNUg5LfsiqpjxrUw7Nw2/EJoq+2Eu6NjJtKhekiD7qZlXf62v
         SolP6T44lAXwqJBRSbBbVV0hAGlZ+TEoQbbnqP9GWm7i+NJ9LnPxR/oeaahvtD2ekayn
         wexQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DBoe09OL4Q7+mtWCD3ILbSfWzN8kQ9HR3nnRkBx9D44=;
        b=eohsM//yoXKOsyCBLfggl1Jy+FjqGi6yzLDBDx8rT+NbYYFAOdE0ZnvwCPvG+BIuQF
         PviglIJqowMvG7zSlObWKbgIUJgtnJy5we/LaznXmkaV3M68crWTTqHvktFztfq2czA4
         /Yqjm9P1vRxc77ehVBDVBwAWJ3WPnNRUe2tXTiETSBCiUB73QayoFrxODar7aswDO+ju
         uZVygx6oYvlHfB51kHBROa4T2r+BR5TJ4jG1+ssb1aSaLtHNuAU4ZDdRwQ3BjyXZRnTP
         RsfZqnZkISY94zvRXEzKlRAVPb+Toq0tvY3IAlFpCI4CUkbR4t48WMe1+VHdGg1cVBhu
         H2fA==
X-Gm-Message-State: APjAAAXP0Zs0TQ0Va7kpFGMCUmVuRD22DLtHwPMgKiz8waI+TchnXGax
        Ng5GXNfRJFapo7cFZAeDgjDPaOAtXKzMHQ==
X-Google-Smtp-Source: APXvYqyMJNQ3DkOysGJk0hVwPjC2w2OLIL/9mMKoOYIqrI0YH42rET+BA/AtbQlwLHeNXvIgj4V1YA==
X-Received: by 2002:a05:620a:12c3:: with SMTP id e3mr2350924qkl.14.1573656850640;
        Wed, 13 Nov 2019 06:54:10 -0800 (PST)
Received: from gmail.com ([184.75.212.4])
        by smtp.gmail.com with ESMTPSA id 134sm606412qkn.24.2019.11.13.06.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 06:54:10 -0800 (PST)
Date:   Wed, 13 Nov 2019 09:54:08 -0500
From:   "Javier F. Arias" <jarias.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH V3 4/4] staging: rtl8723bs: Rename variable
Message-ID: <f201ce3e421420e6c7b76440f62e8bcfc449967a.1573656487.git.jarias.linux@gmail.com>
References: <1d47d745c077cc808bf0c09d2ee40e3c03d34b06.1573656487.git.jarias.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d47d745c077cc808bf0c09d2ee40e3c03d34b06.1573656487.git.jarias.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch renames a variable name previously defined in all caps.

Signed-off-by: Javier F. Arias <jarias.linux@gmail.com>
---
Changes in V3:
        - No changes.
Changes in V2:
        - No changes.

 drivers/staging/rtl8723bs/core/rtw_xmit.c | 24 +++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
index 5856c6e34922..72d3bfe1aa42 100644
--- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
+++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
@@ -1242,7 +1242,7 @@ s32 rtw_mgmt_xmitframe_coalesce(struct adapter *padapter, _pkt *pkt, struct xmit
 	struct sta_info 	*psta = NULL;
 	struct pkt_attrib	*pattrib = &pxmitframe->attrib;
 	s32 bmcst = IS_MCAST(pattrib->ra);
-	u8 *BIP_AAD = NULL;
+	u8 *bip_aad = NULL;
 	u8 *MGMT_body = NULL;
 
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
@@ -1254,10 +1254,10 @@ s32 rtw_mgmt_xmitframe_coalesce(struct adapter *padapter, _pkt *pkt, struct xmit
 	pwlanhdr = (struct ieee80211_hdr *)pframe;
 
 	ori_len = BIP_AAD_SIZE+pattrib->pktlen;
-	tmp_buf = BIP_AAD = rtw_zmalloc(ori_len);
+	tmp_buf = bip_aad = rtw_zmalloc(ori_len);
 	subtype = GetFrameSubType(pframe); /* bit(7)~bit(2) */
 
-	if (!BIP_AAD)
+	if (!bip_aad)
 		return _FAIL;
 
 	spin_lock_bh(&padapter->security_key_mutex);
@@ -1300,17 +1300,17 @@ s32 rtw_mgmt_xmitframe_coalesce(struct adapter *padapter, _pkt *pkt, struct xmit
 		frame_body_len = pattrib->pktlen - sizeof(struct ieee80211_hdr_3addr);
 
 		/* conscruct AAD, copy frame control field */
-		memcpy(BIP_AAD, &pwlanhdr->frame_control, 2);
-		ClearRetry(BIP_AAD);
-		ClearPwrMgt(BIP_AAD);
-		ClearMData(BIP_AAD);
+		memcpy(bip_aad, &pwlanhdr->frame_control, 2);
+		ClearRetry(bip_aad);
+		ClearPwrMgt(bip_aad);
+		ClearMData(bip_aad);
 		/* conscruct AAD, copy address 1 to address 3 */
-		memcpy(BIP_AAD+2, pwlanhdr->addr1, 18);
+		memcpy(bip_aad+2, pwlanhdr->addr1, 18);
 		/* copy management fram body */
-		memcpy(BIP_AAD+BIP_AAD_SIZE, MGMT_body, frame_body_len);
+		memcpy(bip_aad+BIP_AAD_SIZE, MGMT_body, frame_body_len);
 		/* calculate mic */
 		if (omac1_aes_128(padapter->securitypriv.dot11wBIPKey[padapter->securitypriv.dot11wBIPKeyid].skey
-			, BIP_AAD, BIP_AAD_SIZE+frame_body_len, mic))
+			, bip_aad, BIP_AAD_SIZE+frame_body_len, mic))
 			goto xmitframe_coalesce_fail;
 
 		/* copy right BIP mic value, total is 128bits, we use the 0~63 bits */
@@ -1390,12 +1390,12 @@ s32 rtw_mgmt_xmitframe_coalesce(struct adapter *padapter, _pkt *pkt, struct xmit
 
 xmitframe_coalesce_success:
 	spin_unlock_bh(&padapter->security_key_mutex);
-	kfree(BIP_AAD);
+	kfree(bip_aad);
 	return _SUCCESS;
 
 xmitframe_coalesce_fail:
 	spin_unlock_bh(&padapter->security_key_mutex);
-	kfree(BIP_AAD);
+	kfree(bip_aad);
 	return _FAIL;
 }
 
-- 
2.20.1

