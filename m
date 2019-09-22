Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E276AC4740C
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBA93206C2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569179904;
	bh=pqNJ8pNu97tfTX6kEisVmJXTZF0n5AhEugcUW9k3lp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pqv8/6okLewBqONjPTWExvAMjO0f0g+2XDUVTmW6pzkEw/ep3cQg2weTIDHsbDjGT
	 XkbMa+sDvGCxQZmLnotlTe0L0W8pVxcLgZabSz01Lpet2Au+jDC2qKA2tMFggzS8cX
	 2Bd6UaRHMt/iJ54RqRhUf4JB9r5jCv8WUenZqhwM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408095AbfIVSzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 14:55:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:56040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437417AbfIVSzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 14:55:07 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E928E208C2;
        Sun, 22 Sep 2019 18:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569178506;
        bh=pqNJ8pNu97tfTX6kEisVmJXTZF0n5AhEugcUW9k3lp0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y6waaDr81pgDPlc2s1Je2fOD7IM3nGP7uEz2NaryisZCQxdmfzSl9gmVI6cWmI2gs
         99UanaZeo3258oR+0JURFueVekSGrsVJH9aym4R3p6t/7jlFrQAZr+EGMrdpyjqYm2
         Jkj9GUnNS4s69JvnOu3T6T4WUsRrNCUxVUuNsUOU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stephen Douthit <stephend@silicom-usa.com>,
        Tony Luck <tony.luck@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-edac@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 038/128] EDAC, pnd2: Fix ioremap() size in dnv_rd_reg()
Date:   Sun, 22 Sep 2019 14:52:48 -0400
Message-Id: <20190922185418.2158-38-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190922185418.2158-1-sashal@kernel.org>
References: <20190922185418.2158-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Douthit <stephend@silicom-usa.com>

[ Upstream commit 29a3388bfcce7a6d087051376ea02bf8326a957b ]

Depending on how BIOS has marked the reserved region containing the 32KB
MCHBAR you can get warnings like:

resource sanity check: requesting [mem 0xfed10000-0xfed1ffff], which spans more than reserved [mem 0xfed10000-0xfed17fff]
caller dnv_rd_reg+0xc8/0x240 [pnd2_edac] mapping multiple BARs

Not all of the mmio regions used in dnv_rd_reg() are the same size.  The
MCHBAR window is 32KB and the sideband ports are 64KB.  Pass the correct
size to ioremap() depending on which resource we're reading from.

Signed-off-by: Stephen Douthit <stephend@silicom-usa.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/edac/pnd2_edac.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/pnd2_edac.c b/drivers/edac/pnd2_edac.c
index 903a4f1fadcc3..0153c730750e5 100644
--- a/drivers/edac/pnd2_edac.c
+++ b/drivers/edac/pnd2_edac.c
@@ -268,11 +268,14 @@ static u64 get_sideband_reg_base_addr(void)
 	}
 }
 
+#define DNV_MCHBAR_SIZE  0x8000
+#define DNV_SB_PORT_SIZE 0x10000
 static int dnv_rd_reg(int port, int off, int op, void *data, size_t sz, char *name)
 {
 	struct pci_dev *pdev;
 	char *base;
 	u64 addr;
+	unsigned long size;
 
 	if (op == 4) {
 		pdev = pci_get_device(PCI_VENDOR_ID_INTEL, 0x1980, NULL);
@@ -287,15 +290,17 @@ static int dnv_rd_reg(int port, int off, int op, void *data, size_t sz, char *na
 			addr = get_mem_ctrl_hub_base_addr();
 			if (!addr)
 				return -ENODEV;
+			size = DNV_MCHBAR_SIZE;
 		} else {
 			/* MMIO via sideband register base address */
 			addr = get_sideband_reg_base_addr();
 			if (!addr)
 				return -ENODEV;
 			addr += (port << 16);
+			size = DNV_SB_PORT_SIZE;
 		}
 
-		base = ioremap((resource_size_t)addr, 0x10000);
+		base = ioremap((resource_size_t)addr, size);
 		if (!base)
 			return -ENODEV;
 
-- 
2.20.1

