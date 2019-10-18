Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2862CA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D3EE20872
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571436949;
	bh=5IFpmLN3JhJf8ksQjkcKwGvyr/g/pPEKDHGq8xP3mCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0NsasQ1Z5v06v1l+DF3wgpeNWnort7ufyFX1saHuaReg9P5Z/sHYMtFxvncETce9H
	 qPVkyIBENOfNmDNY8FW87R5MPiytC6r1gBmraCQeKeIPDNAql7iXnElQ7fw5Grp5/m
	 Y6rkvOXVCSVvO8brayJFdDbWuLrUtB+iVCU/oNIU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404081AbfJRWPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 18:15:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:41372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388182AbfJRWIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 18:08:48 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56F9C2245D;
        Fri, 18 Oct 2019 22:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571436528;
        bh=5IFpmLN3JhJf8ksQjkcKwGvyr/g/pPEKDHGq8xP3mCU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gKO0VqrvB3UfYKARiQd6tGtgNONCfyDJp69nOiryubCogJhN9qSu7FHE/RsoAq4tF
         37ehvCNBRw6sgE6RuS5xHVJJWoOE6vkgfpBb+pyGWei05Q0g7Dh7zKxmqchw+WExsY
         MrIAFpVMkxD42DezC0O5rsfKujbjL0nEjsgr3pIY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Thierry Reding <treding@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 34/56] gpio: max77620: Use correct unit for debounce times
Date:   Fri, 18 Oct 2019 18:07:31 -0400
Message-Id: <20191018220753.10002-34-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191018220753.10002-1-sashal@kernel.org>
References: <20191018220753.10002-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

[ Upstream commit fffa6af94894126994a7600c6f6f09b892e89fa9 ]

The gpiod_set_debounce() function takes the debounce time in
microseconds. Adjust the switch/case values in the MAX77620 GPIO to use
the correct unit.

Signed-off-by: Thierry Reding <treding@nvidia.com>
Link: https://lore.kernel.org/r/20191002122825.3948322-1-thierry.reding@gmail.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-max77620.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-max77620.c b/drivers/gpio/gpio-max77620.c
index 538bce4b5b427..ac6c1c0548b69 100644
--- a/drivers/gpio/gpio-max77620.c
+++ b/drivers/gpio/gpio-max77620.c
@@ -163,13 +163,13 @@ static int max77620_gpio_set_debounce(struct max77620_gpio *mgpio,
 	case 0:
 		val = MAX77620_CNFG_GPIO_DBNC_None;
 		break;
-	case 1 ... 8:
+	case 1000 ... 8000:
 		val = MAX77620_CNFG_GPIO_DBNC_8ms;
 		break;
-	case 9 ... 16:
+	case 9000 ... 16000:
 		val = MAX77620_CNFG_GPIO_DBNC_16ms;
 		break;
-	case 17 ... 32:
+	case 17000 ... 32000:
 		val = MAX77620_CNFG_GPIO_DBNC_32ms;
 		break;
 	default:
-- 
2.20.1

