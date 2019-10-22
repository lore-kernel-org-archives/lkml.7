Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 423CDCA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 19:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E06321872
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 19:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tRogLjAw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732962AbfJVTVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 15:21:20 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40261 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732911AbfJVTVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 15:21:20 -0400
Received: by mail-ot1-f65.google.com with SMTP id d8so4020676otc.7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 12:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0f04Kxscv5o4C1QvArEzBOxFfUoH9rZElTm3k0F24Mw=;
        b=tRogLjAw/ciCcW5JcJz3Bq4lVLaOvR0pvgH+v0xoI6bI4zYGi4vqEy+ZAeHAGL0yeH
         DM8wyA+aEC83ZyW7ho+WYaPuvYyXY6gIJEdu9NcKN9Wfz/8wSS5qfKcoxNr6zSl79lcH
         AzKFfJs1YaER6ZfRxqyLSUzRel+t4b9ZHeVK4sG6ywt2B7U5Z6xeytBAip40R/Rg5qYv
         MffPOPs0GVyqP78eTphaUA7KGPLkOiK1bUi5nnNY8Aa6T4P+J3Sph0sZjWAaFd2i0yQ9
         z6DmJ7U1sH3FimBBbEUfV5Alalk3uIv92czK6JGzmRQsxIjvMq7xQ8ebwxyZ93TbzMas
         tl0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0f04Kxscv5o4C1QvArEzBOxFfUoH9rZElTm3k0F24Mw=;
        b=UGUD8VwggQda9tlhsjWX3PLT+3zQUtKo7Iup2m7+uYPssXhJotDPaKNy+RN979kz5k
         X0s2sHbVR3jN5IGPPRu4UDJaTd/0vCRaIxR34S5Y9Jhn0USVtA8WA2spw06WvODo/M7j
         J8OGW7pzSz2gVWBDBROrhYuQQHqGuV0dr61i8tOll8cQViez4JdhLbQfFarcNwucSE43
         YiixHgcJDu4bgOg7nGMW9vKz/IH4139512SJ8HpJCK4V3WWb3BAPoYHtPSrHREo/yUCU
         afGK3Z3WE8msMH2DZPxJchK4Uq0NpJ1q8vZhiAtG2zv9oYNGf/XfntNFzSjAS8tpU6o0
         Uq7g==
X-Gm-Message-State: APjAAAUzJlODEdkriCt8YqOsnQzNqJpHr5gw/6sh5IIYilVxiHwZou6V
        z4rddXV5cJqNirkxcLKV5Hc=
X-Google-Smtp-Source: APXvYqxvaPm8vl0CL/uzf5Cbb/dacb981yhfzzcEkWtXCBTVfTaC/2T42tX/0ypHd2+TiQA28PwkEQ==
X-Received: by 2002:a05:6830:4c7:: with SMTP id s7mr4096882otd.3.1571772079567;
        Tue, 22 Oct 2019 12:21:19 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id g8sm5372074otp.42.2019.10.22.12.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 12:21:18 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] kernel/profile: Use cpumask_available to check for NULL cpumask
Date:   Tue, 22 Oct 2019 12:19:57 -0700
Message-Id: <20191022191957.9554-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with clang + -Wtautological-pointer-compare, these
instances pop up:

kernel/profile.c:339:6: warning: comparison of array 'prof_cpu_mask' not
equal to a null pointer is always true [-Wtautological-pointer-compare]
        if (prof_cpu_mask != NULL)
            ^~~~~~~~~~~~~    ~~~~
kernel/profile.c:376:6: warning: comparison of array 'prof_cpu_mask' not
equal to a null pointer is always true [-Wtautological-pointer-compare]
        if (prof_cpu_mask != NULL)
            ^~~~~~~~~~~~~    ~~~~
kernel/profile.c:406:26: warning: comparison of array 'prof_cpu_mask'
not equal to a null pointer is always true
[-Wtautological-pointer-compare]
        if (!user_mode(regs) && prof_cpu_mask != NULL &&
                                ^~~~~~~~~~~~~    ~~~~
3 warnings generated.

This can be addressed with the cpumask_available helper, introduced in
commit f7e30f01a9e2 ("cpumask: Add helper cpumask_available()") to fix
warnings like this while keeping the code the same.

Link: https://github.com/ClangBuiltLinux/linux/issues/747
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 kernel/profile.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/profile.c b/kernel/profile.c
index af7c94bf5fa1..4b144b02ca5d 100644
--- a/kernel/profile.c
+++ b/kernel/profile.c
@@ -336,7 +336,7 @@ static int profile_dead_cpu(unsigned int cpu)
 	struct page *page;
 	int i;
 
-	if (prof_cpu_mask != NULL)
+	if (cpumask_available(prof_cpu_mask))
 		cpumask_clear_cpu(cpu, prof_cpu_mask);
 
 	for (i = 0; i < 2; i++) {
@@ -373,7 +373,7 @@ static int profile_prepare_cpu(unsigned int cpu)
 
 static int profile_online_cpu(unsigned int cpu)
 {
-	if (prof_cpu_mask != NULL)
+	if (cpumask_available(prof_cpu_mask))
 		cpumask_set_cpu(cpu, prof_cpu_mask);
 
 	return 0;
@@ -403,7 +403,7 @@ void profile_tick(int type)
 {
 	struct pt_regs *regs = get_irq_regs();
 
-	if (!user_mode(regs) && prof_cpu_mask != NULL &&
+	if (!user_mode(regs) && cpumask_available(prof_cpu_mask) &&
 	    cpumask_test_cpu(smp_processor_id(), prof_cpu_mask))
 		profile_hit(type, (void *)profile_pc(regs));
 }
-- 
2.23.0

