Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3866C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 17:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBC1C20659
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 17:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ivt92S6S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfGBRhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 13:37:22 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:45498 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfGBRhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 13:37:22 -0400
Received: by mail-pf1-f202.google.com with SMTP id i27so11284868pfk.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 10:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=+5XT/g9T3nucL8IT9LBXdN8sUapYS1KerZVKIiU2Ja0=;
        b=ivt92S6SyIZgafvp3dwb3sISrf333tdrT0i3gp2tt5kenvRX4zWPKppQedKCnYSgVp
         zZtw4mLuaDT8+Y6h+ti++y1d/RWxClB+yQevb+QLAHxYpZL0syiAoUg6HqK7sEOCzV28
         QMNe29VfR+JPs/iJKKTNTBZlDjq4IQ4M7Dj79nTnWWtgV2t0Is8e82+JjdNHBu6uEn5v
         PANUDpPLjqvkVWG0J+c53TSS7zgmd9jqYy7Gfe/pdVfxWZqrdVhmSvXsQ1/CMPdFmVRZ
         9AK8el7XLVcW2cR0fUwRO2a20DVvejabhabNfwK8AvKxcYrdrO/p9FGJL50bBSybl6KP
         vqaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=+5XT/g9T3nucL8IT9LBXdN8sUapYS1KerZVKIiU2Ja0=;
        b=SP5PcgSA/jbdUPm88YNh7YOBFq3kYuouxQMAh8nGOAvJvnfLjqCTemGSywE6B8JD6t
         9wRVg2o/VVVFgJysociO8zQr6FO5vgfO6bDQLKerW1X/SXTvPkL/salDrNBRldgkEViK
         qWo/yS8OJmRN30kAHCsUr4kcmGo7BKROOLGhp0QT8GbrAxrnFdu2jEeb4HkMluXNbjNK
         JtwXxokx3ByRx3lXmGTdEcvz0m+vlDs277R1k17grmv9wlZ6lLrc8lyun+KaFFsfHRHH
         BZPrlENrLAObuRKj/XMAbKYTi7wQFAkAswWfYfKWf1/cRScBUIgesTqsR9VLxB1UkRcJ
         6CSg==
X-Gm-Message-State: APjAAAUhsB462YcbHtHW1B96ib8co5KRi/lu113PqB5Rha0Vj6vzOuqe
        99BIla/27LbF0PxGif3qHTOo+WYt
X-Google-Smtp-Source: APXvYqwd93/UxfeW4hnumPZrXqr0xYXt1ugiJ75SjA9KSHWd+0CUWUnyheXKNNe2WzWVziVI0m6oVQq0
X-Received: by 2002:a63:480e:: with SMTP id v14mr31161233pga.182.1562089040963;
 Tue, 02 Jul 2019 10:37:20 -0700 (PDT)
Date:   Tue,  2 Jul 2019 10:37:15 -0700
Message-Id: <20190702173716.181223-1-nums@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH 1/2] Fix mmap-thread-lookup.c unitialized memory usage
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

Running the perf test command after building perf with a memory
sanitizer causes a warning that says:
WARNING: MemorySanitizer: use-of-uninitialized-value... in mmap-thread-lookup.c
Initializing the go variable to 0 fixes this change.

Signed-off-by: Numfor Mbiziwo-Tiapo <nums@google.com>
---
 tools/perf/tests/mmap-thread-lookup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/mmap-thread-lookup.c b/tools/perf/tests/mmap-thread-lookup.c
index 5ede9b561d32..b1abf4752f35 100644
--- a/tools/perf/tests/mmap-thread-lookup.c
+++ b/tools/perf/tests/mmap-thread-lookup.c
@@ -52,7 +52,7 @@ static void *thread_fn(void *arg)
 {
 	struct thread_data *td = arg;
 	ssize_t ret;
-	int go;
+	int go = 0;
 
 	if (thread_init(td))
 		return NULL;
-- 
2.22.0.410.gd8fdbe21b5-goog

