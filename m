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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89059C4CECE
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 22:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60ADD21655
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 22:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEiTiwJM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbfJLWTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 18:19:49 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38797 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbfJLWTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 18:19:49 -0400
Received: by mail-pl1-f194.google.com with SMTP id w8so6176261plq.5
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2019 15:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cj3J1pEroaTR/ZsfEveu1P6fPFD8w3rJ9/qudwdU1EM=;
        b=QEiTiwJMzTqhEDJXM11vucrej9zVDOr2z4w0FDZVcWjqiEY6eV7X5w+QIyjC5VwwTt
         Bl3xx260mtlD2LEf5Mtq86A/e1Ni+KHB0FXrU5tbJKOxKcNVGleD23k1iehbSFTs+iVb
         MOQrOddqFXCo/kyqJKK/fjIVIeZX0R1WaoaWYtuEHOZmDb5e30t/rLFHomWynGjwXDl0
         m04eajvFJpP3aoj5XqiP181Uln2dWb49EOTpJbBCPp0ClWF7O+NhVnvuQJ0K8rLjmBln
         JY8mINbyrG3Go8IzKJIYWaEm75ktxkqT4q6fEr7KcvacoFeyqrHPd1kCXej7aZe8ea56
         sTQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cj3J1pEroaTR/ZsfEveu1P6fPFD8w3rJ9/qudwdU1EM=;
        b=MiTLOTOcmLN00dceV9ZhCkYXeWqXdOOgQBFiWBg4//4+9PoufyLmPYG6pOBHStTC2J
         2GKOXijVM6oN9Hh3VSz3WQSwbO0wF1sH8mMxCXN26PMe3ATqwVn3fBbK58JyYBCFovas
         KWODeiqDgxjFWyVCYDkYSVXaIZaWj2Fmz3pTLUiw8DACl02Ky16DfIJdM0IZQKkMl+pu
         iU6APA0rtZnBE2HSNfz7MqSTW5l+5V1fr24m7J9HkQ6tr02Vj4Xv6egWv31b03haEAcL
         IHPn3nyU130F1aIVvUwEZltsuDKF5em+iUOVy3aSwBREzIX88HKgnPIt5vsFFQ66rynY
         rSTg==
X-Gm-Message-State: APjAAAVQ42+YMmNLHtVXAuW8LYWns7VQWNpbJCD2vOlbvLXn8fNgBSt4
        9Z3kX6YrZukdpz+/l6Uzr64=
X-Google-Smtp-Source: APXvYqw6XsllW6/XCmJCJV3s870HzmIyUcZI3ccnAxuLC0z96nuQ0p8xsiZ90WLgOlSM3eXZaHwJGA==
X-Received: by 2002:a17:902:a985:: with SMTP id bh5mr21912231plb.184.1570918788530;
        Sat, 12 Oct 2019 15:19:48 -0700 (PDT)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id 30sm13839562pjk.25.2019.10.12.15.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2019 15:19:48 -0700 (PDT)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Larry.Finger@lwfinger.net,
        florian.c.schilhabel@googlemail.com
Subject: [PATCH 2/2] staging: rtl8712: clean up function headers
Date:   Sun, 13 Oct 2019 01:19:16 +0300
Message-Id: <c14b9e60b1e9bab635bc9527cbd2a2a07436ba44.1570918228.git.wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1570918228.git.wambui.karugax@gmail.com>
References: <cover.1570918228.git.wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary line-breaks in function headers to
improve readability of function headers.

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/staging/rtl8712/rtl871x_mp_ioctl.c | 57 ++++++++--------------
 1 file changed, 19 insertions(+), 38 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_mp_ioctl.c b/drivers/staging/rtl8712/rtl871x_mp_ioctl.c
index 8af7892809ca..29b85330815f 100644
--- a/drivers/staging/rtl8712/rtl871x_mp_ioctl.c
+++ b/drivers/staging/rtl8712/rtl871x_mp_ioctl.c
@@ -231,8 +231,7 @@ static int mp_stop_test(struct _adapter *padapter)
 	return _SUCCESS;
 }
 
-uint oid_rt_pro_set_data_rate_hdl(struct oid_par_priv
-					 *poid_par_priv)
+uint oid_rt_pro_set_data_rate_hdl(struct oid_par_priv *poid_par_priv)
 {
 	struct _adapter *Adapter = (struct _adapter *)
 				   (poid_par_priv->adapter_context);
@@ -291,8 +290,7 @@ uint oid_rt_pro_stop_test_hdl(struct oid_par_priv *poid_par_priv)
 	return RNDIS_STATUS_SUCCESS;
 }
 
-uint oid_rt_pro_set_channel_direct_call_hdl(struct oid_par_priv
-						   *poid_par_priv)
+uint oid_rt_pro_set_channel_direct_call_hdl(struct oid_par_priv *poid_par_priv)
 {
 	struct _adapter *Adapter = (struct _adapter *)
 				   (poid_par_priv->adapter_context);
@@ -327,8 +325,7 @@ uint oid_rt_pro_set_antenna_bb_hdl(struct oid_par_priv *poid_par_priv)
 	return RNDIS_STATUS_SUCCESS;
 }
 
-uint oid_rt_pro_set_tx_power_control_hdl(
-					struct oid_par_priv *poid_par_priv)
+uint oid_rt_pro_set_tx_power_control_hdl(struct oid_par_priv *poid_par_priv)
 {
 	struct _adapter *Adapter = (struct _adapter *)
 				   (poid_par_priv->adapter_context);
@@ -346,8 +343,7 @@ uint oid_rt_pro_set_tx_power_control_hdl(
 	return RNDIS_STATUS_SUCCESS;
 }
 
-uint oid_rt_pro_query_tx_packet_sent_hdl(
-					struct oid_par_priv *poid_par_priv)
+uint oid_rt_pro_query_tx_packet_sent_hdl(struct oid_par_priv *poid_par_priv)
 {
 	struct _adapter *Adapter = (struct _adapter *)
 				   (poid_par_priv->adapter_context);
@@ -365,8 +361,7 @@ uint oid_rt_pro_query_tx_packet_sent_hdl(
 	return RNDIS_STATUS_SUCCESS;
 }
 
-uint oid_rt_pro_query_rx_packet_received_hdl(
-					struct oid_par_priv *poid_par_priv)
+uint oid_rt_pro_query_rx_packet_received_hdl(struct oid_par_priv *poid_par_priv)
 {
 	struct _adapter *Adapter = (struct _adapter *)
 				   (poid_par_priv->adapter_context);
@@ -384,8 +379,7 @@ uint oid_rt_pro_query_rx_packet_received_hdl(
 	return RNDIS_STATUS_SUCCESS;
 }
 
-uint oid_rt_pro_query_rx_packet_crc32_error_hdl(
-					struct oid_par_priv *poid_par_priv)
+uint oid_rt_pro_query_rx_packet_crc32_error_hdl(struct oid_par_priv *poid_par_priv)
 {
 	struct _adapter *Adapter = (struct _adapter *)
 				   (poid_par_priv->adapter_context);
@@ -403,8 +397,7 @@ uint oid_rt_pro_query_rx_packet_crc32_error_hdl(
 	return RNDIS_STATUS_SUCCESS;
 }
 
-uint oid_rt_pro_reset_tx_packet_sent_hdl(struct oid_par_priv
-						*poid_par_priv)
+uint oid_rt_pro_reset_tx_packet_sent_hdl(struct oid_par_priv *poid_par_priv)
 {
 	struct _adapter *Adapter = (struct _adapter *)
 				   (poid_par_priv->adapter_context);
@@ -415,8 +408,7 @@ uint oid_rt_pro_reset_tx_packet_sent_hdl(struct oid_par_priv
 	return RNDIS_STATUS_SUCCESS;
 }
 
-uint oid_rt_pro_reset_rx_packet_received_hdl(struct oid_par_priv
-						    *poid_par_priv)
+uint oid_rt_pro_reset_rx_packet_received_hdl(struct oid_par_priv *poid_par_priv)
 {
 	struct _adapter *Adapter = (struct _adapter *)
 				   (poid_par_priv->adapter_context);
@@ -432,8 +424,7 @@ uint oid_rt_pro_reset_rx_packet_received_hdl(struct oid_par_priv
 	return RNDIS_STATUS_SUCCESS;
 }
 
-uint oid_rt_reset_phy_rx_packet_count_hdl(struct oid_par_priv
-						 *poid_par_priv)
+uint oid_rt_reset_phy_rx_packet_count_hdl(struct oid_par_priv *poid_par_priv)
 {
 	struct _adapter *Adapter = (struct _adapter *)
 				   (poid_par_priv->adapter_context);
@@ -444,8 +435,7 @@ uint oid_rt_reset_phy_rx_packet_count_hdl(struct oid_par_priv
 	return RNDIS_STATUS_SUCCESS;
 }
 
-uint oid_rt_get_phy_rx_packet_received_hdl(struct oid_par_priv
-						  *poid_par_priv)
+uint oid_rt_get_phy_rx_packet_received_hdl(struct oid_par_priv *poid_par_priv)
 {
 	struct _adapter *Adapter = (struct _adapter *)
 				   (poid_par_priv->adapter_context);
@@ -460,8 +450,7 @@ uint oid_rt_get_phy_rx_packet_received_hdl(struct oid_par_priv
 	return RNDIS_STATUS_SUCCESS;
 }
 
-uint oid_rt_get_phy_rx_packet_crc32_error_hdl(struct oid_par_priv
-						     *poid_par_priv)
+uint oid_rt_get_phy_rx_packet_crc32_error_hdl(struct oid_par_priv *poid_par_priv)
 {
 	struct _adapter *Adapter = (struct _adapter *)
 				   (poid_par_priv->adapter_context);
@@ -476,8 +465,7 @@ uint oid_rt_get_phy_rx_packet_crc32_error_hdl(struct oid_par_priv
 	return RNDIS_STATUS_SUCCESS;
 }
 
-uint oid_rt_pro_set_modulation_hdl(struct oid_par_priv
-					  *poid_par_priv)
+uint oid_rt_pro_set_modulation_hdl(struct oid_par_priv *poid_par_priv)
 {
 	struct _adapter *Adapter = (struct _adapter *)
 				   (poid_par_priv->adapter_context);
@@ -489,8 +477,7 @@ uint oid_rt_pro_set_modulation_hdl(struct oid_par_priv
 	return RNDIS_STATUS_SUCCESS;
 }
 
-uint oid_rt_pro_set_continuous_tx_hdl(struct oid_par_priv
-					     *poid_par_priv)
+uint oid_rt_pro_set_continuous_tx_hdl(struct oid_par_priv *poid_par_priv)
 {
 	struct _adapter *Adapter = (struct _adapter *)
 				   (poid_par_priv->adapter_context);
@@ -503,8 +490,7 @@ uint oid_rt_pro_set_continuous_tx_hdl(struct oid_par_priv
 	return RNDIS_STATUS_SUCCESS;
 }
 
-uint oid_rt_pro_set_single_carrier_tx_hdl(struct oid_par_priv
-						 *poid_par_priv)
+uint oid_rt_pro_set_single_carrier_tx_hdl(struct oid_par_priv *poid_par_priv)
 {
 	struct _adapter *Adapter = (struct _adapter *)
 				   (poid_par_priv->adapter_context);
@@ -517,8 +503,7 @@ uint oid_rt_pro_set_single_carrier_tx_hdl(struct oid_par_priv
 	return RNDIS_STATUS_SUCCESS;
 }
 
-uint oid_rt_pro_set_carrier_suppression_tx_hdl(struct oid_par_priv
-						      *poid_par_priv)
+uint oid_rt_pro_set_carrier_suppression_tx_hdl(struct oid_par_priv *poid_par_priv)
 {
 	struct _adapter *Adapter = (struct _adapter *)
 				   (poid_par_priv->adapter_context);
@@ -531,8 +516,7 @@ uint oid_rt_pro_set_carrier_suppression_tx_hdl(struct oid_par_priv
 	return RNDIS_STATUS_SUCCESS;
 }
 
-uint oid_rt_pro_set_single_tone_tx_hdl(struct oid_par_priv
-					      *poid_par_priv)
+uint oid_rt_pro_set_single_tone_tx_hdl(struct oid_par_priv *poid_par_priv)
 {
 	struct _adapter *Adapter = (struct _adapter *)
 				   (poid_par_priv->adapter_context);
@@ -545,8 +529,7 @@ uint oid_rt_pro_set_single_tone_tx_hdl(struct oid_par_priv
 	return RNDIS_STATUS_SUCCESS;
 }
 
-uint oid_rt_pro_read_register_hdl(struct oid_par_priv
-					 *poid_par_priv)
+uint oid_rt_pro_read_register_hdl(struct oid_par_priv *poid_par_priv)
 {
 	struct _adapter *Adapter = (struct _adapter *)
 				   (poid_par_priv->adapter_context);
@@ -727,8 +710,7 @@ uint oid_rt_pro_write_efuse_hdl(struct oid_par_priv *poid_par_priv)
 }
 /*----------------------------------------------------------------------*/
 
-uint oid_rt_get_efuse_current_size_hdl(struct oid_par_priv
-					      *poid_par_priv)
+uint oid_rt_get_efuse_current_size_hdl(struct oid_par_priv *poid_par_priv)
 {
 	struct _adapter *Adapter = (struct _adapter *)
 				   (poid_par_priv->adapter_context);
@@ -821,8 +803,7 @@ uint oid_rt_set_bandwidth_hdl(struct oid_par_priv *poid_par_priv)
 	return RNDIS_STATUS_SUCCESS;
 }
 
-uint oid_rt_set_rx_packet_type_hdl(struct oid_par_priv
-					   *poid_par_priv)
+uint oid_rt_set_rx_packet_type_hdl(struct oid_par_priv *poid_par_priv)
 {
 	struct _adapter *Adapter = (struct _adapter *)
 				   (poid_par_priv->adapter_context);
-- 
2.23.0

