Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7884DC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 14:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B1ED2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 14:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZrJX56bw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388686AbfCAO65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 09:58:57 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35051 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728187AbfCAO65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 09:58:57 -0500
Received: by mail-wm1-f66.google.com with SMTP id y15so12558247wma.0;
        Fri, 01 Mar 2019 06:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uiL9Rnh3blwXuAKNU6QmBdtMIcWhOJmlAYKqNemhIFk=;
        b=ZrJX56bw0KZ/G7xznZT4ItP5sRIG7QRMD3Tj7jwov8+W+OeJ3Rj9bhKVgMoOXFs+gO
         60WA9wEyi7XwavtGXFAlljEGPlbiMEmVh9LPVphsigOeDBpkpkUWpdKsTsw4hRFAzfMK
         tSBiX3pIm6Av2mDL8z+tFH8XW7wfxh+WAlLw1stLstkqiMsuSahUqQuuy7J134I/R+Gh
         1S79gJyZepsBTCyKAgdez3RjjaE9lRPpl4OGQ31JSty+59DIBcVWZZ3DcJZJ/n8Cp3vd
         WIv9L+EcWoQWQXJjku25hPKvTGyw5sL+UEVobDHUedUgPPKmktJfCTfZxoDdVG4x8w6+
         f5Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uiL9Rnh3blwXuAKNU6QmBdtMIcWhOJmlAYKqNemhIFk=;
        b=Sa2YuKGkXznVEbD4uTuMdL9nYyGMPA8Np5KEFZp/v/MKJH6q8GGgVnTyFFPLl4+kBa
         i8skhYf17QcJFn3xXD1wY0Zu3Q3gXucQaZrLdiHaEQT2oq4DIiPnlm0lGpEMMpiU0MJW
         Gg6YwflgaGLsCIYKyqdRqceg7cG4/qTVFPNkBycWdw/qECUxN4VOe56CaoqTJ2GqhQ57
         eWGB6UMn8YQ5oQw38pM88BZHuTsk2DvabmHK4ot6KYPSkKL3NTyzD4azGKbCS0vd19TS
         78LJU9yBM/KneFIx4XlltZqai29EUPcyWmUzaUAFQ0LbQl0mwjZrEKtyZpkH3fU6qIQ/
         14cw==
X-Gm-Message-State: AHQUAuaQNVyK6glYjEVZeH5K8axLSDWF7F7FVf7NhKK4YEGa9Ga8iUxN
        bmbp6B6HoEQ9mepQqjwPeUQ=
X-Google-Smtp-Source: AHgI3IZ6WjeBhL0obV2RJmXLQ/43Gir8C3ggByc6SdwIZcldGGfDYDMhaM7egXpfS++ivCrDFwEmXw==
X-Received: by 2002:a7b:cc86:: with SMTP id p6mr3338194wma.32.1551452335241;
        Fri, 01 Mar 2019 06:58:55 -0800 (PST)
Received: from laptop.criteois.lan ([91.199.242.236])
        by smtp.gmail.com with ESMTPSA id d9sm24400372wrn.72.2019.03.01.06.58.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Mar 2019 06:58:53 -0800 (PST)
From:   Erwan Velu <erwanaliasr1@gmail.com>
X-Google-Original-From: Erwan Velu <e.velu@criteo.com>
To:     elliott@hpe.com
Cc:     Erwan Velu <e.velu@criteo.com>,
        Don Brace <don.brace@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        esc.storagedev@microsemi.com (open list:MICROSEMI SMART ARRAY SMARTPQI
        DRIVER (smartpqi)),
        linux-scsi@vger.kernel.org (open list:MICROSEMI SMART ARRAY SMARTPQI
        DRIVER (smartpqi)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] scsi: smartpqi_init: Reporting 'logical unit failure'
Date:   Fri,  1 Mar 2019 15:58:32 +0100
Message-Id: <20190301145832.12735-1-e.velu@criteo.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190227163133.26283-1-e.velu@criteo.com>
References: <20190227163133.26283-1-e.velu@criteo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the HARDWARE_ERROR/0x3e/0x1 case is triggered, the logical volume is offlined.
When reading the kernel log, the reason why the device got offlined isn't reported to the user.
This situation makes difficult for admins to estimate the root cause of the issue they analize.

Reading this part of the code makes clear this is because driver received a HARDWARE_ERROR/0x3e/0x1 which is a 'logical unit failure'.
This patch is just about reporting the reason behind the offlining to ease the analyse.

Signed-off-by: Erwan Velu <e.velu@criteo.com>
---
 drivers/scsi/smartpqi/smartpqi_init.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index f564af8949e8..dfc4a6813440 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -2764,6 +2764,12 @@ static void pqi_process_raid_io_error(struct pqi_io_request *io_request)
 				sshdr.sense_key == HARDWARE_ERROR &&
 				sshdr.asc == 0x3e &&
 				sshdr.ascq == 0x1) {
+			struct pqi_ctrl_info *ctrl_info = shost_to_hba(scmd->device->host);
+			struct pqi_scsi_dev *device = scmd->device->hostdata;
+
+			dev_err_ratelimited(&ctrl_info->pci_dev->dev, "received 'logical unit failure' from controller for scsi %d:%d:%d:%d\n",
+							ctrl_info->scsi_host->host_no, device->bus,
+							device->target, device->lun);
 			pqi_take_device_offline(scmd->device, "RAID");
 			host_byte = DID_NO_CONNECT;
 		}
-- 
2.20.1

