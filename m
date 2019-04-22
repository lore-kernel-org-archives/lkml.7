Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 426C1C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 047DC2075A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555963442;
	bh=zM9sG0IzfsYUlFjFZF9jYc/HS/oFBdSZvNIYTLAxtEA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ICwL3ojOneXtmYxNSHTbMJfldHdDESrH/ugb+8cDWjjSwuMkZH4JMvZKSKCdBziDL
	 3kdFsG8ZVhWVaAJUgs+c0oNSGJiAgAG1KzDzDf/vMcT/BeFMzRZWm63qNtL60lA3Y7
	 TvqIzaQ7tS0ce3DGmIe1iB8LzxHYxQJUe/7+k8sA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732164AbfDVUEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 16:04:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:47670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729307AbfDVTpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:45:47 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B11E7218EA;
        Mon, 22 Apr 2019 19:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962346;
        bh=zM9sG0IzfsYUlFjFZF9jYc/HS/oFBdSZvNIYTLAxtEA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NzOHkq9yezILcU0A3yTTx11WuleOgG77flHp+xYRDulXJj6RJy2m4k0L1rHJyor7v
         QjC4bdF7Ik5syz9eCJdg71Q0BjyG2fc/8D8icz40qlMmsmu6pz/E/OIqvXhEnXunvh
         Adowh8C05yf2z7O0NCDcssheCnx8/Ppifk8jAJWU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wen Yang <wen.yang99@zte.com.cn>,
        Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 15/68] ARM: imx51: fix a leaked reference by adding missing of_node_put
Date:   Mon, 22 Apr 2019 15:44:23 -0400
Message-Id: <20190422194516.11634-15-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194516.11634-1-sashal@kernel.org>
References: <20190422194516.11634-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wen Yang <wen.yang99@zte.com.cn>

[ Upstream commit 0c17e83fe423467e3ccf0a02f99bd050a73bbeb4 ]

The call to of_get_next_child returns a node pointer with refcount
incremented thus it must be explicitly decremented after the last
usage.

Detected by coccinelle with the following warnings:
./arch/arm/mach-imx/mach-imx51.c:64:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 57, but without a corresponding object release within this function.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 arch/arm/mach-imx/mach-imx51.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/mach-imx51.c b/arch/arm/mach-imx/mach-imx51.c
index c7169c2f94c4..08c7892866c2 100644
--- a/arch/arm/mach-imx/mach-imx51.c
+++ b/arch/arm/mach-imx/mach-imx51.c
@@ -59,6 +59,7 @@ static void __init imx51_m4if_setup(void)
 		return;
 
 	m4if_base = of_iomap(np, 0);
+	of_node_put(np);
 	if (!m4if_base) {
 		pr_err("Unable to map M4IF registers\n");
 		return;
-- 
2.19.1

