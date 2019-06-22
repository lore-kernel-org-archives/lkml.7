Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B94C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 06:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBBFD2070B
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 06:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="nIdM5RvC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbfFVGsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 02:48:07 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43077 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbfFVGsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 02:48:06 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5M6lwgB2009370
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 21 Jun 2019 23:47:58 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5M6lwgB2009370
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561186079;
        bh=ToNY+4/+kcq5cYAWpKj8iVLy+yIWMfvVL0atPf5Bx6E=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=nIdM5RvCHlCRgIn534rL/920Md1KsLYfIJbLo0uTAYY7sfwEf9GmJnmRgdQyLcZkZ
         dP/NV0S2eomcpzpgoCvirYm6OrkfaQxkJqWsdr08QVshf/k/M/9GBMOyWSkM7Yxyrc
         IHUN7pIqTYTyqJbnYFhdn0Ivzs10u4hIF/DLPCCm10lmPhd/iaAEyexOi7kU4FkCC4
         P4t/jXrZwQg5MuK0QJbe/ANztKqzGsBhh3alaDJG/V6ekgEgxXjNSntkD7xXsLgDb6
         FjBwOLJfzQpI4MjO3NKN8aZDO5Wwdw8EcvPRNL6X2vEfbu8R2WJBDu08TQ47YxKFII
         yOi6+xdI79+RA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5M6lwmF2009367;
        Fri, 21 Jun 2019 23:47:58 -0700
Date:   Fri, 21 Jun 2019 23:47:58 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-n1w59lpxks6m1le7fpo6rmyw@git.kernel.org>
Cc:     brendan.d.gregg@gmail.com, tglx@linutronix.de, acme@redhat.com,
        namhyung@kernel.org, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, mingo@kernel.org,
        lclaudio@redhat.com, jolsa@kernel.org
Reply-To: mingo@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
          adrian.hunter@intel.com, jolsa@kernel.org, lclaudio@redhat.com,
          tglx@linutronix.de, brendan.d.gregg@gmail.com,
          namhyung@kernel.org, acme@redhat.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace: Fixup pointer arithmetic when consuming
 augmented syscall args
Git-Commit-ID: 016f327ce48f9b0b1cdea729ba7080596113563f
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  016f327ce48f9b0b1cdea729ba7080596113563f
Gitweb:     https://git.kernel.org/tip/016f327ce48f9b0b1cdea729ba7080596113563f
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 14 Jun 2019 16:50:19 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 17 Jun 2019 15:57:19 -0300

perf trace: Fixup pointer arithmetic when consuming augmented syscall args

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
