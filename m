Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F7CC43215
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0428E20707
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574403502;
	bh=cxbX40+yMebtvgtypjYfDbKSAlYOdV5SCSC0zAhdyaI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a/WI781jDLc3PKgYsp3PidlVnxB6k49baKyms96OTl8d4FTzXaZ8mv9zJ+YvomK2O
	 UiOTVrukOHFEtiNeFL9ZZVtTTxQ1X24zDbYk4QKlIHfU/uvnf8+8lN5pYlW7dSCpq4
	 ZlyOywiX6Ipg2edJF7TV+ZzJUQBKOgvh7x+iTVJg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbfKVGNO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 01:13:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:50334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728711AbfKVGNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 01:13:11 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 128E22070E;
        Fri, 22 Nov 2019 06:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574403190;
        bh=cxbX40+yMebtvgtypjYfDbKSAlYOdV5SCSC0zAhdyaI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KNh+4u74GcBR4YXOzev/Jtqm1d0iCAJTCkzNK6O6dFh9jPt8R/tXqD0flm/LvZUYH
         J5otqDc+/jeut/hTJZhjs07VrfWK9Xd30se5gFPpPo9+NKMYGD9T2163xGKcAmtVpq
         bEL9anZmTz3BfSF4+HFz7QiHWNRPm44UomhDzJYo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.4 08/68] ARM: ks8695: fix section mismatch warning
Date:   Fri, 22 Nov 2019 01:12:01 -0500
Message-Id: <20191122061301.4947-7-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122061301.4947-1-sashal@kernel.org>
References: <20191122061301.4947-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 4aa64677330beeeed721b4b122884dabad845d66 ]

WARNING: vmlinux.o(.text+0x13250): Section mismatch in reference from the function acs5k_i2c_init() to the (unknown reference) .init.data:(unknown)
The function acs5k_i2c_init() references
the (unknown reference) __initdata (unknown).
This is often because acs5k_i2c_init lacks a __initdata
annotation or the annotation of (unknown) is wrong.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mach-ks8695/board-acs5k.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-ks8695/board-acs5k.c b/arch/arm/mach-ks8695/board-acs5k.c
index 9f9c0441a9175..e372609c48dd0 100644
--- a/arch/arm/mach-ks8695/board-acs5k.c
+++ b/arch/arm/mach-ks8695/board-acs5k.c
@@ -92,7 +92,7 @@ static struct i2c_board_info acs5k_i2c_devs[] __initdata = {
 	},
 };
 
-static void acs5k_i2c_init(void)
+static void __init acs5k_i2c_init(void)
 {
 	/* The gpio interface */
 	platform_device_register(&acs5k_i2c_device);
-- 
2.20.1

