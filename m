Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83171C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42DA521902
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555962418;
	bh=IZS9drIIi6hW4f6t9pn5QSeDMpldknLsch4FRPQi6C4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qAUl0b1cc6hDluQGAZb3gwMCOyXpe9La0FbbhNBSbbCVpnsT38dS1zmoKRQAp3Rps
	 g21tOWVn50Laji3iOfzRMO7c7yU6qKD1uC3KugFRDJmodQ799kLlxD3XhJgY5HMUUE
	 59fNoo+/BP8hZK6KjpooDMr+leANX5pmTzGufWOU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730126AbfDVTq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:46:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:49376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730107AbfDVTqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:46:53 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A68421909;
        Mon, 22 Apr 2019 19:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962412;
        bh=IZS9drIIi6hW4f6t9pn5QSeDMpldknLsch4FRPQi6C4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J8zReBF1MexDNkF0dqCH3RnHIf2E/q2VU40l/ddeqLSt0VI8vV8GKsUTDk1e3I+Ul
         jtNKVlGGEQWhNPvRgPIVFt8z7il/wDs94yZc+iW7tZblS4ts1Cb2LjTt2LXeWbw3J4
         bvGKWUOcVBGVTt6FjBq6ZHonODJwrwHC6IcrXsxw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sekhar Nori <nsekhar@ti.com>, Arnd Bergmann <arnd@arndb.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 47/68] ARM: davinci: fix build failure with allnoconfig
Date:   Mon, 22 Apr 2019 15:44:55 -0400
Message-Id: <20190422194516.11634-47-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194516.11634-1-sashal@kernel.org>
References: <20190422194516.11634-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sekhar Nori <nsekhar@ti.com>

[ Upstream commit 2dbed152e2d4c3fe2442284918d14797898b1e8a ]

allnoconfig build with just ARCH_DAVINCI enabled
fails because drivers/clk/davinci/* depends on
REGMAP being enabled.

Fix it by selecting REGMAP_MMIO when building in
DaVinci support.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Reviewed-by: David Lechner <david@lechnology.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index cd4c74daf71e..51794c7fa6d5 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -612,6 +612,7 @@ config ARCH_DAVINCI
 	select HAVE_IDE
 	select PM_GENERIC_DOMAINS if PM
 	select PM_GENERIC_DOMAINS_OF if PM && OF
+	select REGMAP_MMIO
 	select RESET_CONTROLLER
 	select USE_OF
 	select ZONE_DMA
-- 
2.19.1

