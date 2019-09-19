Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 704FEC49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44FD721928
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568930945;
	bh=QEOXCkAFfbkcYXS6txlrgPu4vS3DygSi0dUG+iUNWG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d8bj4aZ9d31NpwPOV7pXpiCCIGDqBzV/C4gh/U+ahG4xe+bu/JBuaK2RRFtYlJ3Uw
	 SfbidIAbBS/Mzi2D9Sqnh7xuiOk61qFgVymJAjxkUjalYYxS+YiS20LSwiKcmLPBrn
	 SfSBn/Ajis1k2xFiD9dL1wiqOC7lUEv02a1zyI7I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405349AbfISWJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 18:09:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:46722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393461AbfISWIq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:08:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BA2A218AF;
        Thu, 19 Sep 2019 22:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568930925;
        bh=QEOXCkAFfbkcYXS6txlrgPu4vS3DygSi0dUG+iUNWG0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oHDRRY1xqHrDOeBaPik1eVnt42EFFASAF1rsw/5V2GcKhKBCkcemM45dujrhFMq10
         iNa9Lm3muMUFaLlwCMBLfXkeqEyO/7JJOPfQ1FtHfgwepGcrBl7NWHqJPBfYDAyjLG
         aVFteV5YuQxPiVnAigV/VhiTiT4w/poe9ZYgcyKU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 037/124] ARM: OMAP2+: Fix omap4 errata warning on other SoCs
Date:   Fri, 20 Sep 2019 00:02:05 +0200
Message-Id: <20190919214820.363334347@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190919214819.198419517@linuxfoundation.org>
References: <20190919214819.198419517@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit 45da5e09dd32fa98c32eaafe2513db6bd75e2f4f ]

We have errata i688 workaround produce warnings on SoCs other than
omap4 and omap5:

omap4_sram_init:Unable to allocate sram needed to handle errata I688
omap4_sram_init:Unable to get sram pool needed to handle errata I688

This is happening because there is no ti,omap4-mpu node, or no SRAM
to configure for the other SoCs, so let's remove the warning based
on the SoC revision checks.

As nobody has complained it seems that the other SoC variants do not
need this workaround.

Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mach-omap2/omap4-common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index f9c02f9f1c921..5c3845730dbf5 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -127,6 +127,9 @@ static int __init omap4_sram_init(void)
 	struct device_node *np;
 	struct gen_pool *sram_pool;
 
+	if (!soc_is_omap44xx() && !soc_is_omap54xx())
+		return 0;
+
 	np = of_find_compatible_node(NULL, NULL, "ti,omap4-mpu");
 	if (!np)
 		pr_warn("%s:Unable to allocate sram needed to handle errata I688\n",
-- 
2.20.1



