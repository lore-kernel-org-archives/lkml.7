Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B30C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 08:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51EA920851
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 08:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9jS9Hpu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfFNIf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 04:35:28 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34010 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfFNIf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 04:35:28 -0400
Received: by mail-pl1-f195.google.com with SMTP id i2so728517plt.1;
        Fri, 14 Jun 2019 01:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ZpRAiGHrxAIp1S+RPmqFGpGzlBqUdjPBsoJh2VxfpuI=;
        b=E9jS9HpuVjphXVxURvMgQuFhZQ2njfiNbye4l8eNwERdDTyQ//sQxXLUHnkGal6Ha5
         2cUCQ4kwQa4Igxa9ZrGG1dkPFGhN0DPBzE34S7Uup7ibzyahrFSgG37n6EzJnNW989G5
         EcYS7Lg0TNwe8UWbpZx1st2mvltLOBg/iPAv6MFv2mocK0/4QQJhQrRkLMF3JAzt33AT
         eedmXS6/f9aNWoUj1cp59m0r/xbuSHlROtrXS6E/U2d7kx8stFKbxv9zl+XeSDZ6Afg3
         jKe8rW6CfUNhnZdjkV6Bqqru8xV69ajylMWI/icXrl/BWyBKFGrCO0TLUguCp7/BT6d+
         E9jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZpRAiGHrxAIp1S+RPmqFGpGzlBqUdjPBsoJh2VxfpuI=;
        b=q2prZ5EFCn5jOlRm+4gSxrTc7lXU58vQbjSTuvr4g0icbl2r6iEoSg6eK9p5st4q4H
         GwjGEolHyYRGTxepT51DIA1Ni/P94dao+4fOqbBT11W2a4RT8KWZA9N4AL0PcsIQDPfv
         TfWq71nCOrbsRHpzR5igGam8Xqz+AeKEWV4MckNiAZ40nRwIoWZ9CPTq432KMtzxhNlB
         8lBcl6kqLPxH4DCEhsIS2azHmFqfv9IAobneqRaue6lPssf1p2wFFpL+OpuLAPKG1kou
         pf9E/g70OEOp0aWBbcIDBFwTwL1RALGJxlBpqK1Bb0a26HFbZpzoOU8YiODY9As+6Xhv
         KREA==
X-Gm-Message-State: APjAAAXsECf30E7PTfBTt8/SkS918fWI1K3h3J9MjiCNu5JgHY3+8uM6
        APCiB9iwdoALJWNd5i/RRDRamoNlPvhseQ==
X-Google-Smtp-Source: APXvYqzkRAPQeSQ0qh6n+xAkbjjlE4Rle/q4c1dTWdQ3gq+EynWF7ZOnrNOEiidLJfqhlu4LHDEBLw==
X-Received: by 2002:a17:902:8f81:: with SMTP id z1mr25690812plo.290.1560501327441;
        Fri, 14 Jun 2019 01:35:27 -0700 (PDT)
Received: from xy-data.openstacklocal ([159.138.22.150])
        by smtp.gmail.com with ESMTPSA id m31sm5207975pjb.6.2019.06.14.01.35.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Jun 2019 01:35:26 -0700 (PDT)
From:   Young Xiao <92siuyang@gmail.com>
To:     QLogic-Storage-Upstream@qlogic.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Young Xiao <92siuyang@gmail.com>
Subject: [PATCH] scsi: bnx2fc: Check if sense buffer has been allocated during completion
Date:   Fri, 14 Jun 2019 16:36:37 +0800
Message-Id: <1560501397-831-1-git-send-email-92siuyang@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sc_cmd->sense_buffer is not guaranteed to be allocated so we need to
sc_cmd->check if the pointer is NULL before trying to copy anything into it.

See commit 16a611154dc1 ("scsi: qedf: Check if sense buffer has been allocated
during completion") for details.

Signed-off-by: Young Xiao <92siuyang@gmail.com>
---
 drivers/scsi/bnx2fc/bnx2fc_io.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/bnx2fc/bnx2fc_io.c b/drivers/scsi/bnx2fc/bnx2fc_io.c
index 8def63c..44a5e59 100644
--- a/drivers/scsi/bnx2fc/bnx2fc_io.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_io.c
@@ -1789,9 +1789,11 @@ static void bnx2fc_parse_fcp_rsp(struct bnx2fc_cmd *io_req,
 			fcp_sns_len = SCSI_SENSE_BUFFERSIZE;
 		}
 
-		memset(sc_cmd->sense_buffer, 0, SCSI_SENSE_BUFFERSIZE);
-		if (fcp_sns_len)
-			memcpy(sc_cmd->sense_buffer, rq_data, fcp_sns_len);
+		if (sc_cmd->sense_buffer) {
+			memset(sc_cmd->sense_buffer, 0, SCSI_SENSE_BUFFERSIZE);
+			if (fcp_sns_len)
+				memcpy(sc_cmd->sense_buffer, rq_data, fcp_sns_len);
+		}
 
 		/* return RQ entries */
 		for (i = 0; i < num_rq; i++)
-- 
2.7.4

