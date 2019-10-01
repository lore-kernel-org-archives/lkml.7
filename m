Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B1FC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1D8A21D80
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569928430;
	bh=j7IKgNAX3IdJv8UUoAjn3gR4kQ88mkiLcCvrkBhxa4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0AOPVOTAFuhQeECLQgwpp9cQniqEfbRCAdxwNenE6D06Nv0w06NXbo0mxB+1PzQIW
	 DALttSxN0yIPPWTMBS9Ic48gHcfSDP4piQUVoeyrmJqm4cvbx7NMoom228TcueY180
	 m8RkDyq2dbACo8WfqkJ02103TzZCMKCfqNTxY3QM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732065AbfJALNu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 07:13:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:35786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731944AbfJALNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 07:13:48 -0400
Received: from quaco.ghostprotocols.net (177.206.223.101.dynamic.adsl.gvt.net.br [177.206.223.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E74E21A4A;
        Tue,  1 Oct 2019 11:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569928427;
        bh=j7IKgNAX3IdJv8UUoAjn3gR4kQ88mkiLcCvrkBhxa4w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SHhZ61+jTBhS/sJiFSNNJnxZSazcPXvFU1qEF85rFmf/zlSF+zi6gfVp8+7n0mMRd
         0sGrbvpNhkjISi+Nt3Gzkc3yovylcZbI4fNPLdTosl8HsBFDvV5SkzGgM0DQ//YbVI
         1+nJ0amRZKXYmwfZOFpzyPPLUw2/+TFUY8j31++8=
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
Subject: [PATCH 19/24] perf annotate: Propagate perf_env__arch() error
Date:   Tue,  1 Oct 2019 08:12:11 -0300
Message-Id: <20191001111216.7208-20-acme@kernel.org>
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

The callers of symbol__annotate2() use symbol__strerror_disassemble() to
convert its failure returns into a human readable string, so
propagate error values from functions it calls, starting with
perf_env__arch() that when fails the right thing to do is to look at
'errno' to see why its possible call to uname() failed.

Reported-by: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
Cc: Will Deacon <will@kernel.org>
Link: https://lkml.kernel.org/n/tip-it5d83kyusfhb1q1b0l4pxzs@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index e830eadfca2a..9b7b9176e713 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2071,7 +2071,7 @@ int symbol__annotate(struct symbol *sym, struct map *map,
 	int err;
 
 	if (!arch_name)
-		return -1;
+		return errno;
 
 	args.arch = arch = arch__find(arch_name);
 	if (arch == NULL)
-- 
2.21.0

