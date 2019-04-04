Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCA3C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63AA62147C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369150;
	bh=5CVdNzNVIl8Z4xpNUdyZ11p2qDuMYmRx7E56Bo7WVSM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=S/7AMxPWb7Y7Be4iYh7MsszdwSQRDSu7Cwmx4PjuHhD/XTZl2+lI1gWwC0zyu3dOm
	 o+XhyekyD9bVMrocHr9tzjbh1XCpt1ocxGuCUkvfnIjyd/6hhVrG9K5I9Nuw0JBytg
	 yqi9QSNqhFs1LilR+jsxtzXCJXyz7w1D0dXeaxY4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387406AbfDDJM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:12:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:52452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733311AbfDDJMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:12:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B02442147C;
        Thu,  4 Apr 2019 09:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369144;
        bh=5CVdNzNVIl8Z4xpNUdyZ11p2qDuMYmRx7E56Bo7WVSM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pgC1TDaPq7HLNifG8meLlHDQP6Hg+KULMmPJPyY5pEAAPq1Iv5DbamxhSPKT1Dmm7
         vxHQCczW/AKjBuA08Hubcgjl4XcVdjGwgFWZuhSZgVPvDVt29/uE6/FCSd8Ag7J+Q7
         jZZcksg0nesSpYhfel+yKpEaWUk9OkYh7Sd4n/j4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 100/246] powerpc/44x: Force PCI on for CURRITUCK
Date:   Thu,  4 Apr 2019 10:46:40 +0200
Message-Id: <20190404084622.646031355@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit aa7150ba378650d0e9d84b8e4d805946965a5926 ]

The recent rework of PCI kconfig symbols exposed an existing bug in
the CURRITUCK kconfig logic.

It selects PPC4xx_PCI_EXPRESS which depends on PCI, but PCI is user
selectable and might be disabled, leading to a warning:

  WARNING: unmet direct dependencies detected for PPC4xx_PCI_EXPRESS
    Depends on [n]: PCI [=n] && 4xx [=y]
    Selected by [y]:
    - CURRITUCK [=y] && PPC_47x [=y]

Prior to commit eb01d42a7778 ("PCI: consolidate PCI config entry in
drivers/pci") PCI was enabled by default for currituck_defconfig so we
didn't see the warning. The bad logic was still there, it just
required someone disabling PCI in their .config to hit it.

Fix it by forcing PCI on for CURRITUCK, which seems was always the
expectation anyway.

Fixes: eb01d42a7778 ("PCI: consolidate PCI config entry in drivers/pci")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/platforms/44x/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/Kconfig
index 4a9a72d01c3c..35be81fd2dc2 100644
--- a/arch/powerpc/platforms/44x/Kconfig
+++ b/arch/powerpc/platforms/44x/Kconfig
@@ -180,6 +180,7 @@ config CURRITUCK
 	depends on PPC_47x
 	select SWIOTLB
 	select 476FPE
+	select FORCE_PCI
 	select PPC4xx_PCI_EXPRESS
 	help
 	  This option enables support for the IBM Currituck (476fpe) evaluation board
-- 
2.19.1



