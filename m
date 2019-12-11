Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5041EC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FF5C22527
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576078843;
	bh=t9TQtsoSji5+niuYb59uX5nOBO+cmKRvQ7yP21DTU9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OO64TzuMf6j4UZgYjY3mk7LHtmxR0621q+n0SbghCfl18kr6E5TowXv3UMYtpzcNZ
	 lr/Rl/ug6gOMoikg+muEdK4ixWfHLiZSCkenYEioS5wR8t9iAiQk2cAgOeSMElEyJC
	 y6Z3YyzYPFrKbMT2dvQtCteBiX4yHyIRUoF4Irds=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388402AbfLKPi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:38:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:48752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388362AbfLKPiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:38:21 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3B1D22B48;
        Wed, 11 Dec 2019 15:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576078700;
        bh=t9TQtsoSji5+niuYb59uX5nOBO+cmKRvQ7yP21DTU9I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D5IR4QxXiCH1SHbq+8JVLcNOCJcA9Uni+CSVVoUAwuP0yO8AdNBbvE+ZslwY2QBnD
         dqZgjXY0VNbG2FMNPaW0MgVr+78EyjPvjHcbLJDgF+RuqlYeN6cRdpbk1IAQHzWpH9
         W4zq/nPFpWE5QEk8Lfi1PtkrgL9xtiAe1Nr7xEr0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 06/37] scsi: lpfc: Fix SLI3 hba in loop mode not discovering devices
Date:   Wed, 11 Dec 2019 10:37:42 -0500
Message-Id: <20191211153813.24126-6-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191211153813.24126-1-sashal@kernel.org>
References: <20191211153813.24126-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Smart <jsmart2021@gmail.com>

[ Upstream commit feff8b3d84d3d9570f893b4d83e5eab6693d6a52 ]

When operating in private loop mode, PLOGI exchanges are racing and the
driver tries to abort it's PLOGI. But the PLOGI abort ends up terminating
the login with the other end causing the other end to abort its PLOGI as
well. Discovery never fully completes.

Fix by disabling the PLOGI abort when private loop and letting the state
machine play out.

Link: https://lore.kernel.org/r/20191018211832.7917-5-jsmart2021@gmail.com
Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/lpfc/lpfc_nportdisc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_nportdisc.c b/drivers/scsi/lpfc/lpfc_nportdisc.c
index 3a4613f9fb9fc..6aa0698925dac 100644
--- a/drivers/scsi/lpfc/lpfc_nportdisc.c
+++ b/drivers/scsi/lpfc/lpfc_nportdisc.c
@@ -454,8 +454,10 @@ lpfc_rcv_plogi(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	 * single discovery thread, this will cause a huge delay in
 	 * discovery. Also this will cause multiple state machines
 	 * running in parallel for this node.
+	 * This only applies to a fabric environment.
 	 */
-	if (ndlp->nlp_state == NLP_STE_PLOGI_ISSUE) {
+	if ((ndlp->nlp_state == NLP_STE_PLOGI_ISSUE) &&
+	    (vport->fc_flag & FC_FABRIC)) {
 		/* software abort outstanding PLOGI */
 		lpfc_els_abort(phba, ndlp);
 	}
-- 
2.20.1

