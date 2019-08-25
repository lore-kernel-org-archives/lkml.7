Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542B4C3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 13:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C0C520850
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 13:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BBTUSTiF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbfHYNY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 09:24:29 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35128 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbfHYNY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 09:24:27 -0400
Received: by mail-pf1-f195.google.com with SMTP id d85so9850551pfd.2;
        Sun, 25 Aug 2019 06:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AnjEbtcd5cNHwbypnsrs4cfSdZGE8Y8KXODnC5r+/Sw=;
        b=BBTUSTiFPulSXGVxfV98A1F0dTvb1nWs3kkM5cP9rBvuoglTt4LTj8MiMfMFJBcrsS
         MTkeTo7kfOO+E0w+tKCTnNl3c/QHQ2SSNUY9y0LVFtXPL9z4rM2CVMgGoJ5gO8pDVZ3K
         vpOFcvPN2hFCmHJbZGQeZy5BK6pHjBE8Plt63H0GmNLx4Vm2E5hg9Nh/n+QOK3km2hVD
         H13h6219G0X/DDyWj/h1KQ89LK+SNeEolCXmqpXmn50tXDlsOST1VLkuz+6fbZZ/VRDy
         KA2SYRSEYEHy+/fzoZr+9A/pwqozm+eDevLCy6f29pL0zilHLKXlEXyE9eRy40DxvdGs
         yOaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AnjEbtcd5cNHwbypnsrs4cfSdZGE8Y8KXODnC5r+/Sw=;
        b=FuhL39z/S7UFeuPvYylvfv7RJ1Wi/iz1gAVDwOTSt2KTmzKIsCXO8goPwJflNieCiR
         WHILIMafHNHBZ+M1pKrBjkCoO9kPLPKDBCkzHcDQcyBMlCNOEKZMoGcr9Lu+Cia+EBnv
         6/FoLUcrK0fmCXZbI1SnfI6Kyj1373QjzhdwoLc+oo+29+6zbDhjbRQtWQVRbte+w6xz
         P8QBo7nlkwkI96gcUtihPzVmdFx0acbBsq+/IJLsTElAvKWtbeKXCidYvFUFCuAUff4F
         5h3mmfekr735QzXqec+v52ftGsaVYi5PAqwEog0SXj+5ua03P0uYDBYZn0OKNVsqZZgU
         Z/OA==
X-Gm-Message-State: APjAAAXI+CoFKPcQLdHxzOw7CnfeZwcXGJl+PRJ4PAU3z/rIgwJyCaNU
        Igth+61uobE4Mz9/zeeBjao=
X-Google-Smtp-Source: APXvYqw6YJNQG1mv4TcaAIQFGH9uTD6ol5DJ8JkmCimZzRNBFxq3HdokK6aYuJxRfnvwrECLT3Lxsw==
X-Received: by 2002:a63:5b52:: with SMTP id l18mr12098178pgm.21.1566739466886;
        Sun, 25 Aug 2019 06:24:26 -0700 (PDT)
Received: from localhost.localdomain ([149.28.153.17])
        by smtp.gmail.com with ESMTPSA id y23sm11076562pfr.86.2019.08.25.06.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2019 06:24:26 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, Jessica Yu <jeyu@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 05/11] ftrace: create memcache for hash entries
Date:   Sun, 25 Aug 2019 21:23:24 +0800
Message-Id: <20190825132330.5015-6-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190825132330.5015-1-changbin.du@gmail.com>
References: <20190825132330.5015-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_FTRACE_FUNC_PROTOTYPE is enabled, thousands of
ftrace_func_entry instances are created. So create a dedicated
memcache to enhance performance.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 kernel/trace/ftrace.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index a314f0768b2c..cfcb8dad93ea 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -94,6 +94,8 @@ struct ftrace_ops *function_trace_op __read_mostly = &ftrace_list_end;
 /* What to set function_trace_op to */
 static struct ftrace_ops *set_function_trace_op;
 
+struct kmem_cache *hash_entry_cache;
+
 static bool ftrace_pids_enabled(struct ftrace_ops *ops)
 {
 	struct trace_array *tr;
@@ -1169,7 +1171,7 @@ static int add_hash_entry(struct ftrace_hash *hash, unsigned long ip,
 {
 	struct ftrace_func_entry *entry;
 
-	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
+	entry = kmem_cache_alloc(hash_entry_cache, GFP_KERNEL);
 	if (!entry)
 		return -ENOMEM;
 
@@ -6153,6 +6155,15 @@ void __init ftrace_init(void)
 	if (ret)
 		goto failed;
 
+	hash_entry_cache = kmem_cache_create("ftrace-hash",
+					     sizeof(struct ftrace_func_entry),
+					     sizeof(struct ftrace_func_entry),
+					     0, NULL);
+	if (!hash_entry_cache) {
+		pr_err("failed to create ftrace hash entry cache\n");
+		goto failed;
+	}
+
 	count = __stop_mcount_loc - __start_mcount_loc;
 	if (!count) {
 		pr_info("ftrace: No functions to be traced?\n");
@@ -6172,6 +6183,10 @@ void __init ftrace_init(void)
 
 	return;
  failed:
+	if (hash_entry_cache) {
+		kmem_cache_destroy(hash_entry_cache);
+		hash_entry_cache = NULL;
+	}
 	ftrace_disabled = 1;
 }
 
-- 
2.20.1

