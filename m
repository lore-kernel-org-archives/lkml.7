Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60811C4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 21:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35BB42063F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 21:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N921I7so"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfF0Vr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 17:47:56 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:43406 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfF0Vrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 17:47:55 -0400
Received: by mail-vk1-f201.google.com with SMTP id j140so1021197vke.10
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 14:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Jlmh+4kvOZQk9V9h6xlrXM5stBpJondK1dVakdnE3YI=;
        b=N921I7sobL6tUfzVAJrxbRSoqp9aoCJA4aKLgZUYxvjD4LM1wKRjDuPguikbjutYLB
         /AXcOI2nAoqZfSt3Qy0JIwrQ3t4qI/PbCejCfP/7T5RWDihEPONFK2Soe/tcyFxY54Lt
         6i5t640suQlraueInzE4Xubx2HXj2wGc+UnbhoEdhY4fqDK+VtR2uA6L+C06m1JqiTP4
         +YyFAu87vktTuzTccLPP9KVVQKG2IVmo7ot1G20GckAB0liJRgw64G27XGB3LBmjcfeD
         m943yvQM2PnkWUFatGA/FDsL2aSTEHkuaVc5dDe587a64V2uiNkW6wY1g60z437/clwE
         5aYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Jlmh+4kvOZQk9V9h6xlrXM5stBpJondK1dVakdnE3YI=;
        b=QQe0JhGFfUR6izKcA9BJhh+yChaf5rDIiv0F93ZVnB3vhHO1G+UhHofyQwkwfbK5sU
         TPLgWoNXHcA7hhhgXrOx/taSkWffH1eS0yqG1O13eI63ts4Lh9dDWsGWjMCI9UnYlu+/
         lsEkWrZ/4DaA8B/rILPQfChCPfRLbiQ4BQho/X3XabJ2UvOlgUlKLJjTVQrvyeHby6vK
         V7+Ko0+YOYffFrxSJUux7MLTuctB09oWRHF18WHicEuTUaonDd5kGWk7NGpjmybGwWUJ
         mCUJiHhQGtlKkhZXJnt7AZCbOVnA7tY3UBPeaeuiEY1RQR0HPTj0q3cdqVIWMdcwZP3m
         hGPw==
X-Gm-Message-State: APjAAAVdaXhRhhycVnpNCoT36UAphkZ7vgVep41FfjoUAIrWrGvyvPZH
        tSOoIInuJfN0Cl2yDzKHcw1NAEZ+xP+j
X-Google-Smtp-Source: APXvYqz9eC2+az4dNGWYs0TEc4YFYXGPHi1c3sr2ANx5AnmF7NkzK45LURCUh9ojkfs/n/TxqXZ2I7AiUZpc
X-Received: by 2002:a1f:3692:: with SMTP id d140mr2487711vka.88.1561672074496;
 Thu, 27 Jun 2019 14:47:54 -0700 (PDT)
Date:   Thu, 27 Jun 2019 14:47:38 -0700
Message-Id: <20190627214738.112614-1-rajatja@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH] platform/chrome: lightbar: Get drvdata from parent in suspend/resume
From:   Rajat Jain <rajatja@google.com>
To:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org, rajatxjain@gmail.com,
        evgreen@google.com, gwendal@google.com
Cc:     Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lightbar driver never assigned the drvdata in probe method, and
thus there is nothing there. Need to get the ec_dev from the parent's
drvdata.

Signed-off-by: Rajat Jain <rajatja@google.com>
---
 drivers/platform/chrome/cros_ec_lightbar.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_lightbar.c b/drivers/platform/chrome/cros_ec_lightbar.c
index d30a6650b0b5..26117a8991b3 100644
--- a/drivers/platform/chrome/cros_ec_lightbar.c
+++ b/drivers/platform/chrome/cros_ec_lightbar.c
@@ -600,7 +600,7 @@ static int cros_ec_lightbar_remove(struct platform_device *pd)
 
 static int __maybe_unused cros_ec_lightbar_resume(struct device *dev)
 {
-	struct cros_ec_dev *ec_dev = dev_get_drvdata(dev);
+	struct cros_ec_dev *ec_dev = dev_get_drvdata(dev->parent);
 
 	if (userspace_control)
 		return 0;
@@ -610,7 +610,7 @@ static int __maybe_unused cros_ec_lightbar_resume(struct device *dev)
 
 static int __maybe_unused cros_ec_lightbar_suspend(struct device *dev)
 {
-	struct cros_ec_dev *ec_dev = dev_get_drvdata(dev);
+	struct cros_ec_dev *ec_dev = dev_get_drvdata(dev->parent);
 
 	if (userspace_control)
 		return 0;
-- 
2.22.0.410.gd8fdbe21b5-goog

