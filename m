Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0AEC10F05
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CF8D21741
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368591;
	bh=WlwNroLe3VmHv5MTW3DstOq2YLZml95MzoBl5zpQTSk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hUteSUWOvIyq+rYJdRKeQ6RZKRLJMXw97LHktkfYQ9WOPuEfiaSdtXyQkDPaJO6D8
	 lT/zStHr0NJaMs2txNghD+6PoNfprRh6RfQm4BX0AiPrS83ZbEzrvPWOWR558oDqpR
	 L8u2WcLoV2KEgBLK/TqdtgQ4eKdDvY1d4Dong3CQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731729AbfDDJDK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:03:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:40690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731707AbfDDJDF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:03:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E02FD2177E;
        Thu,  4 Apr 2019 09:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368584;
        bh=WlwNroLe3VmHv5MTW3DstOq2YLZml95MzoBl5zpQTSk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kMv9TY00zJRYB9Fg23O3e6+Wj7goB7Q3B+0YGEb8JgheQSDk0GTfjpy1ILzQ+ToN5
         PIasp2vAoDwJIoPg/mjoD/zh2ieWkSd4i5BDHFHCsxtX/BkBV6RVbx+P+rIOgnIkvJ
         /jf3VgYQzrAt1E/lyDV69iAIxFyyxiRtnIe3H4Qg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jason Yan <yanaijie@huawei.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 077/187] scsi: megaraid_sas: return error when create DMA pool failed
Date:   Thu,  4 Apr 2019 10:46:54 +0200
Message-Id: <20190404084606.665684421@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084603.119654039@linuxfoundation.org>
References: <20190404084603.119654039@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit bcf3b67d16a4c8ffae0aa79de5853435e683945c ]

when create DMA pool for cmd frames failed, we should return -ENOMEM,
instead of 0.
In some case in:

    megasas_init_adapter_fusion()

    -->megasas_alloc_cmds()
       -->megasas_create_frame_pool
          create DMA pool failed,
        --> megasas_free_cmds() [1]

    -->megasas_alloc_cmds_fusion()
       failed, then goto fail_alloc_cmds.
    -->megasas_free_cmds() [2]

we will call megasas_free_cmds twice, [1] will kfree cmd_list,
[2] will use cmd_list.it will cause a problem:

Unable to handle kernel NULL pointer dereference at virtual address
00000000
pgd = ffffffc000f70000
[00000000] *pgd=0000001fbf893003, *pud=0000001fbf893003,
*pmd=0000001fbf894003, *pte=006000006d000707
Internal error: Oops: 96000005 [#1] SMP
 Modules linked in:
 CPU: 18 PID: 1 Comm: swapper/0 Not tainted
 task: ffffffdfb9290000 ti: ffffffdfb923c000 task.ti: ffffffdfb923c000
 PC is at megasas_free_cmds+0x30/0x70
 LR is at megasas_free_cmds+0x24/0x70
 ...
 Call trace:
 [<ffffffc0005b779c>] megasas_free_cmds+0x30/0x70
 [<ffffffc0005bca74>] megasas_init_adapter_fusion+0x2f4/0x4d8
 [<ffffffc0005b926c>] megasas_init_fw+0x2dc/0x760
 [<ffffffc0005b9ab0>] megasas_probe_one+0x3c0/0xcd8
 [<ffffffc0004a5abc>] local_pci_probe+0x4c/0xb4
 [<ffffffc0004a5c40>] pci_device_probe+0x11c/0x14c
 [<ffffffc00053a5e4>] driver_probe_device+0x1ec/0x430
 [<ffffffc00053a92c>] __driver_attach+0xa8/0xb0
 [<ffffffc000538178>] bus_for_each_dev+0x74/0xc8
  [<ffffffc000539e88>] driver_attach+0x28/0x34
 [<ffffffc000539a18>] bus_add_driver+0x16c/0x248
 [<ffffffc00053b234>] driver_register+0x6c/0x138
 [<ffffffc0004a5350>] __pci_register_driver+0x5c/0x6c
 [<ffffffc000ce3868>] megasas_init+0xc0/0x1a8
 [<ffffffc000082a58>] do_one_initcall+0xe8/0x1ec
 [<ffffffc000ca7be8>] kernel_init_freeable+0x1c8/0x284
 [<ffffffc0008d90b8>] kernel_init+0x1c/0xe4

Signed-off-by: Jason Yan <yanaijie@huawei.com>
Acked-by: Sumit Saxena <sumit.saxena@broadcom.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/megaraid/megaraid_sas_base.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index f6de7526ded5..acb503ea8f0c 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -4155,6 +4155,7 @@ int megasas_alloc_cmds(struct megasas_instance *instance)
 	if (megasas_create_frame_pool(instance)) {
 		dev_printk(KERN_DEBUG, &instance->pdev->dev, "Error creating frame DMA pool\n");
 		megasas_free_cmds(instance);
+		return -ENOMEM;
 	}
 
 	return 0;
-- 
2.19.1



