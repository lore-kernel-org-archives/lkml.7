Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54052C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 02:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 261AE2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 02:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/ZNi1Qa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbfF1CsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 22:48:13 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35768 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbfF1CsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 22:48:12 -0400
Received: by mail-pl1-f193.google.com with SMTP id w24so2362875plp.2;
        Thu, 27 Jun 2019 19:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=roX/EbmGLKx9MjR6cO9BgeKhdxGsFEuMu+qfbL6s0qg=;
        b=O/ZNi1QaEyNc8UUM8o0K9x4cAOo5Dtfj1bOof2p3W0aCMnHaDIqWmmlWg9Chda0xqe
         kxuKpqVHS+ID4M5UIdZuc9dBuOkLkjtutaxw6edwCPrWfWmTOO9ILe4Kd2nrdW/e6FVv
         qVzJbYpsHdnJ1+Z+7KzaAE585n0gCLaHjiV3rUBK35TX0jIU5xAOZgEFINz/OZhif/fu
         12l5PgAz86PcYMYRObhlyIqWW+9cmNoD+51OEpapeaaSw6JtMmiF83XumI0y5wApWaYV
         vqbpecXY+eYh1F1UI34fXKjn+T5oIPp949Uet7+LEAspAugJPI+x9AiEz1EtWz2C+L2u
         Hl+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=roX/EbmGLKx9MjR6cO9BgeKhdxGsFEuMu+qfbL6s0qg=;
        b=pAVOBS71rkplb+VfOYTWIdPi8HCIMHgsXI3NMWKYptw9jxavSVcR/cbwOgxfL4B2qp
         QYm1vAQYaf8wjohwYwBZhVCgcu22w7jWotXe2hUtULdA1DA+yqbALg+wzsU2h8Oz4tev
         +Egkmi8Od2T0y2+j03RECl61QkefR0K5KMssvnpAp6SOjRuGK/fFmv1jPeDC9EsLiVob
         DV0H/f+OMAAy/JBLEwRKYy5cHn0/+ZupeFuZNLu6vIccEB10QpXAGwXP53QNaDOjpfQD
         4W/bLu0prhJF/OrIC0MbvDlwImX7X3Ig7V6S4JHqW7YFnU5f1PG9o+gsnVypoceTg4aN
         wiSQ==
X-Gm-Message-State: APjAAAUJVihVl+g9E34Nna1q7N2iG+rHlvx1t+l2iv5+5ad51w2E+uH5
        8zlAlbah0TSO8Yd01pQdnU0=
X-Google-Smtp-Source: APXvYqyXS+aDq+RlvQY0FdPISOkDugkhtFYK0yyJRlWlB+3K2FxjbdlLy7WPkX36BhN9g+Z5HIH38Q==
X-Received: by 2002:a17:902:e6:: with SMTP id a93mr8546987pla.175.1561690091887;
        Thu, 27 Jun 2019 19:48:11 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id f186sm459936pfb.5.2019.06.27.19.48.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 19:48:11 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/27] message: fusion: remove memset after pci_alloc_consistent
Date:   Fri, 28 Jun 2019 10:48:03 +0800
Message-Id: <20190628024804.15475-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pci_alloc_consistent calls dma_alloc_coherent directly.
In commit af7ddd8a627c
("Merge tag 'dma-mapping-4.21' of git://git.infradead.org/users/hch/dma-mapping"),
dma_alloc_coherent has already zeroed the memory.
So memset is not needed.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/message/fusion/mptbase.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/message/fusion/mptbase.c b/drivers/message/fusion/mptbase.c
index d8882b0a1338..845d1ef8abdf 100644
--- a/drivers/message/fusion/mptbase.c
+++ b/drivers/message/fusion/mptbase.c
@@ -4507,7 +4507,6 @@ PrimeIocFifos(MPT_ADAPTER *ioc)
 		dinitprintk(ioc, printk(MYIOC_s_DEBUG_FMT "Total alloc @ %p[%p], sz=%d[%x] bytes\n",
 			 	ioc->name, mem, (void *)(ulong)alloc_dma, total_size, total_size));
 
-		memset(mem, 0, total_size);
 		ioc->alloc_total += total_size;
 		ioc->alloc = mem;
 		ioc->alloc_dma = alloc_dma;
-- 
2.11.0

