Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4793FC2BD09
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D907205ED
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575483871;
	bh=PEHjJTX3goR5S8NOTB+zfkPx9jqMQFf45kBx9Ncjojk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c7Egwq5ZKH8fLOqL2mvNK+An1JP9oKXGC5sJYridGjIFGBz2DMUOxcBPS9Xh9lgrr
	 cT9eChkzx/ob4YG7XxQ31h65v+DnzAGJcx+dbCstzCV+lIfYQ45b6ykKV1xvTLoIoO
	 G7pz8TXNJwI4Nwhl7ikAO84CyFP6Ge1Wnpu+H1qg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729820AbfLDSCV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:02:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:43918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729796AbfLDSCM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:02:12 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19BB720659;
        Wed,  4 Dec 2019 18:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575482532;
        bh=PEHjJTX3goR5S8NOTB+zfkPx9jqMQFf45kBx9Ncjojk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LWr8uXDSfRYyCOx6O9vT6M3T3KJaw/67uxo2M/lKS2q5IgG/clMNFC70SDAJElWfB
         mzfMxGz3f/WtUisuTsre0at5Jz5uLXBZlE8MJu9iMjk/Ff7D0DXuntcex31lYng19v
         kGpmvFHNKoSXRyGCQiyC3ADewU8mWB3bjuk2Kayw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 033/209] ARM: debug-imx: only define DEBUG_IMX_UART_PORT if needed
Date:   Wed,  4 Dec 2019 18:54:05 +0100
Message-Id: <20191204175323.746447116@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204175321.609072813@linuxfoundation.org>
References: <20191204175321.609072813@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit 7c41ea57beb2aee96fa63091a457b1a2826f3c42 ]

If debugging on i.MX is enabled DEBUG_IMX_UART_PORT defines which UART
is used for the debug output. If however debugging is off don't only
hide the then unused config item but drop it completely by using a
dependency instead of a conditional prompt.

This fixes DEBUG_IMX_UART_PORT being present in the kernel config even
if DEBUG_LL is disabled.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/Kconfig.debug | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 954ba8b810521..fd4b679945d3a 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1376,21 +1376,21 @@ config DEBUG_OMAP2PLUS_UART
 	depends on ARCH_OMAP2PLUS
 
 config DEBUG_IMX_UART_PORT
-	int "i.MX Debug UART Port Selection" if DEBUG_IMX1_UART || \
-						DEBUG_IMX25_UART || \
-						DEBUG_IMX21_IMX27_UART || \
-						DEBUG_IMX31_UART || \
-						DEBUG_IMX35_UART || \
-						DEBUG_IMX50_UART || \
-						DEBUG_IMX51_UART || \
-						DEBUG_IMX53_UART || \
-						DEBUG_IMX6Q_UART || \
-						DEBUG_IMX6SL_UART || \
-						DEBUG_IMX6SX_UART || \
-						DEBUG_IMX6UL_UART || \
-						DEBUG_IMX7D_UART
+	int "i.MX Debug UART Port Selection"
+	depends on DEBUG_IMX1_UART || \
+		   DEBUG_IMX25_UART || \
+		   DEBUG_IMX21_IMX27_UART || \
+		   DEBUG_IMX31_UART || \
+		   DEBUG_IMX35_UART || \
+		   DEBUG_IMX50_UART || \
+		   DEBUG_IMX51_UART || \
+		   DEBUG_IMX53_UART || \
+		   DEBUG_IMX6Q_UART || \
+		   DEBUG_IMX6SL_UART || \
+		   DEBUG_IMX6SX_UART || \
+		   DEBUG_IMX6UL_UART || \
+		   DEBUG_IMX7D_UART
 	default 1
-	depends on ARCH_MXC
 	help
 	  Choose UART port on which kernel low-level debug messages
 	  should be output.
-- 
2.20.1



