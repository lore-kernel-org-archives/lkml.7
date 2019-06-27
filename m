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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86468C48BE4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6068020644
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KY7Zmbkl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfF0Rpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 13:45:34 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44130 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbfF0Rpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 13:45:33 -0400
Received: by mail-pf1-f193.google.com with SMTP id t16so1579519pfe.11;
        Thu, 27 Jun 2019 10:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=KsHBBlQbrCLiejasWVdLGkq8oWdlc6LBhKtDSdN6QwI=;
        b=KY7Zmbkl7qw6LDvC3ZwNK5HTCeKRuj9VSWuC8yGWbfgWyys4s5tnioNfTLidt0Yw4H
         okf+F/crK+d6udKSUXt0keoA1Kh5n5zMs5hgq5sxPZAfvujOdfEqjVJzQzjP/m1tunIL
         C+14CfjUqB+HOIdCQPBwrlQ/XdUiedpd0p4gbQ6FGsLMXhOUuxDboWts0OJ8RX9RiAOe
         Q++wZSoGCR0PAmuWxm1Rc+BSqDaD3MfwO+4Ht62bxl/J/dX0A/em5dF44Mxx7b9N4Epf
         knu+dlnACDd2mTX8R5D+qGajwfX0uqZOjtBIBM4PsERdRZBGDCCZIMv3RlxiYBE6Lz+c
         aEZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KsHBBlQbrCLiejasWVdLGkq8oWdlc6LBhKtDSdN6QwI=;
        b=fq3ggpMATTlrjt6yfu2J7iYEm374CCk1Z4SzWNC4J/V+rNKqwj6KbWsoutgv8+twMC
         ScKXFt3CVd1WWeD4Xak62QgKk9MXbVQuwWTW/anv8NtHemsWq0tenM91e2+XKn3CgPam
         1ZujlD7qa1NhS5yEfDyTOh6+L0gO5XehqX3T8F/pDfanH6SPUO+jHrso4bGMhY+2uUXl
         6ANwccCTgOyFPk2EM/Hw7AGKHAnl/754XekZR4bvKkuC0pv/dPdK081kf8AA04zSyQ6g
         YfxBAjXrbH7mCeUbazGVj8uHBd2YWzeyqCxWKWCX3URE8wCmqT1rD1AjrCAYcMvXzCsh
         sctQ==
X-Gm-Message-State: APjAAAWMUhHhxFyI61KODtMQZbnlj9MNXOX0694zFsASls7fVq0lhx5E
        YSs1dUBE0gl5JX1rhP+v198=
X-Google-Smtp-Source: APXvYqyZtS7FMaw4a4j8BfcYCwdI54uw7GmeSz+cjw4tU6m37ZYKtM3INsA421+ZjDSnCsDBZrmlLQ==
X-Received: by 2002:a17:90a:30e4:: with SMTP id h91mr7166684pjb.37.1561657532831;
        Thu, 27 Jun 2019 10:45:32 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id d9sm2591082pgj.34.2019.06.27.10.45.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 10:45:32 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        QLogic-Storage-Upstream@qlogic.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 66/87] scsi: bnx2fc: remove memset after dma_alloc_coherent in bnx2fc_io.c
Date:   Fri, 28 Jun 2019 01:45:26 +0800
Message-Id: <20190627174526.5940-1-huangfq.daxian@gmail.com>
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
 drivers/scsi/bnx2fc/bnx2fc_io.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/scsi/bnx2fc/bnx2fc_io.c b/drivers/scsi/bnx2fc/bnx2fc_io.c
index 8def63c0755f..92b289466797 100644
--- a/drivers/scsi/bnx2fc/bnx2fc_io.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_io.c
@@ -614,8 +614,6 @@ int bnx2fc_init_mp_req(struct bnx2fc_cmd *io_req)
 		bnx2fc_free_mp_resc(io_req);
 		return FAILED;
 	}
-	memset(mp_req->req_buf, 0, CNIC_PAGE_SIZE);
-	memset(mp_req->resp_buf, 0, CNIC_PAGE_SIZE);
 
 	/* Allocate and map mp_req_bd and mp_resp_bd */
 	sz = sizeof(struct fcoe_bd_ctx);
-- 
2.11.0

