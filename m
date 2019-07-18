Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A8CC76186
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1676020578
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563420190;
	bh=j982ZNen7fZJSe+VCv8jDFdTG+k/yWiL0j+VKm6MQhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fnjpMkQmP45eweqZtWjfvl42wSxq8DIT1X7lbcg3MuWEspOPnMOrDgyE0tv1T46Jk
	 KnN8YuQF+4G+0YoxqIlFFKWR/heJQOP4DXpBUiNat48fscgIGv0R7IGZpVzc+nZZHv
	 cikvwbvJEbkNl/fKcf/P4+q6GuEiTHSCY1h9ZPHA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391308AbfGRDXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 23:23:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:60292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389520AbfGRDXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 23:23:04 -0400
Received: from localhost (115.42.148.210.bf.2iij.net [210.148.42.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 413EC21841;
        Thu, 18 Jul 2019 03:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563419615;
        bh=j982ZNen7fZJSe+VCv8jDFdTG+k/yWiL0j+VKm6MQhc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ozY5X6J7Zu1kiwEQIBwbfx7Yd2YziCiri6f+f/sOCyfGpdVgte/xmBA+DSYUB3TOH
         RFpqQaSUVhtekpFSKruWgHdJOW/T+q7vP6HKF6xzmuUg9zBngS2T3L4Ss4eNSfhsBo
         iV8NjvhNjvJLe4EIi7m7vkMxmtIxl0uatCnaMv78=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sekhar Nori <nsekhar@ti.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 15/54] ARM: davinci: da850-evm: call regulator_has_full_constraints()
Date:   Thu, 18 Jul 2019 12:01:45 +0900
Message-Id: <20190718030050.453509943@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190718030048.392549994@linuxfoundation.org>
References: <20190718030048.392549994@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 0c0c9b5753cd04601b17de09da1ed2885a3b42fe ]

The BB expander at 0x21 i2c bus 1 fails to probe on da850-evm because
the board doesn't set has_full_constraints to true in the regulator
API.

Call regulator_has_full_constraints() at the end of board registration
just like we do in da850-lcdk and da830-evm.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mach-davinci/board-da850-evm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index 8e4539f69fdc..3bdf0d588238 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -1479,6 +1479,8 @@ static __init void da850_evm_init(void)
 	if (ret)
 		pr_warn("%s: dsp/rproc registration failed: %d\n",
 			__func__, ret);
+
+	regulator_has_full_constraints();
 }
 
 #ifdef CONFIG_SERIAL_8250_CONSOLE
-- 
2.20.1



