Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBDD2C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FF3121907
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556116841;
	bh=rnYHP/ytZlYxURfI0v411Cq7cakYVK3w410C97OhC/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XWHkSxpNz2f8mgoL853XkpC1j8DgBU3xzR1JKgImnaUf8F/CJmVpRwBngOkRbQV6T
	 xK5trFMsylQ5XE5lb49Wuaq6QeuAxaVbTOFNLl6Quh3RQlE74yMVwlLqpusWUywSAH
	 QprAFi7XQwj2bgWcWioBqR5XrXYuWOzz9bEpm1lE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731992AbfDXOkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:40:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:43070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731958AbfDXOkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:40:33 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5AF8721902;
        Wed, 24 Apr 2019 14:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556116832;
        bh=rnYHP/ytZlYxURfI0v411Cq7cakYVK3w410C97OhC/8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QVkZB1QldfLJ32Eykc2rQ7AECS4z8hK926ooyhWC3aPXknnyeDQJ2GGHsCCmg67bF
         ojaBzh6qkgyEwi9osmfGu6k0VnOMQlCDgiz9QH3PldvPBnl8L0wxhwr4SfnH/Trri/
         jsI0qBzJfcpN4Zo8jQ8oqdNsKD5KWEW5wy8eEx+I=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Peng Hao <peng.hao2@zte.com.cn>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 35/52] arm/mach-at91/pm : fix possible object reference leak
Date:   Wed, 24 Apr 2019 10:38:53 -0400
Message-Id: <20190424143911.28890-35-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190424143911.28890-1-sashal@kernel.org>
References: <20190424143911.28890-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Hao <peng.hao2@zte.com.cn>

[ Upstream commit ba5e60c9b75dec92d4c695b928f69300b17d7686 ]

of_find_device_by_node() takes a reference to the struct device
when it finds a match via get_device. When returning error we should
call put_device.

Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mach-at91/pm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 32fae4dbd63b..0921e2c10edf 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -594,13 +594,13 @@ static int __init at91_pm_backup_init(void)
 
 	np = of_find_compatible_node(NULL, NULL, "atmel,sama5d2-securam");
 	if (!np)
-		goto securam_fail;
+		goto securam_fail_no_ref_dev;
 
 	pdev = of_find_device_by_node(np);
 	of_node_put(np);
 	if (!pdev) {
 		pr_warn("%s: failed to find securam device!\n", __func__);
-		goto securam_fail;
+		goto securam_fail_no_ref_dev;
 	}
 
 	sram_pool = gen_pool_get(&pdev->dev, NULL);
@@ -623,6 +623,8 @@ static int __init at91_pm_backup_init(void)
 	return 0;
 
 securam_fail:
+	put_device(&pdev->dev);
+securam_fail_no_ref_dev:
 	iounmap(pm_data.sfrbu);
 	pm_data.sfrbu = NULL;
 	return ret;
-- 
2.19.1

