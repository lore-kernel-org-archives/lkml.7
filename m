Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF4CFA372A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 16:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 941B221A4C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 16:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571328205;
	bh=5rjSNoxPE9fD3sIR5BPxdqJYQ5b4yQqoWp+8NmhjCXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qGmbt8dYTCkTUhRwNm8nFxCtToK0J2WzS08Jn/eiawuQ3KhxOS8a9SrYJ0lWRuZtJ
	 GmN6VbAM5sHo2v5SqSsD0hHcTjBfin9sgHXJqLYKAzDI2YUn3OmWdsVrvIO7Jas4t5
	 UehE+wkRNu8ZC04CIVnjnEQ8clbK9iDZhizAWDJ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440091AbfJQQDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 12:03:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:46778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725294AbfJQQDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 12:03:23 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51D3A21925;
        Thu, 17 Oct 2019 16:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571328202;
        bh=5rjSNoxPE9fD3sIR5BPxdqJYQ5b4yQqoWp+8NmhjCXY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=asIo83PHuw34j73wIB8+kAgrSij6y64qkAQ5YYwNRbgLwq6bpGhtLwVbAaHQlI4/W
         IW1wt9Zc7PYxI709XYgrR8i4FMnQaKpe2q0oxhLBnyKkbMr3jDj/Qa/pXfaES+9VfL
         qsGboyQR36pE58UnCdPjxlQMuojO3S7jpER/64us=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 04/11] perf annotate: Fix multiple memory and file descriptor leaks
Date:   Thu, 17 Oct 2019 13:02:54 -0300
Message-Id: <20191017160301.20888-5-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191017160301.20888-1-acme@kernel.org>
References: <20191017160301.20888-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>

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
---
 tools/perf/util/annotate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 4036c7f7b0fb..e42bf572358c 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1758,7 +1758,7 @@ static int symbol__disassemble_bpf(struct symbol *sym,
 	info_node = perf_env__find_bpf_prog_info(dso->bpf_prog.env,
 						 dso->bpf_prog.id);
 	if (!info_node) {
-		return SYMBOL_ANNOTATE_ERRNO__BPF_MISSING_BTF;
+		ret = SYMBOL_ANNOTATE_ERRNO__BPF_MISSING_BTF;
 		goto out;
 	}
 	info_linear = info_node->info_linear;
-- 
2.21.0

