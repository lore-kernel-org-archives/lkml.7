Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 437EBC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 16:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13FA9214E0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 16:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U7/GnzSK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbfKLQ4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 11:56:30 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35416 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbfKLQ43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 11:56:29 -0500
Received: by mail-qt1-f196.google.com with SMTP id n4so15867663qte.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 08:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=er/wmmeDT/FC3WYdMLpILfV6MFzVIjn8Uisf7I5rS/4=;
        b=U7/GnzSK7a4tnxHCGdoWdfHK2Z3wQAzDYNeGO/33AvU3nvcSg30RqlkvuhDfs58kMV
         ASareLic8/lM1n6aqa03u4NIMGuH9wIlyU8m+SoiLh4MlqBclJ77M1TjMWVUyGwOLDFi
         4tlkQBBKCAJwyEGFRXVIOqjs0YKC/u9icMeC1BVNtscZPqN+rAGONDSm/4WT4YibjRL/
         qmaaTM6CqDd/RqQ8e+bQiUl+zuRc8K00AdkFTdK/21kGmloOfYrX7UVdepXxBKtS9N8A
         Bs5WY4/2FT9ktA7zj17qiTN+ttA71O1cRBJViNAM4OQzy9Ps0qI61Bt5daxulY8I/3L+
         OIDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=er/wmmeDT/FC3WYdMLpILfV6MFzVIjn8Uisf7I5rS/4=;
        b=JkKNPhBT4Aoj+FRaZQa1B96xfXU0RBpqKye8xHPeAs9tz0DnCcIup9b3XAwXAt0wyV
         SwcDs40OgQuW9JTFGy/mD1gC+w/vRL+D+32wxPPeyMNdt6SW2vdbUQVSlQiYN9tX9JeL
         kas7WK7QYd4FCzg9qsr9sRuDfzlPAxmF4pWblAqZLQN9wfmhurkNf1xMMJgwKcduIw8R
         JikqXqtsV3hQoqddwdFoUhT6ddxBIMqn7x6yLqpT1/aQ2YRE5o8WJGHbweIuxArTwo2k
         8XNrfP/mp/U+C0gLba9DzOGpaLCJJlO6WJ7vBr/KUIYvHyE6fmksGHdhrFe9Qb63y4zF
         KDtQ==
X-Gm-Message-State: APjAAAX2JHEKhqpKI22xohtNjkM7n8bzBeYBrebpud+wI9uPwpxLn3i6
        1h8t1cJvwlkJOw3IrXTR8s6bCxaLPa3h9g==
X-Google-Smtp-Source: APXvYqxWVZeWVlk1jle2WLwBw8PW1CYrr3UlN6puLkRzhtqwTnYLQSjuUVBT9em4Bs1ywUSSyGAHHg==
X-Received: by 2002:ac8:5412:: with SMTP id b18mr32561063qtq.34.1573577787752;
        Tue, 12 Nov 2019 08:56:27 -0800 (PST)
Received: from gmail.com (dynamic-186-154-98-65.dynamic.etb.net.co. [186.154.98.65])
        by smtp.gmail.com with ESMTPSA id e10sm11430326qte.51.2019.11.12.08.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 08:56:27 -0800 (PST)
Date:   Tue, 12 Nov 2019 11:56:25 -0500
From:   "Javier F. Arias" <jarias.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: [PATCH 9/9] staging: rtl8723bs: Rename variable
Message-ID: <92695d6d57a3c8acc009d33337cd0aa9cfff3a61.1573577309.git.jarias.linux@gmail.com>
Mail-Followup-To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
References: <cover.1573577309.git.jarias.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573577309.git.jarias.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch renames a variable name previously defined in uppercase.

Signed-off-by: Javier F. Arias <jarias.linux@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_xmit.c | 24 +++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
index be0d83280e1c..1f5fe218fc0e 100644
--- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
+++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
@@ -1243,7 +1243,7 @@ s32 rtw_mgmt_xmitframe_coalesce(struct adapter *padapter, _pkt *pkt, struct xmit
 	struct sta_info 	*psta = NULL;
 	struct pkt_attrib	*pattrib = &pxmitframe->attrib;
 	s32 bmcst = IS_MCAST(pattrib->ra);
-	u8 *BIP_AAD = NULL;
+	u8 *bip_aad = NULL;
 	u8 *MGMT_body = NULL;
 
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
@@ -1255,10 +1255,10 @@ s32 rtw_mgmt_xmitframe_coalesce(struct adapter *padapter, _pkt *pkt, struct xmit
 	pwlanhdr = (struct ieee80211_hdr *)pframe;
 
 	ori_len = BIP_AAD_SIZE+pattrib->pktlen;
-	tmp_buf = BIP_AAD = rtw_zmalloc(ori_len);
+	tmp_buf = bip_aad = rtw_zmalloc(ori_len);
 	subtype = GetFrameSubType(pframe); /* bit(7)~bit(2) */
 
-	if (!BIP_AAD)
+	if (!bip_aad)
 		return _FAIL;
 
 	spin_lock_bh(&padapter->security_key_mutex);
@@ -1301,17 +1301,17 @@ s32 rtw_mgmt_xmitframe_coalesce(struct adapter *padapter, _pkt *pkt, struct xmit
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
@@ -1391,12 +1391,12 @@ s32 rtw_mgmt_xmitframe_coalesce(struct adapter *padapter, _pkt *pkt, struct xmit
 
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

