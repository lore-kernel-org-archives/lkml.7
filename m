Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BB8C3E8AB
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 11:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28C402084D
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 11:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbfJELVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 07:21:13 -0400
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:33774 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbfJELVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 07:21:13 -0400
Received: from localhost.localdomain ([93.22.148.54])
        by mwinf5d13 with ME
        id 9nM52100B1AfE5H03nM6cy; Sat, 05 Oct 2019 13:21:09 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 05 Oct 2019 13:21:09 +0200
X-ME-IP: 93.22.148.54
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     maximlevitsky@gmail.com, oakad@yahoo.com, ulf.hansson@linaro.org,
        will@kernel.org, gustavo.pimentel@synopsys.com,
        colin.king@canonical.com, gustavo@embeddedor.com,
        efremov@linux.com, tglx@linutronix.de, yuehaibing@huawei.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] memstick: jmb38x_ms: Fix an error handling path in 'jmb38x_ms_probe()'
Date:   Sat,  5 Oct 2019 13:21:01 +0200
Message-Id: <20191005112101.14410-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If 'jmb38x_ms_count_slots()' returns 0, we must undo the previous
'pci_request_regions()' call.

Goto 'err_out_int' to fix it.

Fixes: 60fdd931d577 ("memstick: add support for JMicron jmb38x MemoryStick host controller")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/memstick/host/jmb38x_ms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memstick/host/jmb38x_ms.c b/drivers/memstick/host/jmb38x_ms.c
index c4a477643977..0a9c5ddf2f59 100644
--- a/drivers/memstick/host/jmb38x_ms.c
+++ b/drivers/memstick/host/jmb38x_ms.c
@@ -941,7 +941,7 @@ static int jmb38x_ms_probe(struct pci_dev *pdev,
 	if (!cnt) {
 		rc = -ENODEV;
 		pci_dev_busy = 1;
-		goto err_out;
+		goto err_out_int;
 	}
 
 	jm = kzalloc(sizeof(struct jmb38x_ms)
-- 
2.20.1

