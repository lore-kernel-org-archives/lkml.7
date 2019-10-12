Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64695C10F14
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 22:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38B40206CD
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 22:20:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IE4IDH7o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbfJLWTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 18:19:42 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36000 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbfJLWTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 18:19:42 -0400
Received: by mail-pf1-f196.google.com with SMTP id y22so8182515pfr.3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2019 15:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PzS89TZ3VQzwgK8P2bX5KvfvcY4VtRFHY42+gxItdKw=;
        b=IE4IDH7oqoloAZw7fMo5e7uwMwSAX2CsWN+v2d4jjtnsFkjTR0MD99vCxWiW/dMN0y
         X5a6wf8g1RczC2C/2NIoeNpGbfQEPzoa3QA03j5vcrv+XyBqdr80oAz0tt5XAwta/kKF
         IcoAc1ehw+hqdCpuLfJ3LKKCKWQ6hqXrc8DVsTpw5JMcKSU0zlFzVvYnZgRsvQ58RRZr
         o3YxgtElcW1xzU0em9LI8+O9rUctzgllhTKdOUhRHQz8RfVka30/WKfxe9dy0YT9NsKM
         XGERtlG9VJzpoDr2mhNSx4fefe1MXzXkpsiHlMBZzv1ZGcPP9BfWB2owjvmtx0stG+j0
         I4kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PzS89TZ3VQzwgK8P2bX5KvfvcY4VtRFHY42+gxItdKw=;
        b=kc/u7XL8f5rkXn6bNxy0cBkw29j7dAHEpFLUAkhIAJkToTWfaYaMMDZSdgDji2XnoO
         MjfNvzsCZ79CIAh725J+z+MBzKsKSKlaRtEyhga3QlPueaQ1XgN9UxCpUtzgnicWQ8DT
         UodXWfvExoIuVNEBxN993AYyE8DqC9DkPG6QJXZQMhr1TI13714R+ukBD9rpi1brj3GB
         TxM2v4/DwTr5GN+mvyYG45WUVDA3IjucS16T2Yvp0SJL+B86u2LQBE7r5qQniaTSY/XI
         PUeG5hnzp/C2XIPVZoJGCUozv4hqdnt/Hnx/AUc8l1D5kOSZxRrMeMmDXF9DpUl+f+W3
         vXOQ==
X-Gm-Message-State: APjAAAX666yRYQY0AhO3oKRum5U03u1sftn4AUU/ojDwiLyA4NxTK3Vv
        XQwZyB3zQPgj4/QiajrSSs4=
X-Google-Smtp-Source: APXvYqw0YGZ+ePLzQ8DYtYJ6wamf5q6IWdKIj+QmfD9NT7I1o0YWVkKonHP/yVuKqbwDtWCpUbQd1Q==
X-Received: by 2002:a17:90a:c405:: with SMTP id i5mr27349084pjt.9.1570918781357;
        Sat, 12 Oct 2019 15:19:41 -0700 (PDT)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id 30sm13839562pjk.25.2019.10.12.15.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2019 15:19:41 -0700 (PDT)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Larry.Finger@lwfinger.net,
        florian.c.schilhabel@googlemail.com
Subject: [PATCH 1/2] staging: rtl8712: remove unnecessary return variables
Date:   Sun, 13 Oct 2019 01:19:15 +0300
Message-Id: <f61a0f036af24228c682c6b12c3a8e6cf6736185.1570918228.git.wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1570918228.git.wambui.karugax@gmail.com>
References: <cover.1570918228.git.wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove variables that are only used to hold and return constants and
have the functions directly return the constants.

Issue found by coccinelle:
@@
local idexpression ret;
expression e;
@@

-ret =
+return
     e;
-return ret;

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/staging/rtl8712/rtl871x_mp_ioctl.c | 46 +++++++++-------------
 1 file changed, 19 insertions(+), 27 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_mp_ioctl.c b/drivers/staging/rtl8712/rtl871x_mp_ioctl.c
index aa8f8500cbb2..8af7892809ca 100644
--- a/drivers/staging/rtl8712/rtl871x_mp_ioctl.c
+++ b/drivers/staging/rtl8712/rtl871x_mp_ioctl.c
@@ -283,13 +283,12 @@ uint oid_rt_pro_stop_test_hdl(struct oid_par_priv *poid_par_priv)
 {
 	struct _adapter *Adapter = (struct _adapter *)
 				   (poid_par_priv->adapter_context);
-	uint status = RNDIS_STATUS_SUCCESS;
 
 	if (poid_par_priv->type_of_oid != SET_OID)
 		return RNDIS_STATUS_NOT_ACCEPTED;
 	if (mp_stop_test(Adapter) == _FAIL)
-		status = RNDIS_STATUS_NOT_ACCEPTED;
-	return status;
+		return RNDIS_STATUS_NOT_ACCEPTED;
+	return RNDIS_STATUS_SUCCESS;
 }
 
 uint oid_rt_pro_set_channel_direct_call_hdl(struct oid_par_priv
@@ -350,64 +349,58 @@ uint oid_rt_pro_set_tx_power_control_hdl(
 uint oid_rt_pro_query_tx_packet_sent_hdl(
 					struct oid_par_priv *poid_par_priv)
 {
-	uint status = RNDIS_STATUS_SUCCESS;
 	struct _adapter *Adapter = (struct _adapter *)
 				   (poid_par_priv->adapter_context);
 
-	if (poid_par_priv->type_of_oid != QUERY_OID) {
-		status = RNDIS_STATUS_NOT_ACCEPTED;
-		return status;
-	}
+	if (poid_par_priv->type_of_oid != QUERY_OID)
+		return RNDIS_STATUS_NOT_ACCEPTED;
+
 	if (poid_par_priv->information_buf_len == sizeof(u32)) {
 		*(u32 *)poid_par_priv->information_buf =
 					Adapter->mppriv.tx_pktcount;
 		*poid_par_priv->bytes_rw = poid_par_priv->information_buf_len;
 	} else {
-		status = RNDIS_STATUS_INVALID_LENGTH;
+		return RNDIS_STATUS_INVALID_LENGTH;
 	}
-	return status;
+	return RNDIS_STATUS_SUCCESS;
 }
 
 uint oid_rt_pro_query_rx_packet_received_hdl(
 					struct oid_par_priv *poid_par_priv)
 {
-	uint status = RNDIS_STATUS_SUCCESS;
 	struct _adapter *Adapter = (struct _adapter *)
 				   (poid_par_priv->adapter_context);
 
-	if (poid_par_priv->type_of_oid != QUERY_OID) {
-		status = RNDIS_STATUS_NOT_ACCEPTED;
-		return status;
-	}
+	if (poid_par_priv->type_of_oid != QUERY_OID)
+		return RNDIS_STATUS_NOT_ACCEPTED;
+
 	if (poid_par_priv->information_buf_len == sizeof(u32)) {
 		*(u32 *)poid_par_priv->information_buf =
 					Adapter->mppriv.rx_pktcount;
 		*poid_par_priv->bytes_rw = poid_par_priv->information_buf_len;
 	} else {
-		status = RNDIS_STATUS_INVALID_LENGTH;
+		return RNDIS_STATUS_INVALID_LENGTH;
 	}
-	return status;
+	return RNDIS_STATUS_SUCCESS;
 }
 
 uint oid_rt_pro_query_rx_packet_crc32_error_hdl(
 					struct oid_par_priv *poid_par_priv)
 {
-	uint status = RNDIS_STATUS_SUCCESS;
 	struct _adapter *Adapter = (struct _adapter *)
 				   (poid_par_priv->adapter_context);
 
-	if (poid_par_priv->type_of_oid != QUERY_OID) {
-		status = RNDIS_STATUS_NOT_ACCEPTED;
-		return status;
-	}
+	if (poid_par_priv->type_of_oid != QUERY_OID)
+		return RNDIS_STATUS_NOT_ACCEPTED;
+
 	if (poid_par_priv->information_buf_len == sizeof(u32)) {
 		*(u32 *)poid_par_priv->information_buf =
 					Adapter->mppriv.rx_crcerrpktcount;
 		*poid_par_priv->bytes_rw = poid_par_priv->information_buf_len;
 	} else {
-		status = RNDIS_STATUS_INVALID_LENGTH;
+		return RNDIS_STATUS_INVALID_LENGTH;
 	}
-	return status;
+	return RNDIS_STATUS_SUCCESS;
 }
 
 uint oid_rt_pro_reset_tx_packet_sent_hdl(struct oid_par_priv
@@ -425,7 +418,6 @@ uint oid_rt_pro_reset_tx_packet_sent_hdl(struct oid_par_priv
 uint oid_rt_pro_reset_rx_packet_received_hdl(struct oid_par_priv
 						    *poid_par_priv)
 {
-	uint status = RNDIS_STATUS_SUCCESS;
 	struct _adapter *Adapter = (struct _adapter *)
 				   (poid_par_priv->adapter_context);
 
@@ -435,9 +427,9 @@ uint oid_rt_pro_reset_rx_packet_received_hdl(struct oid_par_priv
 		Adapter->mppriv.rx_pktcount = 0;
 		Adapter->mppriv.rx_crcerrpktcount = 0;
 	} else {
-		status = RNDIS_STATUS_INVALID_LENGTH;
+		return RNDIS_STATUS_INVALID_LENGTH;
 	}
-	return status;
+	return RNDIS_STATUS_SUCCESS;
 }
 
 uint oid_rt_reset_phy_rx_packet_count_hdl(struct oid_par_priv
-- 
2.23.0

