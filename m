Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB60AC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 05:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BA3920659
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 05:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574402231;
	bh=Qfbrh3CAl/9De393ORqQNDprdkPEaFRcGApPRM3ToAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Xvl79uzWYDL9Ro90UULMvk4Y4Evn0d9EmTGe4M81UWqcEy8oEo9aJCg0IdDFSN0eM
	 EDyYlP6jd1M9OVbpwaSLKC4Jnph4J0nEq2mt4OlKmrN62ItNL5s+6OAPetfBW76e5D
	 PFC4zDRXWBHykqCKYVoYcGk018U8XG/VQHmzRuDI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729375AbfKVF5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 00:57:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:35126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729336AbfKVF5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 00:57:01 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CFE42072E;
        Fri, 22 Nov 2019 05:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574402221;
        bh=Qfbrh3CAl/9De393ORqQNDprdkPEaFRcGApPRM3ToAc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B2iL5TCbIvczugImu03GnGBPlgTEtpIHPdTXXwa0wwG6m/p8xZircwsVFqlsoyeYU
         BzfE9VgIGAbv2epzg3v6UQizY/hXWCiSTqRFTw9R/A6mMsnCqowIfFyj528oefOKlV
         ldJuHP+Kqiq2UfXpkoenr+dK4iyJFuVLIyMg+HR4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        David Gibson <david@gibson.dropbear.id.au>,
        Alex Williamson <alex.williamson@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, kvm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 068/127] vfio/spapr_tce: Get rid of possible infinite loop
Date:   Fri, 22 Nov 2019 00:54:46 -0500
Message-Id: <20191122055544.3299-67-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122055544.3299-1-sashal@kernel.org>
References: <20191122055544.3299-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Kardashevskiy <aik@ozlabs.ru>

[ Upstream commit 517ad4ae8aa93dccdb9a88c27257ecb421c9e848 ]

As a part of cleanup, the SPAPR TCE IOMMU subdriver releases preregistered
memory. If there is a bug in memory release, the loop in
tce_iommu_release() becomes infinite; this actually happened to me.

This makes the loop finite and prints a warning on every failure to make
the code more bug prone.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Acked-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vfio/vfio_iommu_spapr_tce.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index b4c68f3b82be9..eba9aaf3cc17c 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -409,6 +409,7 @@ static void tce_iommu_release(void *iommu_data)
 {
 	struct tce_container *container = iommu_data;
 	struct tce_iommu_group *tcegrp;
+	struct tce_iommu_prereg *tcemem, *tmtmp;
 	long i;
 
 	while (tce_groups_attached(container)) {
@@ -431,13 +432,8 @@ static void tce_iommu_release(void *iommu_data)
 		tce_iommu_free_table(container, tbl);
 	}
 
-	while (!list_empty(&container->prereg_list)) {
-		struct tce_iommu_prereg *tcemem;
-
-		tcemem = list_first_entry(&container->prereg_list,
-				struct tce_iommu_prereg, next);
-		WARN_ON_ONCE(tce_iommu_prereg_free(container, tcemem));
-	}
+	list_for_each_entry_safe(tcemem, tmtmp, &container->prereg_list, next)
+		WARN_ON(tce_iommu_prereg_free(container, tcemem));
 
 	tce_iommu_disable(container);
 	if (container->mm)
-- 
2.20.1

