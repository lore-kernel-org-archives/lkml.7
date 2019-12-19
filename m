Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12DDAC2D0C1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 12:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD8A524650
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 12:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576757070;
	bh=6Rc1r90+NZsHmspNGdC3SZJUr1ZhyG4GU4NbJn+UbJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=txgalqB73vPtrVOqY1VCJDkqfWqfcT0NZUdF4dLNmI3/CVyE7+TA/M50nt87YmvbB
	 qI3r+sqWD2kYA21dekgXLwU5hS+Nj5Ct3IpJ+dSWsRBVDorfmgyDK9pfHCnPa5GYPy
	 XC93n3oGA/lilGMmoclmnDTH/Kosl0XjuKN/GiRM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfLSMEZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 07:04:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:36246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726858AbfLSMEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 07:04:21 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D602024650;
        Thu, 19 Dec 2019 12:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576757061;
        bh=6Rc1r90+NZsHmspNGdC3SZJUr1ZhyG4GU4NbJn+UbJg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ScAdaU1fUpklI+A/7mXyfEunMCoXsvnAczSUOLH2sbfBUNN2WxiP/TKbyfI03fXjR
         Pkui+/oCeJfUZtnoh8QzSRydyyqU+vaYbgahwGNw7nXUSZhSx+LmfVPRVlAmKsXjGP
         M9XCslZDtJCPjV+AWo8kC96dekWQ1AVduS+y7RYw=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org, iommu@lists.linuxfoundation.org
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        John Garry <john.garry@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v4 07/16] drivers/iommu: Allow IOMMU bus ops to be unregistered
Date:   Thu, 19 Dec 2019 12:03:43 +0000
Message-Id: <20191219120352.382-8-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191219120352.382-1-will@kernel.org>
References: <20191219120352.382-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'bus_set_iommu()' allows IOMMU drivers to register their ops for a given
bus type. Unfortunately, it then doesn't allow them to be removed, which
is necessary for modular drivers to shutdown cleanly so that they can be
reloaded later on.

Allow 'bus_set_iommu()' to take a NULL 'ops' argument, which clear the
ops pointer for the selected bus_type.

Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/iommu/iommu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index bc8edf90e729..433101f0853c 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1558,6 +1558,11 @@ int bus_set_iommu(struct bus_type *bus, const struct iommu_ops *ops)
 {
 	int err;
 
+	if (ops == NULL) {
+		bus->iommu_ops = NULL;
+		return 0;
+	}
+
 	if (bus->iommu_ops != NULL)
 		return -EBUSY;
 
-- 
2.24.1.735.g03f4e72817-goog

