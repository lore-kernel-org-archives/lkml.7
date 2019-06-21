Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F75C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 17:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E534A21537
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 17:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561138874;
	bh=+qK84BAps1j7VkvEwGzBLN2AZRxGDsH7iIVCI8pVNm4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IcURSluaYgDdDXchKxVYUpXMBidJ8TalEpnF0S/gd21X9oYb0UHlETFBOoucYraGe
	 RsT8F1m1/d8W/I6q/XG852dT1L/ID7xaSpIWx8NBvL+fG0NZvhkVI0qGTyn2CyWwaz
	 wCFeg82+/iGoTMYQnM5f+B3QFhsM2Uu9/YXGfllM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbfFURlN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 13:41:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:60202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726591AbfFURlJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 13:41:09 -0400
Received: from quaco.ghostprotocols.net (187-26-104-93.3g.claro.net.br [187.26.104.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF2FC2083B;
        Fri, 21 Jun 2019 17:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561138868;
        bh=+qK84BAps1j7VkvEwGzBLN2AZRxGDsH7iIVCI8pVNm4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=imcz3/sYzCHOWTSjHSwYIDyhnXJM0kdviAbmoCeHadZVDk1hDDP/3oS77RMvxqvOW
         goGDFFxncZprx384DqJtFPeBNeAtopf3diolQMyumPbtaHyKJRVOmsFlq+I/RP+Ecl
         cVtFWWfwM66WKH6D1wV1AMdtAj7SZX5czyAdJYsI=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>
Subject: [PATCH 20/25] perf trace: Fixup pointer arithmetic when consuming augmented syscall args
Date:   Fri, 21 Jun 2019 14:38:26 -0300
Message-Id: <20190621173831.13780-21-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190621173831.13780-1-acme@kernel.org>
References: <20190621173831.13780-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We can't just add the consumed bytes to the arg->augmented.args member,
as it is not void *, so it will access (consumed * sizeof(struct augmented_arg))
in the next augmented arg, totally wrong, cast the member to void pointe
before adding the number of bytes consumed, duh.

With this and hardcoding handling the 'renameat' and 'renameat2'
syscalls in the tools/perf/examples/bpf/augmented_raw_syscalls.c eBPF
proggie, we get:

	mv/24388 renameat2(AT_FDCWD, "/tmp/build/perf/util/.bpf-event.o.tmp", AT_FDCWD, "/tmp/build/perf/util/.bpf-event.o.cmd", RENAME_NOREPLACE) = 0
	mv/24394 renameat2(AT_FDCWD, "/tmp/build/perf/util/.perf-hooks.o.tmp", AT_FDCWD, "/tmp/build/perf/util/.perf-hooks.o.cmd", RENAME_NOREPLACE) = 0
	mv/24398 renameat2(AT_FDCWD, "/tmp/build/perf/util/.pmu-bison.o.tmp", AT_FDCWD, "/tmp/build/perf/util/.pmu-bison.o.cmd", RENAME_NOREPLACE) = 0
	mv/24401 renameat2(AT_FDCWD, "/tmp/build/perf/util/.expr-bison.o.tmp", AT_FDCWD, "/tmp/build/perf/util/.expr-bison.o.cmd", RENAME_NOREPLACE) = 0
	mv/24406 renameat2(AT_FDCWD, "/tmp/build/perf/util/.pmu.o.tmp", AT_FDCWD, "/tmp/build/perf/util/.pmu.o.cmd", RENAME_NOREPLACE) = 0
	mv/24407 renameat2(AT_FDCWD, "/tmp/build/perf/util/.pmu-flex.o.tmp", AT_FDCWD, "/tmp/build/perf/util/.pmu-flex.o.cmd", RENAME_NOREPLACE) = 0
	mv/24416 renameat2(AT_FDCWD, "/tmp/build/perf/util/.parse-events-flex.o.tmp", AT_FDCWD, "/tmp/build/perf/util/.parse-events-flex.o.cmd", RENAME_NOREPLACE) = 0

I.e. it works with two string args in the same syscall.

Now back to taming the verifier...

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Fixes: 8195168e8779 ("perf trace: Consume the augmented_raw_syscalls payload")
Link: https://lkml.kernel.org/n/tip-n1w59lpxks6m1le7fpo6rmyw@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index d5b2e4d8bf41..f3532b081b31 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1239,7 +1239,7 @@ static size_t syscall_arg__scnprintf_augmented_string(struct syscall_arg *arg, c
 	 */
 	int consumed = sizeof(*augmented_arg) + augmented_arg->size;
 
-	arg->augmented.args += consumed;
+	arg->augmented.args = ((void *)arg->augmented.args) + consumed;
 	arg->augmented.size -= consumed;
 
 	return printed;
-- 
2.20.1

