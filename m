Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC38C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 18:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB4C3208CB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 18:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="cwZBumMW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbfE1SaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 14:30:07 -0400
Received: from mx.aristanetworks.com ([162.210.129.12]:30443 "EHLO
        prod-mx.aristanetworks.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728195AbfE1SaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 14:30:06 -0400
Received: from prod-mx.aristanetworks.com (localhost [127.0.0.1])
        by prod-mx.aristanetworks.com (Postfix) with ESMTP id A549B4256C6;
        Tue, 28 May 2019 11:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
        s=Arista-A; t=1559068223;
        bh=gZKRKJcuRQSwe2TyYVhO9ixqNktFM8piGcLI2AKiDUY=;
        h=From:To:Cc:Subject:Date;
        b=cwZBumMWFxzPMJSF6cLFED0aHPey7MTEIZ7V3LnvIDFB5zxpZ43x7nB1GSzGOMlkG
         4sP5rjTFneL/y2Ame6XATZkW7t0LQmQN+qI+E9SDGKE2dAVmMgzxOr/WVHUdFTXCW4
         0FMqKkkxyPw9ZoUkD0xVBAiF9/cI8Tzo6WqNfJazzFp5vUZjzn4q+p0N16JnB0hBTi
         HXVqUB2EDr08rOxkje+1wNd5KnGv94z8vtv1E/CClOtnoqA37+PnE/aDoiLoVsWQGd
         fgoMdYp/gJp3Ya4kSsvXqc0CKM/Sm1Lu/oS3EZbZA1yXaqAhQaGOJQkVTUkkt/wHl2
         wHpQ2mLtfofbw==
Received: from chmeee (unknown [10.95.80.198])
        by prod-mx.aristanetworks.com (Postfix) with ESMTP id 9CEAB424472;
        Tue, 28 May 2019 11:30:23 -0700 (PDT)
Received: from kevmitch by chmeee with local (Exim 4.92)
        (envelope-from <kevmitch@chmeee>)
        id 1hVgrI-0000xK-LF; Tue, 28 May 2019 11:30:00 -0700
From:   Kevin Mitchell <kevmitch@arista.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Kevin Mitchell <kevmitch@arista.com>
Subject: [PATCH 0/3] handle init errors more gracefully in amd_iommu
Date:   Tue, 28 May 2019 11:29:55 -0700
Message-Id: <20190528182958.3623-1-kevmitch@arista.com>
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

