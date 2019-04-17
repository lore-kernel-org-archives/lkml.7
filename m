Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F4FC282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 15:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8651420652
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 15:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="SfyP+U5G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732753AbfDQP1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 11:27:55 -0400
Received: from m50-138.163.com ([123.125.50.138]:52110 "EHLO m50-138.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732719AbfDQP1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 11:27:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=NCWS3yc7MwovTkphH9
        ApLdhcE57NsDmtG6xOaqw9beM=; b=SfyP+U5G9o/hhPYHzdA3Kah4u5JVJ+yfaw
        shcWahP/A1tBd2Op2zj/NUbq8RJzit9qMWgd+tfvdjsRs4m3NTlHZWyjSScxt6/6
        axL1Sr5oFjTZgRb4MBhuz30g7XiONkoeUJVggrU7dWch5hifWdo+6P19pyXbdLe+
        FjQf51ZQk=
Received: from bp.localdomain (unknown [218.106.182.174])
        by smtp1 (Coremail) with SMTP id C9GowAD3_GjbRbdcgacyAw--.603S3;
        Wed, 17 Apr 2019 23:27:27 +0800 (CST)
From:   Pan Bian <bianpan2016@163.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Joel Stanley <joel@jms.id.au>
Cc:     linux-kernel@vger.kernel.org, Pan Bian <bianpan2016@163.com>
Subject: fsi: use put_device to release resource on error path
Date:   Wed, 17 Apr 2019 23:27:11 +0800
Message-Id: <1555514831-124442-1-git-send-email-bianpan2016@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: C9GowAD3_GjbRbdcgacyAw--.603S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF18uF1rJr45tr43Wr45Wrg_yoWfCrgEka
        1Uurn7Xr4UWa4DA3WYvFWrZrZ29as8WF1rGF1kta4rGryIvr13Zw17Xr4kAa1UWrs7JFWq
        qrWqgr4fA3s8WjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUULFx5UUUUU==
X-Originating-IP: [218.106.182.174]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/xtbBUR+ZclaD2H1MKgAAsz
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the function fsi_slave_init, kfree is used to release slave if error
occurs during set smode. Some fields of slave will not be released.
Resulting in memory leak. Instread, put_device should be used to
correctly release resources.

Fixes: d1dcd6782576("fsi: Add cfam char devices")
Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 drivers/fsi/fsi-core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index 2c31563..2bb6625 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -1056,8 +1056,7 @@ static int fsi_slave_init(struct fsi_master *master, int link, uint8_t id)
 		dev_warn(&master->dev,
 				"can't set smode on slave:%02x:%02x %d\n",
 				link, id, rc);
-		kfree(slave);
-		return -ENODEV;
+		goto err_free;
 	}
 	if (master->link_config)
 		master->link_config(master, link,
-- 
2.7.4

