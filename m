Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5422FC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 18:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B6C8206DF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 18:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="neWTKteH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbfCQSb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 14:31:56 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35618 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727495AbfCQSbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 14:31:55 -0400
Received: by mail-wm1-f65.google.com with SMTP id 81so3235610wme.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2019 11:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=tOpOKBKHJJ0wFO54WQ8Dh4eqDCPLR/zymW7IUVlHAO4=;
        b=neWTKteH9bbHtC89qhsfX327rL+upavau/XItMQmBPGrgAdO9Xj8Xy6HpqKsDJ2pGr
         Eii2iaTZ6fwctdAwRUTBiQh3astWlYtiJBm064NoGiOS/znRzrGZhT+i8wTFq3hHaorg
         nHDOLqgOifXESK9Pe5frIKySP3FL7F9vjJrg+XO/T3/LcTibpo+4VTBErd9vZvAuZd7k
         bpNxqfaTLpcZfQula701+ps3Qrymdzc0FD3+Znws4wtXJwkpExljJnK7Q/jXsovkIeEW
         nySzSclfDWpV314Q+BkooM9ZQgkUvqU7dqfl3un9jE3DFI3txt5D62nYA8nHiFkJl0VW
         lHVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=tOpOKBKHJJ0wFO54WQ8Dh4eqDCPLR/zymW7IUVlHAO4=;
        b=gJgIddIrXdnQ8zQbDKKb+bZGMAndf21qyopLAaAPEvGVsxKPMaJkpmIAqYRAjGBkuz
         jXlg2nc/aLJgkyajeQXFnrzhk3e6t/vqePx7kNZXxzKpn97WYw19tPix1MwKJgA5jP1o
         EeXxQIgD4zZnE2E5lZhdGJkqPw0XpkzSvOkfRadgoAYuR6c/Wlc1X4JkIvqFaQINE/8J
         xYXiKrNq86CIC7UDtZYNOD4zHaQvqXgi+9UlKyRQA2+L6lVVYZR/u2oyLEGWBRXVSLS7
         rZ6a2fupVQp/QnSEo1625FTs6Jds1BMhrxzZFlkpnaPWz8Sex1lTlD69EgfkhDGw2NVe
         WASw==
X-Gm-Message-State: APjAAAVznBque3qe9eGu89JXwO4JZPi0geaze4F2sH45UKIwQYgxJHsu
        opnGtu1hRA1kJ2HIwgxkEJPNux8gL28=
X-Google-Smtp-Source: APXvYqzR8xdczwC4LmtzQB7TGoQDAJnw803vrcQn+0BKR84uuMNh1U01r6mwUylQVtBskd9gvSU1HA==
X-Received: by 2002:a1c:234d:: with SMTP id j74mr8051351wmj.130.1552847513552;
        Sun, 17 Mar 2019 11:31:53 -0700 (PDT)
Received: from p200300EEEE2F.fritz.box (p200300C9871AF900B43796A8F69485B6.dip0.t-ipconnect.de. [2003:c9:871a:f900:b437:96a8:f694:85b6])
        by smtp.gmail.com with ESMTPSA id q5sm8415358wrn.43.2019.03.17.11.31.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 11:31:53 -0700 (PDT)
From:   Emanuel Bennici <benniciemanuel78@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Hardik Singh Rathore <hardiksingh.k@gmail.com>
Subject: [PATCH 10/10] staging: rtl8723bs: Remove Dead Code in core/rtw_mlme.c
Date:   Sun, 17 Mar 2019 19:31:13 +0100
Message-Id: <20190317183115.32393-10-benniciemanuel78@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190317183115.32393-1-benniciemanuel78@gmail.com>
References: <20190317183115.32393-1-benniciemanuel78@gmail.com>
Reply-To: benniciemanuel78@gmail.com
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Functions `void rtw_surveydone_event_callback`, `void rtw_indicate_connect`,
`void rtw_stadel_event_callback` and `void _rtw_join_timeout_handler`
are using the Macro CONFIG_INTEL_WIDI which doesn't exists anymore.

Signed-off-by: Emanuel Bennici <benniciemanuel78@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 32 -----------------------
 1 file changed, 32 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 406e313477aa..79adc6f1e53a 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -943,13 +943,6 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 						|| _SUCCESS != rtw_sitesurvey_cmd(adapter, &pmlmepriv->assoc_ssid, 1, NULL, 0)
 					) {
 						rtw_set_to_roam(adapter, 0);
-#ifdef CONFIG_INTEL_WIDI
-						if (adapter->mlmepriv.widi_state == INTEL_WIDI_STATE_ROAMING) {
-							memset(pmlmepriv->sa_ext, 0x00, L2SDTA_SERVICE_VE_LEN);
-							intel_widi_wk_cmd(adapter, INTEL_WIDI_LISTEN_WK, NULL, 0);
-							DBG_871X("change to widi listen\n");
-						}
-#endif /*  CONFIG_INTEL_WIDI */
 						rtw_free_assoc_resources(adapter, 1);
 						rtw_indicate_disconnect(adapter);
 					} else {
@@ -1108,14 +1101,6 @@ void rtw_indicate_connect(struct adapter *padapter)
 	}
 
 	rtw_set_to_roam(padapter, 0);
-#ifdef CONFIG_INTEL_WIDI
-	if (padapter->mlmepriv.widi_state == INTEL_WIDI_STATE_ROAMING) {
-		memset(pmlmepriv->sa_ext, 0x00, L2SDTA_SERVICE_VE_LEN);
-		intel_widi_wk_cmd(padapter, INTEL_WIDI_LISTEN_WK, NULL, 0);
-		DBG_871X("change to widi listen\n");
-	}
-#endif /*  CONFIG_INTEL_WIDI */
-
 	rtw_set_scan_deny(padapter, 3000);
 
 	RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("-rtw_indicate_connect: fw_state = 0x%08x\n", get_fwstate(pmlmepriv)));
@@ -1703,11 +1688,6 @@ void rtw_stadel_event_callback(struct adapter *adapter, u8 *pbuf)
 			roam = true;
 			roam_target = pmlmepriv->roam_network;
 		}
-#ifdef CONFIG_INTEL_WIDI
-		else if (adapter->mlmepriv.widi_state == INTEL_WIDI_STATE_CONNECTED) {
-			roam = true;
-		}
-#endif /*  CONFIG_INTEL_WIDI */
 
 		if (roam == true) {
 			if (rtw_to_roam(adapter) > 0)
@@ -1732,11 +1712,6 @@ void rtw_stadel_event_callback(struct adapter *adapter, u8 *pbuf)
 		}
 		spin_unlock_bh(&(pmlmepriv->scanned_queue.lock));
 
-#ifdef CONFIG_INTEL_WIDI
-		if (!rtw_to_roam(adapter))
-			process_intel_widi_disconnect(adapter, 1);
-#endif /*  CONFIG_INTEL_WIDI */
-
 		_rtw_roaming(adapter, roam_target);
 	}
 
@@ -1833,13 +1808,6 @@ void _rtw_join_timeout_handler(struct timer_list *t)
 				}
 				break;
 			} else {
-#ifdef CONFIG_INTEL_WIDI
-				if (adapter->mlmepriv.widi_state == INTEL_WIDI_STATE_ROAMING) {
-					memset(pmlmepriv->sa_ext, 0x00, L2SDTA_SERVICE_VE_LEN);
-					intel_widi_wk_cmd(adapter, INTEL_WIDI_LISTEN_WK, NULL, 0);
-					DBG_871X("change to widi listen\n");
-				}
-#endif /*  CONFIG_INTEL_WIDI */
 				DBG_871X("%s We've try roaming but fail\n", __func__);
 				rtw_indicate_disconnect(adapter);
 				break;
-- 
2.19.1

