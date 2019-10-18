Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABBBCA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FFB120872
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571437200;
	bh=hSjRkGT17dgtKhT8LMQ6TAdF8ewyqXN8GSxpj1Z9EVA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0GKZTBlP/ichdrqVbuz0AGeoUVq4Yioi6Tv6UipP0cPVzQF6YMf1yFZFgznlVaoBl
	 9/w/akidx+02nKw0S8D7A6OJM84xrb/vUrYIgwRsp5pqfionr8v3F5RXS3XszvzOyp
	 IaCTwobg7VQkqD80sUEY2Xx//Ta30au1AQNuXolw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730736AbfJRWT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 18:19:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:38980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732100AbfJRWGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 18:06:54 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 915B5222D1;
        Fri, 18 Oct 2019 22:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571436413;
        bh=hSjRkGT17dgtKhT8LMQ6TAdF8ewyqXN8GSxpj1Z9EVA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WZ1qPpr+MgbY+reNET+IPKL2CtrxFmli5lHJRGxM+uKsgxDuje0Wm5Lg9+EPEYf2U
         KLg8cEYBob8evLJ+e7mwEM8YwgxBdsQJXblDGZhIyKsiWhWVA9F4qufOGPZFKeMT7w
         0xn+WRH3ctcqjF76c/gqiaWaYOv6217N5SRkgCzY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 058/100] perf annotate: Propagate perf_env__arch() error
Date:   Fri, 18 Oct 2019 18:04:43 -0400
Message-Id: <20191018220525.9042-58-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191018220525.9042-1-sashal@kernel.org>
References: <20191018220525.9042-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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

