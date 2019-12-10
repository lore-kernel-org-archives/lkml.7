Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50CAC00454
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 18:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A583206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 18:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpsxisJs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbfLJSzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 13:55:16 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42276 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727349AbfLJSzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 13:55:15 -0500
Received: by mail-wr1-f68.google.com with SMTP id a15so21296553wrf.9;
        Tue, 10 Dec 2019 10:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YldZpwx0BEg1l1afKUNAOrjzufMRPQHEPvlq5z7gtSQ=;
        b=DpsxisJs9WoutsvN/4yVLqzS3YOnaiAFLcQuaC1zHUO+TS1CBJmCvmbsX5SrnvoL1E
         19gkFVbWbV+buk9a9RypVkZKJl2VfZ2Nqy9+Q9ITOnsHCFqbpuYCI0DowiT3illhekJZ
         w8dB+FRgm6F2FyoXdIBkw1GyMWMIAJlVcapuFf0YaYWM2HpUwyg4Hoh0e5K3VmHvlNNR
         hw4P0LcZC0GZnGfaJPS5hVjFrdZF/O3l5Guku2mQTtYW1SPq6Gos66USc/pDN3ZkA3/4
         7AV/kKnwK0tfpdI2hfp5PVPmR8JSo0IU56TXMZ0J8eQl0tDOA5oAsD8k0R7KnHKqtzZj
         R/JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YldZpwx0BEg1l1afKUNAOrjzufMRPQHEPvlq5z7gtSQ=;
        b=jAvo1Y9rHDfz9+/IF1ts0zDvkMMfNb2pA6LAGSCH3dzKHE1sVxJBgymQCEWHp+gN0m
         +F72QDuiOBNlutxSCsw9nEZECXSOB7yw+nY2e/4HBuNUHP+LMdRVh8o9jV+O1hs4kNmE
         ShIN5s9E09qbTM+ekhDBbB8PGgKTg/Ko1ARRdATkSCi7/XltxeLS8f8M31MYEol+ldY3
         XW6/VCGtjj4Rd8kiYTzbgDiaa2ui+1xQyagHD8zvp53Q2pGWMYoKx2+FVre8wzAE3NeK
         Zkci1d3OSkohONasP7xUw+FyvlFYrLS1NarVqHxyF3+vBTNQYhM2dMwNuQMwXGDxS+Wt
         B0HQ==
X-Gm-Message-State: APjAAAXYi+NjQZ5CCa1vzIon9P1IBEpOQOW0CqGangroRT++K4BMA3Mk
        veL/RlCJuDCkJcMTAThQxmR03nhf
X-Google-Smtp-Source: APXvYqzI9wwiV/mfdwPygGngDFZHNIJkn/qlgj1xT6slcO/hmq5lLQjYF6UOaSEqrsMgnYD0eks0Gw==
X-Received: by 2002:a5d:52c4:: with SMTP id r4mr4718432wrv.368.1576004113041;
        Tue, 10 Dec 2019 10:55:13 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id e6sm4213536wru.44.2019.12.10.10.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 10:55:12 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Tejun Heo <tj@kernel.org>, Jaedon Shin <jaedon.shin@gmail.com>,
        linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and
        Parallel ATA drivers)),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH 1/8] ata: libahci_platform: Export again ahci_platform_<en/dis>able_phys()
Date:   Tue, 10 Dec 2019 10:53:44 -0800
Message-Id: <20191210185351.14825-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191210185351.14825-1-f.fainelli@gmail.com>
References: <20191210185351.14825-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 6bb86fefa086faba7b60bb452300b76a47cde1a5
("libahci_platform: Staticize ahci_platform_<en/dis>able_phys()") we are
going to need ahci_platform_{enable,disable}_phys() in a subsequent
commit for ahci_brcm.c in order to properly control the PHY
initialization order.

Also make sure the function prototypes are declared in
include/linux/ahci_platform.h as a result.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/ata/libahci_platform.c | 6 ++++--
 include/linux/ahci_platform.h  | 2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index 8befce036af8..129556fcf6be 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -43,7 +43,7 @@ EXPORT_SYMBOL_GPL(ahci_platform_ops);
  * RETURNS:
  * 0 on success otherwise a negative error code
  */
-static int ahci_platform_enable_phys(struct ahci_host_priv *hpriv)
+int ahci_platform_enable_phys(struct ahci_host_priv *hpriv)
 {
 	int rc, i;
 
@@ -74,6 +74,7 @@ static int ahci_platform_enable_phys(struct ahci_host_priv *hpriv)
 	}
 	return rc;
 }
+EXPORT_SYMBOL_GPL(ahci_platform_enable_phys);
 
 /**
  * ahci_platform_disable_phys - Disable PHYs
@@ -81,7 +82,7 @@ static int ahci_platform_enable_phys(struct ahci_host_priv *hpriv)
  *
  * This function disables all PHYs found in hpriv->phys.
  */
-static void ahci_platform_disable_phys(struct ahci_host_priv *hpriv)
+void ahci_platform_disable_phys(struct ahci_host_priv *hpriv)
 {
 	int i;
 
@@ -90,6 +91,7 @@ static void ahci_platform_disable_phys(struct ahci_host_priv *hpriv)
 		phy_exit(hpriv->phys[i]);
 	}
 }
+EXPORT_SYMBOL_GPL(ahci_platform_disable_phys);
 
 /**
  * ahci_platform_enable_clks - Enable platform clocks
diff --git a/include/linux/ahci_platform.h b/include/linux/ahci_platform.h
index 6782f0d45ebe..49e5383d4222 100644
--- a/include/linux/ahci_platform.h
+++ b/include/linux/ahci_platform.h
@@ -19,6 +19,8 @@ struct ahci_host_priv;
 struct platform_device;
 struct scsi_host_template;
 
+int ahci_platform_enable_phys(struct ahci_host_priv *hpriv);
+void ahci_platform_disable_phys(struct ahci_host_priv *hpriv);
 int ahci_platform_enable_clks(struct ahci_host_priv *hpriv);
 void ahci_platform_disable_clks(struct ahci_host_priv *hpriv);
 int ahci_platform_enable_regulators(struct ahci_host_priv *hpriv);
-- 
2.17.1

