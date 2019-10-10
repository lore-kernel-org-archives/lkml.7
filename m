Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B229C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 04:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17CBB20B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 04:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGgepeDf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732685AbfJJEvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 00:51:04 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43988 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbfJJEvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 00:51:04 -0400
Received: by mail-pg1-f195.google.com with SMTP id i32so2835799pgl.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 21:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZUpFJbctHLbLvrh0MpCtPGi5zG/1dlaflfj3eQWRa4g=;
        b=YGgepeDf6EXaLhxLlzAad/R7SJoPuOexB9TX3oOi7is4aN0GR3HJtHSGDyxus4GGih
         SGd7KqD8N8kZMHnWLj8mazYPH8Lu2Nc27DrPS8703lHm1+Cfb9MimvHHfc3uO1lbHjD0
         +wkXda87Tt8Hf5jtJIkXlKdPkUgE3NSdngUzcGh1/tOS5zSewGrJWbXIA2cQ+/rrbXKM
         A/gfO1xYnqCFktzo34pKkRWgwmZPcrUN0WfZpgsDY+HivAdSBj/8v2KpBv1Ct1Ck6fre
         NCkg8GMp3rZNDolRRvXynjNROzyKepKRxqVoiKWoCX8zMEzeu6PjqSdI6HZwpzi7oHyb
         cJMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZUpFJbctHLbLvrh0MpCtPGi5zG/1dlaflfj3eQWRa4g=;
        b=Elj/S/S/prxLWrCP0ZmjefUsIELD12m6Xey1UO/GBb3LaK/s7RY5M2lWuvkMsQOC+R
         mjgEBO89XkwVIOS52GUGB6O/ZPLWeDjVzUXnojyPNV6+C1cNyT1FW3eh4UnYURAFm/qn
         V8c8Sn0nmXCtGSdk25xPvb5P9nX7M42/neY6K23X9S8KS4XJ/xQWwFh0Lwz3CFDB4pcX
         UHmKoArHb1Svguvsybbh2uBMgt0kyaSVr5KNJpPrVhj5fjC2T1SeR4ceP6gi/E4+jXUb
         +P1zGPP/4/0+X65yOO3xobE03KxdQTP7wgqpKbH9TiE95Tu586VfLOeGegRCOyb94iqV
         dZXw==
X-Gm-Message-State: APjAAAXn3zJ9+vCZ1nKtyywys+pW7qs2vB6I0ZUENmuzr7GthQCCbqjU
        rVp4XZnfBvb3L0+WdiiAdn0=
X-Google-Smtp-Source: APXvYqyvVBCicHYH9qcwjshyIoU8tN9x/FSRdssXLVEyOOOGJsHuxAo05mtY4ynZDC3821IJhunDqg==
X-Received: by 2002:a63:6b06:: with SMTP id g6mr8734098pgc.104.1570683063304;
        Wed, 09 Oct 2019 21:51:03 -0700 (PDT)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id q20sm4520090pfl.79.2019.10.09.21.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 21:51:02 -0700 (PDT)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Wambui Karuga <wambui.karugax@gmail.com>
Subject: [PATCH v2 2/4] staging: rtl8723bs: Remove unnecessary braces for single statements
Date:   Thu, 10 Oct 2019 07:49:06 +0300
Message-Id: <8e6f986b6bb09951af5336f5033888eb9e8ef273.1570682635.git.wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1570682635.git.wambui.karugax@gmail.com>
References: <cover.1570682635.git.wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up multiple unnecessary braces around single statement blocks in
drivers/staging/rtl8723bs/core/rtw_mlme.c
Issues reported by checkpatch.pl as:
WARNING: braces {} are not necessary for single statement blocks or
WARNING: braces {} are not necessary for any arm of this statement

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 37 ++++++++---------------
 1 file changed, 12 insertions(+), 25 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 7f27287223e8..b15b761782b8 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -112,9 +112,8 @@ void _rtw_free_mlme_priv(struct mlme_priv *pmlmepriv)
 {
 	if (pmlmepriv) {
 		rtw_free_mlme_priv_ie_data(pmlmepriv);
-		if (pmlmepriv->free_bss_buf) {
+		if (pmlmepriv->free_bss_buf)
 			vfree(pmlmepriv->free_bss_buf);
-		}
 	}
 }
 
@@ -753,11 +752,10 @@ int rtw_is_desired_network(struct adapter *adapter, struct wlan_network *pnetwor
 
 		if (psecuritypriv->ndisauthtype == Ndis802_11AuthModeWPA2PSK) {
 			p = rtw_get_ie(pnetwork->network.IEs + _BEACON_IE_OFFSET_, _RSN_IE_2_, &ie_len, (pnetwork->network.IELength - _BEACON_IE_OFFSET_));
-			if (p && ie_len > 0) {
+			if (p && ie_len > 0)
 				bselected = true;
-			} else {
+			else
 				bselected = false;
-			}
 		}
 	}
 
@@ -822,9 +820,8 @@ void rtw_survey_event_callback(struct adapter	*adapter, u8 *pbuf)
 
 	/*  lock pmlmepriv->lock when you accessing network_q */
 	if ((check_fwstate(pmlmepriv, _FW_UNDER_LINKING)) == false) {
-		if (pnetwork->Ssid.Ssid[0] == 0) {
+		if (pnetwork->Ssid.Ssid[0] == 0)
 			pnetwork->Ssid.SsidLength = 0;
-		}
 		rtw_add_network(adapter, pnetwork);
 	}
 
@@ -893,9 +890,8 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 
 					pmlmepriv->fw_state = WIFI_ADHOC_MASTER_STATE;
 
-					if (rtw_createbss_cmd(adapter) != _SUCCESS) {
-					RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("Error =>rtw_createbss_cmd status FAIL\n"));
-					}
+					if (rtw_createbss_cmd(adapter) != _SUCCESS)
+						RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("Error =>rtw_createbss_cmd status FAIL\n"));
 
 					pmlmepriv->to_join = false;
 				}
@@ -1166,9 +1162,8 @@ static struct sta_info *rtw_joinbss_update_stainfo(struct adapter *padapter, str
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 
 	psta = rtw_get_stainfo(pstapriv, pnetwork->network.MacAddress);
-	if (!psta) {
+	if (!psta)
 		psta = rtw_alloc_stainfo(pstapriv, pnetwork->network.MacAddress);
-	}
 
 	if (psta) { /* update ptarget_sta */
 
@@ -1347,11 +1342,10 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 	rtw_get_encrypt_decrypt_from_registrypriv(adapter);
 
 
-	if (pmlmepriv->assoc_ssid.SsidLength == 0) {
+	if (pmlmepriv->assoc_ssid.SsidLength == 0)
 		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("@@@@@   joinbss event call back  for Any SSid\n"));
-	} else {
+	else
 		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("@@@@@   rtw_joinbss_event_callback for SSid:%s\n", pmlmepriv->assoc_ssid.Ssid));
-	}
 
 	the_same_macaddr = !memcmp(pnetwork->network.MacAddress, cur_network->network.MacAddress, ETH_ALEN);
 
@@ -1723,13 +1717,8 @@ void rtw_stadel_event_callback(struct adapter *adapter, u8 *pbuf)
 				_clr_fwstate_(pmlmepriv, WIFI_ADHOC_STATE);
 			}
 
-			if (rtw_createbss_cmd(adapter) != _SUCCESS) {
-
+			if (rtw_createbss_cmd(adapter) != _SUCCESS)
 				RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("***Error =>stadel_event_callback: rtw_createbss_cmd status FAIL***\n "));
-
-			}
-
-
 		}
 
 	}
@@ -1902,9 +1891,8 @@ void rtw_dynamic_check_timer_handler(struct adapter *adapter)
 		}
 
 	} else {
-		if (is_primary_adapter(adapter)) {
+		if (is_primary_adapter(adapter))
 			rtw_dynamic_chk_wk_cmd(adapter);
-		}
 	}
 
 	/* auto site survey */
@@ -2988,9 +2976,8 @@ void rtw_append_exented_cap(struct adapter *padapter, u8 *out_ie, uint *pout_len
 	u8 *pframe;
 
 
-	if (phtpriv->bss_coexist) {
+	if (phtpriv->bss_coexist)
 		SET_EXT_CAPABILITY_ELE_BSS_COEXIST(cap_content, 1);
-	}
 
 	pframe = rtw_set_ie(out_ie + *pout_len, EID_EXTCapability, 8, cap_content, pout_len);
 }
-- 
2.23.0

