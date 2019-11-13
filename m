Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CBFC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2561222CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573610610;
	bh=mwos+MVeoqtMRotueUyVTiTBMiid/z7oNgxPt77TpPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=imkkcgNpj6fBL8xPrzSBmkhY3J4unJN8G/pn8r9WCPIovoIGktC0qTfKAugrYfnCy
	 sz0NqzfPynu8uhppspMpzMZrBDofiAUV2Tp1+geCp974DJriDI/ptIplfD3Glb04aR
	 HwOJkRJD6acgSCWPMLr4i0lSHD9FTe3KgyfPD1qI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731070AbfKMCD1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 21:03:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:59580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731018AbfKMCCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 21:02:44 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC97D21783;
        Wed, 13 Nov 2019 02:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573610563;
        bh=mwos+MVeoqtMRotueUyVTiTBMiid/z7oNgxPt77TpPs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MCHI+8skZmQMg1ltZuDkoKVyN+x5KRoWYdh7A4z3CuM4oDesYVzJQnu8oodltpr6i
         aZN/leBK1fFCI9u8IxCVT8QfPuwMvue05nWPp0Q00ibyTUDohH+7VdEq6UjAa/NUnl
         aFVB66ZTRZ/mzrWX7rV2waUTK3VTZrXH4AxSG7QQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 42/48] gpio: syscon: Fix possible NULL ptr usage
Date:   Tue, 12 Nov 2019 21:01:25 -0500
Message-Id: <20191113020131.13356-42-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113020131.13356-1-sashal@kernel.org>
References: <20191113020131.13356-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marek Vasut <marex@denx.de>

[ Upstream commit 70728c29465bc4bfa7a8c14304771eab77e923c7 ]

The priv->data->set can be NULL while flags contains GPIO_SYSCON_FEAT_OUT
and chip->set is valid pointer. This happens in case the controller uses
the default GPIO setter. Always use chip->set to access the setter to avoid
possible NULL pointer dereferencing.

Signed-off-by: Marek Vasut <marex@denx.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-syscon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-syscon.c b/drivers/gpio/gpio-syscon.c
index 7b25fdf648023..f579938552cc5 100644
--- a/drivers/gpio/gpio-syscon.c
+++ b/drivers/gpio/gpio-syscon.c
@@ -127,7 +127,7 @@ static int syscon_gpio_dir_out(struct gpio_chip *chip, unsigned offset, int val)
 				   BIT(offs % SYSCON_REG_BITS));
 	}
 
-	priv->data->set(chip, offset, val);
+	chip->set(chip, offset, val);
 
 	return 0;
 }
-- 
2.20.1

