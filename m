Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9387BC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 23:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 703462632A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 23:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfE3XvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 19:51:06 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55635 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfE3XvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 19:51:06 -0400
Received: by mail-wm1-f66.google.com with SMTP id 16so506684wmg.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 16:51:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AxB645BL9Uf5L1O2WobtkCzSZ6Mw86JaZeB1N37NGqY=;
        b=aI+FjeVcjpkGos3A04RMZt70u9ahb2b5Mrv9r1jd0XH1ItCwqfTUYBsqO4uuoROoJH
         zWOHZhIASJYGv29qmsr3o8XZhRcHP8867LEKGa38OLZFU2da339cIDAvT0Eju/caqbmF
         rbiqvp6gdyGDTRAwNA1wUQ2kWuJK8C3nZEw79dx4uOTU+EVHnr2WnyzR0bFLR8F4Ns72
         5VnV/GodJIog1jMBWN6mqCVII3Nd3GSPf/dFuTcsHSNs4dTfZRrNLAHU/S2pzHEq+scX
         hvPxJb7zvDQnupdw2w+g7HdumUZdbgYVB2uvCBni/4podSt9kqqCmSX8kFZHiwJ7YF4K
         2wRQ==
X-Gm-Message-State: APjAAAU73ZvPE84UhKQKWE+QV5nF/zeQWGUUXzgWQ3rchOnZdd2XEVRw
        kIozDKE5/PyzM+q5FnHR447kqAXm1nU=
X-Google-Smtp-Source: APXvYqyBL2gh5onIaVyclfx7wZWUXNn+7ukUzkSyEzWGaWurZGZpQDJtL9QBC/exOaA0DSJbNXZkog==
X-Received: by 2002:a7b:c549:: with SMTP id j9mr3734355wmk.114.1559260263894;
        Thu, 30 May 2019 16:51:03 -0700 (PDT)
Received: from raver.teknoraver.net (net-93-144-152-91.cust.vodafonedsl.it. [93.144.152.91])
        by smtp.gmail.com with ESMTPSA id 65sm7812591wro.85.2019.05.30.16.51.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 30 May 2019 16:51:03 -0700 (PDT)
From:   Matteo Croce <mcroce@redhat.com>
To:     linux-kernel@vger.kernel.org, Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Aaron Tomlin <atomlin@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] checkpatch.pl: Warn on duplicate sysctl local variable
Date:   Fri, 31 May 2019 01:51:01 +0200
Message-Id: <20190530235101.3248-1-mcroce@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 6a33853c5773 ("proc/sysctl: add shared variables for range check")
adds some shared const variables to be used instead of a local copy in
each source file.
Warn when a chunk duplicates one of these values in a ctl_table struct:

    $ scripts/checkpatch.pl 0001-test-commit.patch
    WARNING: duplicated sysctl range checking value 'zero', consider using the shared one in include/linux/sysctl.h
    #27: FILE: arch/arm/kernel/isa.c:48:
    +               .extra1         = &zero,

    WARNING: duplicated sysctl range checking value 'int_max', consider using the shared one in include/linux/sysctl.h
    #28: FILE: arch/arm/kernel/isa.c:49:
    +               .extra2         = &int_max,

    total: 0 errors, 2 warnings, 14 lines checked

Signed-off-by: Matteo Croce <mcroce@redhat.com>
---
 scripts/checkpatch.pl | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 342c7c781ba5..b986bab32af7 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6639,6 +6639,13 @@ sub process {
 				     "unknown module license " . $extracted_string . "\n" . $herecurr);
 			}
 		}
+
+# check for sysctl duplicate constants
+		if ($line =~ /\.extra[12]\s*=\s*&(zero|one|int_max|max_int)\b/) {
+			my $extracted_string = get_quoted_string($line, $rawline);
+			WARN("DUPLICATED_SYSCTL_CONST",
+				"duplicated sysctl range checking value '$1', consider using the shared one in include/linux/sysctl.h" . $extracted_string . "\n" . $herecurr);
+		}
 	}
 
 	# If we have no input at all, then there is nothing to report on
-- 
2.21.0

