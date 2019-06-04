Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D1CC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 23:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DB5A206C1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 23:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559690645;
	bh=JbAu3TdWLDVbaFQsNEeghoscA2U6ZuPh00/lRMKb6+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SYAFEEaKTSfNURxngTSt9A2ZMil6z+mBiExOgwZcvBSMm9pD+xKrSSAihmsmRgjB7
	 Kxshk4rG4eLPiv7vQW1x7E5oTxSc5THzUJmy2BRiBUhuqi+DtAa9XFzQM0ZD+VS6Yx
	 SV5En9XIrwice71owznSlrPiH2Uu4/Vz9PyPhDvY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbfFDXYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 19:24:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:34800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727427AbfFDXYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 19:24:01 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9087320866;
        Tue,  4 Jun 2019 23:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559690640;
        bh=JbAu3TdWLDVbaFQsNEeghoscA2U6ZuPh00/lRMKb6+4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oqUP7Z0BLee73lp5gypjNACCEFAMvHPvtdHGxZzZjhFpg8SZzt3yZHJbkOJssnRH3
         w9aUsB+h/DY9DX3edHtt0SvtpKC68k4qSjJ7VKydsx0Vfw4YkEvbjUIc1VxyQaaVQg
         et/gYzoeJdlU8zzDV+wabzl11piuSY+evIrcgD9Y=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 15/36] scsi: lpfc: add check for loss of ndlp when sending RRQ
Date:   Tue,  4 Jun 2019 19:23:10 -0400
Message-Id: <20190604232333.7185-15-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190604232333.7185-1-sashal@kernel.org>
References: <20190604232333.7185-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Smart <jsmart2021@gmail.com>

[ Upstream commit c8cb261a072c88ca1aff0e804a30db4c7606521b ]

There was a missing qualification of a valid ndlp structure when calling to
send an RRQ for an abort.  Add the check.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
Tested-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/lpfc/lpfc_els.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index 0d214e6b8e9a..f3c6801c0b31 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -7094,7 +7094,10 @@ int
 lpfc_send_rrq(struct lpfc_hba *phba, struct lpfc_node_rrq *rrq)
 {
 	struct lpfc_nodelist *ndlp = lpfc_findnode_did(rrq->vport,
-							rrq->nlp_DID);
+						       rrq->nlp_DID);
+	if (!ndlp)
+		return 1;
+
 	if (lpfc_test_rrq_active(phba, ndlp, rrq->xritag))
 		return lpfc_issue_els_rrq(rrq->vport, ndlp,
 					 rrq->nlp_DID, rrq);
-- 
2.20.1

