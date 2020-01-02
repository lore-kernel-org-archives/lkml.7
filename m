Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1C0C3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB93E22525
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578003870;
	bh=gswYiLu3FlwC8HmRfHwjDATuJUwUjszRLkoCYGdkelQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CMSxkm4TRvRGuoLQSJjVFk2wMhgpc69smsC1Hx6pt3ong324L8MKG/VGX74BG9lgo
	 +EctCX2CqSFT8zTdRf9eYZ76Cu3oPoexSDuB+LS4li5yCdRyD/3M2/KQCLCz8oqiRb
	 7xUzzx8ZWGqjh+cHKA4u10oDWjd4aA2sMGRhRk8Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729266AbgABWY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:24:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:48250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729398AbgABWYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:24:23 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A35420866;
        Thu,  2 Jan 2020 22:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578003863;
        bh=gswYiLu3FlwC8HmRfHwjDATuJUwUjszRLkoCYGdkelQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LlsErYJjk54/SJiAmC6xHjzyuYkoqVubiIx68PFp0kFQ6Kh7a4Mcli2vF90zhzOBC
         6xhcsRa3t3tZWerhSLxIIJS2Fx4P49qNAX2nUWwaWxbQ4tgYn3Z3HHJE+W2oiOAfr+
         j1xsMD66w7HTKBYO9K652qjU1vVh9RX+rGGHKNME=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <jsmart2021@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 07/91] scsi: lpfc: Fix SLI3 hba in loop mode not discovering devices
Date:   Thu,  2 Jan 2020 23:06:49 +0100
Message-Id: <20200102220405.119689544@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102220356.856162165@linuxfoundation.org>
References: <20200102220356.856162165@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 043bca6449cd..96411754aa43 100644
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



