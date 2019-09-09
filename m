Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 269B1C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 15:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE6EB2171F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 15:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568044317;
	bh=AyjekNVhRjBlU8PjHLcUlwzfBiHI9ybDkgsxOYALMeA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=OfyhobY+K2W7zftu+lbyae9h3saBgbWErVJFVSKzEHpRaTwguGnghFWCqZLpWQulx
	 RCs3pe6rhJli0/FQA4c4YWyVAoz8gSaiQfWxuN0TRt7vR1bXS+pSWF8GoSZwu3HIcK
	 M6zb9tmvq1kpkTTsxtlJSx3GlLq9sMoPuBDKj4x8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389047AbfIIPv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 11:51:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:37754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727003AbfIIPvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 11:51:55 -0400
Received: from localhost.localdomain (unknown [194.230.155.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2E972082C;
        Mon,  9 Sep 2019 15:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568044315;
        bh=AyjekNVhRjBlU8PjHLcUlwzfBiHI9ybDkgsxOYALMeA=;
        h=From:To:Cc:Subject:Date:From;
        b=wKljNsiRkPoeNLDUtYW5FzCf7vViXMwOr4k85IOW65t7GXm3+iL+uG0FI3DrUNqFQ
         +7qH8k5CXFFOuIvRC43TTJHFXKQk6w4LYxVTV/zqMrs7yoV5J4qkFTG1HyX70lc84B
         BjKHbiS92dHB+6P7vMJDUib1GoneMLd8CixmUxb4=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [RESEND PATCH] drm/panfrost: Reduce the amount of logs on deferred probe
Date:   Mon,  9 Sep 2019 17:51:46 +0200
Message-Id: <20190909155146.14065-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no point to print deferred probe (and its failures to get
resources) as an error.

In case of multiple probe tries this would pollute the dmesg.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/gpu/drm/panfrost/panfrost_device.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index 46b0b02e4289..2252147bc285 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -95,7 +95,9 @@ static int panfrost_regulator_init(struct panfrost_device *pfdev)
 		pfdev->regulator = NULL;
 		if (ret == -ENODEV)
 			return 0;
-		dev_err(pfdev->dev, "failed to get regulator: %d\n", ret);
+		if (ret != -EPROBE_DEFER)
+			dev_err(pfdev->dev, "failed to get regulator: %d\n",
+				ret);
 		return ret;
 	}
 
-- 
2.17.1

