Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E56C432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 20:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4ADC20729
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 20:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfKQUoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 15:44:05 -0500
Received: from ch3vs05.rockwellcollins.com ([205.175.226.130]:63152 "EHLO
        ch3vs05.rockwellcollins.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726128AbfKQUoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 15:44:05 -0500
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Nov 2019 15:44:05 EST
IronPort-SDR: yJ8pmNvtDVPJ9RfHdaTR6KZdYTsZrXL97+YIAVwaDZo1jnNuGEiGR14rJM/kbU98ptwXosF43S
 /nNAVnYpZmQz74d3G+wf9tw74iaR8U0+XrobfVsG6gdWJwKSDbvg3rRkCi6+exYdTOtcHshktl
 bOrXR4cx2eugSzy8yW05DbXQ7CMJfKkoYmckaof8zDMvUg9R6a4KyC49XkRO/Yc9+5tZCdSWhB
 lmdq+j3KZogMzmnlRyFVkGXZE/W+SO2MoP/met7nvQ7SvmPtQ8qS11+mm+AbrNg1q2QHiMbH7X
 kio=
Received: from ofwch3n02.rockwellcollins.com (HELO dtulimr01.rockwellcollins.com) ([205.175.226.14])
  by ch3vs05.rockwellcollins.com with ESMTP; 17 Nov 2019 14:36:58 -0600
X-Received: from righttwix.rockwellcollins.com (righttwix.rockwellcollins.com [192.168.141.218])
        by dtulimr01.rockwellcollins.com (Postfix) with ESMTP id 6816E6041C;
        Sun, 17 Nov 2019 14:36:57 -0600 (CST)
From:   Brandon Maier <brandon.maier@rockwellcollins.com>
To:     linux-kernel@vger.kernel.org
Cc:     jassisinghbrar@gmail.com,
        Brandon Maier <brandon.maier@rockwellcollins.com>
Subject: [PATCH] mailbox/omap: Handle if CONFIG_PM is disabled
Date:   Sun, 17 Nov 2019 14:36:49 -0600
Message-Id: <20191117203649.15208-1-brandon.maier@rockwellcollins.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_PM is disabled, pm_runtime_put_sync() returns -ENOSYS.

Signed-off-by: Brandon Maier <brandon.maier@rockwellcollins.com>
---
 drivers/mailbox/omap-mailbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/omap-mailbox.c b/drivers/mailbox/omap-mailbox.c
index a3cd63583cf7..5978a35aac6d 100644
--- a/drivers/mailbox/omap-mailbox.c
+++ b/drivers/mailbox/omap-mailbox.c
@@ -868,7 +868,7 @@ static int omap_mbox_probe(struct platform_device *pdev)
 	dev_info(mdev->dev, "omap mailbox rev 0x%x\n", l);
 
 	ret = pm_runtime_put_sync(mdev->dev);
-	if (ret < 0)
+	if (ret < 0 && ret != -ENOSYS)
 		goto unregister;
 
 	devm_kfree(&pdev->dev, finfoblk);
-- 
2.23.0

