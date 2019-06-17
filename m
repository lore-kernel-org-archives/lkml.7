Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BADEC31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 09:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E06E62080C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 09:12:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A97y2r8a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbfFQJMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 05:12:13 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46014 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbfFQJMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 05:12:12 -0400
Received: by mail-ot1-f66.google.com with SMTP id x21so8543789otq.12
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 02:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XkQKkEqj0Dk+yMwwMUT9kq+YcOABBfUMfQA+OLQkIhs=;
        b=A97y2r8a4SElnnqWxEgYt9hqzUlV/cOq2E2WwDSEdCBsMl4m9cFtY2fwwCpdvcakGW
         awt+SV7bLv8nxXRVmEnrNMG5nFwayb31HFNIpLayWLPTVlHkQNzKb7SuHGb/q/kFN1iG
         KVV5NavH8nIx9y83mXraGlVjJ8aelPhg8mONarGKKwUmLvP7zgFt9KexSKptxXiLGBtB
         AghmJ9J5muwb89JeCF2VbT9c8bxFbPOzohfyudUTv0h+bt9tmpFijVpS7R1W1toW/CwL
         o9HaBfx9fAnEFi8vjuByIGu5qiqhE5bzRO7ym7pfTmOyYah4LXxvPFkfhV2bB4XvMmBB
         qZjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XkQKkEqj0Dk+yMwwMUT9kq+YcOABBfUMfQA+OLQkIhs=;
        b=Zv17fUOqDrR5uXhzs1TPTcIAeuc4glU91hCBkm94dS70PmgChUkz60VvuLMTqZhpJS
         +XprgPQkPfszf8lmenkzYwIjGJf7Hy1+SRp9GGo9JrNZWj8cXD4aUmVUdnh69Roz4qtd
         8U8MRVyTk1NgzSc01EhKuPwpDfN9T3girYQZPTudILsyNC1hzsxWjvzsS5mknLGeuhlL
         B1dwmWH9xZsCLTTg35iQKyg+mA4nGn6D5sBRwCDo4gbPvf1uh9uuwGVwRC62ZiVyw0HO
         CeWiju+B997MWnyLIBGneD/03rbsMrCq3o1Xeosam3hVRDCvsFOaxwVQ4N03GCd93aen
         2g3Q==
X-Gm-Message-State: APjAAAXTtiimRw6sN647JorYjGNJsvsmx6oozGmplZgzj+Qc8eQ4fID4
        l3Jj2gUjSISUGrViQGgu9WRVGA==
X-Google-Smtp-Source: APXvYqwsv0A5/ztfsCZbU16h7iBULFGTI4PThp2tCsCGD02xzLu83QPfwHz3CgMUuRTE/EiYGmWv6w==
X-Received: by 2002:a9d:4b88:: with SMTP id k8mr61017358otf.285.1560762731712;
        Mon, 17 Jun 2019 02:12:11 -0700 (PDT)
Received: from localhost.localdomain (li964-79.members.linode.com. [45.33.10.79])
        by smtp.gmail.com with ESMTPSA id l145sm4418324oib.6.2019.06.17.02.12.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 02:12:11 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH 2/2] perf trace: Handle NULL pointer dereference in trace__syscall_info()
Date:   Mon, 17 Jun 2019 17:11:40 +0800
Message-Id: <20190617091140.24372-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190617091140.24372-1-leo.yan@linaro.org>
References: <20190617091140.24372-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

trace__init_bpf_map_syscall_args() invokes trace__syscall_info() to
retrieve system calls information, it always passes NULL for 'evsel'
argument; when id is an invalid value then the logging will try to
output event name, this triggers NULL pointer dereference.

This patch directly uses string "unknown" for event name when 'evsel'
is NULL pointer.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 5cd74651db4c..49dfb2fd393b 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1764,7 +1764,7 @@ static struct syscall *trace__syscall_info(struct trace *trace,
 		static u64 n;
 
 		pr_debug("Invalid syscall %d id, skipping (%s, %" PRIu64 ")\n",
-			 id, perf_evsel__name(evsel), ++n);
+			 id, evsel ? perf_evsel__name(evsel) : "unknown", ++n);
 		return NULL;
 	}
 
-- 
2.17.1

