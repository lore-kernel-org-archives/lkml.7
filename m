Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3438C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CB41205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561595905;
	bh=pX2jxfX2t4iyJsCG7su+48/YUWGiMvuZM+bVa080oqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rEDU7w5vJNVwcWJWuvJ6iYPyqU657ZyjUlAkCr8OHXh4Vwo7Z5BspZ9xIIqB9KZP8
	 Mi/giaR1rWhOKWJghbNvG1VKzvriQQ05M9iCmph9Vg/hfRs3t3THxP23Xs0DeogRuc
	 Q032k1Zn/ac0uSfh309oiYICT5tZXrHwmqEHIeQ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbfF0AiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 20:38:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:42620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728791AbfF0AiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 20:38:18 -0400
Received: from sasha-vm.mshome.net (unknown [107.242.116.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68ADC205ED;
        Thu, 27 Jun 2019 00:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561595897;
        bh=pX2jxfX2t4iyJsCG7su+48/YUWGiMvuZM+bVa080oqM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hTOFfzlsRoHyh7POqddByHAizIKcFz/ciUoCJFOfbjDLJc9AJhGWPwGzRryu/kWeI
         D0jC+ZQd6sNnhHDE3QmzxxlHGZsUzcOBxoj814XXvxDDrBo/EINT6ugOpBaECzAmKE
         U+Yaw+XvalmTVrT9IWTObwgrn8BaAhXgXe16YsJw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sekhar Nori <nsekhar@ti.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 38/60] ARM: davinci: da850-evm: call regulator_has_full_constraints()
Date:   Wed, 26 Jun 2019 20:35:53 -0400
Message-Id: <20190627003616.20767-38-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190627003616.20767-1-sashal@kernel.org>
References: <20190627003616.20767-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

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
index e1a949b47306..774a3e535ad0 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -1472,6 +1472,8 @@ static __init void da850_evm_init(void)
 	if (ret)
 		pr_warn("%s: dsp/rproc registration failed: %d\n",
 			__func__, ret);
+
+	regulator_has_full_constraints();
 }
 
 #ifdef CONFIG_SERIAL_8250_CONSOLE
-- 
2.20.1

