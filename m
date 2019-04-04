Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F50C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA51D20693
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369479;
	bh=eXC2nuX2/486qIzrwRlo/NVAbuI/KQYuGQEmQ1AmwUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=N9SZ1P77XPnEgnvCSmcSRp8nWLueG7yY9P2hO7m9QA/tfTk3OtQeYbc+OSzlbKtE/
	 KhZtS5EFW5bv5eLwndvOR6n0uQ22AzijE5FORO4tD5PeFAnNLFtDhL41GTjZeg15oW
	 W4U01B0MEJ6d1BDl8l4OaAe7hE7fAIGT5qtp4sL8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388074AbfDDJR5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:17:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:59814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387981AbfDDJRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:17:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20B812054F;
        Thu,  4 Apr 2019 09:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369472;
        bh=eXC2nuX2/486qIzrwRlo/NVAbuI/KQYuGQEmQ1AmwUw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UqFeHETGTgixdV3dubxSQDSMtqi9bx8OsC2PVNH1Qeyaosu9aNfqYaO0U1jgFHSuw
         1W0wdzsBYwNHhAoRUPzM6OKU6kNwNQ36KfFvJ7qVeMwgM9aZHxYePph1L3vHj9h+Tn
         G3m3vdVpXjLnZXWNrJrHp9JirMHsxbiPr8L/T2vc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 221/246] PCI: pciehp: Assign ctrl->slot_ctrl before writing it to hardware
Date:   Thu,  4 Apr 2019 10:48:41 +0200
Message-Id: <20190404084626.941335838@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 25bd879ec16ad3b83a5b1c3f16faa55e696bfccb ]

Shameerali reported that running v4.20-rc1 as QEMU guest, the PCIe hotplug
port times out during boot:

  pciehp 0000:00:01.0:pcie004: Timeout on hotplug command 0x03f1 (issued 1016 msec ago)
  pciehp 0000:00:01.0:pcie004: Timeout on hotplug command 0x03f1 (issued 1024 msec ago)
  pciehp 0000:00:01.0:pcie004: Failed to check link status
  pciehp 0000:00:01.0:pcie004: Timeout on hotplug command 0x02f1 (issued 2520 msec ago)

The issue was bisected down to commit 720d6a671a6e ("PCI: pciehp: Do not
handle events if interrupts are masked") and was further analyzed by the
reporter to be caused by the fact that pciehp first updates the hardware
and only then cache the ctrl->slot_ctrl in pcie_do_write_cmd().  If the
interrupt happens before we cache the value, pciehp_isr() reads value 0 and
decides that the interrupt was not meant for it causing the above timeout
to trigger.

Fix by moving ctrl->slot_ctrl assignment to happen before it is written to
the hardware.

Fixes: 720d6a671a6e ("PCI: pciehp: Do not handle events if interrupts are masked")
Link: https://lore.kernel.org/linux-pci/5FC3163CFD30C246ABAA99954A238FA8387DD344@FRAEML521-MBX.china.huawei.com
Reported-by: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/hotplug/pciehp_hpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index c0fb64ace05a..8bfcb8cd0900 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -156,9 +156,9 @@ static void pcie_do_write_cmd(struct controller *ctrl, u16 cmd,
 	slot_ctrl |= (cmd & mask);
 	ctrl->cmd_busy = 1;
 	smp_mb();
+	ctrl->slot_ctrl = slot_ctrl;
 	pcie_capability_write_word(pdev, PCI_EXP_SLTCTL, slot_ctrl);
 	ctrl->cmd_started = jiffies;
-	ctrl->slot_ctrl = slot_ctrl;
 
 	/*
 	 * Controllers with the Intel CF118 and similar errata advertise
-- 
2.19.1



