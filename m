Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD7FC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 042AB2053B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557154893;
	bh=TfJ5KHkL1zHX9fsEI4Y7iL8punVmYs3scVECbtPu8WE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y/yVrZEGlzupuGwLHO9IyaQ9UTnv3iurJ3tmXdUXZMFRdKdL9BV6RxmzDWOxuYh+N
	 cgHsQImzLujT94xWHrkAWOWoDhU8sqplynaAPfErvpyK2hPvAW3GXc9Iw5hZy9RbQB
	 8zPeHtnAte8LH2duf+aAMFgY8ZcXVTvt2326HvlM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbfEFOlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 10:41:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:35142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727417AbfEFOlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:41:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A158E20449;
        Mon,  6 May 2019 14:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557153675;
        bh=TfJ5KHkL1zHX9fsEI4Y7iL8punVmYs3scVECbtPu8WE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XrDSLfdzcwyW4F0KjEoo3Ug3PB9sfvAlNmJxMJgB3RaZ9NkGXTO9tMjG7bFdoCjda
         QF08ErTb7QhkN+hes2186FjZtVmRhHGVZy15l8/Ow6VWTLqDmfxIOf5kMfy9g9eJRS
         MUGwI7l9MBOjiKK575uO71i32h5pSA/b6TFJkwQc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mukesh Ojha <mojha@codeaurora.org>,
        Peng Hao <peng.hao2@zte.com.cn>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 53/99] arm/mach-at91/pm : fix possible object reference leak
Date:   Mon,  6 May 2019 16:32:26 +0200
Message-Id: <20190506143058.874499949@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190506143053.899356316@linuxfoundation.org>
References: <20190506143053.899356316@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
2.20.1



