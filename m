Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 193F8CA9EB9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 12:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D666520863
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 12:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mefPGp8z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfJZMME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 08:12:04 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54916 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbfJZML7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 08:11:59 -0400
Received: by mail-wm1-f68.google.com with SMTP id g7so4837781wmk.4
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2019 05:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NbVw9OZf55Mog4i/sEkAhwwn11xFr8zvKreYfJn7iLs=;
        b=mefPGp8zoB4sngplTq72i2EyVeL3DuklHM38e/Gi/ILN/GE4zliseR0FQmxSwEAclg
         xl68zhkGpfRrgYApPYFOX87LLWcPEpluAoTy1FpfI+5giIXcGLmazFqwXGa1HuUG145B
         P4wMWoE4O3Rn1R+w539NPThKr9OpPuTGGhiw/Q82iAtgLhpwdG9uwomYhTno6gIDmWNm
         awV8QzbheoPCvCQAPot+MOwWKtApQovy6RbgpPUocfimlomnl9gi6n1xMI+wk482ECjC
         HtJzoTvtEwLZWkmim478iXTu55u91tNjhjApbTYkO+QDj945TPJBxk9J6/DKnzZ6dMVP
         UqcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NbVw9OZf55Mog4i/sEkAhwwn11xFr8zvKreYfJn7iLs=;
        b=QwQRTEC4DRvyFvZwubD238caO5+3P1MDyTEnCKO/ktPzPVirdOoVNbakNMk3Qxl0kF
         m9wR/xDb0tuxTfsuRsIZbk8asbf8eMgDcmuelb1mIgrk7loSMk5AR/7s2po48yLc09Pk
         poIQSXJGuAG/IBtFNqcgzQ/g/qMYaSlvV1yBnIiTdNByX27wpfPvIFldy9YSwKB659NH
         /MZ/VSpSwuM9dXqfjA8+6fBEiJsmU5owNF1Qdilop3EW1GFoLpHZzPCHPrFhaCoJfBYh
         wpjuc7UWyqDhgDyuX+D4Qj6syjLimQPdwWABaFJp6T+av+5L/tweGrPIKWbsA/VrlENS
         h2fg==
X-Gm-Message-State: APjAAAX2po81S7s65FPNaX62JPdf6R972BgrZIM36hhD1SbfLJb4yoQn
        nRFJIOM8OUmQEYpTY58GWjs=
X-Google-Smtp-Source: APXvYqwl5eWg+VITDyN2ZJlOeMGJRckdHk7Bpa7YTjumiFu79UNA7QXRDnZdCHTT5OiXG4jd7Son7g==
X-Received: by 2002:a1c:a551:: with SMTP id o78mr7224184wme.4.1572091917410;
        Sat, 26 Oct 2019 05:11:57 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96bf:e0ab:2b68:5d76:a12a:e6ba])
        by smtp.gmail.com with ESMTPSA id v8sm5789906wra.79.2019.10.26.05.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2019 05:11:56 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 7/7] staging: rtl8188eu: reduce indentation level in rtw_alloc_stainfo
Date:   Sat, 26 Oct 2019 14:11:35 +0200
Message-Id: <20191026121135.181897-7-straube.linux@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191026121135.181897-1-straube.linux@gmail.com>
References: <20191026121135.181897-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove else-arm from if-else statement. Move the else code out of the
if-else and skip it by adding goto exit to the if block. The exit label
was directly after the else-arm, so there is no change in behaviour.
Reduces indentation level and clears a line over 80 characters
checkpatch warning.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_sta_mgt.c | 101 ++++++++++---------
 1 file changed, 51 insertions(+), 50 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c b/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c
index 43925b1f43ef..776931b8bf72 100644
--- a/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c
+++ b/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c
@@ -181,70 +181,71 @@ struct sta_info *rtw_alloc_stainfo(struct sta_priv *pstapriv, u8 *hwaddr)
 					struct sta_info, list);
 	if (!psta) {
 		spin_unlock_bh(&pfree_sta_queue->lock);
-	} else {
-		list_del_init(&psta->list);
-		spin_unlock_bh(&pfree_sta_queue->lock);
-		_rtw_init_stainfo(psta);
-		memcpy(psta->hwaddr, hwaddr, ETH_ALEN);
-		index = wifi_mac_hash(hwaddr);
-		RT_TRACE(_module_rtl871x_sta_mgt_c_, _drv_info_,
-			 ("%s: index=%x", __func__, index));
-		if (index >= NUM_STA) {
-			RT_TRACE(_module_rtl871x_sta_mgt_c_, _drv_err_,
-				 ("ERROR => %s: index >= NUM_STA", __func__));
-			psta = NULL;
-			goto exit;
-		}
-		phash_list = &pstapriv->sta_hash[index];
-
-		spin_lock_bh(&pstapriv->sta_hash_lock);
-		list_add_tail(&psta->hash_list, phash_list);
-		pstapriv->asoc_sta_count++;
-		spin_unlock_bh(&pstapriv->sta_hash_lock);
+		goto exit;
+	}
 
-		/* Commented by Albert 2009/08/13
-		 * For the SMC router, the sequence number of first packet of
-		 * WPS handshake will be 0. In this case, this packet will be
-		 * dropped by recv_decache function if we use the 0x00 as the
-		 * default value for tid_rxseq variable. So, we initialize the
-		 * tid_rxseq variable as the 0xffff.
-		 */
+	list_del_init(&psta->list);
+	spin_unlock_bh(&pfree_sta_queue->lock);
+	_rtw_init_stainfo(psta);
+	memcpy(psta->hwaddr, hwaddr, ETH_ALEN);
+	index = wifi_mac_hash(hwaddr);
+	RT_TRACE(_module_rtl871x_sta_mgt_c_, _drv_info_,
+		 ("%s: index=%x", __func__, index));
+	if (index >= NUM_STA) {
+		RT_TRACE(_module_rtl871x_sta_mgt_c_, _drv_err_,
+			 ("ERROR => %s: index >= NUM_STA", __func__));
+		psta = NULL;
+		goto exit;
+	}
+	phash_list = &pstapriv->sta_hash[index];
 
-		for (i = 0; i < 16; i++)
-			memcpy(&psta->sta_recvpriv.rxcache.tid_rxseq[i],
-			       &wRxSeqInitialValue, 2);
+	spin_lock_bh(&pstapriv->sta_hash_lock);
+	list_add_tail(&psta->hash_list, phash_list);
+	pstapriv->asoc_sta_count++;
+	spin_unlock_bh(&pstapriv->sta_hash_lock);
 
-		RT_TRACE(_module_rtl871x_sta_mgt_c_, _drv_info_,
-			 ("alloc number_%d stainfo  with hwaddr = %pM\n",
-			 pstapriv->asoc_sta_count, hwaddr));
+	/* Commented by Albert 2009/08/13
+	 * For the SMC router, the sequence number of first packet of
+	 * WPS handshake will be 0. In this case, this packet will be
+	 * dropped by recv_decache function if we use the 0x00 as the
+	 * default value for tid_rxseq variable. So, we initialize the
+	 * tid_rxseq variable as the 0xffff.
+	 */
 
-		init_addba_retry_timer(pstapriv->padapter, psta);
+	for (i = 0; i < 16; i++)
+		memcpy(&psta->sta_recvpriv.rxcache.tid_rxseq[i],
+		       &wRxSeqInitialValue, 2);
 
-		/* for A-MPDU Rx reordering buffer control */
-		for (i = 0; i < 16; i++) {
-			preorder_ctrl = &psta->recvreorder_ctrl[i];
+	RT_TRACE(_module_rtl871x_sta_mgt_c_, _drv_info_,
+		 ("alloc number_%d stainfo  with hwaddr = %pM\n",
+		  pstapriv->asoc_sta_count, hwaddr));
 
-			preorder_ctrl->padapter = pstapriv->padapter;
+	init_addba_retry_timer(pstapriv->padapter, psta);
 
-			preorder_ctrl->enable = false;
+	/* for A-MPDU Rx reordering buffer control */
+	for (i = 0; i < 16; i++) {
+		preorder_ctrl = &psta->recvreorder_ctrl[i];
 
-			preorder_ctrl->indicate_seq = 0xffff;
-			preorder_ctrl->wend_b = 0xffff;
-			preorder_ctrl->wsize_b = 64;/* 64; */
+		preorder_ctrl->padapter = pstapriv->padapter;
 
-			_rtw_init_queue(&preorder_ctrl->pending_recvframe_queue);
+		preorder_ctrl->enable = false;
 
-			rtw_init_recv_timer(preorder_ctrl);
-		}
+		preorder_ctrl->indicate_seq = 0xffff;
+		preorder_ctrl->wend_b = 0xffff;
+		preorder_ctrl->wsize_b = 64;/* 64; */
 
-		/* init for DM */
-		psta->rssi_stat.UndecoratedSmoothedPWDB = -1;
-		psta->rssi_stat.UndecoratedSmoothedCCK = -1;
+		_rtw_init_queue(&preorder_ctrl->pending_recvframe_queue);
 
-		/* init for the sequence number of received management frame */
-		psta->RxMgmtFrameSeqNum = 0xffff;
+		rtw_init_recv_timer(preorder_ctrl);
 	}
 
+	/* init for DM */
+	psta->rssi_stat.UndecoratedSmoothedPWDB = -1;
+	psta->rssi_stat.UndecoratedSmoothedCCK = -1;
+
+	/* init for the sequence number of received management frame */
+	psta->RxMgmtFrameSeqNum = 0xffff;
+
 exit:
 	return psta;
 }
-- 
2.23.0

