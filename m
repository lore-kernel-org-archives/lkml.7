Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7B1C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF80521655
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557153380;
	bh=nGmKw7oEcz7t/3WCPMGsy5WKp48TzXsV/M5wENwuxF8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EQK4d7DkgdEkMGjIeZSHihK9NXTggpbSjeUGtfDez08Va3AOW54zrTfo5q5EqYFy/
	 13Flo3JOLQF7w0dH9I/ddfggbVZfTGlJMsg6lukG9xCvaZ5HB+JWD4B3Y9lHBTa3/M
	 5e9gnwaVhUZnfOhCg8pBMX69iPaGzOFauNY44kR4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfEFOgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 10:36:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:56598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727127AbfEFOgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:36:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6896E20C01;
        Mon,  6 May 2019 14:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557153375;
        bh=nGmKw7oEcz7t/3WCPMGsy5WKp48TzXsV/M5wENwuxF8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=epVBLkrigMyU8yd/rTfWbJCp237oS4STsAq4ZX5V8ZENfpdf4SG5DA82CT59ptYT9
         OSeLHIrs1vIZNlmmhIWt1/xVWEcQiSFh/dGrsBJqCDGzvd2u4ZWQKJILrnMcWSHedf
         rg/E02vx2jUYUO/H1LBQ7Q7xG5pTSwN9RzszJbqU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mukesh Ojha <mojha@codeaurora.org>,
        Peng Hao <peng.hao2@zte.com.cn>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        "Sasha Levin (Microsoft)" <sashal@kernel.org>
Subject: [PATCH 5.0 065/122] arm/mach-at91/pm : fix possible object reference leak
Date:   Mon,  6 May 2019 16:32:03 +0200
Message-Id: <20190506143100.794247114@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190506143054.670334917@linuxfoundation.org>
References: <20190506143054.670334917@linuxfoundation.org>
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
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 arch/arm/mach-at91/pm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 51e808adb00c..2a757dcaa1a5 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -591,13 +591,13 @@ static int __init at91_pm_backup_init(void)
 
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
@@ -620,6 +620,8 @@ static int __init at91_pm_backup_init(void)
 	return 0;
 
 securam_fail:
+	put_device(&pdev->dev);
+securam_fail_no_ref_dev:
 	iounmap(pm_data.sfrbu);
 	pm_data.sfrbu = NULL;
 	return ret;
-- 
2.20.1



