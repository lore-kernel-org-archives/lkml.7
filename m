Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63963C33CA1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C625206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VtX4QbDJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732898AbgAIQEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:04:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54956 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732883AbgAIQEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:04:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578585870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LKRV6Dbt/iehaVr8Oe5+bZly0BQdm7b+eiiMLnIM3KI=;
        b=VtX4QbDJJ8/uLDsqDarPDelFPo05Uxom0VbBYl6/lA0A1WVItKH8VKWoLKEOswS2/1abg1
        BpgPFOYTPjVhkNY5I5FuCNP9ZnbtsY5PWEbwDvz36h+uSfCpFGr4ARCjftsgwehySzjPgZ
        oqQnBbUGDpN7a2PKh8hQGtRNR1HDB7k=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-DYlxJV2RNmelp9pT6rGaGw-1; Thu, 09 Jan 2020 11:04:29 -0500
X-MC-Unique: DYlxJV2RNmelp9pT6rGaGw-1
Received: by mail-wr1-f70.google.com with SMTP id c6so3025715wrm.18
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 08:04:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LKRV6Dbt/iehaVr8Oe5+bZly0BQdm7b+eiiMLnIM3KI=;
        b=PQIq3jju8gauhN41N0ynx11XqmiYPrlCKcjj+mMeoy3tWtH3rvHdkC/VwyKKJtsele
         8uXtgPFtDYupnDDLjRRkfKUHgOUBVpHavyahEWgqOpPsy5O2gX2WUNjCnGCd2HZfe4YE
         Q/5/B90VazIT7wqRGXu3F5Z42EYYuGuv0wJP271Yzv8A/1A1h6M73dHTPPNOkFnW/4LW
         +s5ibGR5/3KTeBhCjvVnC14rA1+fcEXttWdyslYJV46pq3EazSQzNVq1mlnHrhB3KYuM
         9hOwr3mNZcEg9Tq2pAFUgbq2I4LvpKOmik0ZKsTOxoWVqp8nvtpGfL9zKjaRokESS7nC
         7qsg==
X-Gm-Message-State: APjAAAX9WXRQ0Oxcm6mlwINGNJwcqr1QmanZLBgNbMeixj2uFJRcV+nY
        MlWRfqvadQu33txaaawZib+NsJqS7FC8UQdLjeVxON/UxzjHSofAbGAGC5jh1ygWJ5W4jmzdUco
        y3S1/TWeBNADjkKS8rj8e0JOP
X-Received: by 2002:a05:6000:149:: with SMTP id r9mr11718061wrx.147.1578585867816;
        Thu, 09 Jan 2020 08:04:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqwE3TyBDC9AqG/yX8Wr+TMrqckkMWTYZH3Gv26HTZhn0fYryvFxFkZBJQubZ1op9IAokDJnzw==
X-Received: by 2002:a05:6000:149:: with SMTP id r9mr11718025wrx.147.1578585867532;
        Thu, 09 Jan 2020 08:04:27 -0800 (PST)
Received: from redfedo.redhat.com (host81-140-166-164.range81-140.btcentralplus.com. [81.140.166.164])
        by smtp.gmail.com with ESMTPSA id b17sm8615898wrp.49.2020.01.09.08.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 08:04:27 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC v5 11/57] objtool: Abstract alternative special case handling
Date:   Thu,  9 Jan 2020 16:02:14 +0000
Message-Id: <20200109160300.26150-12-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200109160300.26150-1-jthierry@redhat.com>
References: <20200109160300.26150-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some alternatives associated with a specific feature need to be treated
in a special way. Since the features and how to treat them vary from one
architecture to another, move the special case handling to arch specific
code.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/arch/x86/Build                  |  1 +
 tools/objtool/arch/x86/arch_special.c         | 34 +++++++++++++++++++
 tools/objtool/arch/x86/include/arch_special.h |  5 +++
 tools/objtool/special.c                       | 25 +-------------
 tools/objtool/special.h                       |  8 +++++
 5 files changed, 49 insertions(+), 24 deletions(-)
 create mode 100644 tools/objtool/arch/x86/arch_special.c

diff --git a/tools/objtool/arch/x86/Build b/tools/objtool/arch/x86/Build
index e43fd6fa0ee1..971f9fa90a3c 100644
--- a/tools/objtool/arch/x86/Build
+++ b/tools/objtool/arch/x86/Build
@@ -1,3 +1,4 @@
+objtool-y += arch_special.o
 objtool-y += decode.o
 objtool-y += orc_dump.o
 objtool-y += orc_gen.o
diff --git a/tools/objtool/arch/x86/arch_special.c b/tools/objtool/arch/x86/arch_special.c
new file mode 100644
index 000000000000..6dba31f419d0
--- /dev/null
+++ b/tools/objtool/arch/x86/arch_special.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include "../../special.h"
+#include "../../builtin.h"
+
+void arch_handle_alternative(unsigned short feature, struct special_alt *alt)
+{
+	/*
+	 * If UACCESS validation is enabled; force that alternative;
+	 * otherwise force it the other way.
+	 *
+	 * What we want to avoid is having both the original and the
+	 * alternative code flow at the same time, in that case we can
+	 * find paths that see the STAC but take the NOP instead of
+	 * CLAC and the other way around.
+	 */
+	switch (feature) {
+	case X86_FEATURE_SMAP:
+		if (uaccess)
+			alt->skip_orig = true;
+		else
+			alt->skip_alt = true;
+		break;
+	case X86_FEATURE_POPCNT:
+		/*
+		 * It has been requested that we don't validate the !POPCNT
+		 * feature path which is a "very very small percentage of
+		 * machines".
+		 */
+		alt->skip_orig = true;
+		break;
+	default:
+		break;
+	}
+}
diff --git a/tools/objtool/arch/x86/include/arch_special.h b/tools/objtool/arch/x86/include/arch_special.h
index 426178d504a8..3ab2dc32424b 100644
--- a/tools/objtool/arch/x86/include/arch_special.h
+++ b/tools/objtool/arch/x86/include/arch_special.h
@@ -20,4 +20,9 @@
 #define X86_FEATURE_POPCNT (4 * 32 + 23)
 #define X86_FEATURE_SMAP   (9 * 32 + 20)
 
+struct special_alt;
+
+#define arch_handle_alternative arch_handle_alternative
+void arch_handle_alternative(unsigned short feature, struct special_alt *alt);
+
 #endif /* _X86_ARCH_SPECIAL_H */
diff --git a/tools/objtool/special.c b/tools/objtool/special.c
index b8ccee1b5382..67461b25e649 100644
--- a/tools/objtool/special.c
+++ b/tools/objtool/special.c
@@ -75,30 +75,7 @@ static int get_alt_entry(struct elf *elf, struct special_entry *entry,
 
 		feature = *(unsigned short *)(sec->data->d_buf + offset +
 					      entry->feature);
-
-		/*
-		 * It has been requested that we don't validate the !POPCNT
-		 * feature path which is a "very very small percentage of
-		 * machines".
-		 */
-		if (feature == X86_FEATURE_POPCNT)
-			alt->skip_orig = true;
-
-		/*
-		 * If UACCESS validation is enabled; force that alternative;
-		 * otherwise force it the other way.
-		 *
-		 * What we want to avoid is having both the original and the
-		 * alternative code flow at the same time, in that case we can
-		 * find paths that see the STAC but take the NOP instead of
-		 * CLAC and the other way around.
-		 */
-		if (feature == X86_FEATURE_SMAP) {
-			if (uaccess)
-				alt->skip_orig = true;
-			else
-				alt->skip_alt = true;
-		}
+		arch_handle_alternative(feature, alt);
 	}
 
 	orig_rela = find_rela_by_dest(sec, offset + entry->orig);
diff --git a/tools/objtool/special.h b/tools/objtool/special.h
index 35061530e46e..738a05bc6d3a 100644
--- a/tools/objtool/special.h
+++ b/tools/objtool/special.h
@@ -8,6 +8,7 @@
 
 #include <stdbool.h>
 #include "elf.h"
+#include "arch_special.h"
 
 struct special_alt {
 	struct list_head list;
@@ -28,4 +29,11 @@ struct special_alt {
 
 int special_get_alts(struct elf *elf, struct list_head *alts);
 
+#ifndef arch_handle_alternative
+static inline void arch_handle_alternative(unsigned short feature,
+					   struct special_alt *alt)
+{
+}
+#endif
+
 #endif /* _SPECIAL_H */
-- 
2.21.0

