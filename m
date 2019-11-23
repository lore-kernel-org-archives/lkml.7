Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B77DC432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 21:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10BF920679
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 21:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfKWVkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 16:40:43 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35830 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfKWVkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 16:40:42 -0500
Received: by mail-qk1-f193.google.com with SMTP id v23so1609416qkg.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2019 13:40:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=moLV8nIBuKPEOn4rga1JnaZprJYQ9aX5C5oLRVjtAxI=;
        b=HGVJfoRM/sVxR+FcELWom45qhJ1iobozJ7aUcghXpcn6St+pCCaIrNlSaExVW7ZlB4
         zbS9OIDA9uZWwlMgf9M+hcvtxfp/HpjOHKivGXm0TMAar0M8AQzD+52FRnDzu+ic9diM
         OdkrJhD7we2tTdNEsWs93UCuhpdXJTFskKsAfX/fTyvYsrh0oqS0cDWWT9wr0RsIWsgq
         v2S5ffZWsuPVJgi9Iy900VUcZ7Qm33SaXDA4gnVrQ4Zal/RsEx2HeCfuoEICLpScpe+l
         vyoi2mBhEMT6aFdQOMgYuW6Bym7t3BL0z2XJIXm9gG/6HOS1C/7A81h2Gq2cc5eTiXiz
         L5ZQ==
X-Gm-Message-State: APjAAAWhpf6sMNg9relkfvC3nd2q/nFH2i7dgFk6tIO3AfQXtvyiHVIP
        lsOnad2HjPrp120fZpun9QZr5SFu8Hw=
X-Google-Smtp-Source: APXvYqy5t7PAbBtc568MavJZk8zui62ZJ+IVStzDjYBl+HqTVQpEXE9lL916GG/WFgN+Ay4/dI/GPA==
X-Received: by 2002:ae9:e301:: with SMTP id v1mr9963630qkf.197.1574545241627;
        Sat, 23 Nov 2019 13:40:41 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id v189sm933208qkc.37.2019.11.23.13.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2019 13:40:40 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 1/3] init/main.c: log arguments and environment passed to init
Date:   Sat, 23 Nov 2019 16:40:37 -0500
Message-Id: <20191123214039.139275-2-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191123214039.139275-1-nivedita@alum.mit.edu>
References: <20191123210808.107904-1-nivedita@alum.mit.edu>
 <20191123214039.139275-1-nivedita@alum.mit.edu>
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

