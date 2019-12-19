Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B89C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 12:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 798A524679
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 12:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576757056;
	bh=WptcAB1FKir/J2JPdEAf91BmzeN8oM9lebcSis2OmXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BimPrnnfoE8TAgVFpWS0Eun8hW37j1RRNftzueiCbQcOHfghqeDhzXManu0HpQtOF
	 9lS75q7uUz2YlGui0PgNMSuarv5ObKxJqhQJvUJl6mO82K88Cnj2cscYdBjcLZYrvS
	 92Y2Zl9yvbIQe/GK2DkGr/R2UHN47AA7Wib4NJmw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfLSMEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 07:04:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:35990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726960AbfLSMEN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 07:04:13 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BC45222C2;
        Thu, 19 Dec 2019 12:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576757052;
        bh=WptcAB1FKir/J2JPdEAf91BmzeN8oM9lebcSis2OmXQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dWiMn8UcJD3BIN7p1n6aA3ANDMt7r08FqWFzIugrqxf89y6iRj6o+c3ga2s/RfTC4
         OPhT6dlqDsZ9ymXOwx2GO0yNskWfPyc9hJm55411j6xTWa3qo3wvG/afb7ej0QKADa
         TPb84mydQ/W5h+kRKMaHahCjmRsvab/ZBzWZlMHs=
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
Subject: [PATCH v4 04/16] PCI: Export pci_ats_disabled() as a GPL symbol to modules
Date:   Thu, 19 Dec 2019 12:03:40 +0000
Message-Id: <20191219120352.382-5-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191219120352.382-1-will@kernel.org>
References: <20191219120352.382-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building drivers for ATS-aware IOMMUs as modules requires access to
pci_ats_disabled(). Export it as a GPL symbol to get things working.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/pci/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e87196cc1a7f..ad746d903ceb 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -131,6 +131,7 @@ bool pci_ats_disabled(void)
 {
 	return pcie_ats_disabled;
 }
+EXPORT_SYMBOL_GPL(pci_ats_disabled);
 
 /* Disable bridge_d3 for all PCIe ports */
 static bool pci_bridge_d3_disable;
-- 
2.24.1.735.g03f4e72817-goog

