Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C394FC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 10:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 885DB20821
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 10:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="qcIiL2Ei"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731768AbfDQKtm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 06:49:42 -0400
Received: from m50-134.163.com ([123.125.50.134]:54822 "EHLO m50-134.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725792AbfDQKtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 06:49:41 -0400
X-Greylist: delayed 906 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Apr 2019 06:49:41 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=P+wHLlGQH14iL5T25+
        wCorAAqXLtofaYnTroz8AWOvw=; b=qcIiL2EiQas+VoPpz4h9C42XumfvF8hp6N
        YqwJ4/rkUWsqqN/3n0B+lYij02jZuqI8mKFgcQjpHsKVXEoLEecz1RGuiPgKaI5k
        zakaMv5FNW0XEsru243/bjakOYeqzBKxAp84J8fQ6Xc6MOXjQjyk+RB/scfHBM31
        IodNWOeaw=
Received: from bp.localdomain (unknown [218.106.182.174])
        by smtp4 (Coremail) with SMTP id DtGowADXfTMMAbdcTctsAA--.203S3;
        Wed, 17 Apr 2019 18:34:32 +0800 (CST)
From:   Pan Bian <bianpan2016@163.com>
To:     Johannes Thumshirn <morbidrsa@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Pan Bian <bianpan2016@163.com>
Subject: mcb: correct error handling in mcb_alloc_bus
Date:   Wed, 17 Apr 2019 18:33:44 +0800
Message-Id: <1555497224-72490-1-git-send-email-bianpan2016@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: DtGowADXfTMMAbdcTctsAA--.203S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7JF15Ary5tF13AryUGry3urg_yoWktwb_Ga
        4jvrW7WrW8tw1UWayfJr4xZ34xKrn29r95urnrta93C3yUG34DurZIqws8WrWxXay29FyU
        Xa4kZr4xZr12qjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUfb15UUUUU==
X-Originating-IP: [218.106.182.174]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/xtbBzxmZclaD2Np+WQAAsN
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two issues in the error handling code. First, if ID allocation
fails, the reference count of carrier is decremented, which has
not been incremented yet. Second, if device_add fails, the allocated ID
will not be released. This patches fixes them.

Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 drivers/mcb/mcb-core.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/mcb/mcb-core.c b/drivers/mcb/mcb-core.c
index bb5c569..b5c6a1b 100644
--- a/drivers/mcb/mcb-core.c
+++ b/drivers/mcb/mcb-core.c
@@ -280,8 +280,8 @@ struct mcb_bus *mcb_alloc_bus(struct device *carrier)
 
 	bus_nr = ida_simple_get(&mcb_ida, 0, 0, GFP_KERNEL);
 	if (bus_nr < 0) {
-		rc = bus_nr;
-		goto err_free;
+		kfree(bus);
+		return ERR_PTR(bus_nr);
 	}
 
 	bus->bus_nr = bus_nr;
@@ -296,12 +296,11 @@ struct mcb_bus *mcb_alloc_bus(struct device *carrier)
 	dev_set_name(&bus->dev, "mcb:%d", bus_nr);
 	rc = device_add(&bus->dev);
 	if (rc)
-		goto err_free;
+		goto err_put;
 
 	return bus;
-err_free:
-	put_device(carrier);
-	kfree(bus);
+err_put:
+	put_device(&bus->dev);
 	return ERR_PTR(rc);
 }
 EXPORT_SYMBOL_GPL(mcb_alloc_bus);
-- 
2.7.4


