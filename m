Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB3BFCA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE16F21D80
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572210191;
	bh=MAUIFzvj0oCaU6nDVjrgFqLlv1Ar4V2sW0PJ1BSPT3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LA4nigXscG3diO/lpB+f81C7SGDP2vdwtZsQxyfgIZ9G6Xv48xi3o12r/JRrWpIO4
	 pzDv3MG1FAahkRSedLfhVHJ8DfhFeMr2CPvI8hxHw8qYu+qR01+ioxag/BdLvBQT3B
	 xoixFfPXnt4EcPPhl1aSivzyIc2PXod7eFUgHARA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbfJ0VDK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:03:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:48310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728225AbfJ0VDG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:03:06 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44B4E2064A;
        Sun, 27 Oct 2019 21:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572210184;
        bh=MAUIFzvj0oCaU6nDVjrgFqLlv1Ar4V2sW0PJ1BSPT3A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UFBvt0WFQOiQOrqSq0Ssz2qDJbaMpPiTyBhI/x9MSKqwKiObYu0xEHj3RnS1umq7Z
         2JTbnaUpGk2Bgi528WawBv0GSiQcp5sb6iHQ8zgV05tesC47kq5/1ap6OhbQyNcr+X
         bG15qz92FrE1zoJRGtVsF9WfyeJiGH7uEtgiNMGw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiang Chen <chenxiang66@hisilicon.com>,
        John Garry <john.garry@huawei.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 02/41] scsi: megaraid: disable device when probe failed after enabled device
Date:   Sun, 27 Oct 2019 22:00:40 +0100
Message-Id: <20191027203100.880704822@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027203056.220821342@linuxfoundation.org>
References: <20191027203056.220821342@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiang Chen <chenxiang66@hisilicon.com>

[ Upstream commit 70054aa39a013fa52eff432f2223b8bd5c0048f8 ]

For pci device, need to disable device when probe failed after enabled
device.

Link: https://lore.kernel.org/r/1567818450-173315-1-git-send-email-chenxiang66@hisilicon.com
Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
Reviewed-by: John Garry <john.garry@huawei.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/megaraid.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/megaraid.c b/drivers/scsi/megaraid.c
index 19bffe0b2cc0a..2cbfec6a74662 100644
--- a/drivers/scsi/megaraid.c
+++ b/drivers/scsi/megaraid.c
@@ -4219,11 +4219,11 @@ megaraid_probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 		 */
 		if (pdev->subsystem_vendor == PCI_VENDOR_ID_COMPAQ &&
 		    pdev->subsystem_device == 0xC000)
-		   	return -ENODEV;
+			goto out_disable_device;
 		/* Now check the magic signature byte */
 		pci_read_config_word(pdev, PCI_CONF_AMISIG, &magic);
 		if (magic != HBA_SIGNATURE_471 && magic != HBA_SIGNATURE)
-			return -ENODEV;
+			goto out_disable_device;
 		/* Ok it is probably a megaraid */
 	}
 
-- 
2.20.1



