Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E80E1C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C06B8214E0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573497050;
	bh=y/EzYc3L6edo1ur9WPq4mwtfpeuypnsd12zZoJ/6Kzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DMzqbZPx+4NHbZsHIsFl1hW70BnVLQLdvcog0UJouHrWiPOYslrshxfgl9KllG0Op
	 a9LoNQmRRBTnh9OHvmeqFibjdbLW61FwPWPxyzl3RoXOvf/SxiM2Pib3bIFgsDPrr5
	 DE5acU0RM35Ae0brRMwd/ZIaRyW3W0TMPoWR2kJ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbfKKSat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:30:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:47168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727420AbfKKSar (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:30:47 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6708B214E0;
        Mon, 11 Nov 2019 18:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573497046;
        bh=y/EzYc3L6edo1ur9WPq4mwtfpeuypnsd12zZoJ/6Kzw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WBItQIQNOVLJbDHPKo86yzBr+w5A8zdjlYqlMwP2OmjhnLcRTr/FalF1tYCWy40Am
         6NKY9/lCLtQC8d7LXXQtWHRehriYuLgQZJMEvhZy4XG0JJ4xt95bVLav0sRzWSzZ+Y
         bIdpsVU6tYHeuryWWbcp8SxT5PbKZ4V4WjZEAmRw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        Hannes Reinecke <hare@suse.de>,
        Daniel Wagner <dwagner@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 27/43] scsi: lpfc: Honor module parameter lpfc_use_adisc
Date:   Mon, 11 Nov 2019 19:28:41 +0100
Message-Id: <20191111181319.179410245@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111181246.772983347@linuxfoundation.org>
References: <20191111181246.772983347@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Wagner <dwagner@suse.de>

[ Upstream commit 0fd103ccfe6a06e40e2d9d8c91d96332cc9e1239 ]

The initial lpfc_desc_set_adisc implementation in commit
dea3101e0a5c ("lpfc: add Emulex FC driver version 8.0.28") enabled ADISC if

	cfg_use_adisc && RSCN_MODE && FCP_2_DEVICE

In commit 92d7f7b0cde3 ("[SCSI] lpfc: NPIV: add NPIV support on top of
SLI-3") this changed to

	(cfg_use_adisc && RSC_MODE) || FCP_2_DEVICE

and later in commit ffc954936b13 ("[SCSI] lpfc 8.3.13: FC Discovery Fixes
and enhancements.") to

	(cfg_use_adisc && RSC_MODE) || (FCP_2_DEVICE && FCP_TARGET)

A customer reports that after a devloss, an ADISC failure is logged. It
turns out the ADISC flag is set even the user explicitly set lpfc_use_adisc
= 0.

[Sat Dec 22 22:55:58 2018] lpfc 0000:82:00.0: 2:(0):0203 Devloss timeout on WWPN 50:01:43:80:12:8e:40:20 NPort x05df00 Data: x82000000 x8 xa
[Sat Dec 22 23:08:20 2018] lpfc 0000:82:00.0: 2:(0):2755 ADISC failure DID:05DF00 Status:x9/x70000

[mkp: fixed Hannes' email]

Fixes: 92d7f7b0cde3 ("[SCSI] lpfc: NPIV: add NPIV support on top of SLI-3")
Cc: Dick Kennedy <dick.kennedy@broadcom.com>
Cc: James Smart <james.smart@broadcom.com>
Link: https://lore.kernel.org/r/20191022072112.132268-1-dwagner@suse.de
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: James Smart <james.smart@broadcom.com>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/lpfc/lpfc_nportdisc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_nportdisc.c b/drivers/scsi/lpfc/lpfc_nportdisc.c
index 193733e8c8235..3a4613f9fb9fc 100644
--- a/drivers/scsi/lpfc/lpfc_nportdisc.c
+++ b/drivers/scsi/lpfc/lpfc_nportdisc.c
@@ -759,9 +759,9 @@ lpfc_disc_set_adisc(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 
 	if (!(vport->fc_flag & FC_PT2PT)) {
 		/* Check config parameter use-adisc or FCP-2 */
-		if ((vport->cfg_use_adisc && (vport->fc_flag & FC_RSCN_MODE)) ||
+		if (vport->cfg_use_adisc && ((vport->fc_flag & FC_RSCN_MODE) ||
 		    ((ndlp->nlp_fcp_info & NLP_FCP_2_DEVICE) &&
-		     (ndlp->nlp_type & NLP_FCP_TARGET))) {
+		     (ndlp->nlp_type & NLP_FCP_TARGET)))) {
 			spin_lock_irq(shost->host_lock);
 			ndlp->nlp_flag |= NLP_NPR_ADISC;
 			spin_unlock_irq(shost->host_lock);
-- 
2.20.1



