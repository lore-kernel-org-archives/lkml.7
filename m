Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13E7C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 711BF218CD
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553907239;
	bh=GdBg80LFIB6aFg2sYpd1uRe9iJBdJcaEHuSgYtGAaRs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FGS4srnztCUneE4sNUrbT3qOWZFn+AIodYc4cE+zGNcqwVWCqmI7MYavBvl8dsDvX
	 RasVgsEqoLKYM6hHxYK1dmWtd8It+PRlLiIliVAktOKskpO7Pk2gTktuT7fHFmu812
	 iB+1c8uxxDmBKs3rgBeO6txfyfi44oN1Yxh6g6t0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731404AbfC3Ax6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 20:53:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:60858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731392AbfC3Axz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 20:53:55 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFE0A218AC;
        Sat, 30 Mar 2019 00:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553907235;
        bh=GdBg80LFIB6aFg2sYpd1uRe9iJBdJcaEHuSgYtGAaRs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e8NxzPF0ubKsST6b8TTaaERo67fbpFNluu97FJH0tH0HZuw7T6IkZkbXvZLJwWj+Y
         pOzZUQph7F2yBtM1XvJhZvZGTlE1Y/2xCF+BsIekexJ6acv1oB9bphQXe0xhNlv/e5
         ubwPwy+QybaBWlFF82sVHe3IvHrJPzEyWc7uVi4s=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Changbin Du <changbin.du@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Taeung Song <treeze.taeung@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 30/52] perf config: Fix a memory leak in collect_config()
Date:   Fri, 29 Mar 2019 20:52:37 -0400
Message-Id: <20190330005301.26868-30-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330005301.26868-1-sashal@kernel.org>
References: <20190330005301.26868-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changbin Du <changbin.du@gmail.com>

[ Upstream commit 54569ba4b06d5baedae4614bde33a25a191473ba ]

Detected with gcc's ASan:

  Direct leak of 66 byte(s) in 5 object(s) allocated from:
      #0 0x7ff3b1f32070 in __interceptor_strdup (/usr/lib/x86_64-linux-gnu/libasan.so.5+0x3b070)
      #1 0x560c8761034d in collect_config util/config.c:597
      #2 0x560c8760d9cb in get_value util/config.c:169
      #3 0x560c8760dfd7 in perf_parse_file util/config.c:285
      #4 0x560c8760e0d2 in perf_config_from_file util/config.c:476
      #5 0x560c876108fd in perf_config_set__init util/config.c:661
      #6 0x560c87610c72 in perf_config_set__new util/config.c:709
      #7 0x560c87610d2f in perf_config__init util/config.c:718
      #8 0x560c87610e5d in perf_config util/config.c:730
      #9 0x560c875ddea0 in main /home/changbin/work/linux/tools/perf/perf.c:442
      #10 0x7ff3afb8609a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x2409a)

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Taeung Song <treeze.taeung@gmail.com>
Fixes: 20105ca1240c ("perf config: Introduce perf_config_set class")
Link: http://lkml.kernel.org/r/20190316080556.3075-6-changbin.du@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/config.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
index 5ac157056cdf..9bb742accfa5 100644
--- a/tools/perf/util/config.c
+++ b/tools/perf/util/config.c
@@ -628,11 +628,10 @@ static int collect_config(const char *var, const char *value,
 	}
 
 	ret = set_value(item, value);
-	return ret;
 
 out_free:
 	free(key);
-	return -1;
+	return ret;
 }
 
 int perf_config_set__collect(struct perf_config_set *set, const char *file_name,
-- 
2.19.1

