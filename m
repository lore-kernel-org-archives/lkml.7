Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC98AC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A6AD204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555963310;
	bh=lVDDzm9TFuie7XILpz7bvsjkzwFaeevko5Hnsu2fDGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qPzq5GU9r+2oh8zd/IyhJRM8f11qLCmNmvuMhMcujzI2B/ub6ypKENaQtrnzLJxVH
	 t727XHPiMvPMyNvBqe0ezc/GI4m2757g2/NIu597FFG4Yi7w+CD1Y/hIoFcgxrRi9O
	 XIg+Zyf1VrztuKzagI9689DtC2UpLTYlICPR/hTY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732010AbfDVUBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 16:01:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:49192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729263AbfDVTqs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:46:48 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6899F21902;
        Mon, 22 Apr 2019 19:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962408;
        bh=lVDDzm9TFuie7XILpz7bvsjkzwFaeevko5Hnsu2fDGw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EtFqG7mVR6h8JuMG6BhqpZyT0l+L97y51SRWZzLI7gknWF+sM/zpx/dQs6Kce1L7i
         XhsMCoUW6kwhIPI369DcVYIAcckG97hXtRaGwDbbtI0kDGrOMEwJ1Z7GNxB50taQP7
         MfU+y+2kZlExS/civH9wWGsz4B9SXJRKEUeceu+U=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sasha Levin <sashal@kernel.org>, linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 44/68] gpio: aspeed: fix a potential NULL pointer dereference
Date:   Mon, 22 Apr 2019 15:44:52 -0400
Message-Id: <20190422194516.11634-44-sashal@kernel.org>
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
index 2342e154029b..b696ec35efb3 100644
--- a/drivers/gpio/gpio-aspeed.c
+++ b/drivers/gpio/gpio-aspeed.c
@@ -1225,6 +1225,8 @@ static int __init aspeed_gpio_probe(struct platform_device *pdev)
 
 	gpio->offset_timer =
 		devm_kzalloc(&pdev->dev, gpio->chip.ngpio, GFP_KERNEL);
+	if (!gpio->offset_timer)
+		return -ENOMEM;
 
 	return aspeed_gpio_setup_irqs(gpio, pdev);
 }
-- 
2.19.1

