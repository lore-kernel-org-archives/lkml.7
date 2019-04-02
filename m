Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E419C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 03:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B29820880
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 03:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="g3m1Y2Sc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbfDBDKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 23:10:24 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44416 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbfDBDKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 23:10:24 -0400
Received: by mail-pl1-f194.google.com with SMTP id g12so5484889pll.11
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 20:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hp60OTE4ke8iP5Aud+CmanJ0ZyIKgseuIbzLLPcisQY=;
        b=g3m1Y2ScyzDAURubjhsTnVSDieFyBlqPSM2LC7CUatm8gRlzI4Z4XQ8e+sauoBVcMy
         /Si0ZgUXDkb0dPj3vSxlgc5r0s2q7Upfik19UZen265H5YZZ42iiEK9QbuX7YonIPVGD
         d0/tPGVBnFEdWBuZzWmyAl7nqsH30axLzN9a/pDbloDEH6lC9LU9a4jIP9tdhzmsciY5
         S3tIIQOc4z1gsawWCFsfc9AkK7pkcFlCQf4Z5R8i1IFoxZ3IVzHzOFybLqrgNgncMa7W
         Yh4ifra9SolAtD3ZfW1fVy94mG7zhGcdjiK400DReloJN9yY0S5qFzHvofEschSfANPf
         kDSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hp60OTE4ke8iP5Aud+CmanJ0ZyIKgseuIbzLLPcisQY=;
        b=D5ujoxlQj6GNcBMRblKduPLcOndkhU1v8uR7ntjT53kA89N8wl/D20NYm8GhR/HOGF
         xzlY32AsfK21LZYwHZ/+4l0mpOP2lQaH+6MYb0qHE4neSIGMm3ptI3cVbGOlICnPNPu2
         HslEXUD9xxvDtUrNyuRne8fzRJc43KZxx20spwxH/M0HNUyf3M7HxVYqoH0pIcqsLgf8
         VYQZhyyTMm6wc4fmnSqtflvRilEHmKFwZEcZOKwg5U+8C2VOuXBsubcRzgIbaZRVdjiM
         AVbc9XD56fsQDzveD2uekvZe0cjhs6teEkl/dlLqUVHRUaf5eBjW3gCb2usN1D9JKBGK
         S1mg==
X-Gm-Message-State: APjAAAXVB5U+Y4BB04HP9u3BP9C7/3QuCrCP2fDjxgpVPWgk/iZZimGB
        siYN6wESULfQgY1Q0T7A1W1f3A==
X-Google-Smtp-Source: APXvYqyBVin/OFPJ5V12iXbP2gcs5Osv/4t27BzE77qH7pR8fgo4gJrG7KlV5JQtMOT9MiQxqhVPIg==
X-Received: by 2002:a17:902:2c83:: with SMTP id n3mr69465358plb.281.1554174623140;
        Mon, 01 Apr 2019 20:10:23 -0700 (PDT)
Received: from trong-glaptop.imgcgcw.net ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id c17sm16168464pfd.76.2019.04.01.20.10.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 20:10:22 -0700 (PDT)
From:   trong@android.com
To:     oberpar@linux.ibm.com, akpm@linux-foundation.org
Cc:     ndesaulniers@google.com, ghackmann@android.com, linux-mm@kvack.org,
        kbuild-all@01.org, rdunlap@infradead.org, lkp@intel.com,
        linux-kernel@vger.kernel.org, Tri Vo <trong@android.com>
Subject: [PATCH v3] gcov: fix when CONFIG_MODULES is not set
Date:   Tue,  2 Apr 2019 10:09:56 +0700
Message-Id: <20190402030956.48166-1-trong@android.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tri Vo <trong@android.com>

Fixes: 8c3d220cb6b5 ("gcov: clang support")

Cc: Greg Hackmann <ghackmann@android.com>
Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
Cc: linux-mm@kvack.org
Cc: kbuild-all@01.org
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kbuild test robot <lkp@intel.com>
Link: https://marc.info/?l=linux-mm&m=155384681109231&w=2
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Tri Vo <trong@android.com>
---
 kernel/gcov/clang.c   | 4 ++++
 kernel/gcov/gcc_3_4.c | 4 ++++
 kernel/gcov/gcc_4_7.c | 4 ++++
 3 files changed, 12 insertions(+)

diff --git a/kernel/gcov/clang.c b/kernel/gcov/clang.c
index 125c50397ba2..cfb9ce5e0fed 100644
--- a/kernel/gcov/clang.c
+++ b/kernel/gcov/clang.c
@@ -223,7 +223,11 @@ void gcov_info_unlink(struct gcov_info *prev, struct gcov_info *info)
  */
 bool gcov_info_within_module(struct gcov_info *info, struct module *mod)
 {
+#ifdef CONFIG_MODULES
 	return within_module((unsigned long)info->filename, mod);
+#else
+	return false;
+#endif
 }
 
 /* Symbolic links to be created for each profiling data file. */
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

