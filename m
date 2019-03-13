Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B3BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBE302075C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552504781;
	bh=1RYythygOiFVkB6MhQ7PoCQItYe/S/oWLR9M2yQbfjo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OhN6fVu0hZAklm1mDrgK2FUomr6VrH9TAr4LXgJZy/aWO3ojrwgM00oY7xrP2eY/x
	 OezIOG2zkwHWHm2+7IbEP41VqcK3gzpu89Iu8MQmnU0WejG7986hZ6bQezB7qTpq5t
	 j4XQicdOBCq/rZ/OSlMxyNoWebCaiO3woQ3axEmk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbfCMTTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:19:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:49740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729163AbfCMTTE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:19:04 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F29C213A2;
        Wed, 13 Mar 2019 19:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552504743;
        bh=1RYythygOiFVkB6MhQ7PoCQItYe/S/oWLR9M2yQbfjo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sIK7Sj8EfMrliwtNJGGIZ546Kz9EyOnzgGefSzn3NxdnfQneqzoTJWmDkd4GTiwA/
         esW+/Q8yKgNS5LdzngcXsmePWjKuHE0Wiyd3qIGmwV+2b9qndxusISheMLJw/cPgd3
         p0i6GDhsofodg8BwNgcyHqzFC8sBwykH7LJBlT4g=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vladimir Murzin <vladimir.murzin@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 06/10] arm64: Relax GIC version check during early boot
Date:   Wed, 13 Mar 2019 15:18:42 -0400
Message-Id: <20190313191847.160801-6-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190313191847.160801-1-sashal@kernel.org>
References: <20190313191847.160801-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladimir Murzin <vladimir.murzin@arm.com>

[ Upstream commit 74698f6971f25d045301139413578865fc2bd8f9 ]

Updates to the GIC architecture allow ID_AA64PFR0_EL1.GIC to have
values other than 0 or 1. At the moment, Linux is quite strict in the
way it handles this field at early boot stage (cpufeature is fine) and
will refuse to use the system register CPU interface if it doesn't
find the value 1.

Fixes: 021f653791ad17e03f98aaa7fb933816ae16f161 ("irqchip: gic-v3: Initial support for GICv3")
Reported-by: Chase Conklin <Chase.Conklin@arm.com>
Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/head.S | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 5c4b8d6e8ba0..fcb224df471d 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -295,8 +295,7 @@ CPU_LE(	bic	x0, x0, #(3 << 24)	)	// Clear the EE and E0E bits for EL1
 	/* GICv3 system register access */
 	mrs	x0, id_aa64pfr0_el1
 	ubfx	x0, x0, #24, #4
-	cmp	x0, #1
-	b.ne	3f
+	cbz	x0, 3f
 
 	mrs_s	x0, ICC_SRE_EL2
 	orr	x0, x0, #ICC_SRE_EL2_SRE	// Set ICC_SRE_EL2.SRE==1
-- 
2.19.1

