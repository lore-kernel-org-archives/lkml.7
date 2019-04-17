Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FEC6C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 006582073F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VHzD7Ir/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731431AbfDQI3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 04:29:19 -0400
Received: from m50-135.163.com ([123.125.50.135]:41157 "EHLO m50-135.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726895AbfDQI3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 04:29:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=cWa1HRHl3Sy4zra+1y
        T+ClWWMJ6sMZzRZEpAdx0oZIw=; b=VHzD7Ir/dK79ZwUSKw2v1hKRAqrN/aDWbg
        6QjSPJm+7CYp6FpIcj+u3ib2L+aojVSLtIFgKleo1bvLJOl5UgpX+ALV9TLt6wP3
        f+PnGc7/u1XyYHN7DGqSpoRiCnIMM/Y7FVLQGqkwPvdt6az+x+hgYoQsEk7v6P2Y
        xSDIwWuu4=
Received: from bp.localdomain (unknown [218.106.182.174])
        by smtp5 (Coremail) with SMTP id D9GowADHFyq547ZcMAE4AQ--.740S3;
        Wed, 17 Apr 2019 16:28:44 +0800 (CST)
From:   Pan Bian <bianpan2016@163.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        Mathieu Malaterre <malat@debian.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pan Bian <bianpan2016@163.com>
Subject: mmc: core: fix possible use after free of host
Date:   Wed, 17 Apr 2019 16:28:37 +0800
Message-Id: <1555489717-28294-1-git-send-email-bianpan2016@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: D9GowADHFyq547ZcMAE4AQ--.740S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrZrW7Zw4UXFWUJr13WrWrAFb_yoWDWFcEkF
        Z09rn2934kG34DG3WUuw43ZrWrKan2vw1kta1FqFW3tr1Fqrs7Zws2vr98Zrn3ur47CayY
        yFs8Xr1xAryagjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbznQ5UUUUU==
X-Originating-IP: [218.106.182.174]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/1tbiVBiZclUMH9cM8QAAsL
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the function mmc_alloc_host, the function put_device is called to
release allocated resources when mmc_gpio_alloc fails. Finally, the
function pointed by host->class_dev.class->dev_release (i.e.,
mmc_host_classdev_release) is used to release resources including the
host structure. However, after put_device, host is used and released
again. Resulting in a use-after-free bug.

Fixes: 1ed21719448("mmc: core: fix error path in mmc_host_alloc")
Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 drivers/mmc/core/host.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 3a4402a..f8ac567 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -429,8 +429,6 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 
 	if (mmc_gpio_alloc(host)) {
 		put_device(&host->class_dev);
-		ida_simple_remove(&mmc_host_ida, host->index);
-		kfree(host);
 		return NULL;
 	}
 
-- 
2.7.4


