Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC5AC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 23:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 981B7206C1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 23:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559690828;
	bh=DhF+w2lUm8uOLVu5zxCOaytkiHmbCxqOG12RKPPSHQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q1VS7gizVVGRxSpHb2YcopnhN3VCfZrb/ErR2kSPHb5GMsc0YqZxlvJF6rGbc0Mcv
	 8V6pdShTsWoZXW+Q3vDfxaWa8gwvsyKiHzs6XtLiYLnpDek0avQjuK7/p7eS3c/q4E
	 /t14qG0OY3YQy1591x8z4zdhliytaeBR2INNeI6E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbfFDXZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 19:25:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:37094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727303AbfFDXZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 19:25:24 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADE0320859;
        Tue,  4 Jun 2019 23:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559690723;
        bh=DhF+w2lUm8uOLVu5zxCOaytkiHmbCxqOG12RKPPSHQI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IBeSw4ghTDNhTetyUW5D0RMgM0NLkZsPQGq+txCV1zSTE3W5VHZZOR+4Spsazet2b
         k2wsvADT6vQ4IGlkHTFFmyZMe8QYeCnSHF5AGp5uDFnryqieCqx+uRMukVkXKDMxnp
         fSlVhzAunU2Do+GTOuKJddf+Iq8q5aesIm9s0udU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Colin Ian King <colin.king@canonical.com>,
        Saurav Kashyap <skashyap@marvell.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 12/17] scsi: bnx2fc: fix incorrect cast to u64 on shift operation
Date:   Tue,  4 Jun 2019 19:24:53 -0400
Message-Id: <20190604232459.7745-12-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190604232459.7745-1-sashal@kernel.org>
References: <20190604232459.7745-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit d0c0d902339249c75da85fd9257a86cbb98dfaa5 ]

Currently an int is being shifted and the result is being cast to a u64
which leads to undefined behaviour if the shift is more than 31 bits. Fix
this by casting the integer value 1 to u64 before the shift operation.

Addresses-Coverity: ("Bad shift operation")
Fixes: 7b594769120b ("[SCSI] bnx2fc: Handle REC_TOV error code from firmware")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Acked-by: Saurav Kashyap <skashyap@marvell.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/bnx2fc/bnx2fc_hwi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/bnx2fc/bnx2fc_hwi.c b/drivers/scsi/bnx2fc/bnx2fc_hwi.c
index 5ff9f89c17c7..39b2f60149d9 100644
--- a/drivers/scsi/bnx2fc/bnx2fc_hwi.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_hwi.c
@@ -829,7 +829,7 @@ static void bnx2fc_process_unsol_compl(struct bnx2fc_rport *tgt, u16 wqe)
 			((u64)err_entry->data.err_warn_bitmap_hi << 32) |
 			(u64)err_entry->data.err_warn_bitmap_lo;
 		for (i = 0; i < BNX2FC_NUM_ERR_BITS; i++) {
-			if (err_warn_bit_map & (u64) (1 << i)) {
+			if (err_warn_bit_map & ((u64)1 << i)) {
 				err_warn = i;
 				break;
 			}
-- 
2.20.1

