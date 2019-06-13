Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63334C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32A5020679
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560441698;
	bh=IqCO23bLOxZGkinFkV7sw2ebEJzfNo2BWSXEsk/kzfY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WcyGNeEm+dWbZ18Y7Gd6Bp4ZR9EPd7/I75d6vyPRTSOpavgVEx7edfV+PZFcuhxVt
	 ETC+sW6o33fdfNtcjaVy5WKRk4UP9eNKDjQvfCk3iVirncQ4fBGS2+8ofb82m5sJ+S
	 HNUiY/oomN9L7boXi9T+JsgvNweWTbr71WVFxLjM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390815AbfFMQBh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:01:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:36362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731427AbfFMIsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:48:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C07B421473;
        Thu, 13 Jun 2019 08:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560415705;
        bh=IqCO23bLOxZGkinFkV7sw2ebEJzfNo2BWSXEsk/kzfY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WtPsvqCRYcVIgDgcbejsIa3FtdoMnaEAXRpNk/bzYr0KJvfLWH6x1zynwaxj4iHiP
         eFXFCHLGAm3TEB3XOSlF2JOdiHqRcsBcSdLk2qQEf3Iaed46cXoy+A+0mrioEN7Cmv
         YJvyhBQYX1Tc2CpRhuB+QaONahy612YdvwzjEneE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Greg Kurz <groug@kaod.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Alex Williamson <alex.williamson@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 072/155] vfio-pci/nvlink2: Fix potential VMA leak
Date:   Thu, 13 Jun 2019 10:33:04 +0200
Message-Id: <20190613075657.001361799@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190613075652.691765927@linuxfoundation.org>
References: <20190613075652.691765927@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 2c85f2bd519457073444ec28bbb4743a4e4237a7 ]

If vfio_pci_register_dev_region() fails then we should rollback
previous changes, ie. unmap the ATSD registers.

Fixes: 7f92891778df ("vfio_pci: Add NVIDIA GV100GL [Tesla V100 SXM2] subdriver")
Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vfio/pci/vfio_pci_nvlink2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_nvlink2.c b/drivers/vfio/pci/vfio_pci_nvlink2.c
index 32f695ffe128..50fe3c4f7feb 100644
--- a/drivers/vfio/pci/vfio_pci_nvlink2.c
+++ b/drivers/vfio/pci/vfio_pci_nvlink2.c
@@ -472,6 +472,8 @@ int vfio_pci_ibm_npu2_init(struct vfio_pci_device *vdev)
 	return 0;
 
 free_exit:
+	if (data->base)
+		memunmap(data->base);
 	kfree(data);
 
 	return ret;
-- 
2.20.1



