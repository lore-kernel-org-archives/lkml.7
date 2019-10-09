Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A49ECE597
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 17:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 646D3206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 17:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570641842;
	bh=NGjSbI2cPKdmC/6lFM2rFaIZI5zwvy98Jj9zrIDJtwQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=T3OV9KUXnGQ1B6ue1MWPswb4Rbn5L26Kb/yWX6q4HHPH3XA9gSwKc+rsEbTxTa5wJ
	 vp1auUOkPaYRKnfUdsLOAif8xhdrX/IknRWwsDweFmP+jUPzGSC3VhSXJZ+uwwi4M5
	 oAFCU3ZivGr/fc/jFVWY2FwWII1lP5NW6F8pw2kc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732079AbfJIRYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 13:24:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:48098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731995AbfJIRX4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 13:23:56 -0400
Received: from sasha-vm.mshome.net (unknown [167.220.2.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1FC121E6F;
        Wed,  9 Oct 2019 17:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570641835;
        bh=NGjSbI2cPKdmC/6lFM2rFaIZI5zwvy98Jj9zrIDJtwQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mtcXeumk0OpqU8h4QJ80STM8ly13tm5W/AZ9zKqWI4ErAvFjxm9JvSSQfLLFwaR3m
         QLPid6223wgtDoPlvft720tcFnI7t9nT3YQAwYA/uSnBzjjF9Yrt+srIdshrGoCzqU
         lyMPgU1nkqT5UWxpQGvGIFEWfDkxqLao5qz7tvzA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Himanshu Madhani <hmadhani@marvell.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.3 09/68] scsi: qla2xxx: Silence fwdump template message
Date:   Wed,  9 Oct 2019 13:04:48 -0400
Message-Id: <20191009170547.32204-9-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191009170547.32204-1-sashal@kernel.org>
References: <20191009170547.32204-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Himanshu Madhani <hmadhani@marvell.com>

[ Upstream commit 248a445adfc8c33ffd67cf1f2e336578e34f9e21 ]

Print if fwdt template is present or not, only when
ql2xextended_error_logging is enabled.

Link: https://lore.kernel.org/r/20190912180918.6436-2-hmadhani@marvell.com
Signed-off-by: Himanshu Madhani <hmadhani@marvell.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index afcd9a8858845..3fbe909744a8f 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -3268,7 +3268,7 @@ try_eft:
 
 		for (j = 0; j < 2; j++, fwdt++) {
 			if (!fwdt->template) {
-				ql_log(ql_log_warn, vha, 0x00ba,
+				ql_dbg(ql_dbg_init, vha, 0x00ba,
 				    "-> fwdt%u no template\n", j);
 				continue;
 			}
-- 
2.20.1

