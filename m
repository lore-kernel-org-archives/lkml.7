Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7546BC3276F
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 498EB2253D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578003149;
	bh=znMmWzgjYL4Doa5GAgSjyVDzZg8ISUI1lwxXLueNmtU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=umbXnKbDCyQuzcjG8xXHmifc5x+wTImNQT8SfKtsjWjCUtp0LTiYJnj/bYBZdqRjU
	 YbzlfL1rpvtlMyticplwy9CtNyw+UjgpXT2dWKZIGBplX9Vzzh11NZZXleyH/8R4rw
	 y7ppamsIj+o/67lze+fO0jV3Sbi2gSMI/d6dvpbc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbgABWMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:12:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:51214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727400AbgABWMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:12:14 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D93921D7D;
        Thu,  2 Jan 2020 22:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578003134;
        bh=znMmWzgjYL4Doa5GAgSjyVDzZg8ISUI1lwxXLueNmtU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iqhcpgQmvcG+tXn+VCtrjmhrzV7XnIqtNCC5EaY3XNUfY8TrW3BC47AiSjKHNsgCZ
         CZUbNPae5GoLf8GEEjfpf4YzfDdMPrYEVyVGugPpTxKdshs3RaB78iRMVXHIxhTyiV
         s+ImOipTSHC9HiPlkxWeLtemvNtGP61SlNQ34Gv8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 007/191] scsi: mpt3sas: Reject NVMe Encap cmnds to unsupported HBA
Date:   Thu,  2 Jan 2020 23:04:49 +0100
Message-Id: <20200102215830.585891452@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102215829.911231638@linuxfoundation.org>
References: <20200102215829.911231638@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sreekanth Reddy <sreekanth.reddy@broadcom.com>

[ Upstream commit 77fd4f2c88bf83205a21f9ca49fdcc0c7868dba9 ]

If any faulty application issues an NVMe Encapsulated commands to HBA which
doesn't support NVMe protocol then driver should return the command as
invalid with the following message.

"HBA doesn't support NVMe. Rejecting NVMe Encapsulated request."

Otherwise below page fault kernel panic will be observed while building the
PRPs as there is no PRP pools allocated for the HBA which doesn't support
NVMe drives.

RIP: 0010:_base_build_nvme_prp+0x3b/0xf0 [mpt3sas]
Call Trace:
 _ctl_do_mpt_command+0x931/0x1120 [mpt3sas]
 _ctl_ioctl_main.isra.11+0xa28/0x11e0 [mpt3sas]
 ? prepare_to_wait+0xb0/0xb0
 ? tty_ldisc_deref+0x16/0x20
 _ctl_ioctl+0x1a/0x20 [mpt3sas]
 do_vfs_ioctl+0xaa/0x620
 ? vfs_read+0x117/0x140
 ksys_ioctl+0x67/0x90
 __x64_sys_ioctl+0x1a/0x20
 do_syscall_64+0x60/0x190
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

[mkp: tweaked error string]

Link: https://lore.kernel.org/r/1568379890-18347-12-git-send-email-sreekanth.reddy@broadcom.com
Signed-off-by: Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/mpt3sas/mpt3sas_ctl.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_ctl.c b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
index 3c463e8f6074..b95f7d062ea4 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_ctl.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
@@ -778,6 +778,18 @@ _ctl_do_mpt_command(struct MPT3SAS_ADAPTER *ioc, struct mpt3_ioctl_command karg,
 	case MPI2_FUNCTION_NVME_ENCAPSULATED:
 	{
 		nvme_encap_request = (Mpi26NVMeEncapsulatedRequest_t *)request;
+		if (!ioc->pcie_sg_lookup) {
+			dtmprintk(ioc, ioc_info(ioc,
+			    "HBA doesn't support NVMe. Rejecting NVMe Encapsulated request.\n"
+			    ));
+
+			if (ioc->logging_level & MPT_DEBUG_TM)
+				_debug_dump_mf(nvme_encap_request,
+				    ioc->request_sz/4);
+			mpt3sas_base_free_smid(ioc, smid);
+			ret = -EINVAL;
+			goto out;
+		}
 		/*
 		 * Get the Physical Address of the sense buffer.
 		 * Use Error Response buffer address field to hold the sense
-- 
2.20.1



