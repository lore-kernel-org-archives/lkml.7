Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33A0C2D0BF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBC92206EC
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576521011;
	bh=E+F7Y1VTnP3l3yQ9F4Q3uNcIk7A4nImUB8xp1cxOo4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2gSeHOEfkGlHtVl/7M0Vs8IQaXU8H6web60VoMHXVNeGJ71ES4stNEqVdRx+QwS47
	 YrirMzEm/wr/f8x7trQepWxNgetVezTKKQ/8CmmeQ2GQTcxZJIel1w8HK99idCnglY
	 mXoZ3OlyjEKqpB6V4wd5zlKRw0jodCDL/9SKroz4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731042AbfLPSNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:13:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:58562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730255AbfLPSM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:12:57 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4266A21835;
        Mon, 16 Dec 2019 18:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576519976;
        bh=E+F7Y1VTnP3l3yQ9F4Q3uNcIk7A4nImUB8xp1cxOo4s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o3JghY5sJZ06dPZWmKkHDtfWDg184QzSQmokBOsagdOQw6FoqH/aitHs7U7/zd66U
         KP2PzaDjjMg7cmLGkozexdlRn8GskxCQ5UhsBIcPRJmO9SDLibdEGHVOIhAfkzuFyq
         UGNe2QUA1Mo0Hs3VulYxJXiXUGATBRkWBVD/rMtA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Himanshu Madhani <hmadhani@marvell.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 145/180] scsi: qla2xxx: Fix session lookup in qlt_abort_work()
Date:   Mon, 16 Dec 2019 18:49:45 +0100
Message-Id: <20191216174843.492359033@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174806.018988360@linuxfoundation.org>
References: <20191216174806.018988360@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bart Van Assche <bvanassche@acm.org>

[ Upstream commit ac452b8e79320c9e90c78edf32ba2d42431e4daf ]

Pass the correct session ID to find_sess_by_s_id() instead of passing an
uninitialized variable.

Cc: Himanshu Madhani <hmadhani@marvell.com>
Fixes: 2d70c103fd2a ("[SCSI] qla2xxx: Add LLD target-mode infrastructure for >= 24xx series") # v3.5.
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Tested-by: Himanshu Madhani <hmadhani@marvell.com>
Reviewed-by: Himanshu Madhani <hmadhani@marvell.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_target.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index 1bb0fc9324ead..7e98d1be757dc 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -6195,7 +6195,6 @@ static void qlt_abort_work(struct qla_tgt *tgt,
 	struct qla_hw_data *ha = vha->hw;
 	struct fc_port *sess = NULL;
 	unsigned long flags = 0, flags2 = 0;
-	uint32_t be_s_id;
 	uint8_t s_id[3];
 	int rc;
 
@@ -6208,8 +6207,7 @@ static void qlt_abort_work(struct qla_tgt *tgt,
 	s_id[1] = prm->abts.fcp_hdr_le.s_id[1];
 	s_id[2] = prm->abts.fcp_hdr_le.s_id[0];
 
-	sess = ha->tgt.tgt_ops->find_sess_by_s_id(vha,
-	    (unsigned char *)&be_s_id);
+	sess = ha->tgt.tgt_ops->find_sess_by_s_id(vha, s_id);
 	if (!sess) {
 		spin_unlock_irqrestore(&ha->tgt.sess_lock, flags2);
 
-- 
2.20.1



