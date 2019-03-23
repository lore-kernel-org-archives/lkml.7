Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC40C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 18:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D0192175B
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 18:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eXRVeuu1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbfCWSf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 14:35:29 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46370 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727504AbfCWSf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 14:35:28 -0400
Received: by mail-pg1-f194.google.com with SMTP id a22so3648900pgg.13
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 11:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=HeVkiruF5QSnxERosUYXl9T9apvWKu/EfWrlZJcpFeM=;
        b=eXRVeuu1ChFKOH8/ZvhOxx0IFmmqDwai7mK7UoO38kmgda6wf7KdWxhhr+jZNwwMQP
         kvV7quiuYQ7Lm578bekEXbbm8dzfMM64+jEYike/QN7MyFGTFPU26FO518/N4e5Nf5qf
         v5KMTDo89e89n9DuFinf3usidI1QgpFQZPAqHl6+KkgJ5iEjwq5SZ2GXKZImxUahwmuT
         1K85BG0yyD+Qst3Fi6LM8evV7yF24DK5zzFVN7vkYa2IRDPnQazxzNK3d7pi1Tk7lwxn
         cVhV4p9Pn71EGU3nU7vlPHUMxwMB2u0nufdUiJZzYTMnOil0ZD6yLHZYv6zGm5AZZ8Bp
         HUyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=HeVkiruF5QSnxERosUYXl9T9apvWKu/EfWrlZJcpFeM=;
        b=XtId/yBgw22r74GUfKh93Zl5+1uFN50B30ZW87dP0ufZ5tpjP7e3g+Fr2wCqz+O/KH
         WqNzC/emcESs3lLNljCeDgvTONBOTBQ8vBJmXUW0mzB/CDow8o8h99ov93fDxJ9kx413
         /2vPcIJbgPts0srTHMjxB5NNEAMYIqU1wZn9exYSGImKemlYu3MCMBdWkfPkVL1OqvWf
         7BkkaqXStkLPF0oiz5CD1n/kgE+tyBJg6qeUemdW/viTomSMWgHke1mu5WpS1hmh12iD
         0aZGZDubZQYXIdCA6A/5IIrXi3sY4rT4JrpRQU9KESiqn/eTn6v6RStOcuAaSTCtXjVZ
         tJIQ==
X-Gm-Message-State: APjAAAXl4CFxNybpqotDgrHDeasYICCOXGxypPuFepuyBewxXXVatoOR
        ltS2/iFotJci80peZviUzCA=
X-Google-Smtp-Source: APXvYqwlx8Aqie1YojmV4qQ6yVW2Tqm4xL9qryes5W83Cw45/FPPvCKkx0bs8oOqdqMW1NapQ4FSYA==
X-Received: by 2002:a63:f707:: with SMTP id x7mr7337205pgh.343.1553366127702;
        Sat, 23 Mar 2019 11:35:27 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.91.90])
        by smtp.gmail.com with ESMTPSA id k3sm26126353pfc.59.2019.03.23.11.35.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Mar 2019 11:35:27 -0700 (PDT)
Date:   Sun, 24 Mar 2019 00:05:23 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] ftrace: fix warning using plain integer as NULL & spelling
 corrections
Message-ID: <20190323183523.GA2244@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changed  0 --> NULL to avoid sparse warning
Corrected spelling mistakes reported by checkpatch.pl
Sparse warning below:

sudo make C=2 CF=-D__CHECK_ENDIAN__ M=kernel/trace

CHECK   kernel/trace/ftrace.c
kernel/trace/ftrace.c:3007:24: warning: Using plain integer as NULL
pointer
kernel/trace/ftrace.c:4758:37: warning: Using plain integer as NULL
pointer

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 kernel/trace/ftrace.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index fa79323..26c8ca9 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1992,7 +1992,7 @@ static void print_bug_type(void)
  * modifying the code. @failed should be one of either:
  * EFAULT - if the problem happens on reading the @ip address
  * EINVAL - if what is read at @ip is not what was expected
- * EPERM - if the problem happens on writting to the @ip address
+ * EPERM - if the problem happens on writing to the @ip address
  */
 void ftrace_bug(int failed, struct dyn_ftrace *rec)
 {
@@ -2391,7 +2391,7 @@ __ftrace_replace_code(struct dyn_ftrace *rec, int enable)
 		return ftrace_modify_call(rec, ftrace_old_addr, ftrace_addr);
 	}
 
-	return -1; /* unknow ftrace bug */
+	return -1; /* unknown ftrace bug */
 }
 
 void __weak ftrace_replace_code(int mod_flags)
@@ -3004,7 +3004,7 @@ ftrace_allocate_pages(unsigned long num_to_init)
 	int cnt;
 
 	if (!num_to_init)
-		return 0;
+		return NULL;
 
 	start_pg = pg = kzalloc(sizeof(*pg), GFP_KERNEL);
 	if (!pg)
@@ -4755,7 +4755,7 @@ static int
 ftrace_set_addr(struct ftrace_ops *ops, unsigned long ip, int remove,
 		int reset, int enable)
 {
-	return ftrace_set_hash(ops, 0, 0, ip, remove, reset, enable);
+	return ftrace_set_hash(ops, NULL, 0, ip, remove, reset, enable);
 }
 
 /**
@@ -5463,7 +5463,7 @@ void ftrace_create_filter_files(struct ftrace_ops *ops,
 
 /*
  * The name "destroy_filter_files" is really a misnomer. Although
- * in the future, it may actualy delete the files, but this is
+ * in the future, it may actually delete the files, but this is
  * really intended to make sure the ops passed in are disabled
  * and that when this function returns, the caller is free to
  * free the ops.
@@ -5786,7 +5786,7 @@ void ftrace_module_enable(struct module *mod)
 	/*
 	 * If the tracing is enabled, go ahead and enable the record.
 	 *
-	 * The reason not to enable the record immediatelly is the
+	 * The reason not to enable the record immediately is the
 	 * inherent check of ftrace_make_nop/ftrace_make_call for
 	 * correct previous instructions.  Making first the NOP
 	 * conversion puts the module to the correct state, thus
-- 
2.7.4

