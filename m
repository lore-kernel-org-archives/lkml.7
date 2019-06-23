Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD35C48BE4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 18:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A0A420656
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 18:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nw8R0KYI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfFWSAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 14:00:20 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33155 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbfFWSAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 14:00:19 -0400
Received: by mail-wr1-f65.google.com with SMTP id n9so11474440wru.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2019 11:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D0yn6X+tzWOuxsBWS/gVrSq2d3W5TzvBszpoVVx2is0=;
        b=nw8R0KYIux/6xSfmFF7RSbcZ64oGgKkWHXOlSpxo4sjtwmUW47CArKzXLFHTufRY7i
         mnOPqB6IUsw3jmNDzIz+MfAsxCJqGmIMwgY6po9MihRisRcUi4OaiJWCvRxI/urDaUVn
         ssMwfuq/n/ui6TQu/pG8xtDbNwOHIjjl5X6hQOUWagqog3kP2cfniTJ12veiNaiI2hbi
         BhUn7kn5E89ro5XZTyopkrDMKBEzubh0pl7hRpUe7hBSGw8CEnw5cz72xobE2hyriGat
         n/oRaEhFFzm5m1C4uWOfTqIn7TnDiB4SYqG6ApF3fdqB/gnoxTu+43YpVL8IffyhM6x+
         o6hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D0yn6X+tzWOuxsBWS/gVrSq2d3W5TzvBszpoVVx2is0=;
        b=h0562kd6YSiP2dYydrZM3bo2v0JhySdBop1PetVa9JA4IoW5l6Zevb1pIVLW2JRr+b
         FaHHC25E0ss6iKV2yJfyOOhcsn62LDcn1AjL/vZIrwRHfArMGTRxLjqSzs0xPdbzwKSQ
         /AQLGWqEHy6Yq+SPAIX877c+6vcsRJD+PJZPH0pLRFiS8yuRbJP+y5+5o6EhpycsHc78
         Bo+Rgr/HNeSVrEWW+35IQ4RDJPsUND/CEwf+sK25vUqgn4vOXd9g5KHB94+owdAcJO70
         tZ8tyDbVfiC89jR8S7WCj/ZiS0G9VIvPZOdjKYADr26bLbOeiLVtQ4mF7/uswe/0PDwg
         Z06Q==
X-Gm-Message-State: APjAAAWABr2uD4Qt29j0/N7QiSIJpf3ssQGn6hubwBEFrhQe62npRC0E
        xyJ2vwFj7LAPhQArdlN8zLwQ9Upp
X-Google-Smtp-Source: APXvYqyiIl/QwAaT+T6qqTIHajLRL2aL3ghwRJ1qXFNmPXH7hvgbHln0863MFYeSliK9ilHWpXKd7A==
X-Received: by 2002:adf:eec2:: with SMTP id a2mr33499119wrp.147.1561312817599;
        Sun, 23 Jun 2019 11:00:17 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96bf:e0ab:2b68:5d76:a12a:e6ba])
        by smtp.gmail.com with ESMTPSA id c4sm8216742wrt.86.2019.06.23.11.00.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 23 Jun 2019 11:00:17 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/2] staging: rtl8188eu: remove unused function is_ap_in_wep()
Date:   Sun, 23 Jun 2019 19:59:57 +0200
Message-Id: <20190623175957.16763-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190623175957.16763-1-straube.linux@gmail.com>
References: <20190623175957.16763-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function is_ap_in_wep() is not used in the driver code, so remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../staging/rtl8188eu/core/rtw_wlan_util.c    | 30 -------------------
 .../staging/rtl8188eu/include/rtw_mlme_ext.h  |  1 -
 2 files changed, 31 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
index 159c46b096cb..7bfc5b7c2757 100644
--- a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
@@ -1074,36 +1074,6 @@ unsigned int is_ap_in_tkip(struct adapter *padapter)
 	}
 }
 
-unsigned int is_ap_in_wep(struct adapter *padapter)
-{
-	u32 i;
-	struct ndis_802_11_var_ie *pIE;
-	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
-	struct wlan_bssid_ex *cur_network = &pmlmeinfo->network;
-
-	if (rtw_get_capability((struct wlan_bssid_ex *)cur_network) & WLAN_CAPABILITY_PRIVACY) {
-		for (i = sizeof(struct ndis_802_11_fixed_ie); i < pmlmeinfo->network.ie_length;) {
-			pIE = (struct ndis_802_11_var_ie *)(pmlmeinfo->network.ies + i);
-
-			switch (pIE->ElementID) {
-			case _VENDOR_SPECIFIC_IE_:
-				if (!memcmp(pIE->data, RTW_WPA_OUI, 4))
-					return false;
-				break;
-			case _RSN_IE_2_:
-				return false;
-			default:
-				break;
-			}
-			i += (pIE->Length + 2);
-		}
-		return true;
-	} else {
-		return false;
-	}
-}
-
 static int wifirate2_ratetbl_inx(unsigned char rate)
 {
 	rate = rate & 0x7f;
diff --git a/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h b/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h
index fa14b6fedf08..327f7d1bc20c 100644
--- a/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h
+++ b/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h
@@ -525,7 +525,6 @@ void set_sta_rate(struct adapter *padapter, struct sta_info *psta);
 unsigned char get_highest_rate_idx(u32 mask);
 int support_short_GI(struct adapter *padapter, struct ieee80211_ht_cap *caps);
 unsigned int is_ap_in_tkip(struct adapter *padapter);
-unsigned int is_ap_in_wep(struct adapter *padapter);
 
 void report_join_res(struct adapter *padapter, int res);
 void report_survey_event(struct adapter *padapter,
-- 
2.22.0

