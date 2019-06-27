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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7FCBC48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB2A52086D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNBX7HN0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbfF0Rpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 13:45:43 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40862 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbfF0Rpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 13:45:42 -0400
Received: by mail-pf1-f195.google.com with SMTP id p184so1588643pfp.7;
        Thu, 27 Jun 2019 10:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=to+YLLcx4mRm6uwEhLu6r0Vfyic5/ofLdSpuyp1FJnI=;
        b=cNBX7HN05gnqavPhgH/nQb9BTWUfUbvZrDv9s7UznkMNx869UM8UNVDequVAvHM9xe
         PwtXHgxC0CRIuRrqpC0ozPFpgs38dejeZvfRVv2bdRu7NW86sD7LOcp62cfCdnDwFrjd
         GPsd3wwa9AHS8zms0+MKxYNnEQeMYJ+DD+SpBFpUkrC3UJbAuiAmNH5z4G1EO4sZh5Gf
         MyDvVix6v386omcOlmxfHwSHS/cvNOEXLrsNbe68Zc9juZRrNK07bzf2GFTYOG4UZs6s
         PQ1kfv1LvXkLPqZgdeyJDrdsiDcXNPcHuFP/mAuwkhhuSQMjWgfRxBd2WseFFZS8h6Nv
         FoTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=to+YLLcx4mRm6uwEhLu6r0Vfyic5/ofLdSpuyp1FJnI=;
        b=LGfVCDc8QAvWj9/ml5XAfZlPNj3m8lH6UCKSI0fJcN7p9V79Gq7cwXKJrvVZnXCwh1
         z8d0CqX5FaY5/mytKK3j1Y9wdjJfW3qBg1aMcl50W06YviRA8MTJC4fhKO9Otlih8v24
         F1JbSuB8VstUtPZmdG/R9EYXLjOJ9tqi/S8RmMwt8SZeIPTlReMpzJkOgh5mRDgIUuXY
         p3qBM70U/9MR3HR4EgS3ReyH/gUPoXpmQGGtC8itK7/Nx+9TN/g6mYjm5tfO78mKFDlT
         QP4I7pALlHIqo75+Y76PAgdljT2DTi9RhqGWNodJrlg1DORt75Rn/NKMSQ95omyDmaZf
         cBDA==
X-Gm-Message-State: APjAAAV+IWW7y17BXXNSH6KljevjwGp/N2++AbuXPsAbEqrfKzTNWNJk
        nxi37IqYOVu6f+a4CWpY3RuXTEZUobv77w==
X-Google-Smtp-Source: APXvYqyyOYVCgav2HAI39gcd/3DCfCItKxManmXr01iOJGAwkrWnmAODqZqwsrdQOIVq1ZpgXUeFjw==
X-Received: by 2002:a17:90a:26a1:: with SMTP id m30mr7583928pje.59.1561657541911;
        Thu, 27 Jun 2019 10:45:41 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id g9sm2394525pgs.78.2019.06.27.10.45.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 10:45:41 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
        Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 67/87] scsi: bfa: remove memset after dma_alloc_coherent in bfad.c
Date:   Fri, 28 Jun 2019 01:45:34 +0800
Message-Id: <20190627174534.6045-1-huangfq.daxian@gmail.com>
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
 drivers/scsi/bfa/bfad.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/bfa/bfad.c b/drivers/scsi/bfa/bfad.c
index 2f9213b257a4..39ac58337290 100644
--- a/drivers/scsi/bfa/bfad.c
+++ b/drivers/scsi/bfa/bfad.c
@@ -622,7 +622,6 @@ bfad_hal_mem_alloc(struct bfad_s *bfad)
 			goto ext;
 		}
 		dma_elem->dma = phys_addr;
-		memset(dma_elem->kva, 0, dma_elem->mem_len);
 	}
 ext:
 	return rc;
-- 
2.11.0

