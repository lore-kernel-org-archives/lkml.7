Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E49BDC46478
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 10:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4B9520836
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 10:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BFh3rrWH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfGBKfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 06:35:19 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33543 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfGBKfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 06:35:18 -0400
Received: by mail-ot1-f66.google.com with SMTP id q20so16655149otl.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 03:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ntf4e24cY15lCTdagT3iS0+VMjBOYWf7Iw92R3PEKUw=;
        b=BFh3rrWH1Q7vw8K9KiTKC5WaEVtLH0hxOlQ8lYb+DxjHbhrG8G/LElcvUvV9Z5bMjY
         PvFP3WCg4pEAT++5wHCFpR6vuJg14wqFr8xkqfLzZtDJAbaIKzIL7uG+cj1GqzhMO2oz
         lWopsH2r9uZgOt0L6Hl1QCAUtH7Cy7js2lqRCrJnKKpRi0tuHwlSYpEodH9GQE/iUnc2
         FTPTtbK8H85AKdlBWYas0YUdufWuQAxbJ10khbih9MAd2Fmr+Mu5q6+8HCD70UpIv4LS
         kxPqAejefCAGovMeEGJzkcsjEhjSPfW3Vd90Z4GpmBWL3WYYkgjneF7Yov6E3seeRjaq
         gy1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ntf4e24cY15lCTdagT3iS0+VMjBOYWf7Iw92R3PEKUw=;
        b=OKHJaSxIPBv3/GJBkw5vPJuydtvu6d/t7FjwStj8OU0XvM+WqCHQEhlddHz9LFAxs8
         FamvqslAQJqmCHmKpwSGdN13o5NCfWrHzAQDBFyJkF9nVQuDPBRZv6hYgFgunDX0KnU0
         sbRAoD6U3WJ4jPWU5w0ngNwm0wgEwITxGDuSCblvQZjyQBkwV8dI7yjyJbzPc/gf4VJg
         8zZMOEV+Uya6Jhnj7WylfRNhHqf4PsG2SHFxwYWTRTX5fhyBsph6fnEXh9eQ0OfsTovJ
         5aF1ClEbPpuJKXyPZdrldtokJYVgwV64MnlH+MEBQD93k5T+mE+0HRBozUXKJ3fu5DS4
         kuAw==
X-Gm-Message-State: APjAAAV9m8BxyBGbznD2w5YKp+DULzrcihmx6empNVpBdfYCXQ6L7UwB
        4F1bPOGi5UB41dfW6Qdr3zGRXA==
X-Google-Smtp-Source: APXvYqw3zAInzH4cTXbdXL/Li2f0QnMXGWwp1X9151d8/cPhARYLEWYsz7hEiShYCg/05pNO094M+Q==
X-Received: by 2002:a9d:6853:: with SMTP id c19mr1570455oto.213.1562063718005;
        Tue, 02 Jul 2019 03:35:18 -0700 (PDT)
Received: from localhost.localdomain (li964-79.members.linode.com. [45.33.10.79])
        by smtp.gmail.com with ESMTPSA id 61sm5139805otx.8.2019.07.02.03.35.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 03:35:17 -0700 (PDT)
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
Subject: [PATCH v1 04/11] perf annotate: Smatch: Fix dereferencing freed memory
Date:   Tue,  2 Jul 2019 18:34:13 +0800
Message-Id: <20190702103420.27540-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190702103420.27540-1-leo.yan@linaro.org>
References: <20190702103420.27540-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on the following report from Smatch, fix the potential
dereferencing freed memory check.

  tools/perf/util/annotate.c:1125
  disasm_line__parse() error: dereferencing freed memory 'namep'

tools/perf/util/annotate.c
1100 static int disasm_line__parse(char *line, const char **namep, char **rawp)
1101 {
1102         char tmp, *name = ltrim(line);

[...]

1114         *namep = strdup(name);
1115
1116         if (*namep == NULL)
1117                 goto out_free_name;

[...]

1124 out_free_name:
1125         free((void *)namep);
                          ^^^^^
1126         *namep = NULL;
             ^^^^^^
1127         return -1;
1128 }

If strdup() fails to allocate memory space for *namep, we don't need to
free memory with pointer 'namep', which is resident in data structure
disasm_line::ins::name; and *namep is NULL pointer for this failure, so
it's pointless to assign NULL to *namep again.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/annotate.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index c8ce13419d9b..b8dfcfe08bb1 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1113,16 +1113,14 @@ static int disasm_line__parse(char *line, const char **namep, char **rawp)
 	*namep = strdup(name);
 
 	if (*namep == NULL)
-		goto out_free_name;
+		goto out;
 
 	(*rawp)[0] = tmp;
 	*rawp = ltrim(*rawp);
 
 	return 0;
 
-out_free_name:
-	free((void *)namep);
-	*namep = NULL;
+out:
 	return -1;
 }
 
-- 
2.17.1

