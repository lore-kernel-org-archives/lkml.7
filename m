Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01CCEC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 18:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CECBF208CB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 18:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="CPcnMefj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbfE1SaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 14:30:03 -0400
Received: from smtp.aristanetworks.com ([54.193.82.35]:38956 "EHLO
        uscaw2-clmxp01.aristanetworks.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728160AbfE1SaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 14:30:02 -0400
Received: from uscaw2-clmxp01.aristanetworks.com (localhost [127.0.0.1])
        by uscaw2-clmxp01.aristanetworks.com (Postfix) with ESMTP id 3327921459D0;
        Tue, 28 May 2019 11:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
        s=Arista-A; t=1559068202;
        bh=0YAEwRV8pxaKDZriNp5u14v56Dsy6P+WWcBl+ItO2zQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=CPcnMefjLP+bA9kVccxdr6eJyVU7FozZXFEiVVUdiIzZDrWwjiROptZ4c53QaNP5G
         Sb1uKj3D2NLw1peoM9MgppiBynctpeDgScb+WQhc3y/fumEztSgibXEfIUwTyqBn7q
         vadn06vPi7Ejxq0lFwj/lYZ/q1QIR6laoVm2vw7B/xDHfqqkRWAxGiJd8DrSysrMk0
         nQBUBM9PqX2xihlaVLENurpttKXhXsfeZnhPNoR/CsKURUYTMFDfSLxNlMouCQ0yr+
         U4hYjpj22+0prOqjPKRtCE50h3xGtDYFtN2JGJ3IFuQJFBNpqHtc7V2w+ky8YnkxTx
         XL3jOF/OrHKGA==
Received: from chmeee (unknown [10.95.80.198])
        by uscaw2-clmxp01.aristanetworks.com (Postfix) with ESMTP id 2ABD13134185;
        Tue, 28 May 2019 11:30:02 -0700 (PDT)
Received: from kevmitch by chmeee with local (Exim 4.92)
        (envelope-from <kevmitch@chmeee>)
        id 1hVgrJ-0000xP-F8; Tue, 28 May 2019 11:30:01 -0700
From:   Kevin Mitchell <kevmitch@arista.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Kevin Mitchell <kevmitch@arista.com>
Subject: [PATCH 1/3] iommu/amd: make iommu_disable safer
Date:   Tue, 28 May 2019 11:29:56 -0700
Message-Id: <20190528182958.3623-2-kevmitch@arista.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190528182958.3623-1-kevmitch@arista.com>
References: <20190528182958.3623-1-kevmitch@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make it safe to call iommu_disable during early init error conditions
before mmio_base is set, but after the struct amd_iommu has been added
to the amd_iommu_list. For example, this happens if firmware fails to
fill in mmio_phys in the ACPI table leading to a NULL pointer
dereference in iommu_feature_disable.

Signed-off-by: Kevin Mitchell <kevmitch@arista.com>
---
 drivers/iommu/amd_iommu_init.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index f773792d77fd..3798d7303c99 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -424,6 +424,9 @@ static void iommu_enable(struct amd_iommu *iommu)
 
 static void iommu_disable(struct amd_iommu *iommu)
 {
+	if (!iommu->mmio_base)
+		return;
+
 	/* Disable command buffer */
 	iommu_feature_disable(iommu, CONTROL_CMDBUF_EN);
 
-- 
2.20.1

