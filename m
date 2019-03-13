Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78258C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 469A12177E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552504548;
	bh=eRuTXzFxAF1ju1nSoGwTv5WDMK/ep74xM7GwWiGPUx0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o0ygz4r+McdYBLHYAHlGzT9x5bAYnGv1QsduGJhC2cCLDx3O78Gdp14XshRzsVlZO
	 bvzAPfCWt6Jtgw+qHounb+SZOg5/bObnivS2iETtU0/aoGzq3gn4fln+c5Vjkw7DRF
	 NeC5WqOHi5G1Kwi6b0Slt9PtyZuNz16D0rSVeYRY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbfCMTPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:15:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:45742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728466AbfCMTPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:15:37 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44739213A2;
        Wed, 13 Mar 2019 19:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552504537;
        bh=eRuTXzFxAF1ju1nSoGwTv5WDMK/ep74xM7GwWiGPUx0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U9Qrl0BRFBotq28ZbCyBou+Mv2Lg1IePB9nywUBTcjURH5mMjQT8TJOPrzB9P07P0
         eE9xSVZHchA/Mw3LDloKqHspx1ScB+v7oQcEaPKC/Z3i1v2nKlnkYahLjFXOVklRUL
         Z2VLrm8J/17B1DKYI+JxXnBRi+C8I8TvL1dfM5FE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Martin Wilck <mwilck@suse.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 09/33] scsi: core: reset host byte in DID_NEXUS_FAILURE case
Date:   Wed, 13 Mar 2019 15:14:42 -0400
Message-Id: <20190313191506.159677-9-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190313191506.159677-1-sashal@kernel.org>
References: <20190313191506.159677-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Wilck <mwilck@suse.com>

[ Upstream commit 4a067cf823d9d8e50d41cfb618011c0d4a969c72 ]

Up to 4.12, __scsi_error_from_host_byte() would reset the host byte to
DID_OK for various cases including DID_NEXUS_FAILURE.  Commit
2a842acab109 ("block: introduce new block status code type") replaced this
function with scsi_result_to_blk_status() and removed the host-byte
resetting code for the DID_NEXUS_FAILURE case.  As the line
set_host_byte(cmd, DID_OK) was preserved for the other cases, I suppose
this was an editing mistake.

The fact that the host byte remains set after 4.13 is causing problems with
the sg_persist tool, which now returns success rather then exit status 24
when a RESERVATION CONFLICT error is encountered.

Fixes: 2a842acab109 "block: introduce new block status code type"
Signed-off-by: Martin Wilck <mwilck@suse.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/scsi_lib.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 7f505c027ce7..37d366696d21 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -734,6 +734,7 @@ static blk_status_t __scsi_error_from_host_byte(struct scsi_cmnd *cmd,
 		set_host_byte(cmd, DID_OK);
 		return BLK_STS_TARGET;
 	case DID_NEXUS_FAILURE:
+		set_host_byte(cmd, DID_OK);
 		return BLK_STS_NEXUS;
 	case DID_ALLOC_FAILURE:
 		set_host_byte(cmd, DID_OK);
-- 
2.19.1

