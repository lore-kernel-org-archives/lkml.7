Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 789A3C004C9
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 01:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E23120675
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 01:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pPpZrOV0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbfEFBjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 21:39:20 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43927 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbfEFBjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 21:39:20 -0400
Received: by mail-pf1-f193.google.com with SMTP id c6so664799pfa.10
        for <linux-kernel@vger.kernel.org>; Sun, 05 May 2019 18:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=JnMFVu4wG6faIR55N/V0ef2Ggzg3pOTpOa+bU+giIdA=;
        b=pPpZrOV0xJUaK06EYeWzHDY4I+FJnsONT6Vr481I6lJmgGyIib41MYNuzddSKkCYKI
         vD7bBYHTPYeWV8T4+Kc0E24eGwmvDWTJCqCUQytv7T4PnKhxshXCvG3W5SwTHyREg59Z
         g4kbCfw/reTNNTcmFwkbqFCktToibvqKr1n17maBDp6Kmck0fP3/Il0/LDMe+AN+9pNj
         136VPkg5ZZ4TYPc+XX7Lmw2FDiPsy5n6KAJSaWI+ZeoqAcF79B2LkykrZ9RJO3rSPpUs
         HqojSdxKADSR+9CbGMXCAGnFH4nQi4YLCatANEhvzqD69YvKdQYtQaflj6f+2ydf2HFq
         xipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JnMFVu4wG6faIR55N/V0ef2Ggzg3pOTpOa+bU+giIdA=;
        b=iG8RDX7xkAAOIs+OykpmMvpMzxfuTDLXJOkDI4EYrwgLRvC6KO12kUq5N486cfwKE5
         lx+rQtOv9UaLX/taT+CAVcJbmlDjmTRXxdtCm/0q/Xp2R81IcZKrZ6ho2WzqmOciuawa
         QWFm8yjvKtWIyIUtDnmjL6tIbz9EatptZcuQJIjoNZTUHGNRqYMLUwys1QM+13v6MxpJ
         Ia9RfnCsaK3c/xcHPJJLLUmlBCBpmj9fF5AChLEdwjIEKc0VFUjztqskFmMa06fYr1N6
         7EZfgV4MbsI+H5iSSdMTqPKIIam0jjr5K8s4Uih4bftsGSw9nQDomM/IrYgj6J7cETyp
         6AGg==
X-Gm-Message-State: APjAAAXVBAIisj0aQX82L4KOLZrNiNt576OxGemlZTHrlIU9g30BuA9y
        qgTwEX90sHpdtRypMJMe91hwtFn8
X-Google-Smtp-Source: APXvYqwDMcOIvu3Z5kYmWHSV3z5T0e1BlDS77cuyy76sEadvykgpuEg439vnpFC4ugkMn3qHjFM4iA==
X-Received: by 2002:a62:27c2:: with SMTP id n185mr28919046pfn.51.1557106759484;
        Sun, 05 May 2019 18:39:19 -0700 (PDT)
Received: from izt4n3nohp3b5a1z8j8uuaz.localdomain ([149.129.49.136])
        by smtp.gmail.com with ESMTPSA id b18sm547418pfp.32.2019.05.05.18.39.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 May 2019 18:39:18 -0700 (PDT)
From:   Chengguang Xu <cgxu519@gmail.com>
To:     jack@suse.com
Cc:     linux-kernel@vger.kernel.org, Chengguang Xu <cgxu519@gmail.com>
Subject: [PATCH] quota: add dqi_dirty_list description to comment of Dquot List Management
Date:   Mon,  6 May 2019 09:39:03 +0800
Message-Id: <1557106743-19157-1-git-send-email-cgxu519@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Actually there are four lists for dquot management, so add
the description of dqui_dirty_list to comment.

Signed-off-by: Chengguang Xu <cgxu519@gmail.com>
---
 fs/quota/dquot.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index fc20e06c56ba..6a236bdaef89 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -223,9 +223,9 @@ static void put_quota_format(struct quota_format_type *fmt)
 
 /*
  * Dquot List Management:
- * The quota code uses three lists for dquot management: the inuse_list,
- * free_dquots, and dquot_hash[] array. A single dquot structure may be
- * on all three lists, depending on its current state.
+ * The quota code uses four lists for dquot management: the inuse_list,
+ * free_dquots, dqi_dirty_list, and dquot_hash[] array. A single dquot
+ * structure may be on some of those lists, depending on its current state.
  *
  * All dquots are placed to the end of inuse_list when first created, and this
  * list is used for invalidate operation, which must look at every dquot.
@@ -236,6 +236,10 @@ static void put_quota_format(struct quota_format_type *fmt)
  * dqstats.free_dquots gives the number of dquots on the list. When
  * dquot is invalidated it's completely released from memory.
  *
+ * Dirty dquots are added to the dqi_dirty_list of quota_info when mark
+ * dirtied, and this list is searched when writeback diry dquots to
+ * quota file.
+ *
  * Dquots with a specific identity (device, type and id) are placed on
  * one of the dquot_hash[] hash chains. The provides an efficient search
  * mechanism to locate a specific dquot.
-- 
2.17.2

