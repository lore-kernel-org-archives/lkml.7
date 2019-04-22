Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50776C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0703D2075A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555963700;
	bh=HTlBzVVr/tRb0LUHp3BAgi+bDaV2dXdNwftjh+ug1Ig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H8Pz74+GOj6vVx2I5NjP6EQLnhVI64FhPPX8rc+nPZTnfj2ng24wxrWql5y3aAxu5
	 S8IVnguuP7wAvQHQ6wEM5ChwZMLOt9IrpLrHpQz3qR7iBuYtuBQUHt7LLjHJqs5OVw
	 nYFiq2p7iSsFRS9d5XDy28vQuf4T0R5dVnb40+Ao=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732430AbfDVUIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 16:08:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:44674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729305AbfDVTnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:43:55 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A290A218EA;
        Mon, 22 Apr 2019 19:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962235;
        bh=HTlBzVVr/tRb0LUHp3BAgi+bDaV2dXdNwftjh+ug1Ig=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gML8wflSjFoJ2jc3AVWhTcPkSiH5Kzu8LVS6p2Xj3KVZnaLrGhGrByIyqqgWeN/Ix
         g9fWM88zmtR40PD/XQAV6CPcbXFMmyJcw3V6r2bnzjyXC6A8FgoFuPhWYMuKdEyoVK
         ii8GS+HZxlXV/t1tqO6dCq9qhtf7fBfT4gDuqmaM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sasha Levin <sashal@kernel.org>, linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 55/98] gpio: aspeed: fix a potential NULL pointer dereference
Date:   Mon, 22 Apr 2019 15:41:22 -0400
Message-Id: <20190422194205.10404-55-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194205.10404-1-sashal@kernel.org>
References: <20190422194205.10404-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kangjie Lu <kjlu@umn.edu>

[ Upstream commit 6cf4511e9729c00a7306cf94085f9cc3c52ee723 ]

In case devm_kzalloc, the patch returns ENOMEM to avoid potential
NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 drivers/gpio/gpio-aspeed.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
index 854bce4fb9e7..217507002dbc 100644
--- a/drivers/gpio/gpio-aspeed.c
+++ b/drivers/gpio/gpio-aspeed.c
@@ -1224,6 +1224,8 @@ static int __init aspeed_gpio_probe(struct platform_device *pdev)
 
 	gpio->offset_timer =
 		devm_kzalloc(&pdev->dev, gpio->chip.ngpio, GFP_KERNEL);
+	if (!gpio->offset_timer)
+		return -ENOMEM;
 
 	return aspeed_gpio_setup_irqs(gpio, pdev);
 }
-- 
2.19.1

