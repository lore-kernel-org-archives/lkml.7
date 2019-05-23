Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15341C282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 02:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A97462173C
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 02:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/T2Z7QE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729794AbfEWCvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 22:51:05 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36425 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727802AbfEWCvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 22:51:05 -0400
Received: by mail-pg1-f194.google.com with SMTP id a3so2307308pgb.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 19:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=HIP1lCMDkhKcZ9WTB59tINzSGSxaLnOTeRaBLhbdjGA=;
        b=G/T2Z7QEekY80BE4VeokJq4eLWaaPLM8K8yWsqvVBXQ5rsa3M41KTrq9jPGvAAv12R
         Wi8aE1mfLtdbUOHWs6/WUtUPWNW6FBwHlykmHwFTri2Jr8yBU2tBhETQsDZffIIUUSsE
         Go6+HQ35XmWZ3uKdGR5ZIVUFBFSUZicw1NrUqzLhMQTF2WPpW4KafR06NqUsrW8t8ImZ
         nP34EU2Vey4A5p0wuSNBwEamQusJOK7MUNtZ5u2gORZvHAbLExYvTvkwFuTYC9Qvk1ty
         l58rT+77SnGpzuoJPoDNA1GyDTlNGpJqOxsdUb4otoPYwsBKCUNgVE2ypspnkjNud3xf
         rLoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=HIP1lCMDkhKcZ9WTB59tINzSGSxaLnOTeRaBLhbdjGA=;
        b=aU5dnK2QvVb/8zVwR5WU6uKfWOoaAtvhpss0l0Tu7MeyL+3k0u6nMSWcVGJ/TWYGLg
         eTwQY0nL8ZHdS888vs8QmlXKQMfqpFKvW6TFa2oXFx0CMhFxSZSNqKszRUXpK+kwX3lj
         JF1UEQGc5OH9Ham7RT2bjbs5UpeThaTYLD5yZzFrgXuRv9fYICCRuHbKV13eYekkOOdK
         ivxBhZ9qKGGtdzGh1yhimKQHnf6izceK/EmxDJPC7KYjvMzXYPdIezlixt62le98e9jC
         s7jKt3hZzPhghXnNFqYIL0MY4sDi7tIbDx0f7s3X3/XEL8zKYaSEW8exuSVBLczd3dd4
         mHCA==
X-Gm-Message-State: APjAAAW+8Z8dJQzC3yP/k1mjejaJttxTKOnwgvaBEnUKWrgLHeRoScqR
        7rOL5XaD0pAM7S0bg0FC4FM=
X-Google-Smtp-Source: APXvYqzQiAYnOOz611zIjb6ajYAA1KLL6Poy2Akm2r3k7dvv08It+rjBo2BptF0jkmIPP5lmfqmIqA==
X-Received: by 2002:aa7:81d1:: with SMTP id c17mr80847650pfn.174.1558579864655;
        Wed, 22 May 2019 19:51:04 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.73])
        by smtp.gmail.com with ESMTPSA id m2sm578457pgq.48.2019.05.22.19.51.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 19:51:04 -0700 (PDT)
Date:   Thu, 23 May 2019 08:20:59 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     reg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Hardik Singh Rathore <hardiksingh.k@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [Patch v2] staging: rtl8723bs: core: rtw_recv: fix warning
 Comparison to NULL
Message-ID: <20190523025059.GA6366@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix below warning reported by checkpatch

CHECK: Comparison to NULL could be written
"!precvpriv->pallocated_frame_buf"
CHECK: Comparison to NULL could be written "padapter"

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
-----
changes in v2:
		Corected few erorrs like (!*psta == NULL) pointed in
		review
---
 drivers/staging/rtl8723bs/core/rtw_recv.c | 48 +++++++++++++++----------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index b9f758e..b9c9bba 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -50,7 +50,7 @@ sint _rtw_init_recv_priv(struct recv_priv *precvpriv, struct adapter *padapter)
 
 	precvpriv->pallocated_frame_buf = vzalloc(NR_RECVFRAME * sizeof(union recv_frame) + RXFRAME_ALIGN_SZ);
 
-	if (precvpriv->pallocated_frame_buf == NULL) {
+	if (!precvpriv->pallocated_frame_buf) {
 		res = _FAIL;
 		goto exit;
 	}
@@ -122,7 +122,7 @@ union recv_frame *_rtw_alloc_recvframe(struct __queue *pfree_recv_queue)
 
 		list_del_init(&precvframe->u.hdr.list);
 		padapter = precvframe->u.hdr.adapter;
-		if (padapter != NULL) {
+		if (padapter) {
 			precvpriv = &padapter->recvpriv;
 			if (pfree_recv_queue == &precvpriv->free_recv_queue)
 				precvpriv->free_recvframe_cnt--;
@@ -160,7 +160,7 @@ int rtw_free_recvframe(union recv_frame *precvframe, struct __queue *pfree_recv_
 
 	list_add_tail(&(precvframe->u.hdr.list), get_list_head(pfree_recv_queue));
 
-	if (padapter != NULL) {
+	if (padapter) {
 		if (pfree_recv_queue == &precvpriv->free_recv_queue)
 				precvpriv->free_recvframe_cnt++;
 	}
@@ -183,7 +183,7 @@ sint _rtw_enqueue_recvframe(union recv_frame *precvframe, struct __queue *queue)
 
 	list_add_tail(&(precvframe->u.hdr.list), get_list_head(queue));
 
-	if (padapter != NULL)
+	if (padapter)
 		if (queue == &precvpriv->free_recv_queue)
 			precvpriv->free_recvframe_cnt++;
 
@@ -334,7 +334,7 @@ sint recvframe_chkmic(struct adapter *adapter,  union recv_frame *precvframe)
 			prxattrib->ra[0], prxattrib->ra[1], prxattrib->ra[2], prxattrib->ra[3], prxattrib->ra[4], prxattrib->ra[5]));
 
 		/* calculate mic code */
-		if (stainfo != NULL) {
+		if (stainfo) {
 			if (IS_MCAST(prxattrib->ra)) {
 				/* mickey =&psecuritypriv->dot118021XGrprxmickey.skey[0]; */
 				/* iv = precvframe->u.hdr.rx_data+prxattrib->hdrlen; */
@@ -570,7 +570,7 @@ union recv_frame *portctrl(struct adapter *adapter, union recv_frame *precv_fram
 	RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("########portctrl:adapter->securitypriv.dot11AuthAlgrthm =%d\n", adapter->securitypriv.dot11AuthAlgrthm));
 
 	if (auth_alg == 2) {
-		if ((psta != NULL) && (psta->ieee8021x_blocked)) {
+		if ((psta) && (psta->ieee8021x_blocked)) {
 			__be16 be_tmp;
 
 			/* blocked */
@@ -859,7 +859,7 @@ sint sta2sta_data_frame(
 	else
 		*psta = rtw_get_stainfo(pstapriv, sta_addr); /*  get ap_info */
 
-	if (*psta == NULL) {
+	if (!*psta) {
 		RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("can't get psta under sta2sta_data_frame ; drop pkt\n"));
 		ret = _FAIL;
 		goto exit;
@@ -942,7 +942,7 @@ sint ap2sta_data_frame(
 		else
 			*psta = rtw_get_stainfo(pstapriv, pattrib->bssid); /*  get ap_info */
 
-		if (*psta == NULL) {
+		if (!*psta) {
 			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("ap2sta: can't get psta under STATION_MODE ; drop pkt\n"));
 			#ifdef DBG_RX_DROP_FRAME
 			DBG_871X("DBG_RX_DROP_FRAME %s can't get psta under STATION_MODE ; drop pkt\n", __func__);
@@ -974,7 +974,7 @@ sint ap2sta_data_frame(
 
 
 		*psta = rtw_get_stainfo(pstapriv, pattrib->bssid); /*  get sta_info */
-		if (*psta == NULL) {
+		if (!*psta) {
 			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("can't get psta under MP_MODE ; drop pkt\n"));
 			#ifdef DBG_RX_DROP_FRAME
 			DBG_871X("DBG_RX_DROP_FRAME %s can't get psta under WIFI_MP_STATE ; drop pkt\n", __func__);
@@ -991,7 +991,7 @@ sint ap2sta_data_frame(
 	} else {
 		if (!memcmp(myhwaddr, pattrib->dst, ETH_ALEN) && (!bmcast)) {
 			*psta = rtw_get_stainfo(pstapriv, pattrib->bssid); /*  get sta_info */
-			if (*psta == NULL) {
+			if (!*psta) {
 
 				/* for AP multicast issue , modify by yiwei */
 				static unsigned long send_issue_deauth_time;
@@ -1042,7 +1042,7 @@ sint sta2ap_data_frame(
 		}
 
 		*psta = rtw_get_stainfo(pstapriv, pattrib->src);
-		if (*psta == NULL) {
+		if (!*psta) {
 			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("can't get psta under AP_MODE; drop pkt\n"));
 			DBG_871X("issue_deauth to sta =" MAC_FMT " for the reason(7)\n", MAC_ARG(pattrib->src));
 
@@ -1099,7 +1099,7 @@ sint validate_recv_ctrl_frame(struct adapter *padapter, union recv_frame *precv_
 		return _FAIL;
 
 	psta = rtw_get_stainfo(pstapriv, GetAddr2Ptr(pframe));
-	if (psta == NULL)
+	if (!psta)
 		return _FAIL;
 
 	/* for rx pkt statistics */
@@ -1226,7 +1226,7 @@ sint validate_recv_mgnt_frame(struct adapter *padapter, union recv_frame *precv_
 	RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("+validate_recv_mgnt_frame\n"));
 
 	precv_frame = recvframe_chk_defrag(padapter, precv_frame);
-	if (precv_frame == NULL) {
+	if (!precv_frame) {
 		RT_TRACE(_module_rtl871x_recv_c_, _drv_notice_, ("%s: fragment packet\n", __func__));
 		return _SUCCESS;
 	}
@@ -1274,7 +1274,7 @@ sint validate_recv_data_frame(struct adapter *adapter, union recv_frame *precv_f
 	psa = get_sa(ptr);
 	pbssid = get_hdr_bssid(ptr);
 
-	if (pbssid == NULL) {
+	if (!pbssid) {
 		#ifdef DBG_RX_DROP_FRAME
 		DBG_871X("DBG_RX_DROP_FRAME %s pbssid == NULL\n", __func__);
 		#endif
@@ -1329,7 +1329,7 @@ sint validate_recv_data_frame(struct adapter *adapter, union recv_frame *precv_f
 	}
 
 
-	if (psta == NULL) {
+	if (!psta) {
 		RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, (" after to_fr_ds_chk; psta == NULL\n"));
 		#ifdef DBG_RX_DROP_FRAME
 		DBG_871X("DBG_RX_DROP_FRAME %s psta == NULL\n", __func__);
@@ -1426,7 +1426,7 @@ static sint validate_80211w_mgmt(struct adapter *adapter, union recv_frame *prec
 			/* actual management data frame body */
 			data_len = pattrib->pkt_len - pattrib->hdrlen - pattrib->iv_len - pattrib->icv_len;
 			mgmt_DATA = rtw_zmalloc(data_len);
-			if (mgmt_DATA == NULL) {
+			if (!mgmt_DATA) {
 				DBG_871X("%s mgmt allocate fail  !!!!!!!!!\n", __func__);
 				goto validate_80211w_fail;
 			}
@@ -1811,7 +1811,7 @@ union recv_frame *recvframe_chk_defrag(struct adapter *padapter, union recv_fram
 
 	psta_addr = pfhdr->attrib.ta;
 	psta = rtw_get_stainfo(pstapriv, psta_addr);
-	if (psta == NULL) {
+	if (!psta) {
 		u8 type = GetFrameType(pfhdr->rx_data);
 		if (type != WIFI_DATA_TYPE) {
 			psta = rtw_get_bcmc_stainfo(padapter);
@@ -1827,7 +1827,7 @@ union recv_frame *recvframe_chk_defrag(struct adapter *padapter, union recv_fram
 	if (ismfrag == 1) {
 		/* 0~(n-1) fragment frame */
 		/* enqueue to defraf_g */
-		if (pdefrag_q != NULL) {
+		if (pdefrag_q) {
 			if (fragnum == 0)
 				/* the first fragment */
 				if (!list_empty(&pdefrag_q->queue))
@@ -1858,7 +1858,7 @@ union recv_frame *recvframe_chk_defrag(struct adapter *padapter, union recv_fram
 	if ((ismfrag == 0) && (fragnum != 0)) {
 		/* the last fragment frame */
 		/* enqueue the last fragment */
-		if (pdefrag_q != NULL) {
+		if (pdefrag_q) {
 			/* spin_lock(&pdefrag_q->lock); */
 			phead = get_list_head(pdefrag_q);
 			list_add_tail(&pfhdr->list, phead);
@@ -1879,7 +1879,7 @@ union recv_frame *recvframe_chk_defrag(struct adapter *padapter, union recv_fram
 	}
 
 
-	if ((prtnframe != NULL) && (prtnframe->u.hdr.attrib.privacy)) {
+	if ((prtnframe) && (prtnframe->u.hdr.attrib.privacy)) {
 		/* after defrag we must check tkip mic code */
 		if (recvframe_chkmic(padapter,  prtnframe) == _FAIL) {
 			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("recvframe_chkmic(padapter,  prtnframe) == _FAIL\n"));
@@ -1922,7 +1922,7 @@ static int amsdu_to_msdu(struct adapter *padapter, union recv_frame *prframe)
 		}
 
 		sub_pkt = rtw_os_alloc_msdu_pkt(prframe, nSubframe_Length, pdata);
-		if (sub_pkt == NULL) {
+		if (!sub_pkt) {
 			DBG_871X("%s(): allocate sub packet fail !!!\n", __func__);
 			break;
 		}
@@ -2451,7 +2451,7 @@ static int recv_func_posthandle(struct adapter *padapter, union recv_frame *prfr
 	DBG_COUNTER(padapter->rx_logs.core_rx_post);
 
 	prframe = decryptor(padapter, prframe);
-	if (prframe == NULL) {
+	if (!prframe) {
 		RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("decryptor: drop pkt\n"));
 		#ifdef DBG_RX_DROP_FRAME
 		DBG_871X("DBG_RX_DROP_FRAME %s decryptor: drop pkt\n", __func__);
@@ -2462,7 +2462,7 @@ static int recv_func_posthandle(struct adapter *padapter, union recv_frame *prfr
 	}
 
 	prframe = recvframe_chk_defrag(padapter, prframe);
-	if (prframe == NULL)	{
+	if (!prframe)	{
 		RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("recvframe_chk_defrag: drop pkt\n"));
 		#ifdef DBG_RX_DROP_FRAME
 		DBG_871X("DBG_RX_DROP_FRAME %s recvframe_chk_defrag: drop pkt\n", __func__);
@@ -2472,7 +2472,7 @@ static int recv_func_posthandle(struct adapter *padapter, union recv_frame *prfr
 	}
 
 	prframe = portctrl(padapter, prframe);
-	if (prframe == NULL) {
+	if (!prframe) {
 		RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("portctrl: drop pkt\n"));
 		#ifdef DBG_RX_DROP_FRAME
 		DBG_871X("DBG_RX_DROP_FRAME %s portctrl: drop pkt\n", __func__);
-- 
2.7.4

