Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B9DCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 21:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E3BF2084C
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 21:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dc45mBrO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbfJYVeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 17:34:18 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42026 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfJYVeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 17:34:18 -0400
Received: by mail-pg1-f194.google.com with SMTP id f14so2360151pgi.9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 14:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m8ZYnQwGIuRWfdmXM6ZN6Y9gyuDBd4Jskp2N+oN21Cw=;
        b=Dc45mBrO85y2Lz/HWQWUuSYAOo8ouRZNscOb1k80RiCvwBgp+ZeADGwiTdszOM3Bxh
         9/ghgXR7PIe7rG7X8M9wb5vrexABpoNySXYpvulkK/gr+tdG9tProwF6Ai8T88fSou3d
         MG08uePlz52Wways9c437q7/pIZhKXZTZazHVQI2H4zjyN42IrIsB7SVFYTdnetlvHHj
         mq6/tpv4YM/nWTDpw3sb/XKyn2AzPMS3rqlME58Yq0mxQK4WNDIrGaQjJhv+3G3lcQmN
         zHWQl7atUCLYcoEk+nSpTcqp39RzaT1UpSi9qL1n6HtK/7LigtPtSsqOhK5UoGA4lCPS
         dEjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=m8ZYnQwGIuRWfdmXM6ZN6Y9gyuDBd4Jskp2N+oN21Cw=;
        b=bvaawShHbSk1H2RCqR4mpUP8uuyen2Poa5IgbhgMTb27QUGh82mmuorh+fd3y9qfJb
         lRtnLLh8RFxWz87dJy+NrKOC0IajwTSEdkqv9yZy6HxsiVnfKEwSPfbFk3qbVlCBqlTk
         21thVFvTbPiY2DYdYwivBPMqHL2jYes5ewmLxjZDK72nVrZ//koiDzCPOm6k4LS3Oh+N
         xIf9LiU1YBREJc4gBMpVCswyCSJC7LRKXH/qMHuIwylPVjVuvgtgAVAQNX/lU+N73gOL
         o7bGlLm425NQgYYlsV4Ud7uvr6Bli+VUDXpG16PO2iLWULbGNzj8CkqIqHw+6Q+7Bylh
         PQfg==
X-Gm-Message-State: APjAAAUzMsfX8Utp4zDQhP5Pxb41u5TpEns2B4Z1MwSIpgnBVK+SqsOi
        sCpcIzxJcWrcfrycpbZIYCY=
X-Google-Smtp-Source: APXvYqwyzTP23XNmsOt5kAMraC0K0a/RCiwocdnHyHSawrqDja0EV41z2JMW1PnHsfEZJB1JMjjmCw==
X-Received: by 2002:a17:90b:34a:: with SMTP id fh10mr6860797pjb.59.1572039257855;
        Fri, 25 Oct 2019 14:34:17 -0700 (PDT)
Received: from sultan-box.localdomain ([104.200.129.62])
        by smtp.gmail.com with ESMTPSA id 139sm4603958pfc.94.2019.10.25.14.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 14:34:16 -0700 (PDT)
From:   Sultan Alsawaf <sultan@kerneltoast.com>
X-Google-Original-From: Sultan Alsawaf
Cc:     Sultan Alsawaf <sultan@kerneltoast.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Ming Lei <ming.lei@redhat.com>,
        Gal Pressman <galpress@amazon.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scatterlist: Speed up for_each_sg() loop macro
Date:   Fri, 25 Oct 2019 14:33:58 -0700
Message-Id: <20191025213359.7538-1-sultan@kerneltoast.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sultan Alsawaf <sultan@kerneltoast.com>

Scatterlists are chained in predictable arrays of up to
SG_MAX_SINGLE_ALLOC sg structs in length. Using this knowledge, speed up
for_each_sg() by using constant operations to determine when to simply
increment the sg pointer by one or get the next sg array in the chain.

Rudimentary measurements with a trivial loop body show that this yields
roughly a 2x performance gain.

The following simple test module proves the correctness of the new loop
definition by testing all the different edge cases of sg chains:
#include <linux/module.h>
#include <linux/scatterlist.h>
#include <linux/slab.h>

static int __init test_for_each_sg(void)
{
	static const gfp_t gfp_flags = GFP_KERNEL | __GFP_NOFAIL;
        struct scatterlist *sg;
        struct sg_table *table;
        long old = 0, new = 0;
        unsigned int i, nents;

        table = kmalloc(sizeof(*table), gfp_flags);
        for (nents = 1; nents <= 3 * SG_MAX_SINGLE_ALLOC; nents++) {
                BUG_ON(sg_alloc_table(table, nents, gfp_flags));
                for (sg = table->sgl; sg; sg = sg_next(sg))
                        old ^= (long)sg;
                for_each_sg(table->sgl, sg, nents, i)
                        new ^= (long)sg;
                sg_free_table(table);
        }

        BUG_ON(old != new);
        kfree(table);
        return 0;
}
module_init(test_for_each_sg);

Signed-off-by: Sultan Alsawaf <sultan@kerneltoast.com>
---
 include/linux/scatterlist.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
index 556ec1ea2574..73f7fd6702d7 100644
--- a/include/linux/scatterlist.h
+++ b/include/linux/scatterlist.h
@@ -146,7 +146,10 @@ static inline void sg_set_buf(struct scatterlist *sg, const void *buf,
  * Loop over each sg element, following the pointer to a new list if necessary
  */
 #define for_each_sg(sglist, sg, nr, __i)	\
-	for (__i = 0, sg = (sglist); __i < (nr); __i++, sg = sg_next(sg))
+	for (__i = 0, sg = (sglist); __i < (nr);		\
+	     likely(++__i % (SG_MAX_SINGLE_ALLOC - 1) ||	\
+		    (__i + 1) >= (nr)) ? sg++ :			\
+		    (sg = sg_chain_ptr(sg + 1)))
 
 /**
  * sg_chain - Chain two sglists together
-- 
2.23.0

