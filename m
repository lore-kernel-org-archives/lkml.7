Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABEACC4CECE
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 00:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80D6B21835
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 00:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nSrgttzt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfJOAdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 20:33:11 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:37432 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfJOAdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 20:33:11 -0400
Received: by mail-pl1-f202.google.com with SMTP id p15so10973607plq.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 17:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=b/tG0VRbZwIRSpjUHejoAWVOOXol4K25Gp7J8+effdA=;
        b=nSrgttztpar1ljNROM1YFQFbiQRoJ/egBFlOLZCid/e3LHJpovGMmdbbuBAzVAa8x/
         /7OV9XEoCL/WpJUsKDOPZS70DW2QVpC3zfEJAudKHV/cxA57yf0keAg1aEmsqlHSyDyb
         JSDiDpuZfrbvtlMecWv28HahWsb/us+jU2IfOrTiKySrntyfCTMC8UmriFYLXbfTFiv5
         eEoexI+/Xs7tc9Kk3kWeT/MfkiulMLsk64YoWhnrlO+O8bYam/lpOk1kBVwYkQaFIScO
         C7Ek4dqDI2Tpmi7Pf5k3LMU2sDiu6/DkMTLbWJnkMb69Yd5aRbhnXVvqHy7JA76PBU/T
         eXfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=b/tG0VRbZwIRSpjUHejoAWVOOXol4K25Gp7J8+effdA=;
        b=q59m8bsQr8ZznII/d8bh5/NQw+hYDticFo/mwibxbuBWcFTzAsT6mKcAPsungJwIIq
         Du7L3PJv4rnP9eso0o3U7NN5rY+fesgWuofvqCgN/U8+SRO6wn1mmZGo2EirBsE0s/b2
         TdMDW3UIU2QfdM67l9g0u3dFKPYmbPN+R2cr7BICoigqGTBrV3wPaqwHfr+Ja+V1EigV
         4yGR+jG96CMeS5PEivfYLsziTlrmn57cb5eaLMvSK/ANs1pKD0gdUjRfULZ0qhAWPG7Z
         DtZ1LH892XAJ40P9EHvQ14hRe51xP16kjuJ060cjjYJ8O93b7wsQbgJIJ6OvRCbpFrM+
         bSDg==
X-Gm-Message-State: APjAAAXV3S8zBmnFlE4dJw6Gbd7VoUmiARf7Bn8rPLm2vLbFcydZcTgX
        3IlNr801RBqX6PSOz0h50HAI/GOdXYnv
X-Google-Smtp-Source: APXvYqxCjd62pgBDhQZxucwDOoq3rP/KUr7ETOBFC/ZFlsmlRPIIWjGYoquV4sUrln40cZuyY0GE6Sech8xu
X-Received: by 2002:a63:560d:: with SMTP id k13mr35434441pgb.437.1571099589846;
 Mon, 14 Oct 2019 17:33:09 -0700 (PDT)
Date:   Mon, 14 Oct 2019 17:33:03 -0700
Message-Id: <20191015003303.61293-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
Subject: [PATCH 15/15] perf annotate: ensure objdump argv is NULL terminated
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Song Liu <songliubraving@fb.com>, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide null termination.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/annotate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index f7c620e0099b..a9089e64046d 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1921,6 +1921,7 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 		NULL, /* Will be the objdump command to run. */
 		"--",
 		NULL, /* Will be the symfs path. */
+		NULL,
 	};
 	struct child_process objdump_process;
 	int err = dso__disassemble_filename(dso, symfs_filename, sizeof(symfs_filename));
-- 
2.23.0.700.g56cf767bdb-goog

