Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B85C5C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84C992177E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553709923;
	bh=3viYCtu81UAAKhQ6NUnzOSWUlL6JSP2ZXor9Eq2z3Lk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ovVGxrxBf/Ovvc9pPoep31wUxNBTCgpIw4MyH0Iq7A+2OWaO/+kgsFd8DWcm+V3us
	 jOpd5WbHW3H22fycFG4RYi/y12iJW1/PnztUKyL+Q0otfmqfG7DMMTG9LFGJ3njXVC
	 gzBP402RqLfanEKy39VsDXMwmE+Cfvr6eR7F80Pk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732539AbfC0SFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:05:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:46382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387660AbfC0SFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:05:18 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0AD0217D9;
        Wed, 27 Mar 2019 18:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553709917;
        bh=3viYCtu81UAAKhQ6NUnzOSWUlL6JSP2ZXor9Eq2z3Lk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AuFLMFWlC531nSadTMsd1Ip4WxFaOxZ6DYlfwwrel1ECN0QPX5aQj9CQ1Vm4zvry9
         OXWdVKwHsvAuoYW584hfOXoE0R4agMc/B0iAB+6dmQL2QULLV1c80dXWiNgiwJ4pB8
         4wkhMyoVsY4nqoQb1F4Hw+EO8eD4hEwlv/nrEYi0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jason Yan <yanaijie@huawei.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>,
        megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 112/262] scsi: megaraid_sas: return error when create DMA pool failed
Date:   Wed, 27 Mar 2019 13:59:27 -0400
Message-Id: <20190327180158.10245-112-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Yan <yanaijie@huawei.com>

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
index fcbff83c0097..c9811d1aa007 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -4188,6 +4188,7 @@ int megasas_alloc_cmds(struct megasas_instance *instance)
 	if (megasas_create_frame_pool(instance)) {
 		dev_printk(KERN_DEBUG, &instance->pdev->dev, "Error creating frame DMA pool\n");
 		megasas_free_cmds(instance);
+		return -ENOMEM;
 	}
 
 	return 0;
-- 
2.19.1

