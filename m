Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8CBFC48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B41462086D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDVzn75P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfF0Rom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 13:44:42 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33562 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727255AbfF0Rok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 13:44:40 -0400
Received: by mail-pl1-f194.google.com with SMTP id c14so1694185plo.0;
        Thu, 27 Jun 2019 10:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=AUabHIc5uhlhXs6EIFtS8u7UQYxi/NfpXx9PPBVysGY=;
        b=YDVzn75PSL7/pKHj70BQAhgbt+LsPMtbs14ky50ASWnyNIcoa2NXULwxK9CPzC0cTW
         Atcfxd8DYX+gVqvxza00e7ElBKIdQ2G4Gfra+AZ36muiPkXaURMVJSmv/2oafqayRHan
         6B30oo2lrtFtOybzhN2ZOd8O8eAhtdDxTi+LiLKDTRCaB51q6+VRXvFQJ4j+Am3xNmFv
         DWkPEFj8U0ZQXNIu5HF0WSNNQq79AsNxw2tG7ZzfVFmzCK3/BGaG8FIpmkyrG8d7z+l2
         YrFRSeebaFXeayUy53fjtjv5qGlOX8n9VLrvLtuPkDydyuWadaizn5dKWQTsuB37jRGc
         JSGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AUabHIc5uhlhXs6EIFtS8u7UQYxi/NfpXx9PPBVysGY=;
        b=KgAGomelp4FMgnH9XNbvS5hkGQA/LcJeEJAktziJzURb/8DL2TvSKlnPoVWWO4dues
         otCch8qqAJbtzH9Xtl3mCsExR607SvrIS3gbFIDebmy+k3t7FKPuaKnlOPDkyKbGYjvR
         LY2HWlV/jgkFz8xOsZKRogsHVgwg3XJZi2+Lv38cpITt3Wopdzu8N2iAxtpc73OHe8ou
         xRx1W7K7jgIwkiJc9xGyPDiTGjmGof02TAVeVmGmyK/BP1gVhSAfQ/+cDi29A4O82nQD
         moTZ8dCXwwDMTJH8pozTTmKsEATRwgiF5u/dc1jsDlnrgF9mUxbpgyP5Fi+WwdbA7Ybd
         4AOg==
X-Gm-Message-State: APjAAAWajEZQeE7sUNvy3KklQbKd0lhvqxh87mnN5NFQORKogTJxmeb7
        +KND1IFsvgWY32d23F/nKP8=
X-Google-Smtp-Source: APXvYqyCoAbU3KLSo+ihwoNkibMGs1lBrly+tXA2E1W/eJQaRIqrSo8n3en0Lqpimt4tWTev93E6iA==
X-Received: by 2002:a17:902:d916:: with SMTP id c22mr6110817plz.195.1561657479365;
        Thu, 27 Jun 2019 10:44:39 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id a20sm2657092pgb.72.2019.06.27.10.44.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 10:44:38 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 61/87] scsi: lpfc: remove memset after dma_alloc_coherent
Date:   Fri, 28 Jun 2019 01:44:31 +0800
Message-Id: <20190627174431.5520-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit af7ddd8a627c
("Merge tag 'dma-mapping-4.21' of git://git.infradead.org/users/hch/dma-mapping"),
dma_alloc_coherent has already zeroed the memory.
So memset is not needed.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/scsi/lpfc/lpfc_init.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index eaaef682de25..c3cca3be87f1 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -7770,8 +7770,6 @@ lpfc_sli_pci_mem_setup(struct lpfc_hba *phba)
 	phba->hbqs[LPFC_ELS_HBQ].hbq_alloc_buffer = lpfc_els_hbq_alloc;
 	phba->hbqs[LPFC_ELS_HBQ].hbq_free_buffer = lpfc_els_hbq_free;
 
-	memset(phba->hbqslimp.virt, 0, lpfc_sli_hbq_size());
-
 	phba->MBslimaddr = phba->slim_memmap_p;
 	phba->HAregaddr = phba->ctrl_regs_memmap_p + HA_REG_OFFSET;
 	phba->CAregaddr = phba->ctrl_regs_memmap_p + CA_REG_OFFSET;
-- 
2.11.0

