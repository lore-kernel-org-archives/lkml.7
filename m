Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0EBAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF09E20830
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553551964;
	bh=OWN/jqhesfE1HkP8a7BA/Kjrn1+4nFDAPOEv261Jnrg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GS+6saOax+VkDLaX7GTPXtig5An3Q/sFDMvwt152hErEHlVONPzUxYHVltduPJad5
	 JHHHm/dlNUn5F57RjtpDP6HXSOvqiava39kLiKJ2w67xFKWBGpvl9ENKy+2YE83VtD
	 x6BQelsXS3l9PVQdfGSOM3/RA9fx5pNNm1mxrBD8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730616AbfCYWMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 18:12:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:50340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730996AbfCYWMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 18:12:40 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1786720848;
        Mon, 25 Mar 2019 22:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553551960;
        bh=OWN/jqhesfE1HkP8a7BA/Kjrn1+4nFDAPOEv261Jnrg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uus1KLQUzuOFa7IJaDI+M6QWQ4PcPbOAIfjwBz2cHpf0HYt/MVJoD04b1xjtSFcZJ
         Qf5NGmVYGE9qj0JEsaqOIK7aCorCIemXVcoh1muY1fdAWHaSNaf+Sn5o7yOhUhnmIP
         d9n1XqV7T2fLyVLXptjw00S0vTuLO6pdZsQkBV8M=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Jiang Liu <jiang.liu@linux.intel.com>
Subject: [PATCH 1/2] PCI/MSI: Remove unused __write_msi_msg() and write_msi_msg()
Date:   Mon, 25 Mar 2019 17:12:28 -0500
Message-Id: <20190325221229.36930-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190325221229.36930-1-helgaas@kernel.org>
References: <20190325221229.36930-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Remove unused __write_msi_msg() and write_msi_msg().

These were added by 83a18912b0e8 ("PCI/MSI: Rename write_msi_msg() to
pci_write_msi_msg()"), they served their purpose, and they're no longer
needed.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: Jiang Liu <jiang.liu@linux.intel.com>	# 83a18912b0e8 author
---
 include/linux/msi.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index 7e9b81c3b50d..f934982a0e68 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -148,15 +148,6 @@ u32 __pci_msi_desc_mask_irq(struct msi_desc *desc, u32 mask, u32 flag);
 void pci_msi_mask_irq(struct irq_data *data);
 void pci_msi_unmask_irq(struct irq_data *data);
 
-/* Conversion helpers. Should be removed after merging */
-static inline void __write_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
-{
-	__pci_write_msi_msg(entry, msg);
-}
-static inline void write_msi_msg(int irq, struct msi_msg *msg)
-{
-	pci_write_msi_msg(irq, msg);
-}
 static inline void mask_msi_irq(struct irq_data *data)
 {
 	pci_msi_mask_irq(data);
-- 
2.21.0.392.gf8f6787159e-goog

