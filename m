Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76FABC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 15:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37EAA2053B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 15:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Vse51UYS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbfEJPZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 11:25:34 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43246 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727471AbfEJPZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 11:25:33 -0400
Received: by mail-qt1-f196.google.com with SMTP id r3so6991124qtp.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 08:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=rD6wdEZSwVm7gTO6Zc262W7xf6pRwKIUW1NU/7rGn2A=;
        b=Vse51UYSyy1ghsiglgXF6RW3/8/qDVh6OS4BH4EjjM9jjMD+8CXA1py2GPvl3A017T
         uL6orKa2PgLUA3X4ixVWlrQTLHP+6u3csJPPLltnFLsvDacPuKzH5qoxcN9o5EqrEnmB
         GaKetGi6OWFI/Nedw3bwFPy+HkbaZC3hCIlBvD+HzafpNGmSCwgVDsH3pCahZsSbD+XZ
         mK+rPQftwxIxDiq4xJdD+W8fNtsG/manQvMDu3es0iNrf9bzAjPxCAF5+u35qi9q1PMu
         zys2cKRQuaJ7djrq/jjNFpKYnwyps9KaVAq4t3XC4rLft4Jli+wns2VVK+GNQx70ud4K
         uTrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rD6wdEZSwVm7gTO6Zc262W7xf6pRwKIUW1NU/7rGn2A=;
        b=eF/3bD4wdbUPe9LXsQA4D5iSoMEbUP57jvjIa0h0L0fYlipx2sqDk3I2WhzW0Or0T5
         2ZpwkJu8nlQ3gVYGsBqeQheQ0uRZIDQvcrMKoi6DIDekVznDtgX92E0ye71nXkattsgW
         B4qaNenSagh8IcnASL0sstWV4muaZz2aA70pxevEiRiOdq9Y1F2wmHbyzHoM9WO7ez9s
         5Bv0RHkpQO2UJuEY8UvXQ9D92KycTS1v1UueaZvjR+19zCjlvtnwqGc6Ns7qUnfcC34+
         H31kJgmoZX3BybO/UyusdQI2rSYX16rH+2Mcpz1hTZ4rQh1+xUfNbVhUnFPQQnlfoY+G
         FAMA==
X-Gm-Message-State: APjAAAUd8R/4wLT1jtbKF6ZekbAWgp2Pk6LVZD6IwDJzCV1igAVhzwPB
        xfh/k2GC79vyrGAHHWDytI/56A==
X-Google-Smtp-Source: APXvYqx3J0ym1yQz+Vzeb3MzyXSoo3lAxbtNWwkgNoOay9pH4FboDbP/qAzIr+xyoTJRauMSCqESPQ==
X-Received: by 2002:aed:354c:: with SMTP id b12mr10389906qte.251.1557501933144;
        Fri, 10 May 2019 08:25:33 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id s7sm3037983qkg.70.2019.05.10.08.25.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 08:25:32 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     jroedel@suse.de
Cc:     dwmw2@infradead.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] iommu/intel: fix variable 'iommu' set but not used
Date:   Fri, 10 May 2019 11:25:07 -0400
Message-Id: <1557501907-6450-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit cf04eee8bf0e ("iommu/vt-d: Include ACPI devices in iommu=pt")
added for_each_active_iommu() in iommu_prepare_static_identity_mapping()
but never used the each element, i.e, "drhd->iommu".

drivers/iommu/intel-iommu.c: In function
'iommu_prepare_static_identity_mapping':
drivers/iommu/intel-iommu.c:3037:22: warning: variable 'iommu' set but not
used [-Wunused-but-set-variable]
  struct intel_iommu *iommu;

Fixed the warning by passing "drhd->iommu" directly to
for_each_active_iommu() which all subsequent self-assignments should be
ignored by a compiler anyway.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 drivers/iommu/intel-iommu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index a209199f3af6..86e1ddcb4a8e 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3034,7 +3034,6 @@ static int __init iommu_prepare_static_identity_mapping(int hw)
 {
 	struct pci_dev *pdev = NULL;
 	struct dmar_drhd_unit *drhd;
-	struct intel_iommu *iommu;
 	struct device *dev;
 	int i;
 	int ret = 0;
@@ -3045,7 +3044,7 @@ static int __init iommu_prepare_static_identity_mapping(int hw)
 			return ret;
 	}
 
-	for_each_active_iommu(iommu, drhd)
+	for_each_active_iommu(drhd->iommu, drhd)
 		for_each_active_dev_scope(drhd->devices, drhd->devices_cnt, i, dev) {
 			struct acpi_device_physical_node *pn;
 			struct acpi_device *adev;
-- 
1.8.3.1

