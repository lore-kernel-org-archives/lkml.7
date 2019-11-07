Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95395FC6194
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 01:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AFC72166E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 01:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OwngIHzq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732875AbfKGBOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 20:14:12 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39230 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728265AbfKGBOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 20:14:11 -0500
Received: by mail-qk1-f196.google.com with SMTP id 15so531170qkh.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 17:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=7b+vCOQi/zfQ0jNU6zJ9hmuA9AtUNAb+q9YqVU3W1KU=;
        b=OwngIHzqt+hdbgagXY59BXBnmzvINDMZQ0SdjijhVZQy++DPdb8lVBHgW5CDpT65O8
         Vy5+evqDR4DM8k44XYmE05JqoRDIhBRwokhQtwpkwYzgWnDfctlOsJviXVWuenT/yULq
         0elAiyCST0b0Xsa5IqWeEYSlMSue4DuYEYO85UlL9XES3jCZw7Z/ZiF3wUqQaAbVx1gL
         ki74eyh8wclxMvh96s6zGRtLi/S/oSfe6IhhQGEPQ70Pv5lsjpMYSj8jzhKvfsJZD81f
         IgQyia3ALhwBDVDZO9XVtelKdaQU6YNHZVBswziuX7GrU811kPfCyihSiHL8yKrHs0KX
         FsxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=7b+vCOQi/zfQ0jNU6zJ9hmuA9AtUNAb+q9YqVU3W1KU=;
        b=YqibT+Xgl9KQiOchWctDnMt3v4nyfO+HFvAYB676NOToV0N+dFcZZ+WG0PRWfKHRoT
         RGEzD1dIvtEriwwNAHrW9WvE1mNkIRtF/JWZaRQ58y1cyi4MYyFcNf0WLZoKbwztLRGY
         5+27NCyKAGQ4bM+sYhkIehaJ972QJdEu2R1CH4vAPjNBUEaQpHyNdPf9s9Ln/Ie+fBp7
         EqepC6+/iOEgTRt5paLHlqil6NfHIghl9XoEzpqnej/fCeuXHVPeKFSVY39CNWsAEWhX
         Z/9VzkZMXmylgZ/I22IWrmRR3K6yJqC6nuTD3NDICnLJH1P9FWynZg+Op7gZT5RT8H4h
         WhmQ==
X-Gm-Message-State: APjAAAUcVJkA3iBb2niXP8TY4WEmtKpbwE0PCBCdtGiW/zwghJ/HDw6a
        Ah4rsXHARg24kbJyhmpPCWT17sT01wDZlA==
X-Google-Smtp-Source: APXvYqxQvjwdfi9qIwgOHzMi3Sfg2+EDvmiPd5l0s4FwGK6AS/0ay95QqfdO0NNt8iJjf5JV4X+yhw==
X-Received: by 2002:a37:4d88:: with SMTP id a130mr372831qkb.28.1573089249915;
        Wed, 06 Nov 2019 17:14:09 -0800 (PST)
Received: from gmail.com ([104.200.138.39])
        by smtp.gmail.com with ESMTPSA id u7sm264105qkm.127.2019.11.06.17.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 17:14:09 -0800 (PST)
Date:   Wed, 6 Nov 2019 20:14:05 -0500
From:   "Javier F. Arias" <jarias.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: Remove commented code
Message-ID: <9e1b282503ca14bb639e16572a445bc1f9df850f.1573089167.git.jarias.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes unnecessary commented code.

Signed-off-by: Javier F. Arias <jarias.linux@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_xmit.c | 177 +---------------------
 1 file changed, 2 insertions(+), 175 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
index ab85abecfaaa..a4eec81a2fde 100644
--- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
+++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
@@ -25,8 +25,6 @@ void _rtw_init_sta_xmit_priv(struct sta_xmit_priv *psta_xmitpriv)
 
 	spin_lock_init(&psta_xmitpriv->lock);
 
-	/* for (i = 0 ; i < MAX_NUMBLKS; i++) */
-	/* 	_init_txservq(&(psta_xmitpriv->blk_q[i])); */
 
 	_init_txservq(&psta_xmitpriv->be_q);
 	_init_txservq(&psta_xmitpriv->bk_q);
@@ -54,8 +52,6 @@ s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 
 	pxmitpriv->adapter = padapter;
 
-	/* for (i = 0 ; i < MAX_NUMBLKS; i++) */
-	/* 	_rtw_init_queue(&pxmitpriv->blk_strms[i]); */
 
 	_rtw_init_queue(&pxmitpriv->be_pending);
 	_rtw_init_queue(&pxmitpriv->bk_pending);
@@ -63,8 +59,6 @@ s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 	_rtw_init_queue(&pxmitpriv->vo_pending);
 	_rtw_init_queue(&pxmitpriv->bm_pending);
 
-	/* _rtw_init_queue(&pxmitpriv->legacy_dz_queue); */
-	/* _rtw_init_queue(&pxmitpriv->apsd_queue); */
 
 	_rtw_init_queue(&pxmitpriv->free_xmit_queue);
 
@@ -83,8 +77,6 @@ s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 		goto exit;
 	}
 	pxmitpriv->pxmit_frame_buf = (u8 *)N_BYTE_ALIGMENT((SIZE_PTR)(pxmitpriv->pallocated_frame_buf), 4);
-	/* pxmitpriv->pxmit_frame_buf = pxmitpriv->pallocated_frame_buf + 4 - */
-	/* 						((SIZE_PTR) (pxmitpriv->pallocated_frame_buf) &3); */
 
 	pxframe = (struct xmit_frame *) pxmitpriv->pxmit_frame_buf;
 
@@ -123,8 +115,6 @@ s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 	}
 
 	pxmitpriv->pxmitbuf = (u8 *)N_BYTE_ALIGMENT((SIZE_PTR)(pxmitpriv->pallocated_xmitbuf), 4);
-	/* pxmitpriv->pxmitbuf = pxmitpriv->pallocated_xmitbuf + 4 - */
-	/* 						((SIZE_PTR) (pxmitpriv->pallocated_xmitbuf) &3); */
 
 	pxmitbuf = (struct xmit_buf *)pxmitpriv->pxmitbuf;
 
@@ -489,11 +479,6 @@ static void update_attrib_phy_info(struct adapter *padapter, struct pkt_attrib *
 	else
 		pattrib->ampdu_spacing = psta->htpriv.rx_ampdu_min_spacing;
 
-	/* if (pattrib->ht_en && psta->htpriv.ampdu_enable) */
-	/*  */
-	/* 	if (psta->htpriv.agg_enable_bitmap & BIT(pattrib->priority)) */
-	/* 		pattrib->ampdu_en = true; */
-	/*  */
 
 
 	pattrib->retry_ctrl = false;
@@ -669,7 +654,6 @@ static void set_qos(struct pkt_file *ppktfile, struct pkt_attrib *pattrib)
 	/*  get UserPriority from IP hdr */
 	if (pattrib->ether_type == 0x0800) {
 		_rtw_pktfile_read(ppktfile, (u8 *)&ip_hdr, sizeof(ip_hdr));
-/* 		UserPriority = (ntohs(ip_hdr.tos) >> 5) & 0x3; */
 		UserPriority = ip_hdr.tos >> 5;
 	}
 	pattrib->priority = UserPriority;
@@ -818,7 +802,6 @@ static s32 update_attrib(struct adapter *padapter, _pkt *pkt, struct pkt_attrib
 
 	update_attrib_phy_info(padapter, pattrib, psta);
 
-	/* DBG_8192C("%s ==> mac_id(%d)\n", __func__, pattrib->mac_id); */
 
 	pattrib->psta = psta;
 	/* TODO:_unlock */
@@ -857,7 +840,6 @@ static s32 xmitframe_addmic(struct adapter *padapter, struct xmit_frame *pxmitfr
 	sint			curfragnum, length;
 	u8 *pframe, *payload, mic[8];
 	struct	mic_data		micdata;
-	/* struct	sta_info 	*stainfo; */
 	struct	pkt_attrib	 *pattrib = &pxmitframe->attrib;
 	struct	security_priv *psecuritypriv = &padapter->securitypriv;
 	struct	xmit_priv 	*pxmitpriv = &padapter->xmitpriv;
@@ -865,35 +847,11 @@ static s32 xmitframe_addmic(struct adapter *padapter, struct xmit_frame *pxmitfr
 	u8 hw_hdr_offset = 0;
 	sint bmcst = IS_MCAST(pattrib->ra);
 
-/*
-	if (pattrib->psta)
-	{
-		stainfo = pattrib->psta;
-	}
-	else
-	{
-		DBG_871X("%s, call rtw_get_stainfo()\n", __func__);
-		stainfo =rtw_get_stainfo(&padapter->stapriv ,&pattrib->ra[0]);
-	}
-
-	if (stainfo == NULL)
-	{
-		DBG_871X("%s, psta ==NUL\n", __func__);
-		return _FAIL;
-	}
-
-	if (!(stainfo->state &_FW_LINKED))
-	{
-		DBG_871X("%s, psta->state(0x%x) != _FW_LINKED\n", __func__, stainfo->state);
-		return _FAIL;
-	}
-*/
 
 	hw_hdr_offset = TXDESC_OFFSET;
 
-	if (pattrib->encrypt == _TKIP_) { /* if (psecuritypriv->dot11PrivacyAlgrthm == _TKIP_PRIVACY_) */
+	if (pattrib->encrypt == _TKIP_) {
 		/* encode mic code */
-		/* if (stainfo!= NULL) */
 		{
 			u8 null_key[16] = {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0};
 
@@ -901,16 +859,12 @@ static s32 xmitframe_addmic(struct adapter *padapter, struct xmit_frame *pxmitfr
 
 			if (bmcst) {
 				if (!memcmp(psecuritypriv->dot118021XGrptxmickey[psecuritypriv->dot118021XGrpKeyid].skey, null_key, 16)) {
-					/* DbgPrint("\nxmitframe_addmic:stainfo->dot11tkiptxmickey == 0\n"); */
-					/* msleep(10); */
 					return _FAIL;
 				}
 				/* start to calculate the mic code */
 				rtw_secmicsetkey(&micdata, psecuritypriv->dot118021XGrptxmickey[psecuritypriv->dot118021XGrpKeyid].skey);
 			} else {
 				if (!memcmp(&pattrib->dot11tkiptxmickey.skey[0], null_key, 16)) {
-					/* DbgPrint("\nxmitframe_addmic:stainfo->dot11tkiptxmickey == 0\n"); */
-					/* msleep(10); */
 					return _FAIL;
 				}
 				/* start to calculate the mic code */
@@ -932,7 +886,6 @@ static s32 xmitframe_addmic(struct adapter *padapter, struct xmit_frame *pxmitfr
 
 			}
 
-			/* if (pqospriv->qos_option == 1) */
 			if (pattrib->qos_en)
 				priority[0] = (u8)pxmitframe->attrib.priority;
 
@@ -978,9 +931,6 @@ static s32 xmitframe_addmic(struct adapter *padapter, struct xmit_frame *pxmitfr
 					*(payload+curfragnum+4), *(payload+curfragnum+5), *(payload+curfragnum+6), *(payload+curfragnum+7)));
 			}
 /*
-			else {
-				RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("xmitframe_addmic: rtw_get_stainfo == NULL!!!\n"));
-			}
 */
 	}
 	return _SUCCESS;
@@ -990,11 +940,8 @@ static s32 xmitframe_swencrypt(struct adapter *padapter, struct xmit_frame *pxmi
 {
 
 	struct	pkt_attrib	 *pattrib = &pxmitframe->attrib;
-	/* struct	security_priv *psecuritypriv =&padapter->securitypriv; */
 
-	/* if ((psecuritypriv->sw_encrypt)||(pattrib->bswenc)) */
 	if (pattrib->bswenc) {
-		/* DBG_871X("start xmitframe_swencrypt\n"); */
 		RT_TRACE(_module_rtl871x_xmit_c_, _drv_alert_, ("### xmitframe_swencrypt\n"));
 		switch (pattrib->encrypt) {
 		case _WEP40_:
@@ -1131,14 +1078,12 @@ s32 rtw_make_wlanhdr(struct adapter *padapter, u8 *hdr, struct pkt_attrib *pattr
 
 					/* check BA_starting_seqctrl */
 					if (SN_LESS(pattrib->seqnum, tx_seq)) {
-						/* DBG_871X("tx ampdu seqnum(%d) < tx_seq(%d)\n", pattrib->seqnum, tx_seq); */
 						pattrib->ampdu_en = false;/* AGG BK */
 					} else if (SN_EQUAL(pattrib->seqnum, tx_seq)) {
 						psta->BA_starting_seqctrl[pattrib->priority & 0x0f] = (tx_seq+1)&0xfff;
 
 						pattrib->ampdu_en = true;/* AGG EN */
 					} else {
-						/* DBG_871X("tx ampdu over run\n"); */
 						psta->BA_starting_seqctrl[pattrib->priority & 0x0f] = (pattrib->seqnum+1)&0xfff;
 						pattrib->ampdu_en = true;/* AGG EN */
 					}
@@ -1206,9 +1151,6 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, _pkt *pkt, struct xmit_fram
 	u8 *pframe, *mem_start;
 	u8 hw_hdr_offset;
 
-	/* struct sta_info 	*psta; */
-	/* struct sta_priv 	*pstapriv = &padapter->stapriv; */
-	/* struct mlme_priv *pmlmepriv = &padapter->mlmepriv; */
 	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
 
 	struct pkt_attrib	*pattrib = &pxmitframe->attrib;
@@ -1218,30 +1160,6 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, _pkt *pkt, struct xmit_fram
 	s32 bmcst = IS_MCAST(pattrib->ra);
 	s32 res = _SUCCESS;
 
-/*
-	if (pattrib->psta)
-	{
-		psta = pattrib->psta;
-	} else
-	{
-		DBG_871X("%s, call rtw_get_stainfo()\n", __func__);
-		psta = rtw_get_stainfo(&padapter->stapriv, pattrib->ra);
-	}
-
-	if (psta == NULL)
-  {
-
-		DBG_871X("%s, psta ==NUL\n", __func__);
-		return _FAIL;
-	}
-
-
-	if (!(psta->state &_FW_LINKED))
-	{
-		DBG_871X("%s, psta->state(0x%x) != _FW_LINKED\n", __func__, psta->state);
-		return _FAIL;
-	}
-*/
 	if (!pxmitframe->buf_addr) {
 		DBG_8192C("==> %s buf_addr == NULL\n", __func__);
 		return _FAIL;
@@ -1455,7 +1373,6 @@ s32 rtw_mgmt_xmitframe_coalesce(struct adapter *padapter, _pkt *pkt, struct xmit
 				goto xmitframe_coalesce_fail;
 			}
 
-			/* DBG_871X("%s, action frame category =%d\n", __func__, pframe[WLAN_HDR_A3_LEN]); */
 			/* according 802.11-2012 standard, these five types are not robust types */
 			if (subtype == WIFI_ACTION &&
 			(pframe[WLAN_HDR_A3_LEN] == RTW_WLAN_CATEGORY_PUBLIC ||
@@ -1750,7 +1667,6 @@ struct xmit_buf *rtw_alloc_xmitbuf(struct xmit_priv *pxmitpriv)
 	struct list_head *plist, *phead;
 	struct __queue *pfree_xmitbuf_queue = &pxmitpriv->free_xmitbuf_queue;
 
-	/* DBG_871X("+rtw_alloc_xmitbuf\n"); */
 
 	spin_lock_irqsave(&pfree_xmitbuf_queue->lock, irqL);
 
@@ -1772,7 +1688,6 @@ struct xmit_buf *rtw_alloc_xmitbuf(struct xmit_priv *pxmitpriv)
 		#ifdef DBG_XMIT_BUF
 		DBG_871X("DBG_XMIT_BUF ALLOC no =%d,  free_xmitbuf_cnt =%d\n", pxmitbuf->no, pxmitpriv->free_xmitbuf_cnt);
 		#endif
-		/* DBG_871X("alloc, free_xmitbuf_cnt =%d\n", pxmitpriv->free_xmitbuf_cnt); */
 
 		pxmitbuf->priv_data = NULL;
 
@@ -1801,7 +1716,6 @@ s32 rtw_free_xmitbuf(struct xmit_priv *pxmitpriv, struct xmit_buf *pxmitbuf)
 	_irqL irqL;
 	struct __queue *pfree_xmitbuf_queue = &pxmitpriv->free_xmitbuf_queue;
 
-	/* DBG_871X("+rtw_free_xmitbuf\n"); */
 
 	if (!pxmitbuf)
 		return _FAIL;
@@ -1823,7 +1737,6 @@ s32 rtw_free_xmitbuf(struct xmit_priv *pxmitpriv, struct xmit_buf *pxmitbuf)
 			      get_list_head(pfree_xmitbuf_queue));
 
 		pxmitpriv->free_xmitbuf_cnt++;
-		/* DBG_871X("FREE, free_xmitbuf_cnt =%d\n", pxmitpriv->free_xmitbuf_cnt); */
 		#ifdef DBG_XMIT_BUF
 		DBG_871X("DBG_XMIT_BUF FREE no =%d, free_xmitbuf_cnt =%d\n", pxmitbuf->no, pxmitpriv->free_xmitbuf_cnt);
 		#endif
@@ -1839,7 +1752,6 @@ static void rtw_init_xmitframe(struct xmit_frame *pxframe)
 		pxframe->pxmitbuf = NULL;
 
 		memset(&pxframe->attrib, 0, sizeof(struct pkt_attrib));
-		/* pxframe->attrib.psta = NULL; */
 
 		pxframe->frame_tag = DATA_FRAMETAG;
 
@@ -2034,7 +1946,6 @@ s32 rtw_xmitframe_enqueue(struct adapter *padapter, struct xmit_frame *pxmitfram
 	if (rtw_xmit_classifier(padapter, pxmitframe) == _FAIL) {
 		RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_,
 			 ("rtw_xmitframe_enqueue: drop xmit pkt for classifier fail\n"));
-/* 		pxmitframe->pkt = NULL; */
 		return _FAIL;
 	}
 
@@ -2086,7 +1997,6 @@ struct tx_servq *rtw_get_sta_pending(struct adapter *padapter, struct sta_info *
  */
 s32 rtw_xmit_classifier(struct adapter *padapter, struct xmit_frame *pxmitframe)
 {
-	/* _irqL irqL0; */
 	u8 ac_index;
 	struct sta_info *psta;
 	struct tx_servq	*ptxservq;
@@ -2096,14 +2006,6 @@ s32 rtw_xmit_classifier(struct adapter *padapter, struct xmit_frame *pxmitframe)
 
 	DBG_COUNTER(padapter->tx_logs.core_tx_enqueue_class);
 
-/*
-	if (pattrib->psta) {
-		psta = pattrib->psta;
-	} else {
-		DBG_871X("%s, call rtw_get_stainfo()\n", __func__);
-		psta = rtw_get_stainfo(pstapriv, pattrib->ra);
-	}
-*/
 
 	psta = rtw_get_stainfo(&padapter->stapriv, pattrib->ra);
 	if (pattrib->psta != psta) {
@@ -2128,21 +2030,17 @@ s32 rtw_xmit_classifier(struct adapter *padapter, struct xmit_frame *pxmitframe)
 
 	ptxservq = rtw_get_sta_pending(padapter, psta, pattrib->priority, (u8 *)(&ac_index));
 
-	/* spin_lock_irqsave(&pstapending->lock, irqL0); */
 
 	if (list_empty(&ptxservq->tx_pending)) {
 		list_add_tail(&ptxservq->tx_pending, get_list_head(phwxmits[ac_index].sta_queue));
 	}
 
-	/* spin_lock_irqsave(&ptxservq->sta_pending.lock, irqL1); */
 
 	list_add_tail(&pxmitframe->list, get_list_head(&ptxservq->sta_pending));
 	ptxservq->qcnt++;
 	phwxmits[ac_index].accnt++;
 
-	/* spin_unlock_irqrestore(&ptxservq->sta_pending.lock, irqL1); */
 
-	/* spin_unlock_irqrestore(&pstapending->lock, irqL0); */
 
 exit:
 
@@ -2166,42 +2064,24 @@ s32 rtw_alloc_hwxmits(struct adapter *padapter)
 	hwxmits = pxmitpriv->hwxmits;
 
 	if (pxmitpriv->hwxmit_entry == 5) {
-		/* pxmitpriv->bmc_txqueue.head = 0; */
-		/* hwxmits[0] .phwtxqueue = &pxmitpriv->bmc_txqueue; */
 		hwxmits[0] .sta_queue = &pxmitpriv->bm_pending;
 
-		/* pxmitpriv->vo_txqueue.head = 0; */
-		/* hwxmits[1] .phwtxqueue = &pxmitpriv->vo_txqueue; */
 		hwxmits[1] .sta_queue = &pxmitpriv->vo_pending;
 
-		/* pxmitpriv->vi_txqueue.head = 0; */
-		/* hwxmits[2] .phwtxqueue = &pxmitpriv->vi_txqueue; */
 		hwxmits[2] .sta_queue = &pxmitpriv->vi_pending;
 
-		/* pxmitpriv->bk_txqueue.head = 0; */
-		/* hwxmits[3] .phwtxqueue = &pxmitpriv->bk_txqueue; */
 		hwxmits[3] .sta_queue = &pxmitpriv->bk_pending;
 
-		/* pxmitpriv->be_txqueue.head = 0; */
-		/* hwxmits[4] .phwtxqueue = &pxmitpriv->be_txqueue; */
 		hwxmits[4] .sta_queue = &pxmitpriv->be_pending;
 
 	} else if (pxmitpriv->hwxmit_entry == 4) {
 
-		/* pxmitpriv->vo_txqueue.head = 0; */
-		/* hwxmits[0] .phwtxqueue = &pxmitpriv->vo_txqueue; */
 		hwxmits[0] .sta_queue = &pxmitpriv->vo_pending;
 
-		/* pxmitpriv->vi_txqueue.head = 0; */
-		/* hwxmits[1] .phwtxqueue = &pxmitpriv->vi_txqueue; */
 		hwxmits[1] .sta_queue = &pxmitpriv->vi_pending;
 
-		/* pxmitpriv->be_txqueue.head = 0; */
-		/* hwxmits[2] .phwtxqueue = &pxmitpriv->be_txqueue; */
 		hwxmits[2] .sta_queue = &pxmitpriv->be_pending;
 
-		/* pxmitpriv->bk_txqueue.head = 0; */
-		/* hwxmits[3] .phwtxqueue = &pxmitpriv->bk_txqueue; */
 		hwxmits[3] .sta_queue = &pxmitpriv->bk_pending;
 	} else {
 
@@ -2222,9 +2102,6 @@ void rtw_init_hwxmits(struct hw_xmit *phwxmit, sint entry)
 	sint i;
 
 	for (i = 0; i < entry; i++, phwxmit++) {
-		/* spin_lock_init(&phwxmit->xmit_lock); */
-		/* INIT_LIST_HEAD(&phwxmit->pending); */
-		/* phwxmit->txcmdcnt = 0; */
 		phwxmit->accnt = 0;
 	}
 }
@@ -2391,17 +2268,6 @@ sint xmitframe_enqueue_for_sleeping_sta(struct adapter *padapter, struct xmit_fr
 		DBG_COUNTER(padapter->tx_logs.core_tx_ap_enqueue_warn_fwstate);
 		return ret;
 	}
-/*
-	if (pattrib->psta)
-	{
-		psta = pattrib->psta;
-	}
-	else
-	{
-		DBG_871X("%s, call rtw_get_stainfo()\n", __func__);
-		psta =rtw_get_stainfo(pstapriv, pattrib->ra);
-	}
-*/
 	psta = rtw_get_stainfo(&padapter->stapriv, pattrib->ra);
 	if (pattrib->psta != psta) {
 		DBG_COUNTER(padapter->tx_logs.core_tx_ap_enqueue_warn_sta);
@@ -2423,9 +2289,7 @@ sint xmitframe_enqueue_for_sleeping_sta(struct adapter *padapter, struct xmit_fr
 
 	if (pattrib->triggered == 1) {
 		DBG_COUNTER(padapter->tx_logs.core_tx_ap_enqueue_warn_trigger);
-		/* DBG_871X("directly xmit pspoll_triggered packet\n"); */
 
-		/* pattrib->triggered = 0; */
 		if (bmcst && xmitframe_hiq_filter(pxmitframe))
 			pattrib->qsel = 0x11;/* HIQ */
 
@@ -2441,7 +2305,6 @@ sint xmitframe_enqueue_for_sleeping_sta(struct adapter *padapter, struct xmit_fr
 
 			list_del_init(&pxmitframe->list);
 
-			/* spin_lock_bh(&psta->sleep_q.lock); */
 
 			list_add_tail(&pxmitframe->list, get_list_head(&psta->sleep_q));
 
@@ -2450,10 +2313,9 @@ sint xmitframe_enqueue_for_sleeping_sta(struct adapter *padapter, struct xmit_fr
 			if (!(pstapriv->tim_bitmap & BIT(0)))
 				update_tim = true;
 
-			pstapriv->tim_bitmap |= BIT(0);/*  */
+			pstapriv->tim_bitmap |= BIT(0);
 			pstapriv->sta_dz_bitmap |= BIT(0);
 
-			/* DBG_871X("enqueue, sq_len =%d, tim =%x\n", psta->sleepq_len, pstapriv->tim_bitmap); */
 
 			if (update_tim) {
 				update_beacon(padapter, _TIM_IE_, NULL, true);
@@ -2461,7 +2323,6 @@ sint xmitframe_enqueue_for_sleeping_sta(struct adapter *padapter, struct xmit_fr
 				chk_bmc_sleepq_cmd(padapter);
 			}
 
-			/* spin_unlock_bh(&psta->sleep_q.lock); */
 
 			ret = true;
 
@@ -2484,7 +2345,6 @@ sint xmitframe_enqueue_for_sleeping_sta(struct adapter *padapter, struct xmit_fr
 		if (pstapriv->sta_dz_bitmap & BIT(psta->aid)) {
 			list_del_init(&pxmitframe->list);
 
-			/* spin_lock_bh(&psta->sleep_q.lock); */
 
 			list_add_tail(&pxmitframe->list, get_list_head(&psta->sleep_q));
 
@@ -2519,20 +2379,13 @@ sint xmitframe_enqueue_for_sleeping_sta(struct adapter *padapter, struct xmit_fr
 
 				pstapriv->tim_bitmap |= BIT(psta->aid);
 
-				/* DBG_871X("enqueue, sq_len =%d, tim =%x\n", psta->sleepq_len, pstapriv->tim_bitmap); */
 
 				if (update_tim)
-					/* DBG_871X("sleepq_len == 1, update BCNTIM\n"); */
 					/* upate BCN for TIM IE */
 					update_beacon(padapter, _TIM_IE_, NULL, true);
 			}
 
-			/* spin_unlock_bh(&psta->sleep_q.lock); */
 
-			/* if (psta->sleepq_len > (NR_XMITFRAME>>3)) */
-			/*  */
-			/* 	wakeup_sta_to_xmit(padapter, psta); */
-			/*  */
 
 			ret = true;
 
@@ -2577,7 +2430,6 @@ static void dequeue_xmitframes_to_sleeping_queue(struct adapter *padapter, struc
 			ptxservq->qcnt--;
 			phwxmits[ac_index].accnt--;
 		} else {
-			/* DBG_871X("xmitframe_enqueue_for_sleeping_sta return false\n"); */
 		}
 
 	}
@@ -2640,7 +2492,6 @@ void wakeup_sta_to_xmit(struct adapter *padapter, struct sta_info *psta)
 	psta_bmc = rtw_get_bcmc_stainfo(padapter);
 
 
-	/* spin_lock_bh(&psta->sleep_q.lock); */
 	spin_lock_bh(&pxmitpriv->lock);
 
 	xmitframe_phead = get_list_head(&psta->sleep_q);
@@ -2699,9 +2550,6 @@ void wakeup_sta_to_xmit(struct adapter *padapter, struct sta_info *psta)
 
 	if (psta->sleepq_len == 0) {
 		if (pstapriv->tim_bitmap & BIT(psta->aid)) {
-			/* DBG_871X("wakeup to xmit, qlen == 0, update_BCNTIM, tim =%x\n", pstapriv->tim_bitmap); */
-			/* upate BCN for TIM IE */
-			/* update_BCNTIM(padapter); */
 			update_mask = BIT(0);
 		}
 
@@ -2742,24 +2590,12 @@ void wakeup_sta_to_xmit(struct adapter *padapter, struct sta_info *psta)
 
 
 			pxmitframe->attrib.triggered = 1;
-/*
-			spin_unlock_bh(&psta_bmc->sleep_q.lock);
-			if (rtw_hal_xmit(padapter, pxmitframe) == true)
-			{
-				rtw_os_xmit_complete(padapter, pxmitframe);
-			}
-			spin_lock_bh(&psta_bmc->sleep_q.lock);
-
-*/
 			rtw_hal_xmitframe_enqueue(padapter, pxmitframe);
 
 		}
 
 		if (psta_bmc->sleepq_len == 0) {
 			if (pstapriv->tim_bitmap & BIT(0)) {
-				/* DBG_871X("wakeup to xmit, qlen == 0, update_BCNTIM, tim =%x\n", pstapriv->tim_bitmap); */
-				/* upate BCN for TIM IE */
-				/* update_BCNTIM(padapter); */
 				update_mask |= BIT(1);
 			}
 			pstapriv->tim_bitmap &= ~BIT(0);
@@ -2770,12 +2606,9 @@ void wakeup_sta_to_xmit(struct adapter *padapter, struct sta_info *psta)
 
 _exit:
 
-	/* spin_unlock_bh(&psta_bmc->sleep_q.lock); */
 	spin_unlock_bh(&pxmitpriv->lock);
 
 	if (update_mask)
-		/* update_BCNTIM(padapter); */
-		/* printk("%s => call update_beacon\n", __func__); */
 		update_beacon(padapter, _TIM_IE_, NULL, true);
 
 }
@@ -2789,7 +2622,6 @@ void xmit_delivery_enabled_frames(struct adapter *padapter, struct sta_info *pst
 	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
 
 
-	/* spin_lock_bh(&psta->sleep_q.lock); */
 	spin_lock_bh(&pxmitpriv->lock);
 
 	xmitframe_phead = get_list_head(&psta->sleep_q);
@@ -2842,16 +2674,11 @@ void xmit_delivery_enabled_frames(struct adapter *padapter, struct sta_info *pst
 		if ((psta->sleepq_ac_len == 0) && (!psta->has_legacy_ac) && (wmmps_ac)) {
 			pstapriv->tim_bitmap &= ~BIT(psta->aid);
 
-			/* DBG_871X("wakeup to xmit, qlen == 0, update_BCNTIM, tim =%x\n", pstapriv->tim_bitmap); */
-			/* upate BCN for TIM IE */
-			/* update_BCNTIM(padapter); */
 			update_beacon(padapter, _TIM_IE_, NULL, true);
-			/* update_mask = BIT(0); */
 		}
 
 	}
 
-	/* spin_unlock_bh(&psta->sleep_q.lock); */
 	spin_unlock_bh(&pxmitpriv->lock);
 }
 
-- 
2.20.1

