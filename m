Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46882C43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 18:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17AA8206DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 18:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TL7CjCO/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbfEDSoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 14:44:24 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40159 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbfEDSoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 14:44:24 -0400
Received: by mail-pg1-f193.google.com with SMTP id d31so4355815pgl.7
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2019 11:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=iZgd18AmQtLNRzwkoX+rPoe+HzMyoRmLac3vzm0iiVE=;
        b=TL7CjCO/wA82EXgK8lUJr8DDKvfi+e9E78NJEwMkyADQG/aQxrnpCQWTc7RrcePeAi
         UR9elt3dtRKzou3vGur6M1PyyharAJ86dmr7qZahhKSqBmMn3Ni3XwfADLcHPtvYGoMV
         5nxm82AU4VvMfqEFWDdzmhBb+ZAewhqwZ6Kc3cA2h4f3TUl0U9FDjs4Varjr41zzaozn
         AHsRh6zxrWhEKWHKRcynIXA2vQcmuuTyZS4GhhwIYyDllsdGDuhGrpo/0J9OyFFrf6M9
         TItX1r0ohDSOz0dYY/EtTXvQ4aAbMCuCVY7sfYJkVtIOPMun5BiGx67M3HfjuaK7x48D
         xFPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iZgd18AmQtLNRzwkoX+rPoe+HzMyoRmLac3vzm0iiVE=;
        b=RJXycVaS8AwafxpsDNHZ++/uaf0WV9c9eNXPeDjW0K7/QN4gX80AQZc3XvD52pSizy
         OwPsH8txxADD83EtbTTaRSnKWxCpDjoDeCzhs5K+W5jjtSKTjH947q9cEH2maH+aUN4V
         ZJHYO0Y2LzB0o/aRTEDE1EL+FbQsRvscQsZImCcj7C1HwyFEGDHsS7uF9EENSVLsKZgg
         3FQZHc+6oufPG9Fw57g6u7M5cgKxHIsAz9c0DYj2kWppvPpXO5WB+nZMOg96DQnDxbT5
         clS8LlJNrTB1Jv0UhBkvmCFsvV8epZTKRR909mbS8o7pALHd3PwQ0ZdRrexJwlkXrvgi
         iLiA==
X-Gm-Message-State: APjAAAUltHNT3dCQWlojMxJMTJdGpURZGi8qgngxIU3eKPaAEVULr0GO
        iCm1XdKXTNVKb1uku/HbKak=
X-Google-Smtp-Source: APXvYqzgTAozSw3ZqL0CfGsQxC+BOH3/PoaULtaz8IVi6MkWFx9TZ5XQ5Ilz3W+SgAV+qFEPzhyxiw==
X-Received: by 2002:aa7:8296:: with SMTP id s22mr13348357pfm.52.1556995463860;
        Sat, 04 May 2019 11:44:23 -0700 (PDT)
Received: from localhost.localdomain ([103.87.57.241])
        by smtp.gmail.com with ESMTPSA id m131sm16730778pfc.25.2019.05.04.11.44.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 May 2019 11:44:23 -0700 (PDT)
From:   Vatsala Narang <vatsalanarang@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hadess@hadess.net, hdegoede@redhat.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, julia.lawall@lip6.fr,
        Vatsala Narang <vatsalanarang@gmail.com>
Subject: [PATCH 2/7] staging: rtl8723bs: core: Remove return in void function.
Date:   Sun,  5 May 2019 00:13:58 +0530
Message-Id: <20190504184358.25632-1-vatsalanarang@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove return in void function to get rid of checkpatch warning.

Signed-off-by: Vatsala Narang <vatsalanarang@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 00d84d34da97..a7c22e5e3559 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -3097,8 +3097,6 @@ void issue_auth(struct adapter *padapter, struct sta_info *psta, unsigned short
 	rtw_wep_encrypt(padapter, (u8 *)pmgntframe);
 	DBG_871X("%s\n", __func__);
 	dump_mgntframe(padapter, pmgntframe);
-
-	return;
 }
 
 
@@ -5271,8 +5269,6 @@ void report_del_sta_event(struct adapter *padapter, unsigned char *MacAddr, unsi
 	DBG_871X("report_del_sta_event: delete STA, mac_id =%d\n", mac_id);
 
 	rtw_enqueue_cmd(pcmdpriv, pcmd_obj);
-
-	return;
 }
 
 void report_add_sta_event(struct adapter *padapter, unsigned char *MacAddr, int cam_idx)
@@ -5317,8 +5313,6 @@ void report_add_sta_event(struct adapter *padapter, unsigned char *MacAddr, int
 	DBG_871X("report_add_sta_event: add STA\n");
 
 	rtw_enqueue_cmd(pcmdpriv, pcmd_obj);
-
-	return;
 }
 
 /****************************************************************************
@@ -5828,8 +5822,6 @@ void survey_timer_hdl(struct timer_list *t)
 
 
 exit_survey_timer_hdl:
-
-	return;
 }
 
 void link_timer_hdl(struct timer_list *t)
@@ -5880,8 +5872,6 @@ void link_timer_hdl(struct timer_list *t)
 		issue_assocreq(padapter);
 		set_link_timer(pmlmeext, REASSOC_TO);
 	}
-
-	return;
 }
 
 void addba_timer_hdl(struct timer_list *t)
-- 
2.17.1

