Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BB8C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 18:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D53F5206DA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 18:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730309AbfLLSA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 13:00:27 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34906 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730023AbfLLSA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 13:00:26 -0500
Received: by mail-qk1-f195.google.com with SMTP id z76so2353099qka.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 10:00:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ge4HTdIewKvZfDm4331T+xQhrGpyDOZS/n3ZLfKIywA=;
        b=KC5P0h+2fk1/eSjWzwX7P/e2cFa7Km833c0vixzvG3VDdVCtcfkNuIBcSuFOvKCjnE
         W7Gbrj+CfIC3Iqji+1HunJJsFZ1MApfAhUqegbJUojN9H93vLo2Jrj0/7QhoezwyrY0a
         6+iNqWaOAPPaVdRrlTxSjfRR3/OVI0p0veoYszl3Wj5cR5ERV5sD6tUw93GdNf2UHKjo
         LN5B6+e5mcHzQjTkjOSFoah6XsTWFcdAzLF8ivwL66zkKdI4WqhW11T0CRpfPoDMXEOf
         OwJixdot/VGHbu+QkR5e45mN/XQS4PTwSVqswniOMoBuxU5oGL1sg/ojrbGAaN07Su4O
         gXfw==
X-Gm-Message-State: APjAAAWL3hGRVUH4fFkNw1OeXzHoOCPgRtOgNzDyxHCb7oExupQHnceA
        BVmkX7GPMxb6TSX9nMpYH/0=
X-Google-Smtp-Source: APXvYqzPgquNiWUTSa8w2qUun8q40UYQumZjmfLc645lmbSdBU0r5+O17stNE9wsVgsn/VdZlJbABA==
X-Received: by 2002:a05:620a:218a:: with SMTP id g10mr9469536qka.351.1576173625487;
        Thu, 12 Dec 2019 10:00:25 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id j7sm1946037qkd.46.2019.12.12.10.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 10:00:24 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] init/main.c: log arguments and environment passed to init
Date:   Thu, 12 Dec 2019 13:00:21 -0500
Message-Id: <20191212180023.24339-2-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191212180023.24339-1-nivedita@alum.mit.edu>
References: <20191123214039.139275-1-nivedita@alum.mit.edu>
 <20191212180023.24339-1-nivedita@alum.mit.edu>
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
index 91f6ebb30ef0..4ebf4346a44c 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1042,8 +1042,16 @@ static void __init do_pre_smp_initcalls(void)
 
 static int run_init_process(const char *init_filename)
 {
+	const char *const *p;
+
 	argv_init[0] = init_filename;
 	pr_info("Run %s as init process\n", init_filename);
+	pr_debug("  with arguments:\n");
+	for (p = argv_init; *p; p++)
+		pr_debug("    %s\n", *p);
+	pr_debug("  with environment:\n");
+	for (p = envp_init; *p; p++)
+		pr_debug("    %s\n", *p);
 	return do_execve(getname_kernel(init_filename),
 		(const char __user *const __user *)argv_init,
 		(const char __user *const __user *)envp_init);
-- 
2.23.0

