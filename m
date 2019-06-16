Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7771C31E50
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 16:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8680E2063F
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 16:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/1kUCyU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbfFPQUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 12:20:30 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41999 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfFPQU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 12:20:29 -0400
Received: by mail-pf1-f196.google.com with SMTP id q10so4292439pff.9
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2019 09:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=EzUB83/4vbw+CwJuopIXHONoPt2SMEg6J7YUNraqN58=;
        b=C/1kUCyUiRd88ORqW+QroKCRVfr5FSP7gdgKyhLSo/NsgIm93bymyLGrQN6h8eYgFI
         6ENRvQXAxVXJYZLY7xOMCkd1OXjq4YVIPFZhGQQYaBCRRbRfwcFYW3pThIu/du7Hz/yU
         xIj54L2cwC1HI+L+KB0iDc5GempebOmn7fyv3OH+txdp/uhSbKtQvdMkceA2nTub+44Y
         yN8arsMupMqkBfde+3cDMBstTOJaPYfbCDW6oXgCeGSMk7rbWdPgn1lEFh6VI2zmT2OU
         nkpMLH3UIQHrhs120Y+oREJ1A4bwxtrHTpWD9Wx7ROzmK6lCSWwCUzkBgiP2n6EEAp91
         YdTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=EzUB83/4vbw+CwJuopIXHONoPt2SMEg6J7YUNraqN58=;
        b=g+uYf787gbW7hEm6LInf5Zufwh1IZ3exEs2ZdSQLRMjkldBnifSPitClLgy6xozurS
         guvh5Ri5357CqB6jFyT0PomvaxCjoHOevAFayTh5fNR2/AJTigbHfW/XT+alAxPI8e1q
         m7BQS/djTK+os7uzb5YkY7Q1c6TN12nRcNuRW7GAOWqBtsXPnE+dhy1ASQ/ecxmWP09X
         +2+G+cW5ik3VMPttRkNWBy3+S9lpqWtQf6FogNLslfyf1+RbWcE1bTE0AygpRq4pThsC
         8dTgSGjb4aMgXD8FMvz69oEQD0OTbNQlOo8/gy+r0FKkmXNP6oi/pOPWLbAbqU7uNR9s
         3A9A==
X-Gm-Message-State: APjAAAUh/ap+JKnYGc0oqB+E7xeu8MkR0egpJZsDCNBC5LHx5YW/oBwV
        hCuBaS3WdCX7p63W1MofpGg=
X-Google-Smtp-Source: APXvYqys+TpVk+sQ1uzVkEl6LxwY7m1WZzxx2ChjtdNBGzSy3M7cZO0P3QnAfjyt2f1nGL7xp0ZZCg==
X-Received: by 2002:a63:1208:: with SMTP id h8mr43884589pgl.377.1560702028839;
        Sun, 16 Jun 2019 09:20:28 -0700 (PDT)
Received: from localhost.localdomain (c-98-210-58-162.hsd1.ca.comcast.net. [98.210.58.162])
        by smtp.gmail.com with ESMTPSA id 8sm1687908pgc.13.2019.06.16.09.20.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 16 Jun 2019 09:20:28 -0700 (PDT)
From:   Shobhit Kukreti <shobhitkukreti@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Shobhit Kukreti <shobhitkukreti@gmail.com>
Subject: [PATCH v3 2/3] staging: rtl8723bs: Resolve the checkpatch error: else should follow close brace '}'
Date:   Sun, 16 Jun 2019 09:19:50 -0700
Message-Id: <466c579bdb97777d5e0df0eced4c07b3ec2aa7fe.1560701271.git.shobhitkukreti@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1560701271.git.shobhitkukreti@gmail.com>
References: <20190616131145.GA30779@t-1000>
 <cover.1560701271.git.shobhitkukreti@gmail.com>
In-Reply-To: <cover.1560701271.git.shobhitkukreti@gmail.com>
References: <cover.1560701271.git.shobhitkukreti@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleaned up the code to resolve the checkpatch error else should follow
close brace '}' from the following files:

mlme_linux.c
recv_linux.c
sdio_intf.c

Signed-off-by: Shobhit Kukreti <shobhitkukreti@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/mlme_linux.c |  6 ++----
 drivers/staging/rtl8723bs/os_dep/recv_linux.c | 21 +++++++--------------
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c  |  9 +++------
 3 files changed, 12 insertions(+), 24 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/mlme_linux.c b/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
index 4631b68..6a5ab35 100644
--- a/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
@@ -48,8 +48,7 @@ void rtw_os_indicate_connect(struct adapter *adapter)
 	if ((check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) == true) ||
 		(check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) == true)) {
 		rtw_cfg80211_ibss_indicate_connect(adapter);
-	}
-	else
+	} else
 		rtw_cfg80211_indicate_connect(adapter);
 
 	rtw_indicate_wx_assoc_event(adapter);
@@ -104,8 +103,7 @@ void rtw_reset_securitypriv(struct adapter *adapter)
 		adapter->securitypriv.ndisauthtype = Ndis802_11AuthModeOpen;
 		adapter->securitypriv.ndisencryptstatus = Ndis802_11WEPDisabled;
 
-	}
-	else {
+	} else {
 		/* reset values in securitypriv */
 
 		/* if (adapter->mlmepriv.fw_state & WIFI_STATION_STATE) */
diff --git a/drivers/staging/rtl8723bs/os_dep/recv_linux.c b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
index a2055f6..aab0195 100644
--- a/drivers/staging/rtl8723bs/os_dep/recv_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
@@ -62,15 +62,13 @@ _pkt *rtw_os_alloc_msdu_pkt(union recv_frame *prframe, u16 nSubframe_Length, u8
 	if (sub_skb) {
 		skb_reserve(sub_skb, 12);
 		skb_put_data(sub_skb, (pdata + ETH_HLEN), nSubframe_Length);
-	}
-	else {
+	} else {
 		sub_skb = rtw_skb_clone(prframe->u.hdr.pkt);
 		if (sub_skb) {
 			sub_skb->data = pdata + ETH_HLEN;
 			sub_skb->len = nSubframe_Length;
 			skb_set_tail_pointer(sub_skb, nSubframe_Length);
-		}
-		else {
+		} else {
 			DBG_871X("%s(): rtw_skb_clone() Fail!!!\n", __func__);
 			return NULL;
 		}
@@ -142,8 +140,7 @@ void rtw_os_recv_indicate_pkt(struct adapter *padapter, _pkt *pkt, struct rx_pkt
 						return;
 					}
 				}
-			}
-			else {
+			} else {
 				/*  to APself */
 
 				/* DBG_871X("to APSelf\n"); */
@@ -183,24 +180,21 @@ void rtw_handle_tkip_mic_err(struct adapter *padapter, u8 bgroup)
 
 	if (psecuritypriv->last_mic_err_time == 0) {
 		psecuritypriv->last_mic_err_time = jiffies;
-	}
-	else {
+	} else {
 		cur_time = jiffies;
 
 		if (cur_time - psecuritypriv->last_mic_err_time < 60*HZ) {
 			psecuritypriv->btkip_countermeasure = true;
 			psecuritypriv->last_mic_err_time = 0;
 			psecuritypriv->btkip_countermeasure_time = cur_time;
-		}
-		else {
+		} else {
 			psecuritypriv->last_mic_err_time = jiffies;
 		}
 	}
 
 	if (bgroup) {
 		key_type |= NL80211_KEYTYPE_GROUP;
-	}
-	else {
+	} else {
 		key_type |= NL80211_KEYTYPE_PAIRWISE;
 	}
 
@@ -210,8 +204,7 @@ void rtw_handle_tkip_mic_err(struct adapter *padapter, u8 bgroup)
 	memset(&ev, 0x00, sizeof(ev));
 	if (bgroup) {
 	    ev.flags |= IW_MICFAILURE_GROUP;
-	}
-	else {
+	} else {
 	    ev.flags |= IW_MICFAILURE_PAIRWISE;
 	}
 
diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
index c60f13c..9c408d9 100644
--- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
+++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
@@ -88,8 +88,7 @@ static int sdio_alloc_irq(struct dvobj_priv *dvobj)
 	if (err) {
 		dvobj->drv_dbg.dbg_sdio_alloc_irq_error_cnt++;
 		printk(KERN_CRIT "%s: sdio_claim_irq FAIL(%d)!\n", __func__, err);
-	}
-	else {
+	} else {
 		dvobj->drv_dbg.dbg_sdio_alloc_irq_cnt++;
 		dvobj->irq_alloc = 1;
 	}
@@ -115,8 +114,7 @@ static void sdio_free_irq(struct dvobj_priv *dvobj)
             if (err) {
 				dvobj->drv_dbg.dbg_sdio_free_irq_error_cnt++;
 				DBG_871X_LEVEL(_drv_err_,"%s: sdio_release_irq FAIL(%d)!\n", __func__, err);
-            }
-            else
+            } else
 		dvobj->drv_dbg.dbg_sdio_free_irq_cnt++;
             sdio_release_host(func);
         }
@@ -232,8 +230,7 @@ static void sdio_deinit(struct dvobj_priv *dvobj)
 			if (err) {
 				dvobj->drv_dbg.dbg_sdio_free_irq_error_cnt++;
 				DBG_8192C(KERN_ERR "%s: sdio_release_irq(%d)\n", __func__, err);
-			}
-			else
+			} else
 				dvobj->drv_dbg.dbg_sdio_free_irq_cnt++;
 		}
 
-- 
2.7.4

