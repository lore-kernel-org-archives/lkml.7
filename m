Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C1EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B7572183E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553260543;
	bh=qEAqvr0SQNvC6fO1rGm94tbT/YdfP85kJGoyb1JbFaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i+4kWRuCFTZUaW/ATI48RyYlwhE6AsxvuomRnaXQlzCMsSch8f0yl33YZmvf6bh9i
	 cKk1trCpYxqUFRyws9fNQUsFWeg6OFUu9syF4J5U2jH3Q2vfFZ0BOrFH78YYR6mbnl
	 ppfKVOVbJKnvY0GUrAe6O+x62/6yDUgTuL4WNxHI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729596AbfCVL1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:27:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:55514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729013AbfCVL1s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:27:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EFAB2183E;
        Fri, 22 Mar 2019 11:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254067;
        bh=qEAqvr0SQNvC6fO1rGm94tbT/YdfP85kJGoyb1JbFaE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SnxKo1mpRGwBsdBNPjT/r3SBazciYZDh3ACdhjIsVD0fH+2S2+CK66Ro/BzuTvsUd
         BfsXyw3dK1WlD+jUIlypT7+C2lf2v2JfZGTGyH39r3SnNXzrRDEZR5fRjEGptdNotD
         pqxnykwlhxNK71dfizRjUOJuNhvGo/aARE4+YosI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 006/230] mfd: db8500-prcmu: Fix some section annotations
Date:   Fri, 22 Mar 2019 12:12:24 +0100
Message-Id: <20190322111237.207297606@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit a3888f62fe66429fad3be7f2ba962e1e08c26fd6 ]

When building the kernel with Clang, the following section mismatch
warnings appear:

WARNING: vmlinux.o(.text+0x7239cc): Section mismatch in reference from
the function db8500_prcmu_probe() to the function
.init.text:init_prcm_registers()
The function db8500_prcmu_probe() references
the function __init init_prcm_registers().
This is often because db8500_prcmu_probe lacks a __init
annotation or the annotation of init_prcm_registers is wrong.

WARNING: vmlinux.o(.text+0x723e28): Section mismatch in reference from
the function db8500_prcmu_probe() to the function
.init.text:fw_project_name()
The function db8500_prcmu_probe() references
the function __init fw_project_name().
This is often because db8500_prcmu_probe lacks a __init
annotation or the annotation of fw_project_name is wrong.

db8500_prcmu_probe should not be marked as __init so remove the __init
annotation from fw_project_name and init_prcm_registers.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/db8500-prcmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index 12099b09a9a71..e71b9f23379d0 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -2610,7 +2610,7 @@ static struct irq_chip prcmu_irq_chip = {
 	.irq_unmask	= prcmu_irq_unmask,
 };
 
-static __init char *fw_project_name(u32 project)
+static char *fw_project_name(u32 project)
 {
 	switch (project) {
 	case PRCMU_FW_PROJECT_U8500:
@@ -2758,7 +2758,7 @@ void __init db8500_prcmu_early_init(u32 phy_base, u32 size)
 	INIT_WORK(&mb0_transfer.mask_work, prcmu_mask_work);
 }
 
-static void __init init_prcm_registers(void)
+static void init_prcm_registers(void)
 {
 	u32 val;
 
-- 
2.19.1



