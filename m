Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A47C00454
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2D0D2073B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576079173;
	bh=McM3dhr1jVpD0AJ5FtS8xQ2qMJkB4Xzr3/8KHIfFeDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EjqY6Sbu0BUrWhfceK0pjAOPNHspnEOcpJ9sEmoSICaPAx35hI4R2v3pxSxwQAMNp
	 7CyMWcU1H6z+v1xx6yBb4MPuVAzo7D4kPGjJlz/jMCtAaNrZJw6BDvcYJm6oGPY6Ep
	 ap3NqA4p+ifxz1t62yAvDf5TV7LrelIesTbpewIQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387419AbfLKPqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:46:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:60458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733203AbfLKP04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:26:56 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E832C2467A;
        Wed, 11 Dec 2019 15:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576078015;
        bh=McM3dhr1jVpD0AJ5FtS8xQ2qMJkB4Xzr3/8KHIfFeDI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uZdIRt2kRx6HygAZf2zPz3Nn/POxZUV9Pqk0Iw9x4wEzFT2wbgN9Za+PcZZ75oE5q
         hrxRhHFx35p9dCuJwhN8CHmKYtOXCY9SznwYoX9xURu5kBOcDLXdV+PyUsdAN3bviw
         aE4G6E3HyqkR6Tjp5BTkK4i9/z21W+/90WkqxNL0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 10/79] scsi: lpfc: Fix SLI3 hba in loop mode not discovering devices
Date:   Wed, 11 Dec 2019 10:25:34 -0500
Message-Id: <20191211152643.23056-10-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191211152643.23056-1-sashal@kernel.org>
References: <20191211152643.23056-1-sashal@kernel.org>
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
index bd8dc6a2243c0..3dfed191252cf 100644
--- a/drivers/scsi/lpfc/lpfc_nportdisc.c
+++ b/drivers/scsi/lpfc/lpfc_nportdisc.c
@@ -483,8 +483,10 @@ lpfc_rcv_plogi(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
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

