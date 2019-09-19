Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C11FC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0EE2218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568931079;
	bh=Zqd5/E63vnr/mwIYahJPTQHIhkHsBfJp65brYETECCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uhxlMC9eydw2rkazerCmdhNmHYechtHj5zNc3QGhjI73e3NQ1G4ESwrOjrnKpRMF6
	 r2oBzD7jXKmKX90XfChe+wqijEQC7fymSUKqYQJGSu486FQR9jKRHwkhdkjFnj7qI6
	 hysPMjTgAtteXtMsN0ygy5YfEtN1TSfKE2QZhQjY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393559AbfISWLS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 18:11:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:49834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393539AbfISWLN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:11:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 166AF218AF;
        Thu, 19 Sep 2019 22:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568931071;
        bh=Zqd5/E63vnr/mwIYahJPTQHIhkHsBfJp65brYETECCo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IF9BKjROGgu8k6CDVh5+wAJm7iJc0fyPWfYgQZ/PDnViSZTCB7BGWEWyzoO95IcPP
         j+geUez3Th4WK58ner7DSnCwP9nbW8mpFDDJzTSZTZaNz8X2hTi2K3oMGg4JBW9J8K
         4Prcd6sC44kfs9jP1ihg8sDCn8KoQygyOmR/L0Aw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stuart Hayes <stuart.w.hayes@gmail.com>,
        Joerg Roedel <jroedel@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 118/124] iommu/amd: Flush old domains in kdump kernel
Date:   Fri, 20 Sep 2019 00:03:26 +0200
Message-Id: <20190919214823.471987280@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190919214819.198419517@linuxfoundation.org>
References: <20190919214819.198419517@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stuart Hayes <stuart.w.hayes@gmail.com>

[ Upstream commit 36b7200f67dfe75b416b5281ed4ace9927b513bc ]

When devices are attached to the amd_iommu in a kdump kernel, the old device
table entries (DTEs), which were copied from the crashed kernel, will be
overwritten with a new domain number.  When the new DTE is written, the IOMMU
is told to flush the DTE from its internal cache--but it is not told to flush
the translation cache entries for the old domain number.

Without this patch, AMD systems using the tg3 network driver fail when kdump
tries to save the vmcore to a network system, showing network timeouts and
(sometimes) IOMMU errors in the kernel log.

This patch will flush IOMMU translation cache entries for the old domain when
a DTE gets overwritten with a new domain number.

Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
Fixes: 3ac3e5ee5ed5 ('iommu/amd: Copy old trans table from old kernel')
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/amd_iommu.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index dce1d8d2e8a44..b265062edf6c8 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1143,6 +1143,17 @@ static void amd_iommu_flush_tlb_all(struct amd_iommu *iommu)
 	iommu_completion_wait(iommu);
 }
 
+static void amd_iommu_flush_tlb_domid(struct amd_iommu *iommu, u32 dom_id)
+{
+	struct iommu_cmd cmd;
+
+	build_inv_iommu_pages(&cmd, 0, CMD_INV_IOMMU_ALL_PAGES_ADDRESS,
+			      dom_id, 1);
+	iommu_queue_command(iommu, &cmd);
+
+	iommu_completion_wait(iommu);
+}
+
 static void amd_iommu_flush_all(struct amd_iommu *iommu)
 {
 	struct iommu_cmd cmd;
@@ -1863,6 +1874,7 @@ static void set_dte_entry(u16 devid, struct protection_domain *domain,
 {
 	u64 pte_root = 0;
 	u64 flags = 0;
+	u32 old_domid;
 
 	if (domain->mode != PAGE_MODE_NONE)
 		pte_root = iommu_virt_to_phys(domain->pt_root);
@@ -1912,8 +1924,20 @@ static void set_dte_entry(u16 devid, struct protection_domain *domain,
 	flags &= ~DEV_DOMID_MASK;
 	flags |= domain->id;
 
+	old_domid = amd_iommu_dev_table[devid].data[1] & DEV_DOMID_MASK;
 	amd_iommu_dev_table[devid].data[1]  = flags;
 	amd_iommu_dev_table[devid].data[0]  = pte_root;
+
+	/*
+	 * A kdump kernel might be replacing a domain ID that was copied from
+	 * the previous kernel--if so, it needs to flush the translation cache
+	 * entries for the old domain ID that is being overwritten
+	 */
+	if (old_domid) {
+		struct amd_iommu *iommu = amd_iommu_rlookup_table[devid];
+
+		amd_iommu_flush_tlb_domid(iommu, old_domid);
+	}
 }
 
 static void clear_dte_entry(u16 devid)
-- 
2.20.1



