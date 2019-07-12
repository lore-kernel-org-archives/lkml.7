Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA83C742BD
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 13:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B3AB20863
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 13:50:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbfGLNuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 09:50:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:57280 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726976AbfGLNuv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 09:50:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9B0F8AF47;
        Fri, 12 Jul 2019 13:50:50 +0000 (UTC)
Date:   Fri, 12 Jul 2019 15:50:49 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Krzysztof Halasa <khalasa@piap.pl>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] soc: ixp4xx: Really select helper drivers automatically
Message-ID: <20190712155049.09ecfaf5@endymion>
In-Reply-To: <20190712153722.3d1498be@endymion>
References: <20190712153722.3d1498be@endymion>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kconfig claims that the ixp4xx-qmgr and ixp4xx-npe helper drivers
are selected automatically as needed. However this is not what the
Kconfig entries are doing. Convert depends to select to match the
help texts.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Krzysztof Halasa <khalasa@piap.pl>
---
Sorry about the weird patch numbering, I found this issue right before
sending the other patch so I had to insert a new patch in the middle of
the series.

This should get tested on ixp4xx, I could only test on x86.

 drivers/net/ethernet/xscale/Kconfig |    7 ++++---
 drivers/net/wan/Kconfig             |    4 +++-
 2 files changed, 7 insertions(+), 4 deletions(-)

--- linux-5.2.orig/drivers/net/ethernet/xscale/Kconfig	2019-07-12 15:44:22.617698231 +0200
+++ linux-5.2/drivers/net/ethernet/xscale/Kconfig	2019-07-12 15:48:00.538938930 +0200
@@ -6,8 +6,7 @@
 config NET_VENDOR_XSCALE
 	bool "Intel XScale IXP devices"
 	default y
-	depends on NET_VENDOR_INTEL && (ARM && ARCH_IXP4XX && \
-		   IXP4XX_NPE && IXP4XX_QMGR)
+	depends on NET_VENDOR_INTEL && (ARM && ARCH_IXP4XX)
 	---help---
 	  If you have a network (Ethernet) card belonging to this class, say Y.
 
@@ -20,9 +19,11 @@ if NET_VENDOR_XSCALE
 
 config IXP4XX_ETH
 	tristate "Intel IXP4xx Ethernet support"
-	depends on ARM && ARCH_IXP4XX && IXP4XX_NPE && IXP4XX_QMGR
+	depends on ARM && ARCH_IXP4XX
 	select PHYLIB
 	select NET_PTP_CLASSIFY
+	select IXP4XX_NPE
+	select IXP4XX_QMGR
 	---help---
 	  Say Y here if you want to use built-in Ethernet ports
 	  on IXP4xx processor.
--- linux-5.2.orig/drivers/net/wan/Kconfig	2019-07-12 15:44:22.628698395 +0200
+++ linux-5.2/drivers/net/wan/Kconfig	2019-07-12 15:47:25.211414758 +0200
@@ -329,7 +329,9 @@ config DSCC4_PCI_RST
 
 config IXP4XX_HSS
 	tristate "Intel IXP4xx HSS (synchronous serial port) support"
-	depends on HDLC && ARM && ARCH_IXP4XX && IXP4XX_NPE && IXP4XX_QMGR
+	depends on HDLC && ARM && ARCH_IXP4XX
+	select IXP4XX_NPE
+	select IXP4XX_QMGR
 	help
 	  Say Y here if you want to use built-in HSS ports
 	  on IXP4xx processor.

-- 
Jean Delvare
SUSE L3 Support
