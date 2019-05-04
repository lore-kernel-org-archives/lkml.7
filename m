Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C40C43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 18:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56FBC206DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 18:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+F3lZww"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbfEDSpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 14:45:16 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34442 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbfEDSpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 14:45:16 -0400
Received: by mail-pf1-f196.google.com with SMTP id b3so4583882pfd.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2019 11:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4ZV3T+sC26+wNJhp8FnOpe5j6bcSYkII4kHQNmenI7c=;
        b=U+F3lZww5+Udbo5orvUcEv9NexOUB7poM1PpojkQ0hAHDRiqMcPpQ5qBnxPn/9uyzw
         azbEU1BjDCWTLAiJgNAaPVp0CV6AIE6E+uoVyLbu/yfowKnDTyM4WvoTQFKunriFb7Kj
         mUIor1G86gDH6EPIKhnzihgID6XYcxEJIpwjldyRWCfrXfVbX28JgmQbePB+r001uPDj
         lkkUufKGjDZDXl/lo1ac9LOOzeOotAmiB8Q4CxBtJT/OWHfoh9aUkcEay11NTKy6zuk/
         uz9wLfgLpH8IxhNf4c9jsohkV4bq4ZQllsKhsHqXBrNku5YuiYw4lmXNHrOvDQuDIRdw
         kdOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4ZV3T+sC26+wNJhp8FnOpe5j6bcSYkII4kHQNmenI7c=;
        b=iqNtvKpnrWN45Za3L3tNuRcH0e3ICCYnGtpFHmZd6e/77TICHkQ45nHVr4UDOA1+8n
         0JHq0mZQNYr0bPeoVBN95RtmXrkZq21XcokA/ZIvpiebcCiKut3yymTA2rEPLZcpXDQl
         Dx3VdEPiwfp4tQGY0fhNKenUIOEQtmbgZVEPh6aAqG13986QFE2tDkqGezhH1zEwB0KQ
         p8iOzq/xrLNf6str2J9wWCN1JmYE6NA2Rd2rAJpWqz7dnGPk1dn8dbox0WV/S6Kkcsb5
         GVuMn5aVzIe1xOygyOd6w+ZLuVBOPro4+xMWU4jaMZt2zxx3kRZIHJ7FqboiyC6WY6jP
         INCw==
X-Gm-Message-State: APjAAAXJlhfI8Wp3nh6p0/hvx8pHnN9ahSCi8nbITgQLypaPCObigjyj
        yyAm09N90Ngd8h2KfvqdleE=
X-Google-Smtp-Source: APXvYqwEK5X5HW1aM5mU0RNeMXXx+2Wx360kN2MF3Chng07x/EvrPMpQUFRz6ecvPGYdI+tPWK44Tw==
X-Received: by 2002:a63:3d0b:: with SMTP id k11mr299200pga.349.1556995515534;
        Sat, 04 May 2019 11:45:15 -0700 (PDT)
Received: from localhost.localdomain ([103.87.57.241])
        by smtp.gmail.com with ESMTPSA id w189sm8072686pfw.147.2019.05.04.11.45.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 May 2019 11:45:15 -0700 (PDT)
From:   Vatsala Narang <vatsalanarang@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hadess@hadess.net, hdegoede@redhat.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, julia.lawall@lip6.fr,
        Vatsala Narang <vatsalanarang@gmail.com>
Subject: [PATCH 3/7] staging: rtl8723bs: core: Replace NULL comparisons.
Date:   Sun,  5 May 2019 00:14:50 +0530
Message-Id: <20190504184450.25686-1-vatsalanarang@gmail.com>
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
index a7c22e5e3559..32b66dce99cd 100644
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
@@ -3907,7 +3907,7 @@ void issue_action_BA(struct adapter *padapter, unsigned char *raddr, unsigned ch
 	DBG_871X("%s, category =%d, action =%d, status =%d\n", __func__, category, action, status);
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
-	if (pmgntframe == NULL)
+	if (!pmgntframe)
 		return;
 
 	/* update attribute */
@@ -5031,12 +5031,12 @@ void report_survey_event(struct adapter *padapter, union recv_frame *precv_frame
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
@@ -5084,12 +5084,12 @@ void report_surveydone_event(struct adapter *padapter)
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
@@ -5131,12 +5131,12 @@ void report_join_res(struct adapter *padapter, int res)
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
@@ -5182,12 +5182,12 @@ void report_wmm_edca_update(struct adapter *padapter)
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

