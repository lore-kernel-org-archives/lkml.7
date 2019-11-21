Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D75B6C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 11:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEC4320898
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 11:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574336974;
	bh=HhaL4BLv1sPN6SJYNIsxTzj4ZdcoNvTMOhOJbQ+5IpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HPBOW6DJyG44BGD6RyVR6/1gdALbGEmVS6V+FAx7Bofj/7v5HCoUxLYGIR9IGupQn
	 PcY8uWpXmF3nDcuBlc8pzVXQ/+iPHx7n9RWz4kk27w5f+oyxWqPRyx4PRGR6KkN3ZV
	 ZGujXp+S9uRWOwIEJeZ5KFWSZPK5ecznG2B6S9hs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbfKULtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 06:49:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:38722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727047AbfKULtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 06:49:32 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 165B9214E0;
        Thu, 21 Nov 2019 11:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574336972;
        bh=HhaL4BLv1sPN6SJYNIsxTzj4ZdcoNvTMOhOJbQ+5IpM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K3Eu8C5/OrlNeGhQdU9cOmt2ZLJ1iQ6ANDR3qq5syBsP9b6115+zNqX4hlThlP8Kb
         ahMUKoj2RNSTfVFt0CRKex5/2Yzr3zO5+3kAI/kramWRqb1vd3pHaAPgGZfW/JyqIB
         SwTxXy0FCXgAdN3SN2KTtQgTWFOAGriuwt9YvpPY=
From:   Will Deacon <will@kernel.org>
To:     iommu@lists.linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        John Garry <john.garry@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v3 03/14] PCI: Export pci_ats_disabled() as a GPL symbol to modules
Date:   Thu, 21 Nov 2019 11:49:07 +0000
Message-Id: <20191121114918.2293-4-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191121114918.2293-1-will@kernel.org>
References: <20191121114918.2293-1-will@kernel.org>
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
index a97e2571a527..4fbe5b576dd8 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -123,6 +123,7 @@ bool pci_ats_disabled(void)
 {
 	return pcie_ats_disabled;
 }
+EXPORT_SYMBOL_GPL(pci_ats_disabled);
 
 /* Disable bridge_d3 for all PCIe ports */
 static bool pci_bridge_d3_disable;
-- 
2.24.0.432.g9d3f5f5b63-goog

