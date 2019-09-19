Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A2CC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DC6D21907
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568931167;
	bh=qmsEjHrRZCpwx/XrFU4kSpvkC/FoRbT7gOt7GZYWx0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I9kUR4DkmYSkG7u9E5MsCKV5xbGFYH/W83sMAiKR1A1FDMBfCMU5mxWzGIAf90CbU
	 CrTKe6ZDd8fZqe9KU0Ol304xZFThRh5uPAcNFU7R6gumWZXbre1LxZQ12tASC/v7Gz
	 8y0JX7uW7kOQzGmYC+t4fLfli2kuxYT265P35n1w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393686AbfISWMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 18:12:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:51702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393668AbfISWMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:12:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B07921928;
        Thu, 19 Sep 2019 22:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568931162;
        bh=qmsEjHrRZCpwx/XrFU4kSpvkC/FoRbT7gOt7GZYWx0I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ByNuIaYctnUZ70rd9JjXH3wOjgMqX0pNrTQrj91wR7VlXkq5xPibFrBrMoAyL6PRz
         iYOtE+aFd4mGcRxsfsvWD0Yic3HVpw4LOLdmqw/JeOquhN5Ub0nLmB4GUPHMgDJ91a
         UMgGgVStNyj+4oNXkL81TObEOv8cTZQ48Q3/KKFs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 25/79] ARM: OMAP2+: Fix omap4 errata warning on other SoCs
Date:   Fri, 20 Sep 2019 00:03:10 +0200
Message-Id: <20190919214810.172247189@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190919214807.612593061@linuxfoundation.org>
References: <20190919214807.612593061@linuxfoundation.org>
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
index b226c8aaf8b1c..7074cfd1ff413 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -131,6 +131,9 @@ static int __init omap4_sram_init(void)
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



