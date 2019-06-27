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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8BDC48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAA302086D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VLc3SIuF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbfF0RqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 13:46:04 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40898 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbfF0RqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 13:46:02 -0400
Received: by mail-pf1-f196.google.com with SMTP id p184so1589109pfp.7;
        Thu, 27 Jun 2019 10:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=o+36uH8gml1ZGrQYdSI5lxoYpgHdYwkkvcnlEpAcvxc=;
        b=VLc3SIuFHR72K59KZtvjOHJR/Pb65re/R0PSiTa7GgEJCKa4LwkgAGkv6XffTvPnDf
         1yTzNqpIX8etis+JYRNEEpn0giOtH+huaUymEw8KXFLfhhLQli1fNGNIVLxNQew4NGya
         O1hpQd+hHdTsNy7wBMXxRnK+CXdZRODKyD+MP/oULWok3L2ZACH2gxxKUW4OLolSBmDj
         X7jJ4/9ZbJDbA9Kj8BVHXQdKUPHKnQs1CUITfwxEmpWeWLPTazDx+Hf9v3G2I0ZZ0M5C
         VDCtYrOmtFEn1WIKY+rtog90+Jas3FkIcB/2qNadRIW7WiD/dRYDtqpMehWVjAqDuezq
         Stxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=o+36uH8gml1ZGrQYdSI5lxoYpgHdYwkkvcnlEpAcvxc=;
        b=qcbLcdhFrpMsN/+qhYLs6k89unRZGIyAPyRt+ZINbXy4+GqUAvvJp0IeQQ9XK9Hm/j
         dm3A6UjHEEvzTUMsBDupny91k5zwL9tQiD4WqyCuv3MCEPxyOpqBIC30kIEpzw4hS/1p
         RcNC9w1Tlaidv4xtynpM5/kPQx1TW+9qevFqDP6SVOMwzZ5+zlPpmEHQi43K1n6MMcE6
         OXHO019AAyAEjcma4JkNU2x0bVcTPCkhk5RLtdkPv15IkA4KITPWBw43JPs9mK3IMcJ9
         OIMLcH8ktEvjar0dro+sUD3VPiiT6kZgMexDsygTdHpLae40xMutM2yRybAKVGjRlDcf
         tTTg==
X-Gm-Message-State: APjAAAXQ8YOSrv9Js8TjTWuSs4HhHjQjuzXknFe6wk9RoAnqSiWazS64
        YDZPKaTD+O5D3Q6HxIqDtkxUxbKTLU4mVg==
X-Google-Smtp-Source: APXvYqy92XNMInm4ZAyBxfWWY7IUZN67sKW9UCkJ/NmXuwjrYc7ozMB0cXMD2ituSSV+LXP3GbuBfQ==
X-Received: by 2002:a63:4d63:: with SMTP id n35mr4891540pgl.43.1561657561653;
        Thu, 27 Jun 2019 10:46:01 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id h1sm3452403pfo.152.2019.06.27.10.45.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 10:46:01 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Ching Huang <ching2048@areca.com.tw>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 69/87] scsi: arcmsr: remove memset after dma_coherent in arcmsr_hba.c
Date:   Fri, 28 Jun 2019 01:45:53 +0800
Message-Id: <20190627174554.6206-1-huangfq.daxian@gmail.com>
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
 drivers/scsi/arcmsr/arcmsr_hba.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/arcmsr/arcmsr_hba.c b/drivers/scsi/arcmsr/arcmsr_hba.c
index 88053b15c363..a0d0dc83184f 100644
--- a/drivers/scsi/arcmsr/arcmsr_hba.c
+++ b/drivers/scsi/arcmsr/arcmsr_hba.c
@@ -727,7 +727,6 @@ static int arcmsr_alloc_ccb_pool(struct AdapterControlBlock *acb)
 	}
 	acb->dma_coherent = dma_coherent;
 	acb->dma_coherent_handle = dma_coherent_handle;
-	memset(dma_coherent, 0, acb->uncache_size);
 	acb->ccbsize = roundup_ccbsize;
 	ccb_tmp = dma_coherent;
 	curr_phy_upper32 = upper_32_bits(dma_coherent_handle);
-- 
2.11.0

