Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A5DC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 11:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9710208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 11:16:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729440AbfEMLQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 07:16:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:49324 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729433AbfEMLQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 07:16:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 19A45AD7C;
        Mon, 13 May 2019 11:16:19 +0000 (UTC)
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: SGI-IP22: provide missing dma_mask/coherent_dma_mask
Date:   Mon, 13 May 2019 13:16:08 +0200
Message-Id: <20190513111609.14855-1-tbogendoerfer@suse.de>
X-Mailer: git-send-email 2.13.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set dma_masks for SGIWD93 and SGISEEQ otherwise DMA allocations fails
and causes not working SCSI/ethernet.

Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
---
 arch/mips/sgi-ip22/ip22-platform.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/mips/sgi-ip22/ip22-platform.c b/arch/mips/sgi-ip22/ip22-platform.c
index 37ad26716579..0b2002e02a47 100644
--- a/arch/mips/sgi-ip22/ip22-platform.c
+++ b/arch/mips/sgi-ip22/ip22-platform.c
@@ -3,6 +3,7 @@
 #include <linux/if_ether.h>
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
+#include <linux/dma-mapping.h>
 
 #include <asm/paccess.h>
 #include <asm/sgi/ip22.h>
@@ -25,6 +26,8 @@ static struct sgiwd93_platform_data sgiwd93_0_pd = {
 	.irq	= SGI_WD93_0_IRQ,
 };
 
+static u64 sgiwd93_0_dma_mask = DMA_BIT_MASK(32);
+
 static struct platform_device sgiwd93_0_device = {
 	.name		= "sgiwd93",
 	.id		= 0,
@@ -32,6 +35,8 @@ static struct platform_device sgiwd93_0_device = {
 	.resource	= sgiwd93_0_resources,
 	.dev = {
 		.platform_data = &sgiwd93_0_pd,
+		.dma_mask = &sgiwd93_0_dma_mask,
+		.coherent_dma_mask = DMA_BIT_MASK(32),
 	},
 };
 
@@ -49,6 +54,8 @@ static struct sgiwd93_platform_data sgiwd93_1_pd = {
 	.irq	= SGI_WD93_1_IRQ,
 };
 
+static u64 sgiwd93_1_dma_mask = DMA_BIT_MASK(32);
+
 static struct platform_device sgiwd93_1_device = {
 	.name		= "sgiwd93",
 	.id		= 1,
@@ -56,6 +63,8 @@ static struct platform_device sgiwd93_1_device = {
 	.resource	= sgiwd93_1_resources,
 	.dev = {
 		.platform_data = &sgiwd93_1_pd,
+		.dma_mask = &sgiwd93_1_dma_mask,
+		.coherent_dma_mask = DMA_BIT_MASK(32),
 	},
 };
 
@@ -96,6 +105,8 @@ static struct resource sgiseeq_0_resources[] = {
 
 static struct sgiseeq_platform_data eth0_pd;
 
+static u64 sgiseeq_dma_mask = DMA_BIT_MASK(32);
+
 static struct platform_device eth0_device = {
 	.name		= "sgiseeq",
 	.id		= 0,
@@ -103,6 +114,8 @@ static struct platform_device eth0_device = {
 	.resource	= sgiseeq_0_resources,
 	.dev = {
 		.platform_data = &eth0_pd,
+		.dma_mask = &sgiseeq_dma_mask,
+		.coherent_dma_mask = DMA_BIT_MASK(32),
 	},
 };
 
-- 
2.13.7

