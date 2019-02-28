Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF79C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A415D20C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551367519;
	bh=UUWwfRW6tf/h6D6LTyEDLNG5biXtNZ3iKZ9FBP4N5Bs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qcEg9igYt1bhxG5x1pQLAMN9CcOqtrsmxhtidmchLAYe3RYETgpsRRe6wHa/jywx6
	 1GMXVFSuvsCxksnPEh1mMjcHQy+ntB4KhJE+Vk2TWtgXKjACZVfsrewBZxmjjoMnWj
	 TP3ACpRRFD0aUrCPl8RZRq9DRrWRO6jLLkDSqXzM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388473AbfB1PZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:25:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:45552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388180AbfB1PMK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:12:10 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 988002171F;
        Thu, 28 Feb 2019 15:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366730;
        bh=UUWwfRW6tf/h6D6LTyEDLNG5biXtNZ3iKZ9FBP4N5Bs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SCkskRPTzkrCJ9Iynr3RwofawVCXa6pyIrYqionkSncPgSR3GFNCCCAQPqHtqD6Ct
         6+zo4hHeRDsJ29OEagjAZb/hZV2w3omlttzuAOwsfZci46+vyImEGuPG9Y7uEqPtDD
         D0hYITS5AA/+jYzdIU/4M5vIqrPsbUjy1ij/hQ98=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zenghui Yu <yuzenghui@huawei.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 32/64] irqchip/gic-v3-its: Fix ITT_entry_size accessor
Date:   Thu, 28 Feb 2019 10:10:33 -0500
Message-Id: <20190228151105.11277-32-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228151105.11277-1-sashal@kernel.org>
References: <20190228151105.11277-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zenghui Yu <yuzenghui@huawei.com>

[ Upstream commit 56841070ccc87b463ac037d2d1f2beb8e5e35f0c ]

According to ARM IHI 0069C (ID070116), we should use GITS_TYPER's
bits [7:4] as ITT_entry_size instead of [8:4]. Although this is
pretty annoying, it only results in a potential over-allocation
of memory, and nothing bad happens.

Fixes: 3dfa576bfb45 ("irqchip/gic-v3-its: Add probing for VLPI properties")
Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
[maz: massaged subject and commit message]
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/irqchip/arm-gic-v3.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index 8bdbb5f29494b..3188c0bef3e79 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -319,7 +319,7 @@
 #define GITS_TYPER_PLPIS		(1UL << 0)
 #define GITS_TYPER_VLPIS		(1UL << 1)
 #define GITS_TYPER_ITT_ENTRY_SIZE_SHIFT	4
-#define GITS_TYPER_ITT_ENTRY_SIZE(r)	((((r) >> GITS_TYPER_ITT_ENTRY_SIZE_SHIFT) & 0x1f) + 1)
+#define GITS_TYPER_ITT_ENTRY_SIZE(r)	((((r) >> GITS_TYPER_ITT_ENTRY_SIZE_SHIFT) & 0xf) + 1)
 #define GITS_TYPER_IDBITS_SHIFT		8
 #define GITS_TYPER_DEVBITS_SHIFT	13
 #define GITS_TYPER_DEVBITS(r)		((((r) >> GITS_TYPER_DEVBITS_SHIFT) & 0x1f) + 1)
-- 
2.19.1

