Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62FA7C10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 07:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25352214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 07:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Q1sf1Rhk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388152AbfDRHX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 03:23:59 -0400
Received: from m50-132.163.com ([123.125.50.132]:41047 "EHLO m50-132.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731317AbfDRHX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 03:23:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=A2avxIEXMxtUFGqdlf
        UaJw2dGK5fmozKEPD9FwObH70=; b=Q1sf1Rhku4O9XOBto8Sjj0Gd2pxHy4Z5AH
        nuo2LuqplfA64do2+Ibq9t0wNt4N8TZPUeQikn3BFBPAOVhIxiAj0N2i1Y/HL6+f
        oGkN/EyRZCWC4TToyPMKbadPhzUEESDh1isKIGJIMzCN0KaaLvnp93wPg7pG2Z9o
        1ZlnOmXlU=
Received: from bp.localdomain (unknown [218.106.182.174])
        by smtp2 (Coremail) with SMTP id DNGowACniR_TJbhcX+MIAA--.174S3;
        Thu, 18 Apr 2019 15:23:06 +0800 (CST)
From:   Pan Bian <bianpan2016@163.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pan Bian <bianpan2016@163.com>
Subject: stm class: Fix possible double free
Date:   Thu, 18 Apr 2019 15:22:58 +0800
Message-Id: <1555572178-73786-1-git-send-email-bianpan2016@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: DNGowACniR_TJbhcX+MIAA--.174S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7try3Cw4DAr1kCr1kKw1ftFb_yoW8GF43pa
        18Ga4Yyry8Krsrur1DJF18ZFy5GayIkw1ruFy0kwna9FZ8Z34vyryYya45CayDJrW8AFWa
        qFW3ArW8ur1UAw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UlkskUUUUU=
X-Originating-IP: [218.106.182.174]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/xtbBZBKaclQHEfe2+AAAsl
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function stm_register_device() calls put_device(&stm->dev) to
release allocated memory (in stm_device_release()) on error paths.
However, after that, the freed memory stm is released again, resulting
in a double free bug. There is a similar issue in the function
stm_source_register_device. This patch fixes these issues.

Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 drivers/hwtracing/stm/core.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
index c7ba8ac..cfb5c4d 100644
--- a/drivers/hwtracing/stm/core.c
+++ b/drivers/hwtracing/stm/core.c
@@ -886,8 +886,10 @@ int stm_register_device(struct device *parent, struct stm_data *stm_data,
 		return -ENOMEM;
 
 	stm->major = register_chrdev(0, stm_data->name, &stm_fops);
-	if (stm->major < 0)
-		goto err_free;
+	if (stm->major < 0) {
+		vfree(stm);
+		return err;
+	}
 
 	device_initialize(&stm->dev);
 	stm->dev.devt = MKDEV(stm->major, 0);
@@ -933,8 +935,6 @@ int stm_register_device(struct device *parent, struct stm_data *stm_data,
 
 	/* matches device_initialize() above */
 	put_device(&stm->dev);
-err_free:
-	vfree(stm);
 
 	return err;
 }
@@ -1277,7 +1277,6 @@ int stm_source_register_device(struct device *parent,
 
 err:
 	put_device(&src->dev);
-	kfree(src);
 
 	return err;
 }
-- 
2.7.4


