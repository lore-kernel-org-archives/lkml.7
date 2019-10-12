Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE1B8C4CECE
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 18:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93D022087E
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 18:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oO/2/jj1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729572AbfJLSF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 14:05:57 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43851 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728162AbfJLSF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 14:05:56 -0400
Received: by mail-pl1-f193.google.com with SMTP id f21so6003245plj.10
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2019 11:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W8TBrANdRshN+5yx0SA5yPFRIQNY5exzm8qSnlTsABE=;
        b=oO/2/jj1HnbagEmggvNbKwOI2Z7uZQfhq6544cr5FI6RBprZ8iC/KwgjfYp9CUiTy2
         hn8U/r2YfnPy0X/mDUMJgp1WBel7rjhZYXXs7zpef2gSpFVAymvYI2RvG6/f74K15gi7
         7fea6bpIymn98RIHPCtBVfI9XqGxuWSJ89/7Mc9MnmQh/N7sYyJj6IB9hnUpGvq8J2ge
         tY3EKuD22iSJSnPXtICE40p7afrlpanZOlhQxRPsP85clz/TCMColI/3g4k6B05ieYhF
         dEIU0i0Qj1YfVmtWUgw2A60zlK0E5trk6ryyeNWIdKeo8xoE2BJ3Q13xCQ9QplZaVt3x
         Yjpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W8TBrANdRshN+5yx0SA5yPFRIQNY5exzm8qSnlTsABE=;
        b=XvQoXH2yMqE+ty78LqlULaLw5/nue0KKLcgyZOyCphlBgR+IwdJaVXP667N4ZEJuJn
         1/Pg9pQp4R7HV7YXBqsIF4ZYhKgPMirP1+xPnfbYdb3XWWhdw61vBHDEqeCx2qZ2z/2H
         vJQDh3PYvDeZR8lvYoPFN3/iMbfhqvkMnOQwc9xGJoDcbsiF/vgCkCC5fB6yfzbkzzOD
         zDCb5AKQuTf//mjCNbL8wbGBv0jqrfoQQ2OaQR66guponNkoAUyZG6+XA2Towno2yYPj
         2t6x9Xp7sAle71EEzuPd5TtCbTL5uzyIA+EQJ388tn7gRjygGRf/JsJAF2ig8LHd5T8p
         Jmhg==
X-Gm-Message-State: APjAAAV9vNMlHCKlvGJ4TYuSaZLupLhTvk+Hgn4H//lGCU+JIn0v0Tbz
        kRHe9/80U2XHiZdaQw1qk+U=
X-Google-Smtp-Source: APXvYqxmEqPwJrNgh/aEzoTBiAOJMcr21592UdEv0huXprVWfGb1Ka/n+y71IhViBDA2/8FwN1lLBw==
X-Received: by 2002:a17:902:b08f:: with SMTP id p15mr20503594plr.229.1570903554758;
        Sat, 12 Oct 2019 11:05:54 -0700 (PDT)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id p17sm12183475pfn.50.2019.10.12.11.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2019 11:05:54 -0700 (PDT)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Wambui Karuga <wambui.karugax@gmail.com>
Subject: [PATCH v2 2/5] staging: octeon: remove typedef declaration for cvmx_helper_link_info
Date:   Sat, 12 Oct 2019 21:04:32 +0300
Message-Id: <fb373aed8fd2b04d01198f5a5769fd2476714e88.1570821661.git.wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1570821661.git.wambui.karugax@gmail.com>
References: <cover.1570821661.git.wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove declaration of union cvmx_helper_link_info as typedef.
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
index ffac0c4b3f5c..c798672d61b2 100644
--- a/drivers/staging/octeon/ethernet-mdio.c
+++ b/drivers/staging/octeon/ethernet-mdio.c
@@ -65,7 +65,7 @@ int cvm_oct_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 }
 
 void cvm_oct_note_carrier(struct octeon_ethernet *priv,
-			  cvmx_helper_link_info_t li)
+			  union cvmx_helper_link_info li)
 {
 	if (li.s.link_up) {
 		pr_notice_ratelimited("%s: %u Mbps %s duplex, port %d, queue %d\n",
@@ -81,7 +81,7 @@ void cvm_oct_note_carrier(struct octeon_ethernet *priv,
 void cvm_oct_adjust_link(struct net_device *dev)
 {
 	struct octeon_ethernet *priv = netdev_priv(dev);
-	cvmx_helper_link_info_t link_info;
+	union cvmx_helper_link_info link_info;
 
 	link_info.u64		= 0;
 	link_info.s.link_up	= dev->phydev->link ? 1 : 0;
@@ -106,7 +106,7 @@ int cvm_oct_common_stop(struct net_device *dev)
 {
 	struct octeon_ethernet *priv = netdev_priv(dev);
 	int interface = INTERFACE(priv->port);
-	cvmx_helper_link_info_t link_info;
+	union cvmx_helper_link_info link_info;
 	union cvmx_gmxx_prtx_cfg gmx_cfg;
 	int index = INDEX(priv->port);
 
diff --git a/drivers/staging/octeon/ethernet-rgmii.c b/drivers/staging/octeon/ethernet-rgmii.c
index d91fd5ce9e68..0c4fac31540a 100644
--- a/drivers/staging/octeon/ethernet-rgmii.c
+++ b/drivers/staging/octeon/ethernet-rgmii.c
@@ -53,7 +53,7 @@ static void cvm_oct_set_hw_preamble(struct octeon_ethernet *priv, bool enable)
 static void cvm_oct_check_preamble_errors(struct net_device *dev)
 {
 	struct octeon_ethernet *priv = netdev_priv(dev);
-	cvmx_helper_link_info_t link_info;
+	union cvmx_helper_link_info link_info;
 	unsigned long flags;
 
 	link_info.u64 = priv->link_info;
@@ -103,7 +103,7 @@ static void cvm_oct_check_preamble_errors(struct net_device *dev)
 static void cvm_oct_rgmii_poll(struct net_device *dev)
 {
 	struct octeon_ethernet *priv = netdev_priv(dev);
-	cvmx_helper_link_info_t link_info;
+	union cvmx_helper_link_info link_info;
 	bool status_change;
 
 	link_info = cvmx_helper_link_get(priv->port);
diff --git a/drivers/staging/octeon/ethernet.c b/drivers/staging/octeon/ethernet.c
index f892f1ad4638..f42c3816ce49 100644
--- a/drivers/staging/octeon/ethernet.c
+++ b/drivers/staging/octeon/ethernet.c
@@ -460,7 +460,7 @@ int cvm_oct_common_open(struct net_device *dev,
 	struct octeon_ethernet *priv = netdev_priv(dev);
 	int interface = INTERFACE(priv->port);
 	int index = INDEX(priv->port);
-	cvmx_helper_link_info_t link_info;
+	union cvmx_helper_link_info link_info;
 	int rv;
 
 	rv = cvm_oct_phy_setup_device(dev);
@@ -496,7 +496,7 @@ int cvm_oct_common_open(struct net_device *dev,
 void cvm_oct_link_poll(struct net_device *dev)
 {
 	struct octeon_ethernet *priv = netdev_priv(dev);
-	cvmx_helper_link_info_t link_info;
+	union cvmx_helper_link_info link_info;
 
 	link_info = cvmx_helper_link_get(priv->port);
 	if (link_info.u64 == priv->link_info)
diff --git a/drivers/staging/octeon/octeon-ethernet.h b/drivers/staging/octeon/octeon-ethernet.h
index 042220d86d33..a6140705706f 100644
--- a/drivers/staging/octeon/octeon-ethernet.h
+++ b/drivers/staging/octeon/octeon-ethernet.h
@@ -91,7 +91,7 @@ int cvm_oct_common_stop(struct net_device *dev);
 int cvm_oct_common_open(struct net_device *dev,
 			void (*link_poll)(struct net_device *));
 void cvm_oct_note_carrier(struct octeon_ethernet *priv,
-			  cvmx_helper_link_info_t li);
+			  union cvmx_helper_link_info li);
 void cvm_oct_link_poll(struct net_device *dev);
 
 extern int always_use_pow;
diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
index 7c29cfbd55d1..0991be329139 100644
--- a/drivers/staging/octeon/octeon-stubs.h
+++ b/drivers/staging/octeon/octeon-stubs.h
@@ -191,7 +191,7 @@ struct cvmx_wqe {
 	uint8_t packet_data[96];
 };
 
-typedef union {
+union cvmx_helper_link_info {
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
+static inline union cvmx_helper_link_info cvmx_helper_link_get(int ipd_port)
 {
-	cvmx_helper_link_info_t ret = { .u64 = 0 };
+	union cvmx_helper_link_info ret = { .u64 = 0 };
 
 	return ret;
 }
 
 static inline int cvmx_helper_link_set(int ipd_port,
-				cvmx_helper_link_info_t link_info)
+				       union cvmx_helper_link_info link_info)
 {
 	return 0;
 }
-- 
2.23.0

