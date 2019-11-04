Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A84B6CA9EC9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79F8D20650
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572906023;
	bh=hSjRkGT17dgtKhT8LMQ6TAdF8ewyqXN8GSxpj1Z9EVA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d2jM6PVqaIpcawsoBX/vM94eOTCdZrtobS5Si639zPDHy/DNMBYuxSZISn5LkFyyW
	 uW9Vj+J3F5ZiT+y3vi1B09F3ecHAGIk/KlA8sRN4lC2Jdr+N2o4++JiOjYUi167XGA
	 Q0Y96cj+J/fwArUNcRoLBAOhsjNn0jGV/U3CdjQ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388722AbfKDV7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 16:59:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:56882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388308AbfKDV7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 16:59:39 -0500
Received: from localhost (6.204-14-84.ripe.coltfrance.com [84.14.204.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA04020650;
        Mon,  4 Nov 2019 21:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572904778;
        bh=hSjRkGT17dgtKhT8LMQ6TAdF8ewyqXN8GSxpj1Z9EVA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OIejQO1dTtA8vB6EUV4ZiIrnBc3qNXfqIDmZHve8//L4am9PoMJwqxIJdj0jr9tZw
         cEDOHLlc2JrPKw/BAyuwTB8g0tG3DTnsGYKTlggh8ObTFlzL1ihHwotjEQ/p/79U0M
         JmXKZo9ae/uj7fpvXaBXeQbJPNHQ7HZTt3LXfIWE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Will Deacon <will@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 4.19 066/149] perf annotate: Propagate perf_env__arch() error
Date:   Mon,  4 Nov 2019 22:44:19 +0100
Message-Id: <20191104212141.372085138@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104212126.090054740@linuxfoundation.org>
References: <20191104212126.090054740@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

[ Upstream commit a66fa0619a0ae3585ef09e9c33ecfb5c7c6cb72b ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/annotate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index daea1fdf73856..4ef62bcdc80f0 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1871,7 +1871,7 @@ int symbol__annotate(struct symbol *sym, struct map *map,
 	int err;
 
 	if (!arch_name)
-		return -1;
+		return errno;
 
 	args.arch = arch = arch__find(arch_name);
 	if (arch == NULL)
-- 
2.20.1



