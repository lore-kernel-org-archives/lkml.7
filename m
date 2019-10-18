Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C130CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 08:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CD6E21852
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 08:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U2HT03hz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442217AbfJRI4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 04:56:34 -0400
Received: from mail-qt1-f173.google.com ([209.85.160.173]:36826 "EHLO
        mail-qt1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731444AbfJRI4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 04:56:33 -0400
Received: by mail-qt1-f173.google.com with SMTP id o12so8057059qtf.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 01:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=snrzNKZP8UfDDZs1OeUEUGCjAFE7mZySQcyt2rcLINA=;
        b=U2HT03hztP06LbbfQbo8H7jDrof9hC5KyKHqdcod+av5BovCeale9v/m7fV3jWYZoE
         shZWn8PaWaYYY64CEB4pR9zkRaRvyM683F97eX8qfF/m3db27g5+drVoSJnMI/1x5MXp
         /kZ5iwBR9BWkgi39e1WWhE/cRV/OSJdcGje83sYyDJOVzkKsf8jimWeMeWf9aN/sz9Gx
         stH6hMVs/wRxZe9z6NCh+3GoL5t/oAAyiR+oJlj2hPwBzfSl6QoJ4j8cAPflXYYD0Wlk
         dxgnVbyFq+MmYTPPxw5GV/DdnQtrjH1o2eF5fFe+1eXWWQF+TDZHgZVRPDbcAxXcQowv
         EBIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=snrzNKZP8UfDDZs1OeUEUGCjAFE7mZySQcyt2rcLINA=;
        b=Wh5Wuf8ATt8C5UHiEWFG3nBzjg2EvQY9K5+H1WzSG0Rn69LSevnMBlxohL2DmfLrsZ
         rOY9qdtA6nmryfXo03LeW0Ct/RizQYlBPa8o0XVbrNso7OwgTr8f0Z+Yrv1bkVj7Oqlw
         h+ZGSdV6YtB3HpP/VCggf3StNW+pkg0O83itJFHLqoBco97Kfn3p+Nyq0UbSmGs8Oawq
         4yrDlPLS8VvyRyLF2Y3oOaDC+AMaWBEELEsHXljCZ8uhfCCONKtEtIfu6u5rbBOgLPTV
         cGcggJmHBuzdz/ZcfIy+0k/029+dAGnp5V8clgVWVoasxqZ+53EAfVyQMiZxbQdUw/gx
         elkw==
X-Gm-Message-State: APjAAAWOLRStoZFwZOV85D7irsX8Z7Tu52KafxFnj3IWAowE6e6+NJMu
        PdQo2Ver5wJ5QbWXtf04z3TArQ==
X-Google-Smtp-Source: APXvYqztWZ5PO5vow5vlVL+G4WNWYD6ihju1gP0h7a+KKr9eISB6SWuBakgZ1+DyifO/Q1SSD9WLmg==
X-Received: by 2002:ac8:27b7:: with SMTP id w52mr8777575qtw.78.1571388990676;
        Fri, 18 Oct 2019 01:56:30 -0700 (PDT)
Received: from localhost.localdomain (li937-157.members.linode.com. [45.56.119.157])
        by smtp.gmail.com with ESMTPSA id a134sm3076571qkc.95.2019.10.18.01.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 01:56:30 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 2/3] perf tests bp_account: Add dedicated checking helper is_supported()
Date:   Fri, 18 Oct 2019 16:55:30 +0800
Message-Id: <20191018085531.6348-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191018085531.6348-1-leo.yan@linaro.org>
References: <20191018085531.6348-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arm architecture supports the breakpoint accounting but it doesn't
support breakpoint overflow signal handling.  The current code uses the
same checking helper, thus it disables both testings (bp_account and
bp_signal) for arm platform.

For handling two testings separately, this patch adds a dedicated
checking helper is_supported() for breakpoint accounting testing, thus
it allows supporting breakpoint accounting testing on arm platform; the
old helper test__bp_signal_is_supported() is only used to checking for
breakpoint overflow signal testing.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/tests/bp_account.c   | 16 ++++++++++++++++
 tools/perf/tests/builtin-test.c |  2 +-
 tools/perf/tests/tests.h        |  1 +
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/bp_account.c b/tools/perf/tests/bp_account.c
index 52ff7a462670..d0b935356274 100644
--- a/tools/perf/tests/bp_account.c
+++ b/tools/perf/tests/bp_account.c
@@ -188,3 +188,19 @@ int test__bp_accounting(struct test *test __maybe_unused, int subtest __maybe_un
 
 	return bp_accounting(wp_cnt, share);
 }
+
+bool test__bp_account_is_supported(void)
+{
+	/*
+	 * PowerPC and S390 do not support creation of instruction
+	 * breakpoints using the perf_event interface.
+	 *
+	 * Just disable the test for these architectures until these
+	 * issues are resolved.
+	 */
+#if defined(__powerpc__) || defined(__s390x__)
+	return false;
+#else
+	return true;
+#endif
+}
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 55774baffc2a..8b286e9b7549 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -121,7 +121,7 @@ static struct test generic_tests[] = {
 	{
 		.desc = "Breakpoint accounting",
 		.func = test__bp_accounting,
-		.is_supported = test__bp_signal_is_supported,
+		.is_supported = test__bp_account_is_supported,
 	},
 	{
 		.desc = "Watchpoint",
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 72912eb473cb..9837b6e93023 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -111,6 +111,7 @@ int test__map_groups__merge_in(struct test *t, int subtest);
 int test__time_utils(struct test *t, int subtest);
 
 bool test__bp_signal_is_supported(void);
+bool test__bp_account_is_supported(void);
 bool test__wp_is_supported(void);
 
 #if defined(__arm__) || defined(__aarch64__)
-- 
2.17.1

