Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F6DC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 01:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AA67222D3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 01:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6f0bDO2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbfKMBiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 20:38:50 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:34671 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbfKMBiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 20:38:50 -0500
Received: by mail-yb1-f195.google.com with SMTP id k17so338411ybp.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 17:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=y+6XQ7Mp3JFH59crShuP5NbgquuJh6X+lW4US7xmPBE=;
        b=C6f0bDO2X2dhxZxx8WsvpXD/G3iG+3QnH97YSYkbt6O4c3xDWvlcBMMGeWbP5KssA7
         8glly2fOqEPUrdlwUEyGZU3PQZzJ/KwhNw0cO5pBtTwjzFb76HSuWmb4ims4hJ1EHkM7
         6XI68zOT9fmgEC8N+PdsvcKa+vZZ0VnhHPorgf9uEzBPlJHpmqryz9zHcCcyGvG/Jcy8
         q4MKVJNqmaY6+LdlEJ+clYxvkqfwJnuKHX8XBqZhalnrqxFIqZt8SegtzbMwqT4FX2hZ
         9cDoBg898T7qW3xXP50zcJZC89K2gREPF/p25A6nzrx6K8phLelEdjsY2Qq62BCAE6xU
         Y3Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y+6XQ7Mp3JFH59crShuP5NbgquuJh6X+lW4US7xmPBE=;
        b=SP+wMvBiN16sQ3rl+aSHFoskJRPHnSfCrXKZu4W/DrOs9UaTpi88IsAk5UI+Rvw3X3
         rGu70YOX0gZ+0O9ynhxG1848KHTBs2v12bxTn+ozGaXrW3ksTLz22hVuOpnHsJ06/pet
         vvz/8pXF8FSi9y/frzpJ5NYdlA49Qai16LUoXAI1lzIRPGY5xx5uOsSlvCTm5266/8i5
         dvgWwUcu40beqlU6MyN7fJuXkBK9YrBfOFW2IW/Mvu9T0Av9ZeWTC+Kqr9PWzK3u6yTu
         AQiKLDTt2cf26muR3xYv0v9N8g64ABozsX8L+piPUvA+PPwGXL0E3qKrSJsaS0HsTbR0
         it9A==
X-Gm-Message-State: APjAAAW8jp3drWjYUAKPjlBScRyc36C/bnGzTZdJ4f0JTbln/C6fCC70
        ApzpJB7uEE3XFchz5qmzYFHBZ591UOHxgA==
X-Google-Smtp-Source: APXvYqwro6YIGNYc5MaiAY8FDzWnDxZP7g64A0rm8PfYOs7Fi/pZiYGTX9rUF3MSOYyXpU0MUIpNfg==
X-Received: by 2002:a25:bbca:: with SMTP id c10mr821284ybk.308.1573609129731;
        Tue, 12 Nov 2019 17:38:49 -0800 (PST)
Received: from gmail.com ([196.247.56.44])
        by smtp.gmail.com with ESMTPSA id x78sm230535ywg.108.2019.11.12.17.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 17:38:49 -0800 (PST)
Date:   Tue, 12 Nov 2019 20:38:47 -0500
From:   "Javier F. Arias" <jarias.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] staging: rtl8723bs: Rename variable
Message-ID: <1610b265f1c6ee0148002642836283fb3757a36f.1573605920.git.jarias.linux@gmail.com>
References: <61ec6328ccb22696ccc769ce9fbbe26fd00cd04a.1573605920.git.jarias.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61ec6328ccb22696ccc769ce9fbbe26fd00cd04a.1573605920.git.jarias.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch renames a variable name previously defined in uppercase.

Signed-off-by: Javier F. Arias <jarias.linux@gmail.com>
---
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

