Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E068BC06511
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 10:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B99EF2146F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 10:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kl6cvJ0z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbfGBKfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 06:35:44 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41393 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfGBKfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 06:35:43 -0400
Received: by mail-oi1-f196.google.com with SMTP id g7so12618800oia.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 03:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V5qTJJXMX1ZTj5uDhYEBO+OiJyquQwYXAx7tq46WL+E=;
        b=kl6cvJ0zlfJ4KIzgl8/M2GfhjusvmgoE9v0c+xjgfAU4sjiJCtTNEv2yzhWtVB8AI+
         gVbM8Qqsd7hSC9h0YewLPNreo18mQdKFVsH7a/QDGIyl2Bx1MoYHbh/qxkHoMHpiHQQZ
         vGOf5QD+aLwBNctZy/pFQEZGJbP+OIpBoWjVd7U6ksXP+Kq7VHvzUoFQcrbYXG+R4IXC
         T2VkFAs1O1gftEP2gLOO9Rw0MVuxO3GxyeHuurTVufDtKMAqN1fYRoKPEeS15cpCs1uV
         ZLkVdcbR1CFwm0XLj32S+RmS5gWwfsNv0VOqqgjvUahAMaBkQgFnEolKo5Cz/8uEdTmr
         yehA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V5qTJJXMX1ZTj5uDhYEBO+OiJyquQwYXAx7tq46WL+E=;
        b=acWDy8EZ1JCm0F7Ic8GDu20suVPFVL2KVuU0akvDhGmmrCHD+cGVP1Qm+WHqk9wLh9
         wyWzzx13n7d94PDcJAi3RrA4eBhLkKnqFPgUXqIgNkeSVC65tXnjofpq96WWajClOTqE
         G3/lQonenCugIJ5rPg+PYaMyOVnzhP4mo/ObB0eCTwqaw1JQXnms17K8AsekHZMF37yl
         /u0iJO01doXDJx0eDcSSvgXDLkMd9ZvYEhbJW8T8TvjyflUQRMOqqtxxVX5i5zpKmqVu
         Jcud13un8Ld8PwHGpuRY6RMdmO96Fs5LrNjLHsIU4VCdkoTceYiYSPoo0cMssK9GAb7Y
         DFiw==
X-Gm-Message-State: APjAAAUSOmd78AD2lj4FQRIzyQCKtxZGO2ZBNEZIGvv7tRknUp+MW0MI
        BMZReAQDJ4MBycDdpNfMJ56Omw==
X-Google-Smtp-Source: APXvYqz59VS9CDs0uFQjkuuAuV2DBtWVLiGfaY9BCu/0Bna+d2JpT5qQdBt2XFFh/CRMcG2+5UHiYg==
X-Received: by 2002:aca:c5d0:: with SMTP id v199mr2313436oif.144.1562063742299;
        Tue, 02 Jul 2019 03:35:42 -0700 (PDT)
Received: from localhost.localdomain (li964-79.members.linode.com. [45.33.10.79])
        by smtp.gmail.com with ESMTPSA id 61sm5139805otx.8.2019.07.02.03.35.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 03:35:41 -0700 (PDT)
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
Subject: [PATCH v1 07/11] perf map: Smatch: Fix potential NULL pointer dereference
Date:   Tue,  2 Jul 2019 18:34:16 +0800
Message-Id: <20190702103420.27540-8-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190702103420.27540-1-leo.yan@linaro.org>
References: <20190702103420.27540-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on the following report from Smatch, fix the potential
NULL pointer dereference check.

  tools/perf/util/map.c:479
  map__fprintf_srccode() error: we previously assumed 'state' could be
  null (see line 466)

tools/perf/util/map.c
465         /* Avoid redundant printing */
466         if (state &&
467             state->srcfile &&
468             !strcmp(state->srcfile, srcfile) &&
469             state->line == line) {
470                 free(srcfile);
471                 return 0;
472         }
473
474         srccode = find_sourceline(srcfile, line, &len);
475         if (!srccode)
476                 goto out_free_line;
477
478         ret = fprintf(fp, "|%-8d %.*s", line, len, srccode);
479         state->srcfile = srcfile;
            ^^^^^^^
480         state->line = line;
            ^^^^^^^

This patch validates 'state' pointer before access its elements.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/map.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 6fce983c6115..5f87975d2562 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -476,8 +476,11 @@ int map__fprintf_srccode(struct map *map, u64 addr,
 		goto out_free_line;
 
 	ret = fprintf(fp, "|%-8d %.*s", line, len, srccode);
-	state->srcfile = srcfile;
-	state->line = line;
+
+	if (state) {
+		state->srcfile = srcfile;
+		state->line = line;
+	}
 	return ret;
 
 out_free_line:
-- 
2.17.1

