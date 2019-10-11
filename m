Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5EAC47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 06:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96CD52196E
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 06:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qRw947YL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbfJKGD1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 02:03:27 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40082 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbfJKGDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 02:03:19 -0400
Received: by mail-pg1-f193.google.com with SMTP id d26so5144622pgl.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 23:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qz3Pn3iXTIAiE5Vxrx22/mL18yJZNqUc+hQQr9LyuGk=;
        b=qRw947YLIcc9aPdljmXnyA/xH0POdjYEa92ZTsYn+nL5Xdk2MjpmQIMKvPT+Fk8PNT
         CNoQPCcCnEkBxcZlxSeGajPaVjv8ive0kdMZN1tZhV5xmpbZbdnrruqT70ceWXUsNjEH
         tVPp++edETPFa5n7v/TL2CRj11yWwyTWoUMQS1Mg2lfcxByj5xKSlb2xNCivzshc/F2z
         vdEk1+Pup1096N721pH2WV7vA+B4OQgGF4q8StprvbbbSUsPWl6hSLUy0L3Qn6bYiaWp
         3/nYTzz9v2MpWYcIdbnyavV6lyeX2W0QMecnG8E+wxFwXH7F2XW8FX6G352oXeYOz8QH
         WGgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qz3Pn3iXTIAiE5Vxrx22/mL18yJZNqUc+hQQr9LyuGk=;
        b=lbNdjMtWHKClYIGDC11Gm2JPyhSoW94XEZUCe8yM2TP3zvRCWudthcvOTyrRwZX+23
         DCg5XZ4c1g+OG6fo65PhCT6llD9Hu7g5iQPQyCFPSkgxi//wkfMaWpHHx5ijSKia01zm
         K0MqN2qINEyc813CEuaFm3P7Mlo4fa+ByOMazBvgVdFkVvwCqgQ+GbolG8KcAkWB/rLn
         Hy/leGnE8cf290cf5h3RyVLA9vH7Ktq5zB5BnowJMrJUtDKDfVXjMpML2/SviCQ1vHN1
         dBVM6DhOKQDmKi9CqJcAaEZ0NNRMtGkTjWeUyznW0F5/zpmFzR7c8JslnsM//PRGaV/e
         uW8A==
X-Gm-Message-State: APjAAAXyXvx1LtYDQzdqr9yrcyPczyTZL6qtoSWM42U706CF6pzDrJa6
        HBuBKwGuynqM0bRk7bg5Pe0=
X-Google-Smtp-Source: APXvYqwyzKMM75Cft1OKVW9Jt6akVe0ytXSGjl13uwCrlJOem0eKVsftuj36yrTACVJiv/+7Y/ISWw==
X-Received: by 2002:a17:90a:de14:: with SMTP id m20mr15695383pjv.10.1570773798627;
        Thu, 10 Oct 2019 23:03:18 -0700 (PDT)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id p11sm9395715pgb.1.2019.10.10.23.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 23:03:17 -0700 (PDT)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Wambui Karuga <wambui.karugax@gmail.com>
Subject: [PATCH 2/5] staging: octeon: remove typedef declaration for cvmx_helper_link_info_t
Date:   Fri, 11 Oct 2019 09:02:39 +0300
Message-Id: <78e2c3a4089261e416e9b890cdf81ef029966b75.1570773209.git.wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1570773209.git.wambui.karugax@gmail.com>
References: <cover.1570773209.git.wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove declaration of union cvmx_helper_link_info_t as typedef in
drivers/staging/octeon/octeon-stubs.h.
Also replace its previous uses with new union declaration.
Issue found by checkpatch.pl

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/staging/octeon/ethernet-mdio.c   |  6 +++---
 drivers/staging/octeon/ethernet-rgmii.c  |  4 ++--
 drivers/staging/octeon/ethernet.c        |  4 ++--
 drivers/staging/octeon/octeon-ethernet.h |  2 +-
 drivers/staging/octeon/octeon-stubs.h    | 10 +++++-----
 5 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/octeon/ethernet-mdio.c b/drivers/staging/octeon/ethernet-mdio.c
index ffac0c4b3f5c..847081549373 100644
--- a/drivers/staging/octeon/ethernet-mdio.c
+++ b/drivers/staging/octeon/ethernet-mdio.c
@@ -65,7 +65,7 @@ int cvm_oct_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 }
 
 void cvm_oct_note_carrier(struct octeon_ethernet *priv,
-			  cvmx_helper_link_info_t li)
+			  union cvmx_helper_link_info_t li)
 {
 	if (li.s.link_up) {
 		pr_notice_ratelimited("%s: %u Mbps %s duplex, port %d, queue %d\n",
@@ -81,7 +81,7 @@ void cvm_oct_note_carrier(struct octeon_ethernet *priv,
 void cvm_oct_adjust_link(struct net_device *dev)
 {
 	struct octeon_ethernet *priv = netdev_priv(dev);
-	cvmx_helper_link_info_t link_info;
+	union cvmx_helper_link_info_t link_info;
 
 	link_info.u64		= 0;
 	link_info.s.link_up	= dev->phydev->link ? 1 : 0;
@@ -106,7 +106,7 @@ int cvm_oct_common_stop(struct net_device *dev)
 {
 	struct octeon_ethernet *priv = netdev_priv(dev);
 	int interface = INTERFACE(priv->port);
-	cvmx_helper_link_info_t link_info;
+	union cvmx_helper_link_info_t link_info;
 	union cvmx_gmxx_prtx_cfg gmx_cfg;
 	int index = INDEX(priv->port);
 
diff --git a/drivers/staging/octeon/ethernet-rgmii.c b/drivers/staging/octeon/ethernet-rgmii.c
index d91fd5ce9e68..f815be830ce0 100644
--- a/drivers/staging/octeon/ethernet-rgmii.c
+++ b/drivers/staging/octeon/ethernet-rgmii.c
@@ -53,7 +53,7 @@ static void cvm_oct_set_hw_preamble(struct octeon_ethernet *priv, bool enable)
 static void cvm_oct_check_preamble_errors(struct net_device *dev)
 {
 	struct octeon_ethernet *priv = netdev_priv(dev);
-	cvmx_helper_link_info_t link_info;
+	union cvmx_helper_link_info_t link_info;
 	unsigned long flags;
 
 	link_info.u64 = priv->link_info;
@@ -103,7 +103,7 @@ static void cvm_oct_check_preamble_errors(struct net_device *dev)
 static void cvm_oct_rgmii_poll(struct net_device *dev)
 {
 	struct octeon_ethernet *priv = netdev_priv(dev);
-	cvmx_helper_link_info_t link_info;
+	union cvmx_helper_link_info_t link_info;
 	bool status_change;
 
 	link_info = cvmx_helper_link_get(priv->port);
diff --git a/drivers/staging/octeon/ethernet.c b/drivers/staging/octeon/ethernet.c
index 3de209b7d0ec..1f7a7ebe1a60 100644
--- a/drivers/staging/octeon/ethernet.c
+++ b/drivers/staging/octeon/ethernet.c
@@ -460,7 +460,7 @@ int cvm_oct_common_open(struct net_device *dev,
 	struct octeon_ethernet *priv = netdev_priv(dev);
 	int interface = INTERFACE(priv->port);
 	int index = INDEX(priv->port);
-	cvmx_helper_link_info_t link_info;
+	union cvmx_helper_link_info_t link_info;
 	int rv;
 
 	rv = cvm_oct_phy_setup_device(dev);
@@ -496,7 +496,7 @@ int cvm_oct_common_open(struct net_device *dev,
 void cvm_oct_link_poll(struct net_device *dev)
 {
 	struct octeon_ethernet *priv = netdev_priv(dev);
-	cvmx_helper_link_info_t link_info;
+	union cvmx_helper_link_info_t link_info;
 
 	link_info = cvmx_helper_link_get(priv->port);
 	if (link_info.u64 == priv->link_info)
diff --git a/drivers/staging/octeon/octeon-ethernet.h b/drivers/staging/octeon/octeon-ethernet.h
index 042220d86d33..5a0d754b0c70 100644
--- a/drivers/staging/octeon/octeon-ethernet.h
+++ b/drivers/staging/octeon/octeon-ethernet.h
@@ -91,7 +91,7 @@ int cvm_oct_common_stop(struct net_device *dev);
 int cvm_oct_common_open(struct net_device *dev,
 			void (*link_poll)(struct net_device *));
 void cvm_oct_note_carrier(struct octeon_ethernet *priv,
-			  cvmx_helper_link_info_t li);
+			  union cvmx_helper_link_info_t li);
 void cvm_oct_link_poll(struct net_device *dev);
 
 extern int always_use_pow;
diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
index fd7522f70f7e..78f42597cee5 100644
--- a/drivers/staging/octeon/octeon-stubs.h
+++ b/drivers/staging/octeon/octeon-stubs.h
@@ -191,7 +191,7 @@ struct cvmx_wqe_t {
 	uint8_t packet_data[96];
 };
 
-typedef union {
+union cvmx_helper_link_info_t {
 	uint64_t u64;
 	struct {
 		uint64_t reserved_20_63:44;
@@ -199,7 +199,7 @@ typedef union {
 		uint64_t full_duplex:1;	    /**< 1 if the link is full duplex */
 		uint64_t speed:18;	    /**< Speed of the link in Mbps */
 	} s;
-} cvmx_helper_link_info_t;
+};
 
 typedef enum {
 	CVMX_FAU_REG_32_START	= 0,
@@ -1267,15 +1267,15 @@ static inline cvmx_helper_interface_mode_t cvmx_helper_interface_get_mode(int
 	return 0;
 }
 
-static inline cvmx_helper_link_info_t cvmx_helper_link_get(int ipd_port)
+static inline union cvmx_helper_link_info_t cvmx_helper_link_get(int ipd_port)
 {
-	cvmx_helper_link_info_t ret = { .u64 = 0 };
+	union cvmx_helper_link_info_t ret = { .u64 = 0 };
 
 	return ret;
 }
 
 static inline int cvmx_helper_link_set(int ipd_port,
-				cvmx_helper_link_info_t link_info)
+				       union cvmx_helper_link_info_t link_info)
 {
 	return 0;
 }
-- 
2.23.0

