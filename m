Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69366C10F00
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 327F1206C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553714815;
	bh=Ke7PKD/eQdDk1TotwE2Zwkfq6hKB7erw5boECmEx25I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OS6HjFUVT/EWivdhXM04HFHLMjrFg48OOn0YCe7FkQVxzlf66TPBc34Sg9zCLaDbO
	 EYHSmjRcSKECHunMFxHq534vh3w3qlz1CjqQK9YEqs1K7zXdG95znOE061p6wL62M5
	 sVnYynDHP1FMI6irXvxABmwtolmWLTmdn7LHxC5c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388144AbfC0TZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:25:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:46240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387601AbfC0SFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:05:11 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E8F5217D9;
        Wed, 27 Mar 2019 18:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553709910;
        bh=Ke7PKD/eQdDk1TotwE2Zwkfq6hKB7erw5boECmEx25I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cghY5gvyWN6n2Y3eVVzFdsQ+vg0t28/A0nzI7fkjHYpJpDRsBlaqOAdOKvuhYeDvB
         dGEU+ivS9vCqoWpqmNxTnYmYMkZJpUqN77K3kKAyFcqCq0Th71dYf1mEa+8oxkHrQo
         iJJjBobRy3wVtq7V9cpiekReezxKZYhPSMsnMB+w=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 5.0 106/262] powerpc/44x: Force PCI on for CURRITUCK
Date:   Wed, 27 Mar 2019 13:59:21 -0400
Message-Id: <20190327180158.10245-106-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Ellerman <mpe@ellerman.id.au>

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

