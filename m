Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9680BC10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 644E72133D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551368000;
	bh=2Rv7brahYN8Uz9rnNkGYlc8II7kelXFK7zP2hogbRlA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OXwyZ8yiT1cQ92iIYDurODPVMuJ8CrSwRFAfl2VlA2KOPdPacd5+BNj7lMoxXEmqw
	 WyVrtbncoQ6D5M48zZUKRUh7OXoKe8Y+qNac2E49mxUtJn+psI8qdag7+qbL0uQpeR
	 9TAAp//e0TZpnKHWKJwi/kehwK43hPjbwxCOkcrg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733120AbfB1PIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:08:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:41086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733032AbfB1PIo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:08:44 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E6FD218B0;
        Thu, 28 Feb 2019 15:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366524;
        bh=2Rv7brahYN8Uz9rnNkGYlc8II7kelXFK7zP2hogbRlA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c6D059fEaZ4eVf/uGi6HvsoMS6M2TSykH2ioOet1raDdtDdFW7sCPgJDXFvD9kIgi
         kIpe64aUCpXITDMENw8NmI0YSd1gUa+fhMacmiRAVMNSCnEnwyMx7XOqVxIWwnQY8T
         Vy6KKoaST40zFHhNz9WOlmsLbcMenc1OgpBnxERU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Peng Hao <peng.hao2@zte.com.cn>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 18/81] ARM: pxa: ssp: unneeded to free devm_ allocated data
Date:   Thu, 28 Feb 2019 10:07:10 -0500
Message-Id: <20190228150813.10256-18-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228150813.10256-1-sashal@kernel.org>
References: <20190228150813.10256-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Hao <peng.hao2@zte.com.cn>

[ Upstream commit ba16adeb346387eb2d1ada69003588be96f098fa ]

devm_ allocated data will be automatically freed. The free
of devm_ allocated data is invalid.

Fixes: 1c459de1e645 ("ARM: pxa: ssp: use devm_ functions")
Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
[title's prefix changed]
Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/plat-pxa/ssp.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/plat-pxa/ssp.c b/arch/arm/plat-pxa/ssp.c
index ed36dcab80f1e..f519199741837 100644
--- a/arch/arm/plat-pxa/ssp.c
+++ b/arch/arm/plat-pxa/ssp.c
@@ -190,8 +190,6 @@ static int pxa_ssp_remove(struct platform_device *pdev)
 	if (ssp == NULL)
 		return -ENODEV;
 
-	iounmap(ssp->mmio_base);
-
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	release_mem_region(res->start, resource_size(res));
 
@@ -201,7 +199,6 @@ static int pxa_ssp_remove(struct platform_device *pdev)
 	list_del(&ssp->node);
 	mutex_unlock(&ssp_lock);
 
-	kfree(ssp);
 	return 0;
 }
 
-- 
2.19.1

