Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9DB0C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 08:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A52A4233A0
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 08:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfHUINl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 04:13:41 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:43964 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726217AbfHUINl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 04:13:41 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B0828844EB881BAF5AAA;
        Wed, 21 Aug 2019 16:13:39 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Wed, 21 Aug 2019
 16:13:32 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <marek.behun@nic.cz>, <gregkh@linuxfoundation.org>,
        <linus.walleij@linaro.org>, <arnd@arndb.de>
CC:     <linux-kernel@vger.kernel.org>, Jason Yan <yanaijie@huawei.com>
Subject: [PATCH -next] moxtet: remove set but not used variable 'dummy'
Date:   Wed, 21 Aug 2019 16:34:22 +0800
Message-ID: <20190821083422.45334-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/bus/moxtet.c: In function moxtet_remove:
drivers/bus/moxtet.c:822:6: warning: variable dummy set but not used
[-Wunused-but-set-variable]

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/bus/moxtet.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/bus/moxtet.c b/drivers/bus/moxtet.c
index 1ee4570e7e17..baccf7609357 100644
--- a/drivers/bus/moxtet.c
+++ b/drivers/bus/moxtet.c
@@ -819,7 +819,6 @@ static int moxtet_probe(struct spi_device *spi)
 static int moxtet_remove(struct spi_device *spi)
 {
 	struct moxtet *moxtet = spi_get_drvdata(spi);
-	int dummy;
 
 	free_irq(moxtet->dev_irq, moxtet);
 
@@ -827,7 +826,7 @@ static int moxtet_remove(struct spi_device *spi)
 
 	moxtet_unregister_debugfs(moxtet);
 
-	dummy = device_for_each_child(moxtet->dev, NULL, __unregister);
+	device_for_each_child(moxtet->dev, NULL, __unregister);
 
 	mutex_destroy(&moxtet->lock);
 
-- 
2.17.2

