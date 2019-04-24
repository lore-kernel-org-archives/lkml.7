Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0606BC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0AC1218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556116965;
	bh=MB7Y3mWB13g6WEFgVqxjBmbpTbh/cnfSVdR8/1EcTOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0xohRkW21fOzcP38s0sKcx0+MMqrhhcmwzc1RSS5uHT8pGX+JviZL103zaANm6fhk
	 N2FkmNGzJIouJVhuxVOj4GCkU2LpWEgRk4T7x5607OufwcW/pq51+xaSVVMe0rF7tU
	 Vvt1dpGPalQddbywi1vzt1zONeBxwSriDmnzTbP0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731980AbfDXOkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:40:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:43082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731369AbfDXOkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:40:36 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21D5B21903;
        Wed, 24 Apr 2019 14:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556116835;
        bh=MB7Y3mWB13g6WEFgVqxjBmbpTbh/cnfSVdR8/1EcTOQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ah3hfEeAIEOgVsnGfbGbaYdjEDJVK8RX6/DyAKvU4PEAWQWYC6/WhFCPTU1v9bmZK
         JYKdS3E/uqcJZcpGw1ZeX8sEmRgNiYUqb4ysizXrcIXnGXliU9UQRfLA+c1NmWVOEV
         b9JMESuxSWOT1KdecndqKOKosjL7AKT7bQqHJKH4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wei Li <liwei391@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 36/52] arm64: fix wrong check of on_sdei_stack in nmi context
Date:   Wed, 24 Apr 2019 10:38:54 -0400
Message-Id: <20190424143911.28890-36-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190424143911.28890-1-sashal@kernel.org>
References: <20190424143911.28890-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Li <liwei391@huawei.com>

[ Upstream commit 1c41860864c8ae0387ef7d44f0000e99cbb2e06d ]

When doing unwind_frame() in the context of pseudo nmi (need enable
CONFIG_ARM64_PSEUDO_NMI), reaching the bottom of the stack (fp == 0,
pc != 0), function on_sdei_stack() will return true while the sdei acpi
table is not inited in fact. This will cause a "NULL pointer dereference"
oops when going on.

Reviewed-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Wei Li <liwei391@huawei.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/sdei.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/kernel/sdei.c b/arch/arm64/kernel/sdei.c
index 5ba4465e44f0..ea94cf8f9dc6 100644
--- a/arch/arm64/kernel/sdei.c
+++ b/arch/arm64/kernel/sdei.c
@@ -94,6 +94,9 @@ static bool on_sdei_normal_stack(unsigned long sp, struct stack_info *info)
 	unsigned long low = (unsigned long)raw_cpu_read(sdei_stack_normal_ptr);
 	unsigned long high = low + SDEI_STACK_SIZE;
 
+	if (!low)
+		return false;
+
 	if (sp < low || sp >= high)
 		return false;
 
@@ -111,6 +114,9 @@ static bool on_sdei_critical_stack(unsigned long sp, struct stack_info *info)
 	unsigned long low = (unsigned long)raw_cpu_read(sdei_stack_critical_ptr);
 	unsigned long high = low + SDEI_STACK_SIZE;
 
+	if (!low)
+		return false;
+
 	if (sp < low || sp >= high)
 		return false;
 
-- 
2.19.1

