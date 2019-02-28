Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375CFC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 049A020C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551367869;
	bh=QVcIaP+MA59SyAgFst32utuG2nTD5JgMRVtSCU06Ypk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1Qv3B+7xW3e040gTWGilC+asaqDaA45loKLJGnLazqrwNuH51/3J7Dqs9SIleT7Y7
	 5jK7zJTLxwnPL0p7vkxUJsveERhiU/J9w2iQA33EyuW+By7QpPTsYZVgmsYXkG0E/S
	 Ikx0lR/7fUe5ogWorAhoGBu+4RUiQ+TZd+l7eIj0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389139AbfB1PbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:31:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:41920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387400AbfB1PJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:09:19 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AADB0206B8;
        Thu, 28 Feb 2019 15:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366559;
        bh=QVcIaP+MA59SyAgFst32utuG2nTD5JgMRVtSCU06Ypk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=exTRBKfvSkxD81CpFVlSVj0nO2ljyc5AmqPoMj2emfI8xGwescY36ss6iMhywqHii
         Er5BJpP8UPxPRyXuHiXc0LI2Grxa22vByaiXMEmSkRGhwcW5x37vCzOFeQDq4KHrPF
         XhWjWlg6ksdjC6YeXMh0usn65yQa5tMRaYL0Lkww=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zenghui Yu <yuzenghui@huawei.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 41/81] irqchip/gic-v3-its: Fix ITT_entry_size accessor
Date:   Thu, 28 Feb 2019 10:07:33 -0500
Message-Id: <20190228150813.10256-41-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228150813.10256-1-sashal@kernel.org>
References: <20190228150813.10256-1-sashal@kernel.org>
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
index 071b4cbdf0104..c848a7cc502ee 100644
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

