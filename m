Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76F6C48BE4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF8DF20644
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mVKxBsAK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbfF0Ro5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 13:44:57 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38777 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbfF0Ro5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 13:44:57 -0400
Received: by mail-pl1-f193.google.com with SMTP id 9so906161ple.5;
        Thu, 27 Jun 2019 10:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=x8TyTjEHF7IwBr8kCYr6z238B3fU5nGIx1RXJcSqctI=;
        b=mVKxBsAK81UGpOP20Tg7BotB05AsNej6XOM8e4+R5YHXhy5BMe/GufwKR0XmT+UZhY
         Nhjnsx4YLlX6OVtrHlU4W/Cg8y6qc/m3YpxfRpzzUSk/8kWjoqSlPJNeaKIn4j1Lk09h
         BXPrqOK98+/4nxRvGEK9jkZ0fN2ADIz29KCw/1jlwOH8DIkaLOFlRKT+evBnScwen98T
         Jv+LW29S0abCCKiW5keg6hLLM0zVf/Im5+xV3qL3DKdFlt4ifhJPLK2q30FtKzLagWIT
         Dj6b0oRbDuVNv1XTCh9nNSieUedacbkT29OGl84wR/2u+Dkn/NhwyJ3B0FzUh5dgsh0+
         GgfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=x8TyTjEHF7IwBr8kCYr6z238B3fU5nGIx1RXJcSqctI=;
        b=BuU0JTMTAOZHnlTsMupK6+wFv5TaiCt2zdi/eYD6NgAdsfO8oxUf48mpPB08t61PAH
         5CfZ47V8qHCQp+UXn4ndrvM8fmLkXAgKgFx0yr5/SYRJOONh7wUKY82IuzHwbD4xqxpw
         bqVtDq8NuwxCfg7+j41PATLGOgkX1FxhkrLEsnQkNFUv9OErbnkoMm0FSTTNXoMNakm2
         V6k0tsPL6isVfdasfEu5PwarBMDltspkecRkKoDOtNxKna/s4BeoVLXQQ2Fc8LN3nMgx
         hDryyLqLCfaD03oYvBt+Otknt2mrnyuODGQxKOnptduLXGX3CHsiSR4mxrPWfpH/mqmm
         cc0Q==
X-Gm-Message-State: APjAAAV7XUTMLwUrzOdXUEr0zysKJKmGmuZ4JL7X7/4k52N3s5EpKV9Q
        tNMXmkYjD1hy0t4nv0TY468=
X-Google-Smtp-Source: APXvYqyRPIWHrjwyO4yHVshkBFd0RczLrw0/B9zuDdE3IsvrbmPMBEZx4lbwjciXd0tTSWuL5ktEqg==
X-Received: by 2002:a17:902:8f87:: with SMTP id z7mr5908735plo.65.1561657496736;
        Thu, 27 Jun 2019 10:44:56 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id f72sm12642298pjg.10.2019.06.27.10.44.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 10:44:56 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 62/87] scsi: lpfc: replace kmalloc and memset with kzalloc
Date:   Fri, 28 Jun 2019 01:44:46 +0800
Message-Id: <20190627174446.5624-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmalloc + memset(0) -> kzalloc

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/scsi/lpfc/lpfc_debugfs.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_debugfs.c b/drivers/scsi/lpfc/lpfc_debugfs.c
index 1ee857d9d165..0dfac41f2fa8 100644
--- a/drivers/scsi/lpfc/lpfc_debugfs.c
+++ b/drivers/scsi/lpfc/lpfc_debugfs.c
@@ -6017,7 +6017,7 @@ lpfc_debugfs_initialize(struct lpfc_vport *vport)
 				 phba->hba_debugfs_root,
 				 phba, &lpfc_debugfs_op_slow_ring_trc);
 		if (!phba->slow_ring_trc) {
-			phba->slow_ring_trc = kmalloc(
+			phba->slow_ring_trc = kzalloc(
 				(sizeof(struct lpfc_debugfs_trc) *
 				lpfc_debugfs_max_slow_ring_trc),
 				GFP_KERNEL);
@@ -6028,9 +6028,6 @@ lpfc_debugfs_initialize(struct lpfc_vport *vport)
 				goto debug_failed;
 			}
 			atomic_set(&phba->slow_ring_trc_cnt, 0);
-			memset(phba->slow_ring_trc, 0,
-				(sizeof(struct lpfc_debugfs_trc) *
-				lpfc_debugfs_max_slow_ring_trc));
 		}
 
 		snprintf(name, sizeof(name), "nvmeio_trc");
-- 
2.11.0

