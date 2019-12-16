Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C619C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 330C021582
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576518833;
	bh=YuhEBZJyMt+Lfrvbqcx6l9FpzFwOKU9CEJ0Qd0iJNmM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yrG6LiEyn51VV02GFrUni1FmQQSnwFR3b+gOt697la4q1FY9u+V2YCHaq/NB/yzZv
	 z5G6JWVZdgXgw7umeyS+Z569esAL3aIz/peAi0NSb3C3swpY+W5FndHJhFIRbKhL51
	 yOG5NF2quGv9eY4gaQKecBz7qZoha0mgFiXAJXJM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfLPRxv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 12:53:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:48534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727815AbfLPRxs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 12:53:48 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83D90206D3;
        Mon, 16 Dec 2019 17:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576518828;
        bh=YuhEBZJyMt+Lfrvbqcx6l9FpzFwOKU9CEJ0Qd0iJNmM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PT4YcMc8H8DzLIZXSiFhNW8eewErzIOgn7vASoklM0IBCNBTcSK3urEdBrqWt8VpU
         p0+O8oWNHQf2u5mk9mpeASQuAkIF7ezlhJI0MIJwSEBJ8g7ZjYUUOA8UpVKebquVOZ
         TMUInt7HkS975mQsMiMzqweySElj6mpSlCSe6uJw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 083/267] ARM: OMAP1/2: fix SoC name printing
Date:   Mon, 16 Dec 2019 18:46:49 +0100
Message-Id: <20191216174857.514249153@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174848.701533383@linuxfoundation.org>
References: <20191216174848.701533383@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aaro Koskinen <aaro.koskinen@iki.fi>

[ Upstream commit 04a92358b3964988c78dfe370a559ae550383886 ]

Currently we get extra newlines on OMAP1/2 when the SoC name is printed:

[    0.000000] OMAP1510
[    0.000000]  revision 2 handled as 15xx id: bc058c9b93111a16

[    0.000000] OMAP2420
[    0.000000]

Fix by using pr_cont.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mach-omap1/id.c | 6 +++---
 arch/arm/mach-omap2/id.c | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap1/id.c b/arch/arm/mach-omap1/id.c
index 52de382fc8047..7e49dfda3d2f4 100644
--- a/arch/arm/mach-omap1/id.c
+++ b/arch/arm/mach-omap1/id.c
@@ -200,10 +200,10 @@ void __init omap_check_revision(void)
 		printk(KERN_INFO "Unknown OMAP cpu type: 0x%02x\n", cpu_type);
 	}
 
-	printk(KERN_INFO "OMAP%04x", omap_revision >> 16);
+	pr_info("OMAP%04x", omap_revision >> 16);
 	if ((omap_revision >> 8) & 0xff)
-		printk(KERN_INFO "%x", (omap_revision >> 8) & 0xff);
-	printk(KERN_INFO " revision %i handled as %02xxx id: %08x%08x\n",
+		pr_cont("%x", (omap_revision >> 8) & 0xff);
+	pr_cont(" revision %i handled as %02xxx id: %08x%08x\n",
 	       die_rev, omap_revision & 0xff, system_serial_low,
 	       system_serial_high);
 }
diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 16cb1c195fd8e..79d71b1eae594 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -199,8 +199,8 @@ void __init omap2xxx_check_revision(void)
 
 	pr_info("%s", soc_name);
 	if ((omap_rev() >> 8) & 0x0f)
-		pr_info("%s", soc_rev);
-	pr_info("\n");
+		pr_cont("%s", soc_rev);
+	pr_cont("\n");
 }
 
 #define OMAP3_SHOW_FEATURE(feat)		\
-- 
2.20.1



