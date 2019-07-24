Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A3CAC76191
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 18:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2246F21951
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 18:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ex6GxVMQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387564AbfGXSpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 14:45:25 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:54242 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728720AbfGXSpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 14:45:24 -0400
Received: by mail-pg1-f201.google.com with SMTP id t18so18893810pgu.20
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 11:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=r1Lwo95bqBpHaP05fLy4buBVdc4R2UztiarSDTsVMoM=;
        b=Ex6GxVMQvR+cx+YRIWfUlH5M2lCX6wTziVMvcS4Eaj7OoYwUDJjJuihOPkKO9TqegM
         kpvb4I9F1SqW3fjZghdG7z/XLvUsY+wjqQrJXy1px+i9ThldzZbm3hyydwFD2wJDRiQz
         1RsZs5+34rNT7TX875PqgjnGo79eB4Uz/rXN5Q2ETBMnyJN+jRiRdRQJR4GXJDMNxDfo
         7GGSO80sbebtOtOy3rODVuZpRx8ldyNVltGmV443tofM8GHbgVDTqztYi8hL6f/b5K7K
         KqU65CyxmXHrNxuFfXBnU/JvhkJK5M32ny+ABRzaKAu0QuVm6fIjdtwUKHMshFzmZIcf
         RlPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=r1Lwo95bqBpHaP05fLy4buBVdc4R2UztiarSDTsVMoM=;
        b=tX6HkWwxDudwwULZ9qJ0/HvKd+9dcmHj0sFFjMstCw6TuzGbRz/a8Jsh41DASJ/KQ4
         Xe0KfpoWcQcaoDXqkayjz/+Hks0zcui/Ry6h10s5+qBtXGhTKQglxOM5WdSsSiLlX1us
         /aVW6gvjliPmISIMEiiKuLlFO9NDPA3QOCzRTH0mduMhOeYsN8p5i88YHkMMpUR7N+CT
         OwIofmPlOptXte9NO364HxizibzhKwxjIHj2s4DfqFY7WI0mmrqoI3O46ucRuDrGbU1C
         VdZal2yitp4xoaEb9vR3QG7uf4Z9WGSxQUxfIaMgTlJMsmPa9wFHANQy2+buyOjzamEs
         Mxvg==
X-Gm-Message-State: APjAAAUKmUNb3BgrDBA9ch4TjYeGyVtr2bbUf0e3d2YT2fbGTDiABmTy
        xyM0VYP7TZNVKWXIxkwt6uX9X2c/
X-Google-Smtp-Source: APXvYqybhL1eQVErqxmcsD8sAKN7eNcncx2p/FfwGeBX34GFuyRquYH2AQpIO3PHGtfNRqazU7F8KRdf
X-Received: by 2002:a63:3147:: with SMTP id x68mr18906127pgx.212.1563993923640;
 Wed, 24 Jul 2019 11:45:23 -0700 (PDT)
Date:   Wed, 24 Jul 2019 11:45:12 -0700
In-Reply-To: <20190724184512.162887-1-nums@google.com>
Message-Id: <20190724184512.162887-4-nums@google.com>
Mime-Version: 1.0
References: <20190724184512.162887-1-nums@google.com>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
Subject: [PATCH 3/3] Fix insn.c misaligned address error
From:   Numfor Mbiziwo-Tiapo <nums@google.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, songliubraving@fb.com, mbd@fb.com
Cc:     linux-kernel@vger.kernel.org, irogers@google.com,
        eranian@google.com, Numfor Mbiziwo-Tiapo <nums@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ubsan (undefined behavior sanitizer) version of perf throws an
error on the 'x86 instruction decoder - new instructions' function
of perf test.

To reproduce this run:
make -C tools/perf USE_CLANG=1 EXTRA_CFLAGS="-fsanitize=undefined"

then run: tools/perf/perf test 62 -v

The error occurs in the __get_next macro (line 34) where an int is
read from a potentially unaligned address. Using memcpy instead of
assignment from an unaligned pointer.

Signed-off-by: Numfor Mbiziwo-Tiapo <nums@google.com>
---
 tools/perf/util/intel-pt-decoder/insn.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/intel-pt-decoder/insn.c b/tools/perf/util/intel-pt-decoder/insn.c
index ca983e2bea8b..de1944c60aa9 100644
--- a/tools/perf/util/intel-pt-decoder/insn.c
+++ b/tools/perf/util/intel-pt-decoder/insn.c
@@ -31,7 +31,8 @@
 	((insn)->next_byte + sizeof(t) + n <= (insn)->end_kaddr)
 
 #define __get_next(t, insn)	\
-	({ t r = *(t*)insn->next_byte; insn->next_byte += sizeof(t); r; })
+	({ t r; memcpy(&r, insn->next_byte, sizeof(t)); \
+		insn->next_byte += sizeof(t); r; })
 
 #define __peek_nbyte_next(t, insn, n)	\
 	({ t r = *(t*)((insn)->next_byte + n); r; })
-- 
2.22.0.657.g960e92d24f-goog

