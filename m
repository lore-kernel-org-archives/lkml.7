Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36193C3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08A2B217F4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578004766;
	bh=+zrt2PfYOEuMTQxgmUYYfno+qL18+KOj8WYPPz4YJmk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Th3GOPKVGNQPX2n8zkIyoxUg+JIERWnugyrwPah8gc0mA/rl7ZBJUPgudFMui7e2d
	 ODJCGWZ2diwgdgfNBRHU8FwOaew/kG44pwiBDl1EeEQq0PQdwYNLGUvk+BX2x0x3UP
	 16yDgrWyB+PHikubTNYbUmPFvKnJPopAjv4R8rqU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731471AbgABWjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:39:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:55444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731459AbgABWjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:39:23 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E4C222525;
        Thu,  2 Jan 2020 22:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578004762;
        bh=+zrt2PfYOEuMTQxgmUYYfno+qL18+KOj8WYPPz4YJmk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XIBN+xIZbMPz2j0LceUv0Q30C3Y9iz9J/JEiTLiuMfwFilmwiBz2lTbbJoZb4c0mD
         3kVR8urXYwN0puVRlFf9mx+pHfEgKfveqwStOQjQiwAe7tPnRh3OBAztUZkgxxITFQ
         GQNaKSFv1LFlUEeH3a0AcuBe2aBcdFkQdhd/iNlA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jack Wang <jinpu.wang@cloud.ionos.com>,
        peter chang <dpf@google.com>,
        Deepak Ukey <deepak.ukey@microchip.com>,
        Viswas G <Viswas.G@microchip.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 117/137] scsi: pm80xx: Fix for SATA device discovery
Date:   Thu,  2 Jan 2020 23:08:10 +0100
Message-Id: <20200102220602.896797596@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102220546.618583146@linuxfoundation.org>
References: <20200102220546.618583146@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: peter chang <dpf@google.com>

[ Upstream commit ce21c63ee995b7a8b7b81245f2cee521f8c3c220 ]

Driver was missing complete() call in mpi_sata_completion which result in
SATA abort error handling timing out. That causes the device to be left in
the in_recovery state so subsequent commands sent to the device fail and
the OS removes access to it.

Link: https://lore.kernel.org/r/20191114100910.6153-2-deepak.ukey@microchip.com
Acked-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Signed-off-by: peter chang <dpf@google.com>
Signed-off-by: Deepak Ukey <deepak.ukey@microchip.com>
Signed-off-by: Viswas G <Viswas.G@microchip.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/pm8001/pm80xx_hwi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
index 9edd61c063a1..df5f0bc29587 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.c
+++ b/drivers/scsi/pm8001/pm80xx_hwi.c
@@ -2368,6 +2368,8 @@ mpi_sata_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
 			pm8001_printk("task 0x%p done with io_status 0x%x"
 			" resp 0x%x stat 0x%x but aborted by upper layer!\n",
 			t, status, ts->resp, ts->stat));
+		if (t->slow_task)
+			complete(&t->slow_task->completion);
 		pm8001_ccb_task_free(pm8001_ha, t, ccb, tag);
 	} else {
 		spin_unlock_irqrestore(&t->task_state_lock, flags);
-- 
2.20.1



