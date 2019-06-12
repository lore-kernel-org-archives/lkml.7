Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A97C46477
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A3C921473
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="1ceR8VNQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393616AbfFMRPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 13:15:03 -0400
Received: from smtp.aristanetworks.com ([52.0.43.43]:48978 "EHLO
        smtp.aristanetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728800AbfFLVwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 17:52:21 -0400
Received: from smtp.aristanetworks.com (localhost [127.0.0.1])
        by smtp.aristanetworks.com (Postfix) with ESMTP id A816030DD5A8;
        Wed, 12 Jun 2019 14:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
        s=Arista-A; t=1560376339;
        bh=gZKRKJcuRQSwe2TyYVhO9ixqNktFM8piGcLI2AKiDUY=;
        h=From:To:Cc:Subject:Date;
        b=1ceR8VNQckqIlWxoGgGn9zbBtPmVs/5npYY8OjtyIbVGHiciJtQ0dQNe4lKERZPMu
         6CixhkXs+XOyifhEnimauktjNu4j/0hBisAPV1usnGX4f2c7pT+Y2h8J0B2YdHfaSK
         q8B+AScT1PhpDKlgQAs1bWqRZOTxY7t7YAS5QPuxKeNL+33t+KICul0yaoW561kE1N
         h40tF1z2SrnXXl0oTL0gTm3N2v7XgMSJB9YHNeU2ojrjSalGGtf9Rw030hlJJ+HI7Q
         i6LISs1BjX6+ye66fIAAXJ/kaEF/P4EUYC1B7IUB6AbX/iVD/BQIDK9Y3Yu77Ha2Wt
         pIFLYmOZLBTYQ==
Received: from chmeee (unknown [10.80.4.152])
        by smtp.aristanetworks.com (Postfix) with ESMTP id 84CAB30DD5A5;
        Wed, 12 Jun 2019 14:52:19 -0700 (PDT)
Received: from kevmitch by chmeee with local (Exim 4.92)
        (envelope-from <kevmitch@chmeee>)
        id 1hbBAI-0003K5-UY; Wed, 12 Jun 2019 14:52:18 -0700
From:   Kevin Mitchell <kevmitch@arista.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Kevin Mitchell <kevmitch@arista.com>
Subject: [PATCH 0/3] handle init errors more gracefully in amd_iommu
Date:   Wed, 12 Jun 2019 14:52:01 -0700
Message-Id: <20190612215203.12711-1-kevmitch@arista.com>
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

