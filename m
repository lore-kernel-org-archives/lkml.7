Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2CAC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 09:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C66425660
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 09:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="taNAEZaz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbfE3Jie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 05:38:34 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37400 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbfE3Jid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 05:38:33 -0400
Received: by mail-ot1-f67.google.com with SMTP id r10so4997820otd.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 02:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=z64OqaBKebP/IGWv/kYHRoni/+OEoO1da+k1V6PUKYs=;
        b=taNAEZazM5IQxDbQ2mFszG0wR4L81GyL8Ap+4mK1C4thAbnUHxhoyKSjldtfqzLsV0
         3z7MsKrcBT+S2M57pYMgvw0YQzde10soZ8rGblawSfQkUGbHZYqsrL6oR8feVKI4XiHR
         t4JaujT8q/ihoVuP9gn68k3ErB1wfeDBc2pS6RMXtuUstFv5nvZs0ZlYuKENfyZgNegI
         33oCc15MK3LnRxkAl1qH2a7CpXF2wc76FxX8E8X4ZlZ3wDptQ7pRWUoBsKzCqtNGKm33
         qa+fVH30kPtJgGwZ2UtaITKQa18pg3tj2qalI0ZojV8ARrBP4cHZx0CEk4lNphT1b/HI
         qSxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=z64OqaBKebP/IGWv/kYHRoni/+OEoO1da+k1V6PUKYs=;
        b=n1fey8qgKtF46jiO0Tazf91dgBBr33ghnWUFIvMitvAps6aIcQD0vYbAJVeyQ9g7Fw
         o0ftKPHpphdrPBc2/RmQgIwsX3lIXcgi0eqQ6Bl7jkCKvjAhy0no3tTaqafnVkvBcvdS
         GJggZ5RRn6+mxKOBbdKcgrdoAnJWFaIhhSZTMZtzfrEJtcUC3/j4Z5bAZum5h7Vs+T97
         gI97UwXTNIe3cPB3ZsEkMtS3APV1HRaccsh2+RoF40KIrvlV8SE3b3EUnUFOv+LoC2Jd
         i4NK2M8tFUECZZmbj05Pa+HKnS01TIzNhGe42/P65DwTLdMKa6BtTS+WOiE6+cT6gYCJ
         KaKw==
X-Gm-Message-State: APjAAAXnjnBoxwLq4kWWf6I6BNn2lAPgcrkCvVY0dPm+7LnnNTpfRbmm
        tl0khrDrgQxOK0Mb2d4g8swt3A==
X-Google-Smtp-Source: APXvYqxE42qqSq3/b3A52dqvsNMPY45C4CdoXVx6xSqZbXgF13nUjYtNHddR0pa3GAxe8EDTE3gMIQ==
X-Received: by 2002:a9d:6195:: with SMTP id g21mr37277otk.179.1559209112907;
        Thu, 30 May 2019 02:38:32 -0700 (PDT)
Received: from localhost.localdomain (li808-42.members.linode.com. [104.237.132.42])
        by smtp.gmail.com with ESMTPSA id t21sm844082otj.46.2019.05.30.02.38.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 02:38:31 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH] perf symbols: Remove unused variable 'err'
Date:   Thu, 30 May 2019 17:38:01 +0800
Message-Id: <20190530093801.20510-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable 'err' is defined but never used in function symsrc__init(),
remove it and directly return -1 at the end of the function.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/symbol-elf.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 4ad106a5f2c0..fdc5bd7dbb90 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -699,7 +699,6 @@ bool __weak elf__needs_adjust_symbols(GElf_Ehdr ehdr)
 int symsrc__init(struct symsrc *ss, struct dso *dso, const char *name,
 		 enum dso_binary_type type)
 {
-	int err = -1;
 	GElf_Ehdr ehdr;
 	Elf *elf;
 	int fd;
@@ -793,7 +792,7 @@ int symsrc__init(struct symsrc *ss, struct dso *dso, const char *name,
 	elf_end(elf);
 out_close:
 	close(fd);
-	return err;
+	return -1;
 }
 
 /**
-- 
2.17.1

