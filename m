Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29CC9CA9EC9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E52AE21929
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572905265;
	bh=7sswNqk+vSRcaPxXaAyNYYTr8uidR7ZgpcGDrKXJKns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u9SSnFOpj17nmwi7OOo6ZcinSa3HijIaC+FEhwBKGt6hKqfloPXm3cClwuWb+z3ie
	 xTOixljbp/hqoHvlheGDJGERPVxbblDOoRe48Huf4PhB8K+2Oh2soeFuA+zXen81eW
	 GYTCJsUfd9EX76UFZ9raxVVWk09cL9npeUQsfgDk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390160AbfKDWHn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 17:07:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:40298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388225AbfKDWHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 17:07:41 -0500
Received: from localhost (6.204-14-84.ripe.coltfrance.com [84.14.204.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CBA7214D9;
        Mon,  4 Nov 2019 22:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572905260;
        bh=7sswNqk+vSRcaPxXaAyNYYTr8uidR7ZgpcGDrKXJKns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0k4s4jkTEEy86MabToV+PKNkS47fleUgaSz9ZxYv8vL4RA32SnEIV3LX/qODjVn7j
         MV9J9gh76YX5vnMWcj3VUpnMj+RF8PPWWaRNnejfibzHSn2lmnADR4hNR6RVhbhaqj
         TYht4P4h1myny3lN55hN3VbaR1ywOyFOr8W4POfE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 083/163] perf annotate: Fix multiple memory and file descriptor leaks
Date:   Mon,  4 Nov 2019 22:44:33 +0100
Message-Id: <20191104212146.297059666@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104212140.046021995@linuxfoundation.org>
References: <20191104212140.046021995@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gustavo A. R. Silva <gustavo@embeddedor.com>

[ Upstream commit f948eb45e3af9fb18a0487d0797a773897ef6929 ]

Store SYMBOL_ANNOTATE_ERRNO__BPF_MISSING_BTF in variable *ret*, instead
of returning in the middle of the function and leaking multiple
resources: prog_linfo, btf, s and bfdf.

Addresses-Coverity-ID: 1454832 ("Structurally dead code")
Fixes: 11aad897f6d1 ("perf annotate: Don't return -1 for error when doing BPF disassembly")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20191014171047.GA30850@embeddedor
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/annotate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index fb8756026a805..2e02d2a0176a8 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1752,7 +1752,7 @@ static int symbol__disassemble_bpf(struct symbol *sym,
 	info_node = perf_env__find_bpf_prog_info(dso->bpf_prog.env,
 						 dso->bpf_prog.id);
 	if (!info_node) {
-		return SYMBOL_ANNOTATE_ERRNO__BPF_MISSING_BTF;
+		ret = SYMBOL_ANNOTATE_ERRNO__BPF_MISSING_BTF;
 		goto out;
 	}
 	info_linear = info_node->info_linear;
-- 
2.20.1



