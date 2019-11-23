Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F4CC432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 21:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A81E22068F
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 21:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfKWVIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 16:08:20 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38236 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbfKWVIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 16:08:19 -0500
Received: by mail-qk1-f193.google.com with SMTP id e2so9428900qkn.5
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2019 13:08:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=moLV8nIBuKPEOn4rga1JnaZprJYQ9aX5C5oLRVjtAxI=;
        b=jiwtll2qYN29U1ADI2nzYRmeKbkre3GzvhzigqPAajeNZEr+CGpsXEpkW7/sUslR4H
         CYtBbXS8DvNZSI8LiD5ABzTVsGiT5GC35HJx25yNte57y0+TYrQSmIBkp3IIAQkierU0
         RVdLRghgbhZYriOyHs4fUpQ4Mu72LeahdY7A6QnTNVNkEqQfi3LxLevKsL23R7iEPpXm
         VYg+3q15rtyRs/GXTQl76PTLOw2KMJ/O2ktzXvsVMnuuyW40e/P0psTlxLdMaAflEuo3
         lzWXrHLr+oTeuyhEGWwW3OXkR5qPjAKgiaA7FDtEJqpXTaAHd10Pt2zoSQY7kDUDyT2y
         clZA==
X-Gm-Message-State: APjAAAXZMluf7XbeVmDcHxH1ye8FVv+gsF0PtLXO5I0Sv4YUf/JGcrZ0
        U1oZQqCQHBpW1te7wDmo6F/U/mPZxxM=
X-Google-Smtp-Source: APXvYqwFkXPtecLSi5tL6mT8CpVMRtplNTEqRvogrXeUkS4g4paOUKRtQ4dZq9w3y8iD0bWYXphyHg==
X-Received: by 2002:a37:847:: with SMTP id 68mr8469125qki.366.1574543298884;
        Sat, 23 Nov 2019 13:08:18 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id c37sm1164978qta.56.2019.11.23.13.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2019 13:08:18 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     linux-kernel@vger.kernel.org, nivedita@alum.mit.edu
Subject: [PATCH 1/3] init/main.c: log arguments and environment passed to init
Date:   Sat, 23 Nov 2019 16:08:06 -0500
Message-Id: <20191123210808.107904-2-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191123210808.107904-1-nivedita@alum.mit.edu>
References: <20191123210808.107904-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend logging in `run_init_process` to also show the arguments and
environment that we are passing to init.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 init/main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/init/main.c b/init/main.c
index 91f6ebb30ef0..c92f0376b1bc 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1042,8 +1042,16 @@ static void __init do_pre_smp_initcalls(void)
 
 static int run_init_process(const char *init_filename)
 {
+	const char *const *p;
+
 	argv_init[0] = init_filename;
 	pr_info("Run %s as init process\n", init_filename);
+	pr_info("  with arguments:\n");
+	for (p = argv_init; *p; p++)
+		pr_info("    %s\n", *p);
+	pr_info("  with environment:\n");
+	for (p = envp_init; *p; p++)
+		pr_info("    %s\n", *p);
 	return do_execve(getname_kernel(init_filename),
 		(const char __user *const __user *)argv_init,
 		(const char __user *const __user *)envp_init);
-- 
2.23.0

