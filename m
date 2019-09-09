Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A040C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 20:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 192FE20674
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 20:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405988AbfIIUT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 16:19:28 -0400
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:32654 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405970AbfIIUT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 16:19:27 -0400
Received: from localhost.localdomain ([90.126.97.183])
        by mwinf5d12 with ME
        id zYKM2000H3xPcdm03YKMxP; Mon, 09 Sep 2019 22:19:24 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 09 Sep 2019 22:19:24 +0200
X-ME-IP: 90.126.97.183
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     will@kernel.org, robin.murphy@arm.com, joro@8bytes.org
Cc:     linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] iommu/io-pgtable: Move some initialization data to .init.rodata
Date:   Mon,  9 Sep 2019 22:19:19 +0200
Message-Id: <20190909201919.5841-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The memory used by '__init' functions can be freed once the initialization
phase has been performed.

Mark some 'static const' array defined and used within some '__init'
functions as '__initconst', so that the corresponding data can also be
discarded.

Without '__initconst', the data are put in the .rodata section.
With the qualifier, they are put in the .init.rodata section.

With gcc 8.3.0, the following changes have been measured:

Without '__initconst':
   section      size
  .rodata       00000720
  .init.rodata  00000018

With '__initconst':
   section      size
  .rodata       00000660
  .init.rodata  00000058

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Adding __initconst "within" a function is not in line with kernel/include/init.h
which states that:
 * Don't forget to initialize data not at file scope, i.e. within a function,
 * as gcc otherwise puts the data into the bss section and not into the init
 * section.
However, having the array within the function or out-side the function
seems to have no impact in the generated code and in the section used.
According to my test, both put the data in .init.rodata.

Maybe the comment is outdated or related to some older vesion of gcc.
---
 drivers/iommu/io-pgtable-arm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 161a7d56264d..24076f0560c6 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -1109,7 +1109,7 @@ static void __init arm_lpae_dump_ops(struct io_pgtable_ops *ops)
 
 static int __init arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
 {
-	static const enum io_pgtable_fmt fmts[] = {
+	static const enum io_pgtable_fmt fmts[] __initconst = {
 		ARM_64_LPAE_S1,
 		ARM_64_LPAE_S2,
 	};
@@ -1208,13 +1208,13 @@ static int __init arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
 
 static int __init arm_lpae_do_selftests(void)
 {
-	static const unsigned long pgsize[] = {
+	static const unsigned long pgsize[] __initconst = {
 		SZ_4K | SZ_2M | SZ_1G,
 		SZ_16K | SZ_32M,
 		SZ_64K | SZ_512M,
 	};
 
-	static const unsigned int ias[] = {
+	static const unsigned int ias[] __initconst = {
 		32, 36, 40, 42, 44, 48,
 	};
 
-- 
2.20.1

