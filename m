Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A334AC3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79DDE222C3
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578003842;
	bh=pdekizaXvzqvsk7vgKpBNrciJBJfRkGBtpH/Pk0IYOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FyxBYvR6nDBFU6xzC9lHtZ1a1pcMsfp4HxFN/UaMkGO5Tn2cOFAwjJyQMycNBzQIE
	 pj1rLBGOziqnmdYoG8kTCpficttthDPZm6Ua6dbq4NSAAMEz3yqfVHB2qxhbslUx7K
	 dXdOcaE3Kwio90zpR1KH9SH6kvPfsqj/JYe4cFEQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729351AbgABWYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:24:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:47140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729337AbgABWX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:23:57 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2073220863;
        Thu,  2 Jan 2020 22:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578003836;
        bh=pdekizaXvzqvsk7vgKpBNrciJBJfRkGBtpH/Pk0IYOo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZABXVWc1tTfugeJULsQySfQGDof+ztc7mA0zl4c23aQ1G7UheQcBLFGx1m120gi+R
         TPhfQsC4FcuqKcM45lyiNSFT58Wc7BdVxvmJ7hh29OJ3G7mj4OA78EZlt3fF8djBOT
         oI1vq3AxTVtImk5dcbXa7YeaEFV1hHD4UtJJeUog=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 02/91] scsi: mpt3sas: Fix clear pending bit in ioctl status
Date:   Thu,  2 Jan 2020 23:06:44 +0100
Message-Id: <20200102220359.894313369@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102220356.856162165@linuxfoundation.org>
References: <20200102220356.856162165@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sreekanth Reddy <sreekanth.reddy@broadcom.com>

[ Upstream commit 782b281883caf70289ba6a186af29441a117d23e ]

When user issues diag register command from application with required size,
and if driver unable to allocate the memory, then it will fail the register
command. While failing the register command, driver is not currently
clearing MPT3_CMD_PENDING bit in ctl_cmds.status variable which was set
before trying to allocate the memory. As this bit is set, subsequent
register command will be failed with BUSY status even when user wants to
register the trace buffer will less memory.

Clear MPT3_CMD_PENDING bit in ctl_cmds.status before returning the diag
register command with no memory status.

Link: https://lore.kernel.org/r/1568379890-18347-4-git-send-email-sreekanth.reddy@broadcom.com
Signed-off-by: Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/mpt3sas/mpt3sas_ctl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_ctl.c b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
index bdffb692bded..622dcf2984a9 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_ctl.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
@@ -1502,7 +1502,8 @@ _ctl_diag_register_2(struct MPT3SAS_ADAPTER *ioc,
 			    " for diag buffers, requested size(%d)\n",
 			    ioc->name, __func__, request_data_sz);
 			mpt3sas_base_free_smid(ioc, smid);
-			return -ENOMEM;
+			rc = -ENOMEM;
+			goto out;
 		}
 		ioc->diag_buffer[buffer_type] = request_data;
 		ioc->diag_buffer_sz[buffer_type] = request_data_sz;
-- 
2.20.1



