Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2218C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BE4C2196E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573498511;
	bh=2FsLtqLhiS99k5pYtrl0YkqcXm3pKpNcJ8wumBrs2j0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YhBevFdaTOC++CVjcHi+XH1RiuQwVFYwXihEcBQfplSgw/QRaUtYDponZfCoBg0A4
	 N4wukqVBRhavFtQbc4MHeGGjfEboj9kYqWxd6SugH7ZgkptM9pTC1ddIyBrdf51o8t
	 Xj3ZZY3MUQbeeJH3rGYGWCAHYngAYOh96SaN5a7Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730614AbfKKSzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:55:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:51718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729901AbfKKSzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:55:04 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68BA12173B;
        Mon, 11 Nov 2019 18:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573498504;
        bh=2FsLtqLhiS99k5pYtrl0YkqcXm3pKpNcJ8wumBrs2j0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gw/CTandKyeVLC8vLmoVnsNqf1HhHuCfxEv8kIbcPfMlffQkxSFKoSwibDry0+IrT
         ARVt0fTiKXpVsRtW7sC9WeJW2i3xx5MB96mpAZb4c4zh1w7CK2QAu9k/Czvc9p13TB
         SE58YwdE6oZlaReOWjPE2M8AkpWrqM4NCzlLZXHk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Smart <jsmart2021@gmail.com>,
        Daniel Wagner <dwagner@suse.de>,
        James Smart <james.smart@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 111/193] scsi: lpfc: Check queue pointer before use
Date:   Mon, 11 Nov 2019 19:28:13 +0100
Message-Id: <20191111181509.301623127@linuxfoundation.org>
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

From: Daniel Wagner <dwagner@suse.de>

[ Upstream commit 535fb49e730a6fe1e9f11af4ae67ef4228ff4287 ]

The queue pointer might not be valid. The rest of the code checks the
pointer before accessing it. lpfc_sli4_process_missed_mbox_completions is
the only place where the check is missing.

Fixes: 657add4e5e15 ("scsi: lpfc: Fix poor use of hardware queues if fewer irq vectors")
Cc: James Smart <jsmart2021@gmail.com>
Link: https://lore.kernel.org/r/20191018162111.8798-1-dwagner@suse.de
Signed-off-by: Daniel Wagner <dwagner@suse.de>
Reviewed-by: James Smart <james.smart@broadcom.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/lpfc/lpfc_sli.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index f9e6a135d6565..c7027ecd4d19e 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -7898,7 +7898,7 @@ lpfc_sli4_process_missed_mbox_completions(struct lpfc_hba *phba)
 	if (sli4_hba->hdwq) {
 		for (eqidx = 0; eqidx < phba->cfg_irq_chann; eqidx++) {
 			eq = phba->sli4_hba.hba_eq_hdl[eqidx].eq;
-			if (eq->queue_id == sli4_hba->mbx_cq->assoc_qid) {
+			if (eq && eq->queue_id == sli4_hba->mbx_cq->assoc_qid) {
 				fpeq = eq;
 				break;
 			}
-- 
2.20.1



