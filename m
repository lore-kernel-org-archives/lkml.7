Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45531C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09EE021670
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556811105;
	bh=TlKxbaWIZGpv9TtVGGYTktQJNZ3Mj7RiqgeTUz7E6qw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=G3Lg6n0UB7L4/7bFBWF76C1HvsHzElJXzAE5GpDowdZ/PdGxC83gqylKL76UNn8qM
	 6JaCR6Yw1+a4f9mO9hq1tHmAYECfJL8RSMl9qs0cnj2sJOIstFpgsjIVXGfciOPAtS
	 WMLpEjwja9kMsay/d4Y1UaLod5SIkRXLch/PkBfQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729036AbfEBPbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 11:31:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:50874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729006AbfEBPbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 11:31:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 319F920675;
        Thu,  2 May 2019 15:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556811100;
        bh=TlKxbaWIZGpv9TtVGGYTktQJNZ3Mj7RiqgeTUz7E6qw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kde0dDBaf5ABZE1E3FKgNjGR3gScB/kl8F3+NsdrLrXh2wqJfojpJ1RSWdXqVFUsQ
         VSY1xJrEJPvgc8Fyh29yhuPhS3s4GFc3+QU/9TcdDXUeLTWA0DAunZfrDBJxJSTE5e
         YcqmXExxRCpBE4b9wLmtN4m6ERjyvZVgs7pAYtoA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wen Yang <wen.yang99@zte.com.cn>,
        Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        "Sasha Levin (Microsoft)" <sashal@kernel.org>
Subject: [PATCH 5.0 028/101] ARM: imx51: fix a leaked reference by adding missing of_node_put
Date:   Thu,  2 May 2019 17:20:30 +0200
Message-Id: <20190502143341.577830056@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190502143339.434882399@linuxfoundation.org>
References: <20190502143339.434882399@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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



