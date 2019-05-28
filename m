Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B598DC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 18:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A95020B7C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 18:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="2sCXXHF0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbfE1SaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 14:30:16 -0400
Received: from smtp.aristanetworks.com ([54.193.82.35]:38972 "EHLO
        uscaw2-clmxp01.aristanetworks.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728171AbfE1SaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 14:30:03 -0400
Received: from uscaw2-clmxp01.aristanetworks.com (localhost [127.0.0.1])
        by uscaw2-clmxp01.aristanetworks.com (Postfix) with ESMTP id B5B0F21459D5;
        Tue, 28 May 2019 11:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
        s=Arista-A; t=1559068202;
        bh=Ur8IpLq8gF2to3WfM7YOfN36My26fjgqB6sAL0vxTRg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=2sCXXHF0Kk/W/V823fzZrplTnrsbuto8mew1pgv5z3zK6llbvpzOy/ZR2w/Tz4YBC
         raTu+yPMJyQ1L4n1wO9fdgkJYdSKkz9UoaXku2QjxBYeg5DlRrG1Aqe96iYJAkAuVy
         MLSTvIy5iHTFbAuwjndwFMArd8aBz8DF9omc2QVnH/2lSnzkQLBx3N1DgXq3vEu1Pp
         AqBzyBUPdZt2dr4aRjJY8+N2ISs4B/itsTgByc9TkulAXPkSqrAX0y9/YfPBj05YrU
         /AF+D+nLEZLG/C7l5ATkC84BIhBoBRaKbrtXCRXRWTNhvIjBt7dK8M9kN5FKuJZQ7Z
         cRqx/fjQ3mH3g==
Received: from chmeee (unknown [10.95.80.198])
        by uscaw2-clmxp01.aristanetworks.com (Postfix) with ESMTP id AD1A13134185;
        Tue, 28 May 2019 11:30:02 -0700 (PDT)
Received: from kevmitch by chmeee with local (Exim 4.92)
        (envelope-from <kevmitch@chmeee>)
        id 1hVgrK-0000xS-77; Tue, 28 May 2019 11:30:02 -0700
From:   Kevin Mitchell <kevmitch@arista.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Kevin Mitchell <kevmitch@arista.com>
Subject: [PATCH 2/3] iommu/amd: move gart fallback to amd_iommu_init
Date:   Tue, 28 May 2019 11:29:57 -0700
Message-Id: <20190528182958.3623-3-kevmitch@arista.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190528182958.3623-1-kevmitch@arista.com>
References: <20190528182958.3623-1-kevmitch@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fallback to the GART driver in the case amd_iommu doesn't work was
executed in a function called free_iommu_resources, which didn't really
make sense. This was even being called twice if amd_iommu=off was
specified on the command line.

The only complication is that it needs to be verified that amd_iommu has
fully relinquished control by calling free_iommu_resources and emptying
the amd_iommu_list.

Signed-off-by: Kevin Mitchell <kevmitch@arista.com>
---
 drivers/iommu/amd_iommu_init.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 3798d7303c99..5f3df5ae6ba8 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -2345,15 +2345,6 @@ static void __init free_iommu_resources(void)
 	amd_iommu_dev_table = NULL;
 
 	free_iommu_all();
-
-#ifdef CONFIG_GART_IOMMU
-	/*
-	 * We failed to initialize the AMD IOMMU - try fallback to GART
-	 * if possible.
-	 */
-	gart_iommu_init();
-
-#endif
 }
 
 /* SB IOAPIC is always on this device in AMD systems */
@@ -2774,6 +2765,16 @@ static int __init amd_iommu_init(void)
 		}
 	}
 
+#ifdef CONFIG_GART_IOMMU
+	if (ret && list_empty(&amd_iommu_list)) {
+		/*
+		 * We failed to initialize the AMD IOMMU - try fallback
+		 * to GART if possible.
+		 */
+		gart_iommu_init();
+	}
+#endif
+
 	for_each_iommu(iommu)
 		amd_iommu_debugfs_setup(iommu);
 
-- 
2.20.1

