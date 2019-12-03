Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE3EC432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A020420674
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575414149;
	bh=1lcF54AcbRONjDESSOA+6p0jhMgKCR+p52kcc7fQZc0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g3R6159u2qMejSWZuqJ29Oi9mIkIQAFkf8ypEcOogew9yJH7l9SLFS4BFSQHZGRDf
	 2vynx8MKawYyYKAAY8Mlk4n2gHXevQHPvRCD1bB3qIVK9a2yIjcZBa4CbWqGZadVGk
	 fbeo2/tGf0/RaKsDz2TBCVBLB5nlbbr7/J3ONlHU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729652AbfLCWym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:54:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:48474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728397AbfLCWyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:54:33 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9983F21582;
        Tue,  3 Dec 2019 22:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575413673;
        bh=1lcF54AcbRONjDESSOA+6p0jhMgKCR+p52kcc7fQZc0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DWKczIaIWPXe43FkoUik1sFQuOMTa4BbTcCKh8YfcMjbUgDiumiH9mD2dpJ8YB4fN
         yajI6GL1AJpiLsqonhuJOWYvFu5y4+9FeCa1HFBztUidKzeZKSEXZsGkrrlSC7LCVg
         DveCAl9ckQvKKh14z15pXtG60vT7G7qVn3FjVMcw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
        David Gibson <david@gibson.dropbear.id.au>,
        Alex Williamson <alex.williamson@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 169/321] vfio/spapr_tce: Get rid of possible infinite loop
Date:   Tue,  3 Dec 2019 23:33:55 +0100
Message-Id: <20191203223435.927454925@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203223427.103571230@linuxfoundation.org>
References: <20191203223427.103571230@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 96721b154454f..ec53310f16136 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -371,6 +371,7 @@ static void tce_iommu_release(void *iommu_data)
 {
 	struct tce_container *container = iommu_data;
 	struct tce_iommu_group *tcegrp;
+	struct tce_iommu_prereg *tcemem, *tmtmp;
 	long i;
 
 	while (tce_groups_attached(container)) {
@@ -393,13 +394,8 @@ static void tce_iommu_release(void *iommu_data)
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



