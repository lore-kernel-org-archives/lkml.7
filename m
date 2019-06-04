Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2637C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 23:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 720DB206B8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 23:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559691068;
	bh=nPrxG2VCASchUxSF39JLTqA8vdNFE2cc2ID1X0gHivw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZaTXWSYYm2behOComfKBlHqAU+wejI4jp8wxzvov4fEMYcFefgA59FJUwDcyVh+0S
	 Hj3WkGy/v32FKA5jWHMK9ByBhzLJ3WQ/Bze1WAG3rwp/h7Ee9QIn/TeUV6L6Rf6Tcc
	 lxAjV5tqfL8rJhJif6GLYSMJjtJ4j/QLc+FkyBmg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbfFDXbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 19:31:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:33598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727183AbfFDXXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 19:23:07 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8011F2085A;
        Tue,  4 Jun 2019 23:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559690587;
        bh=nPrxG2VCASchUxSF39JLTqA8vdNFE2cc2ID1X0gHivw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ghBHankZdiz7+AN1/+96Lr2l+EMpKw45ye4LiTlW1nXbV/VDvAJyM3wSsSrnBYSO5
         ce10wjxqZ8RvIz6PPvP75ubPN49+pBEQS/uNyfNxnIwRmtaIRNlxmWvQ7E0UWmUk2X
         7esKwhvNX0I+l/278u2pJF6kSDdgYxnGHeErDmPI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Hannes Reinecke <hare@suse.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.1 36/60] scsi: myrs: Fix uninitialized variable
Date:   Tue,  4 Jun 2019 19:21:46 -0400
Message-Id: <20190604232212.6753-36-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190604232212.6753-1-sashal@kernel.org>
References: <20190604232212.6753-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit 41552199b5518fe26bee0829a28dd1880441b430 ]

drivers/scsi/myrs.c: In function 'myrs_log_event':
drivers/scsi/myrs.c:821:24: warning: 'sshdr.sense_key' may be used uninitialized in this function [-Wmaybe-uninitialized]
  struct scsi_sense_hdr sshdr;

If ev->ev_code is not 0x1C, sshdr.sense_key may be used uninitialized. Fix
this by initializing variable 'sshdr' to 0.

Fixes: 77266186397c ("scsi: myrs: Add Mylex RAID controller (SCSI interface)")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/myrs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/myrs.c b/drivers/scsi/myrs.c
index b8d54ef8cf6d..eb0dd566330a 100644
--- a/drivers/scsi/myrs.c
+++ b/drivers/scsi/myrs.c
@@ -818,7 +818,7 @@ static void myrs_log_event(struct myrs_hba *cs, struct myrs_event *ev)
 	unsigned char ev_type, *ev_msg;
 	struct Scsi_Host *shost = cs->host;
 	struct scsi_device *sdev;
-	struct scsi_sense_hdr sshdr;
+	struct scsi_sense_hdr sshdr = {0};
 	unsigned char sense_info[4];
 	unsigned char cmd_specific[4];
 
-- 
2.20.1

