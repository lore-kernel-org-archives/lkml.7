Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F8EC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 19:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE439218D3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 19:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HPKtN+Ac"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfCOTv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 15:51:58 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:45416 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727282AbfCOTvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 15:51:54 -0400
Received: by mail-qt1-f201.google.com with SMTP id 35so9646261qty.12
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 12:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=yc2TKKK3uyNjx4k/SCg2YsIAkDocczWLqEwyHrZeSHg=;
        b=HPKtN+AcCirGFFQHEZAu/mCbNrjYIKj90qShdg/IiFhxen49J0Qdpnr1pcKG7a6Z8e
         JeJ2qVhpKVo0e4MFSlZbzLIR2woDetJaTNND5bdihZ/qbAWcocsa2cvfjheYeB4rsRtq
         VupfRDNmC+dOLdGj40kTGJqU/K4oyQ4V3HkdkM9xosZcLU7jdIpJBpWnC76XUdwc2cRx
         PrBSQsPpZWMh+HxdTYEIi4nHU5c8m+m6PJBso4DlJCsFDkKaGHF5sF+vigRkHjI5UG0U
         RhfFgSuDuzmav8L6Qcw6zbyS+BybgMK3vA4F1h2a+P/7Y7SKXtGu14CbY9cr1/NstkUy
         Z8Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yc2TKKK3uyNjx4k/SCg2YsIAkDocczWLqEwyHrZeSHg=;
        b=UZaG2ryiReWypLEuef/ZDwJheerj5CKf6S1CMmsfXX+qW5ODenqXhqnLlArxwFFgQG
         W4SEpSQ+G15jgPVI1jcQREymTYZk9F1beDRz6JZCsmfIqrFqzT6H+NbHl6+TnG51R+Gn
         Rzi6NcxyhkxV2rU6OcMhcPTF7liSFBWtxsfyJDjAwLE/wAhOO2L36FAzNv+tjc/BjuZm
         MTJrRqP4Z6VNkDA163OgvJbn4emrpWpPbtUKYN/jV2457A8yIm3MuouzTFiG5PHQ0zy9
         21b22ISGTSP0P5JfyaZOnrzn3uolisY9fn/cchOXRKGY/kZamfwMVNGsWLxxovLubjlS
         /3WA==
X-Gm-Message-State: APjAAAWIHIyN5aSEi/Y6pwPKZzQqjTp3nPdgo0pOht3aVb5N7FILL7Yi
        OOtf4dLMfug55DNwh9D3rX0syMUNCWkLSysR
X-Google-Smtp-Source: APXvYqxQt9HPpRfECab7LUPrHAbJSVnQOqRrkiVNkyIaCkT/+WBTjFpEfz28zU++TxipH2bwdLb5/hvYcjvCwg1k
X-Received: by 2002:ac8:28c9:: with SMTP id j9mr3165248qtj.21.1552679513588;
 Fri, 15 Mar 2019 12:51:53 -0700 (PDT)
Date:   Fri, 15 Mar 2019 20:51:27 +0100
In-Reply-To: <cover.1552679409.git.andreyknvl@google.com>
Message-Id: <f7fa36ec55ed4b45f61d841f9b726772a04cc0a5.1552679409.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1552679409.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928-goog
Subject: [PATCH v11 03/14] lib, arm64: untag user pointers in strn*_user
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is a part of a series that extends arm64 kernel ABI to allow to
pass tagged user pointers (with the top byte set to something else other
than 0x00) as syscall arguments.

strncpy_from_user and strnlen_user accept user addresses as arguments, and
do not go through the same path as copy_from_user and others, so here we
need to handle the case of tagged user addresses separately.

Untag user pointers passed to these functions.

Note, that this patch only temporarily untags the pointers to perform
validity checks, but then uses them as is to perform user memory accesses.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/strncpy_from_user.c | 3 ++-
 lib/strnlen_user.c      | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/strncpy_from_user.c b/lib/strncpy_from_user.c
index 58eacd41526c..6209bb9507c7 100644
--- a/lib/strncpy_from_user.c
+++ b/lib/strncpy_from_user.c
@@ -6,6 +6,7 @@
 #include <linux/uaccess.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
+#include <linux/mm.h>
 
 #include <asm/byteorder.h>
 #include <asm/word-at-a-time.h>
@@ -107,7 +108,7 @@ long strncpy_from_user(char *dst, const char __user *src, long count)
 		return 0;
 
 	max_addr = user_addr_max();
-	src_addr = (unsigned long)src;
+	src_addr = (unsigned long)untagged_addr(src);
 	if (likely(src_addr < max_addr)) {
 		unsigned long max = max_addr - src_addr;
 		long retval;
diff --git a/lib/strnlen_user.c b/lib/strnlen_user.c
index 1c1a1b0e38a5..8ca3d2ac32ec 100644
--- a/lib/strnlen_user.c
+++ b/lib/strnlen_user.c
@@ -2,6 +2,7 @@
 #include <linux/kernel.h>
 #include <linux/export.h>
 #include <linux/uaccess.h>
+#include <linux/mm.h>
 
 #include <asm/word-at-a-time.h>
 
@@ -109,7 +110,7 @@ long strnlen_user(const char __user *str, long count)
 		return 0;
 
 	max_addr = user_addr_max();
-	src_addr = (unsigned long)str;
+	src_addr = (unsigned long)untagged_addr(str);
 	if (likely(src_addr < max_addr)) {
 		unsigned long max = max_addr - src_addr;
 		long retval;
-- 
2.21.0.360.g471c308f928-goog

