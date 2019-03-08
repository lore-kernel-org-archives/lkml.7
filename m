Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A09BDC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72E6221019
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552049501;
	bh=IdHsUZiMazwry2KxSiATNJWfGNpVZ0nOHBAHhS73thA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wRuepCJjw8XFaIK1Y9Hy+3mKOel+4Ha758Im46+Aw997e8V8TcSOmOU4mjSYNfBJ6
	 MFWEvMAvYpRd2agSWijZMi9Dci8mZOwIOq2MOVatcTlBkK67orZ+W011wVK3Uw/V8+
	 c0Xhah6HAYegUNtzv31J6eZafT0ZPur/19pkru4I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfCHMvk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:51:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:54848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726764AbfCHMvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:51:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09B7321019;
        Fri,  8 Mar 2019 12:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552049496;
        bh=IdHsUZiMazwry2KxSiATNJWfGNpVZ0nOHBAHhS73thA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lFWvdLikxxzzVh/oBZLqVCWUiro5L7jhD6esgr7NMCBrfjGDzzYrsE02habH7bi2Q
         XmSCnPY00gJ/z9yPuG6DyzbvQsXDqAE/c0UeDnbvmCQjD/zPWUQG3SnUdtVQqz4Jft
         M5I7rBJeJD7oMGbzANuVpDdAx0SadrpX9s3k8Oqw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.0 20/46] net: dsa: mv8e6xxx: fix number of internal PHYs for 88E6x90 family
Date:   Fri,  8 Mar 2019 13:49:53 +0100
Message-Id: <20190308124903.558050430@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308124902.257040783@linuxfoundation.org>
References: <20190308124902.257040783@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heiner Kallweit <hkallweit1@gmail.com>

[ Upstream commit 95150f29ae480276e76368cdf8a9524b5a96c0ca ]

Ports 9 and 10 don't have internal PHY's but are (dependent on the
version) SERDES/SGMII/XAUI/RXAUI ports.

v2:
- fix it for all 88E6x90 family members

Fixes: bc3931557d1d ("net: dsa: mv88e6xxx: Add number of internal PHYs")
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/dsa/mv88e6xxx/chip.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -4222,7 +4222,7 @@ static const struct mv88e6xxx_info mv88e
 		.name = "Marvell 88E6190",
 		.num_databases = 4096,
 		.num_ports = 11,	/* 10 + Z80 */
-		.num_internal_phys = 11,
+		.num_internal_phys = 9,
 		.num_gpio = 16,
 		.max_vid = 8191,
 		.port_base_addr = 0x0,
@@ -4245,7 +4245,7 @@ static const struct mv88e6xxx_info mv88e
 		.name = "Marvell 88E6190X",
 		.num_databases = 4096,
 		.num_ports = 11,	/* 10 + Z80 */
-		.num_internal_phys = 11,
+		.num_internal_phys = 9,
 		.num_gpio = 16,
 		.max_vid = 8191,
 		.port_base_addr = 0x0,
@@ -4268,7 +4268,7 @@ static const struct mv88e6xxx_info mv88e
 		.name = "Marvell 88E6191",
 		.num_databases = 4096,
 		.num_ports = 11,	/* 10 + Z80 */
-		.num_internal_phys = 11,
+		.num_internal_phys = 9,
 		.max_vid = 8191,
 		.port_base_addr = 0x0,
 		.phy_base_addr = 0x0,
@@ -4315,7 +4315,7 @@ static const struct mv88e6xxx_info mv88e
 		.name = "Marvell 88E6290",
 		.num_databases = 4096,
 		.num_ports = 11,	/* 10 + Z80 */
-		.num_internal_phys = 11,
+		.num_internal_phys = 9,
 		.num_gpio = 16,
 		.max_vid = 8191,
 		.port_base_addr = 0x0,
@@ -4477,7 +4477,7 @@ static const struct mv88e6xxx_info mv88e
 		.name = "Marvell 88E6390",
 		.num_databases = 4096,
 		.num_ports = 11,	/* 10 + Z80 */
-		.num_internal_phys = 11,
+		.num_internal_phys = 9,
 		.num_gpio = 16,
 		.max_vid = 8191,
 		.port_base_addr = 0x0,
@@ -4500,7 +4500,7 @@ static const struct mv88e6xxx_info mv88e
 		.name = "Marvell 88E6390X",
 		.num_databases = 4096,
 		.num_ports = 11,	/* 10 + Z80 */
-		.num_internal_phys = 11,
+		.num_internal_phys = 9,
 		.num_gpio = 16,
 		.max_vid = 8191,
 		.port_base_addr = 0x0,


