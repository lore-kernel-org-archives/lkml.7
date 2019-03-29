Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21CC9C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 17:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E78FB2184D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 17:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U9KbfiY2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729895AbfC2Rpy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 13:45:54 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:55773 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728977AbfC2Rpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 13:45:54 -0400
Received: by mail-qt1-f201.google.com with SMTP id h51so2937818qte.22
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 10:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MY/FhGStq36GLtRvOP3TUiFwwq8ZbgwnWXgDNjfyXLc=;
        b=U9KbfiY2tmMN3GbfNt8jNImUF01m6grsBPWSAKAY+TrMvuGI6cltQvl/Nirx7lcbau
         /akZ/ARDBKBCMYz1I19MMPsToUhiU4BJcVIzKJV6YKtUdE+bzoUnHPToaaCd2naMOIcV
         ZOtykiTHkOTpTb3WJkmcOfffCA+58ktbybVfG6xMgrWhv46+yngJmvLRhCyWQETNKMyJ
         1WWioQfxhI3z8MqAPw7T5CTFK7yCulwR3rMPL/3fVEFMgCF+IBB2IlQ+korX36XTuOHG
         EB0aNuRSnIgnZEgMx9fBh8DS75VMssmVPBjHGBoAp6X+bazkB2/R8bYyJxs8T23jiQif
         73qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MY/FhGStq36GLtRvOP3TUiFwwq8ZbgwnWXgDNjfyXLc=;
        b=TJvGC74D8XZulJFhr+L3DT1ro6ZIfHwXytIUHWJjul2Zlo/UpfLCgvnf6pVIA3xw05
         2uhwWakcymB+rGU8ZMOxIcIUFAceu4aez/A5AqtTFE4mUW91rbwLkrYFR83gyOvh4Xzh
         GDdFe+9e1Lsuj5IBuBs50DQWj4VexcpbDEPuRkJmLlC8+CuPqJ7XidGCRywm//knpkc+
         3JA6n+YwVN6Ggl0JbCJ8uOcDuY+VSLOX9jIVvycEmWg4bqIdgS1NSl27fiIxj+4iLxI1
         l/O/nQvLVGkhtG2ZIcKRxYHl0qgrMcqIWo3punLqqpkqN035W62jznYEH5ao5dnSmH0m
         j02A==
X-Gm-Message-State: APjAAAVn2kCUppfN7Y/0D6tEfQe+s5iK5Iy+Kqcz8wW7NJJcZ7oYr5mu
        WaFHVOX06b28XXOK3gY+aZiR/l7ZnmdvrKL0QG4=
X-Google-Smtp-Source: APXvYqxtGdNegUoK0pdi/nSTKMHASrseGZaV3kE5Z3L0T9xsiDIdV2DrQQlwb5i+SndR8Lbae0m3yNWoCYyCgBJwxzs=
X-Received: by 2002:a37:6704:: with SMTP id b4mr3214830qkc.29.1553881552858;
 Fri, 29 Mar 2019 10:45:52 -0700 (PDT)
Date:   Fri, 29 Mar 2019 10:45:41 -0700
In-Reply-To: <201903291603.7podsjD7%lkp@intel.com>
Message-Id: <20190329174541.79972-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <201903291603.7podsjD7%lkp@intel.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH] gcov: include linux/module.h for within_module
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     oberpar@linux.ibm.com, akpm@linux-foundation.org
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Greg Hackmann <ghackmann@android.com>,
        Tri Vo <trong@android.com>, linux-mm@kvack.org,
        kbuild-all@01.org, kbuild test robot <lkp@intel.com>,
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
Reported-by: kbuild test robot <lkp@intel.com>
Link: https://marc.info/?l=linux-mm&m=155384681109231&w=2
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 kernel/gcov/gcc_3_4.c | 1 +
 kernel/gcov/gcc_4_7.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/kernel/gcov/gcc_3_4.c b/kernel/gcov/gcc_3_4.c
index 801ee4b0b969..0eda59ef57df 100644
--- a/kernel/gcov/gcc_3_4.c
+++ b/kernel/gcov/gcc_3_4.c
@@ -16,6 +16,7 @@
  */
 
 #include <linux/errno.h>
+#include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/seq_file.h>
diff --git a/kernel/gcov/gcc_4_7.c b/kernel/gcov/gcc_4_7.c
index ec37563674d6..677851284fe2 100644
--- a/kernel/gcov/gcc_4_7.c
+++ b/kernel/gcov/gcc_4_7.c
@@ -13,6 +13,7 @@
  */
 
 #include <linux/errno.h>
+#include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/seq_file.h>
-- 
2.21.0.392.gf8f6787159e-goog

