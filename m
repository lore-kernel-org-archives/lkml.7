Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B0AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 026F82171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqvSL9j0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732013AbfB1Iqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 03:46:55 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36145 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731931AbfB1Iqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 03:46:49 -0500
Received: by mail-wm1-f68.google.com with SMTP id j125so8058790wmj.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 00:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M1XdwZtwAosdJP136ZFqHjIOI3upm3EbRWSk+eiYROQ=;
        b=ZqvSL9j0ENlVQJvCTCNzbWCKioAzTDzS3QEx2absrhSMvJfiwMDMx2Db6fULI4s7Ww
         QnS/6HStHShNXufAfa8dQ3FHRi7V6WADwixlFFiOWl20VlvcwEFHhNNg7J8Wo7CiwMkb
         uxZ6MkDRMy306QZ9J3pJdsSQ2GA9TMfuKweRNfj2KrhWLbw6EL17jm4BC9DzMAT0m+LW
         Egjn6w/jJt98/YMNmMmB8uZuzmfmcqWGtFGc5/BgmaIMBqAWlf4IT947lZvQouvJZ/Wc
         Ma9sx/XjpCnw3wTN/HuUzwLP5fpSb4/KKTwYxR05L7ZVwsyMlbZOncuUmtsc94IYbtPI
         3k9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=M1XdwZtwAosdJP136ZFqHjIOI3upm3EbRWSk+eiYROQ=;
        b=s4mOrQffiwIXE5Xe+lbTatU+hiflzri28WvYnknB4Zauki9DRPaal1BRUg0TzsLNUC
         pgwShcarFo0j+wDobH3qH1wRo+kZXc//SS64BBIj9GuJmvm76wjueZr3+teQI+EKmwmR
         Kk14ojGjrBWzXVxdKbMjNjy7ZXGwR9tsLDbHVBFXpUgXCqqTNEshKJsxesp+X/2wQbQm
         WRnUcj7gmP8BNwgUt492uM0sgH2zwKdBVKewPgS9srecK+vRvPb6OHzvuLmdtwH7upvg
         Vyv14wEHPuSpVyw+fZJRQ4XwgtRnpw5x+c34wBB78oaUUeUg8cJVIBLZT0f1kEPETV7m
         63wg==
X-Gm-Message-State: AHQUAubKQGqVXbkqtRSwuAwu4+d+kM0S11LPwHAsqwUlXOgvh5mVQFCa
        sp8uU5RYPQ/7bVE0mRutXgQ=
X-Google-Smtp-Source: APXvYqyr7ZM21bofUEj/iPXG63SYOQ7ilmkhLeW6ExqTOzvn/rnToGg1bwcwfFrtune9O4F2cvAJuQ==
X-Received: by 2002:a1c:80d6:: with SMTP id b205mr2167460wmd.109.1551343607282;
        Thu, 28 Feb 2019 00:46:47 -0800 (PST)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id h126sm4409305wmf.2.2019.02.28.00.46.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 00:46:46 -0800 (PST)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     Omer Shpigelman <oshpigelman@habana.ai>
Subject: [PATCH 09/15] habanalabs: return correct error code on MMU mapping failure
Date:   Thu, 28 Feb 2019 10:46:18 +0200
Message-Id: <20190228084624.25288-10-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190228084624.25288-1-oded.gabbay@gmail.com>
References: <20190228084624.25288-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Omer Shpigelman <oshpigelman@habana.ai>

This patch fix a bug where EINVAL was returned instead of -EINVAL.

Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/mmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/mmu.c b/drivers/misc/habanalabs/mmu.c
index a7187f9a5948..ce404e6cc9a9 100644
--- a/drivers/misc/habanalabs/mmu.c
+++ b/drivers/misc/habanalabs/mmu.c
@@ -710,7 +710,7 @@ static int _hl_mmu_map(struct hl_ctx *ctx, u64 virt_addr, u64 phys_addr,
 			dev_err(hdev->dev,
 				"DRAM: mapping already exists for virt_addr 0x%llx\n",
 					virt_addr);
-			rc = EINVAL;
+			rc = -EINVAL;
 			goto err;
 		}
 
@@ -744,7 +744,7 @@ static int _hl_mmu_map(struct hl_ctx *ctx, u64 virt_addr, u64 phys_addr,
 							hop4_pte_addr),
 							hop4_pte_addr);
 
-		rc = EINVAL;
+		rc = -EINVAL;
 		goto err;
 	}
 
-- 
2.17.1

