Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF9C9C388F3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89EBE21924
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569928435;
	bh=lHerwJ8lzUPJcvLZ6l595zMEqfVKN0oxl/LJv65ZLb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g66QGrwggNStc0ng7yRV5461Cdi/SEacPk/8aINMXthOvbDADJYmHMyEj5qN5iqPq
	 xtyXF0/e5ZxDr4BXE1liHiH1IMuds77lZ9lC7VF0dNDphnrPtxSgNfjElpQcLPtNvS
	 Zmpr8hiJdIwiZsrr+JC8KZ26L5hQoV9cLrDDb92U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732090AbfJALNy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 07:13:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:35864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731944AbfJALNw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 07:13:52 -0400
Received: from quaco.ghostprotocols.net (177.206.223.101.dynamic.adsl.gvt.net.br [177.206.223.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27A3721D79;
        Tue,  1 Oct 2019 11:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569928431;
        bh=lHerwJ8lzUPJcvLZ6l595zMEqfVKN0oxl/LJv65ZLb0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tZHWF3TwiqH9VN7C0chJHGgN4+o8I3PqowJubERLj/fIo20EjkYN4DlzVfmcLoBIu
         8Yvu0r2zvlIOV0aan0kAIKa5GMmWgqlLjzSdds/dOUIvkSF6pBos6q8jAcNDyhujpS
         Fu0vkN7cTfsIm5yWc/i1X1NsYI9sF0iLh3t7QBbo=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Subject: [PATCH 20/24] perf annotate: Fix the signedness of failure returns
Date:   Tue,  1 Oct 2019 08:12:12 -0300
Message-Id: <20191001111216.7208-21-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191001111216.7208-1-acme@kernel.org>
References: <20191001111216.7208-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Callers of symbol__annotate() expect a errno value or some other
extended error value range in symbol__strerror_disassemble() to
convert to a proper error string, fix it when propagating a failure to
find the arch specific annotation routines via arch__find(arch_name).

Reported-by: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
Cc: Will Deacon <will@kernel.org>
Link: https://lkml.kernel.org/n/tip-o0k6dw7cas0vvmjjvgsyvu1i@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 9b7b9176e713..95109acf4808 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2075,7 +2075,7 @@ int symbol__annotate(struct symbol *sym, struct map *map,
 
 	args.arch = arch = arch__find(arch_name);
 	if (arch == NULL)
-		return -ENOTSUP;
+		return ENOTSUP;
 
 	if (parch)
 		*parch = arch;
-- 
2.21.0

