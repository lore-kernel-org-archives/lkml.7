Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD25C004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 13:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECA1620C01
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 13:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGYQSg1n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbfEENUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 09:20:34 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43395 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727840AbfEENUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 09:20:31 -0400
Received: by mail-pg1-f194.google.com with SMTP id t22so5074963pgi.10
        for <linux-kernel@vger.kernel.org>; Sun, 05 May 2019 06:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2Doo+lglnNPg0EyRNMNjdEFntKFoZq9VqOdtgBEWIpY=;
        b=GGYQSg1n0GjOtWcjQQp2/X4i9CJpyrTM5+MEWZNJifHlRXiroZXNi6IGeX9qdC319L
         jeL5fA/gUTrPEo15bv+yXPpunrIZdrok7nGaxYByeGH8nW/tyC9daEkn69uNCroGn5vF
         cfZ19/CCB4fnkw03uOBt+ZgH2+BJ54twu6HQbGbfLK99a52ernaLIwKQvVgsUglLME17
         tShiHapzofNbbJAwnH3XnTCY3/Hkvpg8KVcQ2w0d0Abpwn9HWnY5ikjHX0qbKC6dij5E
         NkttvuCI/SZcR7xxy6x21qzXxtjntqoh84QG4AnePMy3VSD3KvETT5evCxWb5k/bnzzC
         mAGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2Doo+lglnNPg0EyRNMNjdEFntKFoZq9VqOdtgBEWIpY=;
        b=WsgoAHrimpYmKi0QCwcQoQV/XViQBRgsJVrPcntpEsRNvmDVI4KCLQJEiXiNeMmvrw
         Ycyk8qGaR5U+nTWRZDywgxcW3WEuXS1pBDbtf3rHWL5nB1LxAGN1HGAl74WNLuEyhlqH
         E56/yoGvcQQS/77DCYzQuzGRa2SykMtamZlXmnw6Gd1glQO2kiddLfdNCcufLE8/bnDT
         bkinGy9LBceiA35MXziqRfnny00/FXDLAqwpgc71mFozzdWVN2jrz7buNnzQJpuMHEMI
         G/uzhnc9qEKp7xicb9KU9VptIBOt0mwrqoRI9vcjMoGFaUsTTKfXliR6um7UVdzQhV4y
         fSOg==
X-Gm-Message-State: APjAAAV+Tfjbw8TkgkkA+S+NRfQ2sGBWG3AuJ48IY1MKfA0ABthzOkSX
        wwFXq96xxqMKMOFPO+MMG90=
X-Google-Smtp-Source: APXvYqyR1sx82moMHP0c+jfWLdDOoW6kqZIvx88jMKpJFY1EsoOsNvHG2dQu8WM75zKd7qs/b5NkdA==
X-Received: by 2002:a63:4c26:: with SMTP id z38mr25331775pga.425.1557062430850;
        Sun, 05 May 2019 06:20:30 -0700 (PDT)
Received: from localhost.localdomain ([103.87.56.229])
        by smtp.gmail.com with ESMTPSA id y14sm9493801pga.54.2019.05.05.06.20.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 May 2019 06:20:30 -0700 (PDT)
From:   Vatsala Narang <vatsalanarang@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hadess@hadess.net, hdegoede@redhat.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, julia.lawall@lip6.fr,
        Vatsala Narang <vatsalanarang@gmail.com>
Subject: [PATCH v2 2/6] staging: rtl8723bs: core: Replace NULL comparisons.
Date:   Sun,  5 May 2019 18:50:13 +0530
Message-Id: <20190505132013.4289-1-vatsalanarang@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace NULL comparisons in the file to get rid of checkpatch warning.

Signed-off-by: Vatsala Narang <vatsalanarang@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 32 +++++++++----------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 00d84d34da97..ac70bbaae722 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -381,7 +381,7 @@ static void init_channel_list(struct adapter *padapter, RT_CHANNEL_INFO *channel
 				((BW40MINUS == o->bw) || (BW40PLUS == o->bw)))
 				continue;
 
-			if (reg == NULL) {
+			if (!reg) {
 				reg = &channel_list->reg_class[cla];
 				cla++;
 				reg->reg_class = o->op_class;
@@ -659,7 +659,7 @@ unsigned int OnProbeReq(struct adapter *padapter, union recv_frame *precv_frame)
 			/*  allocate a new one */
 			DBG_871X("going to alloc stainfo for rc ="MAC_FMT"\n",  MAC_ARG(get_sa(pframe)));
 			psta = rtw_alloc_stainfo(pstapriv, get_sa(pframe));
-			if (psta == NULL) {
+			if (!psta) {
 				/* TODO: */
 				DBG_871X(" Exceed the upper limit of supported clients...\n");
 				return _SUCCESS;
@@ -1217,7 +1217,7 @@ unsigned int OnAssocReq(struct adapter *padapter, union recv_frame *precv_frame)
 	}
 
 	pstat = rtw_get_stainfo(pstapriv, GetAddr2Ptr(pframe));
-	if (pstat == NULL) {
+	if (!pstat) {
 		status = _RSON_CLS2_;
 		goto asoc_class2_error;
 	}
@@ -1377,7 +1377,7 @@ unsigned int OnAssocReq(struct adapter *padapter, union recv_frame *precv_frame)
 		goto OnAssocReqFail;
 
 	pstat->flags &= ~(WLAN_STA_WPS | WLAN_STA_MAYBE_WPS);
-	if (wpa_ie == NULL) {
+	if (!wpa_ie) {
 		if (elems.wps_ie) {
 			DBG_871X("STA included WPS IE in "
 				   "(Re)Association Request - assume WPS is "
@@ -1943,7 +1943,7 @@ unsigned int OnAction_back(struct adapter *padapter, union recv_frame *precv_fra
 	addr = GetAddr2Ptr(pframe);
 	psta = rtw_get_stainfo(pstapriv, addr);
 
-	if (psta == NULL)
+	if (!psta)
 		return _SUCCESS;
 
 	frame_body = (unsigned char *)(pframe + sizeof(struct ieee80211_hdr_3addr));
@@ -2462,7 +2462,7 @@ void issue_beacon(struct adapter *padapter, int timeout_ms)
 	/* DBG_871X("%s\n", __func__); */
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
-	if (pmgntframe == NULL) {
+	if (!pmgntframe) {
 		DBG_871X("%s, alloc mgnt frame fail\n", __func__);
 		return;
 	}
@@ -2843,7 +2843,7 @@ static int _issue_probereq(struct adapter *padapter,
 	RT_TRACE(_module_rtl871x_mlme_c_, _drv_notice_, ("+issue_probereq\n"));
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
-	if (pmgntframe == NULL)
+	if (!pmgntframe)
 		goto exit;
 
 	/* update attribute */
@@ -3909,7 +3909,7 @@ void issue_action_BA(struct adapter *padapter, unsigned char *raddr, unsigned ch
 	DBG_871X("%s, category =%d, action =%d, status =%d\n", __func__, category, action, status);
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
-	if (pmgntframe == NULL)
+	if (!pmgntframe)
 		return;
 
 	/* update attribute */
@@ -5033,12 +5033,12 @@ void report_survey_event(struct adapter *padapter, union recv_frame *precv_frame
 	pcmdpriv = &padapter->cmdpriv;
 
 	pcmd_obj = rtw_zmalloc(sizeof(struct cmd_obj));
-	if (pcmd_obj == NULL)
+	if (!pcmd_obj)
 		return;
 
 	cmdsz = (sizeof(struct survey_event) + sizeof(struct C2HEvent_Header));
 	pevtcmd = rtw_zmalloc(cmdsz);
-	if (pevtcmd == NULL) {
+	if (!pevtcmd) {
 		kfree(pcmd_obj);
 		return;
 	}
@@ -5086,12 +5086,12 @@ void report_surveydone_event(struct adapter *padapter)
 	struct cmd_priv *pcmdpriv = &padapter->cmdpriv;
 
 	pcmd_obj = rtw_zmalloc(sizeof(struct cmd_obj));
-	if (pcmd_obj == NULL)
+	if (!pcmd_obj)
 		return;
 
 	cmdsz = (sizeof(struct surveydone_event) + sizeof(struct C2HEvent_Header));
 	pevtcmd = rtw_zmalloc(cmdsz);
-	if (pevtcmd == NULL) {
+	if (!pevtcmd) {
 		kfree(pcmd_obj);
 		return;
 	}
@@ -5133,12 +5133,12 @@ void report_join_res(struct adapter *padapter, int res)
 	struct cmd_priv *pcmdpriv = &padapter->cmdpriv;
 
 	pcmd_obj = rtw_zmalloc(sizeof(struct cmd_obj));
-	if (pcmd_obj == NULL)
+	if (!pcmd_obj)
 		return;
 
 	cmdsz = (sizeof(struct joinbss_event) + sizeof(struct C2HEvent_Header));
 	pevtcmd = rtw_zmalloc(cmdsz);
-	if (pevtcmd == NULL) {
+	if (!pevtcmd) {
 		kfree(pcmd_obj);
 		return;
 	}
@@ -5184,12 +5184,12 @@ void report_wmm_edca_update(struct adapter *padapter)
 	struct cmd_priv *pcmdpriv = &padapter->cmdpriv;
 
 	pcmd_obj = rtw_zmalloc(sizeof(struct cmd_obj));
-	if (pcmd_obj == NULL)
+	if (!pcmd_obj)
 		return;
 
 	cmdsz = (sizeof(struct wmm_event) + sizeof(struct C2HEvent_Header));
 	pevtcmd = rtw_zmalloc(cmdsz);
-	if (pevtcmd == NULL) {
+	if (!pevtcmd) {
 		kfree(pcmd_obj);
 		return;
 	}
-- 
2.17.1

