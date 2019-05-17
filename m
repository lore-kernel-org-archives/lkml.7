Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E682C04AAF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 01:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F41B9206BF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 01:00:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="W0R/TFST"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbfEQBAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 21:00:01 -0400
Received: from smtp.aristanetworks.com ([52.0.43.43]:39212 "EHLO
        usvae2-clmxp01.aristanetworks.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726901AbfEQBAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 21:00:00 -0400
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 May 2019 21:00:00 EDT
Received: from usvae2-clmxp01.aristanetworks.com (localhost [127.0.0.1])
        by usvae2-clmxp01.aristanetworks.com (Postfix) with ESMTP id 60B3830D51F7;
        Thu, 16 May 2019 17:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
        s=Arista-A; t=1558054400;
        bh=gZKRKJcuRQSwe2TyYVhO9ixqNktFM8piGcLI2AKiDUY=;
        h=From:To:Cc:Subject:Date;
        b=W0R/TFSTzK9An9pCZ5cWXkyfD+NQGfUw4fj9BddSbmVeI5W9KzH3YhRfLvhMSTLbY
         XgELyp0YcG37szHF1Wl0s4/1b3fcpwQiGZPFcx6i7mu1suwFAbtPbHor6PXaZZtjI+
         qd17afeUKsWTE/T7zBFtO1+11PUu+pwBZxz2bb3pOb1pAUSALAUs82ymFrKW5iGgmc
         yv1jZ4VSZfU+Grw+1Tp2wbCCIfe80NKqZKfCyImCDkP8KBCtHVIzWAQlwAEg99Gg6c
         Aivf/3fVaDCuC+OjZqJ/VXsXS4jwy6iQPiQPZsOJ7gjJ8U0wZZyF5aM4I1pwCSABYj
         UOYSSg8c8kZxA==
Received: from chmeee (unknown [10.95.92.211])
        by usvae2-clmxp01.aristanetworks.com (Postfix) with ESMTP id 9C78E30D51F6;
        Thu, 16 May 2019 17:53:19 -0700 (PDT)
Received: from kevmitch by chmeee with local (Exim 4.92)
        (envelope-from <kevmitch@chmeee>)
        id 1hRR7e-00011A-Dt; Thu, 16 May 2019 17:53:18 -0700
From:   Kevin Mitchell <kevmitch@arista.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Kevin Mitchell <kevmitch@arista.com>
Subject: [PATCH 0/3] handle init errors more gracefully in amd_iommu
Date:   Thu, 16 May 2019 17:52:39 -0700
Message-Id: <20190517005242.20257-1-kevmitch@arista.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series makes error handling more robust in the amd_iommu init
code. It was initially motivated by problematic firmware that does not
set up the physical address of the iommu. This led to a NULL dereference
panic when iommu_disable was called during cleanup.

While the first patch is sufficient to avoid the panic, the subsequent
two move the cleanup closer to the actual error and avoid calling the
cleanup code twice when amd_iommu=off is specified on the command line.

I have tested this series on a variety of AMD CPUs with firmware
exhibiting the issue. I have additionally tested on platforms where the
firmware has been fixed. I tried both with and without amd_iommu=off. I
have also tested on older CPUs where no IOMMU is detected and even one
where the GART driver ends up running.

Thanks,

Kevin

Kevin Mitchell (3):
  iommu/amd: make iommu_disable safer
  iommu/amd: move gart fallback to amd_iommu_init
  iommu/amd: only free resources once on init error

 drivers/iommu/amd_iommu_init.c | 45 ++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 21 deletions(-)

-- 
2.20.1

