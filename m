Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26323C06514
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 10:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA33620836
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 10:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qjjisz9+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbfGBKf1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 06:35:27 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39409 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfGBKf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 06:35:26 -0400
Received: by mail-oi1-f196.google.com with SMTP id m202so12622160oig.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 03:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j8r6zV3IEktEeBidDu6w6MpwFi6YkkHS02O0zUC0bQU=;
        b=Qjjisz9+e7yYwO6xLzJxQ9HbSJNib4eLc/3vLq48/xqqic/aAX4AvVAU/q5Zop1wmJ
         XkmTke4IVTLDngJtze/ZkDjaA1QU2R2D/kHisk1UxjpNfhZtzV+/+629pPbm+Ug4uQB3
         4FUiB7Cc9UYcJjXd+1RdHn98NgTgP+CyF3zfcn8HHtP4zbskHeNvhiTO+SBYh8XED2gK
         tgRH9S+HRPx4neVupbgOI+Jf8yoEA/nT9Hu9YsNGYeST0SZxaf7/1ytrlD2AQQgeCoI8
         QHpmQwLSW44gvSGD2fR7zcUfA5vt3FIfsqKNmFUkJO+2QCNdtXC1KzICntwRsWO7lm+s
         l/Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j8r6zV3IEktEeBidDu6w6MpwFi6YkkHS02O0zUC0bQU=;
        b=ZhWtOEMWNsZTy66YnUSfM+vSeMkQXQjREusRvBKXrlKSlM7PydkH7stkzRWGpHjlu6
         +7g15x+rVWqM9g2NTLSmhkb4CCf4loZuaoTgionVeck7M/udDy2d+kLYpl1DyxW5zitj
         UXu1kk3ZyfZYm0bqQS3WqXiuGsVJDYPY3rDbWo1AHn5dLa8cVrmvWrwAER7lVEg8IbW5
         ZY5C2pwQ/12IgsXwczUmnPErCeckrehAWew+Q6ssMGA+EOFyOBABGsRozwf13er4CQ7v
         3su9rsdqFLSZwngaZgU8unFEN0dJCjMJcZ1b26WOxXRT2OUM7ug81+RV0gAWm3rmMT/1
         uQuw==
X-Gm-Message-State: APjAAAW+W/IL6PLOMra5UOi3pBe66ryje61/6yJPjlMFjp5bxpz3xVrp
        m9YUWwaYwUOFkiuIkqh6zXoiKg==
X-Google-Smtp-Source: APXvYqxFBE3kxigBHHifCwiRVBNPGG9/R+BcMI2vSqv/pA1AkddGPDPye+08h6Sn5ZFJoOKfqS3Zvg==
X-Received: by 2002:a54:4615:: with SMTP id p21mr2435033oip.22.1562063726111;
        Tue, 02 Jul 2019 03:35:26 -0700 (PDT)
Received: from localhost.localdomain (li964-79.members.linode.com. [45.33.10.79])
        by smtp.gmail.com with ESMTPSA id 61sm5139805otx.8.2019.07.02.03.35.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 03:35:25 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Andi Kleen <ak@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jin Yao <yao.jin@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Changbin Du <changbin.du@intel.com>,
        Eric Saint-Etienne <eric.saint.etienne@oracle.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 05/11] perf trace: Smatch: Fix potential NULL pointer dereference
Date:   Tue,  2 Jul 2019 18:34:14 +0800
Message-Id: <20190702103420.27540-6-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190702103420.27540-1-leo.yan@linaro.org>
References: <20190702103420.27540-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on the following report from Smatch, fix the potential
NULL pointer dereference check.

  tools/perf/builtin-trace.c:1044
  thread_trace__new() error: we previously assumed 'ttrace' could be
  null (see line 1041).

tools/perf/builtin-trace.c
1037 static struct thread_trace *thread_trace__new(void)
1038 {
1039         struct thread_trace *ttrace =  zalloc(sizeof(struct thread_trace));
1040
1041         if (ttrace)
1042                 ttrace->files.max = -1;
1043
1044         ttrace->syscall_stats = intlist__new(NULL);
             ^^^^^^^^
1045
1046         return ttrace;
1047 }

This patch directly returns NULL when fail to allocate memory for
ttrace; this can avoid potential NULL pointer dereference.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-trace.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index f3532b081b31..874d78890c60 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1038,9 +1038,10 @@ static struct thread_trace *thread_trace__new(void)
 {
 	struct thread_trace *ttrace =  zalloc(sizeof(struct thread_trace));
 
-	if (ttrace)
-		ttrace->files.max = -1;
+	if (ttrace == NULL)
+		return NULL;
 
+	ttrace->files.max = -1;
 	ttrace->syscall_stats = intlist__new(NULL);
 
 	return ttrace;
-- 
2.17.1

