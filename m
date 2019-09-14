Return-Path: <SRS0=tewG=XJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEAFAC4CEC7
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 11:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8656620717
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 11:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ouOXyIwR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730262AbfINL4v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Sep 2019 07:56:51 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34829 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729885AbfINL4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 07:56:50 -0400
Received: by mail-wm1-f66.google.com with SMTP id y21so1115450wmi.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2019 04:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qQpCdDZTLmJVj8QmOn08OiO8kq3v3BOagLcGV6hpUg0=;
        b=ouOXyIwRLq94CyfPzMD7mQ4g9bU5gl4sgrwuUctXnXwIq+k6joclsol/8qcmn5m1WY
         p2DDxEVw9nXt08XZzu2Qcn3upCxN6KKV05Xs6XcoDCnpCAe5m8zOFhHFNIx0lmkBTSRG
         CueyPh/CITZi3PupmSq7ZPewi+Vvo26UIskjAwQb7nXzvGvEeITX0aTG48LoxKGZXUvy
         heAhs5r99oZgMT917Y42ynEA5J8VMN0j5qGRLdpln8KzjjDphPvxi+7RFwM56LoSNGxs
         J+ZrH0SE8MWxqLPKg7a7EgR2OmCg3RiBnc9tGu2o/f7pVvgHubp60UefqQWQIEcuArno
         forw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qQpCdDZTLmJVj8QmOn08OiO8kq3v3BOagLcGV6hpUg0=;
        b=qiHlxI+C5aMjcOZUrQ75941J8scQmGrJ7FgQrRAVxEIbJCkr9Q1SfrB2fi0CkaiL7R
         EWRPuF9akW1xOI88JZKSnd3+vK0W0kG/a7mpWFdBRqUvfLcPkt8f6iOypC83YDq/URcH
         yuN47sFDkcAcCv160UAQYo+b5YYdT4MI0tx8wgQYvS6WxGbVehtoj+sYRfeAvBolXSvW
         I1kgzQ8B430hh2okYFsTrGVoY6Gxd4+ZolMj0nzgGDmP6G7k0lDizk5xoFfdRYG9sZPj
         dV0T/LmoOuhemWTiuLSOcmt8bjQkAg9EQDTc0ND/Vda0nTquzOjasvm8iFPyC1xXNuLe
         wspQ==
X-Gm-Message-State: APjAAAXx6+dYuWYTl5mz4WEuIIuokLfl+sSNs19mwbZXoe+IuojK3u1/
        tQCCAFaVpX7+vxvYTpKhVT8=
X-Google-Smtp-Source: APXvYqzTMant0Z4zMA8ZBil0vmoz3PDqpks9wIq6Opv1wKkUCSoxVNsMDY/WSu5P9S8eMsy9jj7gQQ==
X-Received: by 2002:a7b:c758:: with SMTP id w24mr5165165wmk.148.1568462207717;
        Sat, 14 Sep 2019 04:56:47 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96bf:e0ab:2b68:5d76:a12a:e6ba])
        by smtp.gmail.com with ESMTPSA id e20sm63466269wrc.34.2019.09.14.04.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2019 04:56:47 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8723bs: remove return statements from void functions
Date:   Sat, 14 Sep 2019 13:56:34 +0200
Message-Id: <20190914115634.67874-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary return statements from void functions reported by
checkpatch.

WARNING: void function return statements are not generally useful

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c         |  5 -----
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c     | 10 ----------
 drivers/staging/rtl8723bs/core/rtw_pwrctrl.c      |  1 -
 drivers/staging/rtl8723bs/core/rtw_security.c     |  1 -
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c    |  2 --
 drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c    |  2 --
 drivers/staging/rtl8723bs/hal/odm_DIG.c           |  1 -
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c |  1 -
 drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c    |  2 --
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c |  1 -
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c      |  1 -
 11 files changed, 27 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 34adf5789c98..4000125054c3 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -329,7 +329,6 @@ void rtw_generate_random_ibss(u8 *pibss)
 	pibss[3] = (u8)(curtime & 0xff) ;/* p[0]; */
 	pibss[4] = (u8)((curtime>>8) & 0xff) ;/* p[1]; */
 	pibss[5] = (u8)((curtime>>16) & 0xff) ;/* p[2]; */
-	return;
 }
 
 u8 *rtw_get_capability_from_ie(u8 *ie)
@@ -832,8 +831,6 @@ void rtw_survey_event_callback(struct adapter	*adapter, u8 *pbuf)
 exit:
 
 	spin_unlock_bh(&pmlmepriv->lock);
-
-	return;
 }
 
 
@@ -1840,8 +1837,6 @@ void rtw_mlme_reset_auto_scan_int(struct adapter *adapter)
 			mlme->auto_scan_int_ms = mlme->roam_scan_int_ms;
 	} else
 		mlme->auto_scan_int_ms = 0; /* disabled */
-
-	return;
 }
 
 static void rtw_auto_scan_handler(struct adapter *padapter)
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 2128886c9924..4f812cd19b31 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -3086,8 +3086,6 @@ void issue_auth(struct adapter *padapter, struct sta_info *psta, unsigned short
 	rtw_wep_encrypt(padapter, (u8 *)pmgntframe);
 	DBG_871X("%s\n", __func__);
 	dump_mgntframe(padapter, pmgntframe);
-
-	return;
 }
 
 
@@ -3405,8 +3403,6 @@ void issue_assocreq(struct adapter *padapter)
 		rtw_buf_update(&pmlmepriv->assoc_req, &pmlmepriv->assoc_req_len, (u8 *)pwlanhdr, pattrib->pktlen);
 	else
 		rtw_buf_free(&pmlmepriv->assoc_req, &pmlmepriv->assoc_req_len);
-
-	return;
 }
 
 /* when wait_ack is ture, this function shoule be called at process context */
@@ -5260,8 +5256,6 @@ void report_del_sta_event(struct adapter *padapter, unsigned char *MacAddr, unsi
 	DBG_871X("report_del_sta_event: delete STA, mac_id =%d\n", mac_id);
 
 	rtw_enqueue_cmd(pcmdpriv, pcmd_obj);
-
-	return;
 }
 
 void report_add_sta_event(struct adapter *padapter, unsigned char *MacAddr, int cam_idx)
@@ -5306,8 +5300,6 @@ void report_add_sta_event(struct adapter *padapter, unsigned char *MacAddr, int
 	DBG_871X("report_add_sta_event: add STA\n");
 
 	rtw_enqueue_cmd(pcmdpriv, pcmd_obj);
-
-	return;
 }
 
 /****************************************************************************
@@ -5869,8 +5861,6 @@ void link_timer_hdl(struct timer_list *t)
 		issue_assocreq(padapter);
 		set_link_timer(pmlmeext, REASSOC_TO);
 	}
-
-	return;
 }
 
 void addba_timer_hdl(struct timer_list *t)
diff --git a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
index 4075de07e0a9..30137f0bd984 100644
--- a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
+++ b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
@@ -190,7 +190,6 @@ void rtw_ps_processor(struct adapter *padapter)
 	}
 exit:
 	pwrpriv->ps_processing = false;
-	return;
 }
 
 static void pwr_state_check_handler(struct timer_list *t)
diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
index 57cfe06d7d73..5ffaf9bfa6e8 100644
--- a/drivers/staging/rtl8723bs/core/rtw_security.c
+++ b/drivers/staging/rtl8723bs/core/rtw_security.c
@@ -309,7 +309,6 @@ void rtw_wep_decrypt(struct adapter  *padapter, u8 *precvframe)
 
 		WEP_SW_DEC_CNT_INC(psecuritypriv, prxattrib->ra);
 	}
-	return;
 }
 
 /* 3		=====TKIP related ===== */
diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index ea3ea2a6b314..5ab98f3e722e 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -1170,8 +1170,6 @@ void HT_info_handler(struct adapter *padapter, struct ndis_80211_var_ie *pIE)
 
 	pmlmeinfo->HT_info_enable = 1;
 	memcpy(&(pmlmeinfo->HT_info), pIE->data, pIE->Length);
-
-	return;
 }
 
 void HTOnAssocRsp(struct adapter *padapter)
diff --git a/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c b/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c
index 3239d37087c8..1ca9063a269f 100644
--- a/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c
+++ b/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c
@@ -402,8 +402,6 @@ static void GetDeltaSwingTable_8723B(
 		*TemperatureUP_B   = (u8 *)DeltaSwingTableIdx_2GA_P_8188E;
 		*TemperatureDOWN_B = (u8 *)DeltaSwingTableIdx_2GA_N_8188E;
 	}
-
-	return;
 }
 
 
diff --git a/drivers/staging/rtl8723bs/hal/odm_DIG.c b/drivers/staging/rtl8723bs/hal/odm_DIG.c
index 70d98c58ca97..40fe43c62c45 100644
--- a/drivers/staging/rtl8723bs/hal/odm_DIG.c
+++ b/drivers/staging/rtl8723bs/hal/odm_DIG.c
@@ -1074,7 +1074,6 @@ void odm_FAThresholdCheck(
 		dm_FA_thres[1] = 4000;
 		dm_FA_thres[2] = 5000;
 	}
-	return;
 }
 
 u8 odm_ForbiddenIGICheck(void *pDM_VOID, u8 DIG_Dynamic_MIN, u8 CurrentIGI)
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index faeaf24fa833..87535a4c2e14 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -3773,7 +3773,6 @@ void C2HPacketHandler_8723B(struct adapter *padapter, u8 *pbuffer, u16 length)
 
 	process_c2h_event(padapter, &C2hEvent, tmpBuf);
 	/* c2h_handler_8723b(padapter,&C2hEvent); */
-	return;
 }
 
 void SetHwReg8723B(struct adapter *padapter, u8 variable, u8 *val)
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
index 0f3301091258..e8577c084bbd 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
@@ -179,8 +179,6 @@ static void rtl8723bs_c2h_packet_handler(struct adapter *padapter,
 		kfree(tmp);
 
 	/* DBG_871X("-%s res(%d)\n", __func__, res); */
-
-	return;
 }
 
 static inline union recv_frame *try_alloc_recvframe(struct recv_priv *precvpriv,
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index f819abb756dc..67d56f3c0717 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -1422,7 +1422,6 @@ void rtw_cfg80211_unlink_bss(struct adapter *padapter, struct wlan_network *pnet
 		DBG_8192C("%s(): cfg80211_unlink %s!! () ", __func__, select_network.Ssid.Ssid);
 		cfg80211_put_bss(padapter->rtw_wdev->wiphy, bss);
 	}
-	return;
 }
 
 void rtw_cfg80211_surveydone_event_callback(struct adapter *padapter)
diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
index d3784c44f6d0..12f683e2e0e2 100644
--- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
+++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
@@ -281,7 +281,6 @@ static void sdio_dvobj_deinit(struct sdio_func *func)
 		sdio_deinit(dvobj);
 		devobj_deinit(dvobj);
 	}
-	return;
 }
 
 void rtw_set_hal_ops(struct adapter *padapter)
-- 
2.23.0

