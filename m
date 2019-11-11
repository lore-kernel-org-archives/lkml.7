Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F3E9C17445
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEFE2222C2
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573498504;
	bh=pUWKp8naBDs9sjU+E0WOyTLJfsG5GyDZCVxfypsKw5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FXtLE7DRm7QnbZaThyH3+NRjAbD1HlBdDgIlVdHFCpXtLq1bSA+4rS3NdDlTCXhto
	 wcJhUbaGwctXqccDJCSyIvPbyqCYN6/LDWoQY2gFlmVdFnDM9D94i6Q6S8lwkTEAit
	 o1g3UeJ2p62ttHTN/oE/k/X2UKCkfJGpiY6dQfGY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730595AbfKKSzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:55:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:51466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729539AbfKKSy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:54:58 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21008204EC;
        Mon, 11 Nov 2019 18:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573498497;
        bh=pUWKp8naBDs9sjU+E0WOyTLJfsG5GyDZCVxfypsKw5k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fk0sUEygIIdxD3eOQCSVH82w9bSMi9lX+BtZH7o5Wr7WThLu35yNx5vyBPYcC67f+
         TolrLnQ6KeShtPRHZ1B2LB8YVZQzXeFBJbd7tR9L0ioP6Nx5IAT31wi4D3tDnIrhc4
         Y79S/1h/vndQPzTSpgfVy+NLtG6m7vn2+08Xv7IE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiang Chen <chenxiang66@hisilicon.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 136/193] scsi: sd: define variable dif as unsigned int instead of bool
Date:   Mon, 11 Nov 2019 19:28:38 +0100
Message-Id: <20191111181511.204518731@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111181459.850623879@linuxfoundation.org>
References: <20191111181459.850623879@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiang Chen <chenxiang66@hisilicon.com>

[ Upstream commit 0cf9f4e547cebb5f5d2d046437c71ddcc8ea4a39 ]

Variable dif in function sd_setup_read_write_cmnd() is the return value of
function scsi_host_dif_capable() which returns dif capability of disks.  If
define it as bool, even for the disks which support DIF3, the function
still return dif=1, which causes IO error. So define variable dif as
unsigned int instead of bool.

Fixes: e249e42d277e ("scsi: sd: Clean up sd_setup_read_write_cmnd()")
Link: https://lore.kernel.org/r/1571725628-132736-1-git-send-email-chenxiang66@hisilicon.com
Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/sd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 2d77f32e13d5e..9dc367e2e742d 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -1166,11 +1166,12 @@ static blk_status_t sd_setup_read_write_cmnd(struct scsi_cmnd *cmd)
 	sector_t lba = sectors_to_logical(sdp, blk_rq_pos(rq));
 	sector_t threshold;
 	unsigned int nr_blocks = sectors_to_logical(sdp, blk_rq_sectors(rq));
-	bool dif, dix;
 	unsigned int mask = logical_to_sectors(sdp, 1) - 1;
 	bool write = rq_data_dir(rq) == WRITE;
 	unsigned char protect, fua;
 	blk_status_t ret;
+	unsigned int dif;
+	bool dix;
 
 	ret = scsi_init_io(cmd);
 	if (ret != BLK_STS_OK)
-- 
2.20.1



