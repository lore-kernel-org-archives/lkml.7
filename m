Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9625EC742AE
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 09:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79AE22064B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 09:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfGLJiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 05:38:16 -0400
Received: from ozlabs.ru ([107.173.13.209]:58430 "EHLO ozlabs.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbfGLJiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 05:38:16 -0400
X-Greylist: delayed 493 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Jul 2019 05:38:15 EDT
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
        by ozlabs.ru (Postfix) with ESMTP id 90D15AE80571;
        Fri, 12 Jul 2019 05:29:58 -0400 (EDT)
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
To:     linux-kernel@vger.kernel.org
Cc:     "Oliver O'Halloran" <oohall@gmail.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Sam Bobroff <sbobroff@linux.ibm.com>,
        Alistair Popple <alistair@popple.id.au>,
        Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: [PATCH kernel v4 0/4] powerpc/ioda2: Yet another attempt to allow DMA masks between 32 and 59
Date:   Fri, 12 Jul 2019 19:29:51 +1000
Message-Id: <20190712092955.56218-1-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an attempt to allow DMA masks between 32..59 which are not large
enough to use either a PHB3 bypass mode or a sketchy bypass. Depending
on the max order, up to 40 is usually available.


This is based on sha1
a2b6f26c264e Christophe Leroy "powerpc/module64: Use symbolic instructions names.".

Please comment. Thanks.



Alexey Kardashevskiy (4):
  powerpc/powernv/ioda: Fix race in TCE level allocation
  powerpc/iommu: Allow bypass-only for DMA
  powerpc/powernv/ioda2: Allocate TCE table levels on demand for default
    DMA window
  powerpc/powernv/ioda2: Create bigger default window with 64k IOMMU
    pages

 arch/powerpc/include/asm/iommu.h              |  8 +-
 arch/powerpc/platforms/powernv/pci.h          |  2 +-
 arch/powerpc/kernel/dma-iommu.c               | 11 ++-
 arch/powerpc/kernel/iommu.c                   | 74 +++++++++++++------
 arch/powerpc/platforms/powernv/pci-ioda-tce.c | 38 ++++++----
 arch/powerpc/platforms/powernv/pci-ioda.c     | 40 ++++++++--
 6 files changed, 121 insertions(+), 52 deletions(-)

-- 
2.17.1

