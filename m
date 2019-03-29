Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FDFC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 18:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B141E218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 18:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aCWK7gJz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730008AbfC2SSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 14:18:46 -0400
Received: from mail-oi1-f202.google.com ([209.85.167.202]:46424 "EHLO
        mail-oi1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729932AbfC2SSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 14:18:45 -0400
Received: by mail-oi1-f202.google.com with SMTP id r190so1202048oie.13
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 11:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=TseWlpWgDOC1dH/DYUii6Dj7Adu2b04wsLgsksnWzVs=;
        b=aCWK7gJzF3d75NDpKwWtvmS/qE84L+JURj00H6Rnfrs9q+nLcB7Iar9x4ITUCEC0Nb
         3lumsJUWh9/3schkD1WrA+EGu2Vu6ZLjfVb6lYn94aGhq8iMp69ap/CFBL1esizbgHGT
         zuRylkxVZv3nLdX/jczIvsCBbtQkWaKggyYZ2Fo3Tedv2UuFmPW5INX+fQNmYKnrmwCA
         2cb9kFZDTglPbLG6521pJ03Rx2hZfprggupI01xKA2z7uvIgASCVvL13RwWwi7kGKJ4q
         zj0Urly5rpwdSrRefTuReJ4cPhu5Bc6ksomuE39b6dp1n3b0lMTAt5Fbp92I3eBS84u8
         6VUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TseWlpWgDOC1dH/DYUii6Dj7Adu2b04wsLgsksnWzVs=;
        b=bn6/Gk+lu8Zp3kG+YcKkf48P4EuymfZZYvX8rZk+5s3+itrV80y7D8D78l5iMoYgAF
         k3AuLC/uXiGhN3MTCwlqZH/oLF/o/OITpAKLHgTPwKP89SUrBUt+a6EaPj5pKG7oxutJ
         ckoly+d2qvwaIQVxUFHf/07Auwn7NN4FzTd1Y+7qzKrim31aWAqz9MHTMYVa3PBJqwUQ
         +bo1QsfKJMbJVZNBJAj7tRFoI+99pvHPacvl2uEhPpbkheyxhbiSbzHrCDdw8D1a63cc
         7zbdRP48nGhoMHV/9EjfA3L+95klvr7fpUCExWXOESOfm8kOGCOh1nhiyCxNF4APB5PH
         pQQg==
X-Gm-Message-State: APjAAAU4tEOsV4UpU2nM4yyOUR0c+88t9cyv9V5txB1HV9eieKPIgPUJ
        qC2T4XEVIPYLak9pDesH8635BQ7gbvp+d8wfKQE=
X-Google-Smtp-Source: APXvYqzfwHSCPcOtHrOCnhWc8fdsm1m+pGdQUhnhIoEflOxbRll66KgIaKEOvChamCyINXmb+mMmrq9F7N5iWy8mcRo=
X-Received: by 2002:aca:3841:: with SMTP id f62mr4238023oia.9.1553883524800;
 Fri, 29 Mar 2019 11:18:44 -0700 (PDT)
Date:   Fri, 29 Mar 2019 11:18:39 -0700
In-Reply-To: <eea3ce6a-732b-5c1d-9975-eddaeee21cf5@infradead.org>
Message-Id: <20190329181839.139301-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <eea3ce6a-732b-5c1d-9975-eddaeee21cf5@infradead.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH v2] gcov: fix when CONFIG_MODULES is not set
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     oberpar@linux.ibm.com, akpm@linux-foundation.org
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Greg Hackmann <ghackmann@android.com>,
        Tri Vo <trong@android.com>, linux-mm@kvack.org,
        kbuild-all@01.org, Randy Dunlap <rdunlap@infradead.org>,
        kbuild test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes commit 8c3d220cb6b5 ("gcov: clang support")

Cc: Greg Hackmann <ghackmann@android.com>
Cc: Tri Vo <trong@android.com>
Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
Cc: linux-mm@kvack.org
Cc: kbuild-all@01.org
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kbuild test robot <lkp@intel.com>
Link: https://marc.info/?l=linux-mm&m=155384681109231&w=2
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 kernel/gcov/gcc_3_4.c | 4 ++++
 kernel/gcov/gcc_4_7.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/kernel/gcov/gcc_3_4.c b/kernel/gcov/gcc_3_4.c
index 801ee4b0b969..8fc30f178351 100644
--- a/kernel/gcov/gcc_3_4.c
+++ b/kernel/gcov/gcc_3_4.c
@@ -146,7 +146,11 @@ void gcov_info_unlink(struct gcov_info *prev, struct gcov_info *info)
  */
 bool gcov_info_within_module(struct gcov_info *info, struct module *mod)
 {
+#ifdef CONFIG_MODULES
 	return within_module((unsigned long)info, mod);
+#else
+	return false;
+#endif
 }
 
 /* Symbolic links to be created for each profiling data file. */
diff --git a/kernel/gcov/gcc_4_7.c b/kernel/gcov/gcc_4_7.c
index ec37563674d6..0b6886d4a4dd 100644
--- a/kernel/gcov/gcc_4_7.c
+++ b/kernel/gcov/gcc_4_7.c
@@ -159,7 +159,11 @@ void gcov_info_unlink(struct gcov_info *prev, struct gcov_info *info)
  */
 bool gcov_info_within_module(struct gcov_info *info, struct module *mod)
 {
+#ifdef CONFIG_MODULES
 	return within_module((unsigned long)info, mod);
+#else
+	return false;
+#endif
 }
 
 /* Symbolic links to be created for each profiling data file. */
-- 
2.21.0.392.gf8f6787159e-goog

