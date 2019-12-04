Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5EAAC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85BB22089C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575483033;
	bh=OzYtwF3JQAAv1AmFBZhtaXfAlBLGifIQv0NrdVQPlHM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Mjru8gP3/omRNFeLSByQOicbg8qZAYSVWRjKNaAqei/tjquoY0PlsaPZ3T9rHksWB
	 4JGT/bDl0beOy/uLUug6db5O5EvuxEUupr6bdYYKQHiJYpBR+CZwzs4iU45lNRT6z/
	 tTfU7xqfqPTOFlJTCTnvgpHu/03BHyeN7AV41tpg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731281AbfLDSKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:10:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:37770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731260AbfLDSK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:10:29 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 121EA20675;
        Wed,  4 Dec 2019 18:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575483028;
        bh=OzYtwF3JQAAv1AmFBZhtaXfAlBLGifIQv0NrdVQPlHM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lj1X/L5/Tkhzei8MB+vzWmjgonyJ0uCw6Ydr1zEXg3D5fY6KjJbcpiHN8MTfaHQmh
         LPTqwLpYfBhKT0NDq0G465C4slJJvJ5HpXaN41Tyq6MuHBW5K4JtPXyh/rJfnmHngy
         8jssZQlQobFVMk8g4Ip8TLM+pmobnuk9lzNbKwBg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 022/125] ARM: ks8695: fix section mismatch warning
Date:   Wed,  4 Dec 2019 18:55:27 +0100
Message-Id: <20191204175318.999667463@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204175308.377746305@linuxfoundation.org>
References: <20191204175308.377746305@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index e4d709c8ed32f..76d3083f1f634 100644
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



