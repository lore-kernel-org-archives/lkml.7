Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68700C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 17:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42EDE20659
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 17:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M1wpP4Lv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfGBRhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 13:37:25 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:40484 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfGBRhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 13:37:24 -0400
Received: by mail-pf1-f201.google.com with SMTP id z1so11259191pfb.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 10:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1FAnKetMS6oVEFfaAMdIzJKX0drL1rc4E0VM9rZq68w=;
        b=M1wpP4LvC86w13Y9yZtd4RaRSscqUQfIQ8ghzT1N29DkC5SgPgrc0DSl5bjo+MPrin
         byi1CQr7BDUdowtx1lML/VgMRRcpwlOQud8aA5ktnWgIfgOeYvUnKe1azQT9+IJIaIr8
         KFVNGaByHdpkQdvgTwUnvAhRPwqA3J9aPM+8bHzDuPhXdxNcExvDtvHGaaPdzrNGZWJz
         46e4rDEYUlToNykFMkfGS3l52lokzGy6gA3UuoOW2ETZfUxhEZt1qZFA8/jJL1s+tdY5
         QCGZie3X9KnYsZsm+P66r+xI4+TpSNECS45b9s6PioF4NsGskU79uexDIKHL5Eak05l3
         1oww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1FAnKetMS6oVEFfaAMdIzJKX0drL1rc4E0VM9rZq68w=;
        b=Cl6P8rUcLPKA5epx+W+kSEf1vn9vARO3x0JB8SjMklXHG43HxteEyjNKAHkBo6Ywqq
         SPwsYzF+sTe6YUv6rdAu8iwEQEor9JVayq0XnDrGly+ZQIKgOESABuiDS4xNsURo9Aqs
         jv/OH5KzPvB1Lk8A+nKDkTB7nG1nqIztYhoGNly6Atgl9pGMAp00zcMLp8EyYbXkAhYU
         /liZoRqlJ0mh3cecWDiz57tYTIP3mD/Nvukw81KgwZxDrI9wpQWsQvt8eCjAYndb+ul9
         yzMXbEG4tbyg8AtgAb9yV2TlkyKO77Bbosg6t9HFttKut8dUUWHuIYUEb+Cg664DNynB
         m2mQ==
X-Gm-Message-State: APjAAAW0c1Ol8vIHMICIMcIdC95XGhT7THluwTBKJf/imIR/wfbiYMVT
        o39w+StjCJc8bs3iLZtyetMIQHyY
X-Google-Smtp-Source: APXvYqzSWOlssB8Os6IHcljkK5kHmI9pPz4N/6iWF86+MCzxSkoUEKAWUlnmWi7SYaNj0t4ST3eTH4HB
X-Received: by 2002:a65:4b8b:: with SMTP id t11mr23416538pgq.130.1562089043245;
 Tue, 02 Jul 2019 10:37:23 -0700 (PDT)
Date:   Tue,  2 Jul 2019 10:37:16 -0700
In-Reply-To: <20190702173716.181223-1-nums@google.com>
Message-Id: <20190702173716.181223-2-nums@google.com>
Mime-Version: 1.0
References: <20190702173716.181223-1-nums@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH 2/2] Fix perf-hooks test
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

The perf-hooks test fails with Address Sanitizer and Memory
Sanitizer builds because it purposefully generates a segfault.
Checking if these sanitizers are active when running this test
will allow the perf-hooks test to pass.

Signed-off-by: Numfor Mbiziwo-Tiapo <nums@google.com>
---
 tools/perf/tests/perf-hooks.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/tests/perf-hooks.c b/tools/perf/tests/perf-hooks.c
index a693bcf017ea..524ecba63615 100644
--- a/tools/perf/tests/perf-hooks.c
+++ b/tools/perf/tests/perf-hooks.c
@@ -25,7 +25,12 @@ static void the_hook(void *_hook_flags)
 	*hook_flags = 1234;
 
 	/* Generate a segfault, test perf_hooks__recover */
+#if defined(ADDRESS_SANITIZER) || defined(MEMORY_SANITIZER) || \
+defined(THREAD_SANITIZER) || defined(SAFESTACK_SANITIZER)
+	raise(SIGSEGV);
+#else
 	*p = 0;
+#endif
 }
 
 int test__perf_hooks(struct test *test __maybe_unused, int subtest __maybe_unused)
-- 
2.22.0.410.gd8fdbe21b5-goog

