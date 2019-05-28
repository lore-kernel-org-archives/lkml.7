Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37483C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 21:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C5BC2075B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 21:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="eylaPdfE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbfE1VaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 17:30:21 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57419 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727379AbfE1VaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 17:30:20 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4SLT0ME2240691
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 28 May 2019 14:29:01 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4SLT0ME2240691
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559078941;
        bh=tQNsMs0TRa8lDs2oQqcZTf0IymSwdCblBMJnjnLXlWE=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=eylaPdfEeZG0FBijKssapop7ZdiwiiTyVP950jC4Rz3b0ulQzHoeeSzvpXecCg7Vi
         OtPAtI+uL6cSRv8R5NnkEaMiBEN83nBY4cY1wNvNGp87hzFpqQuZ5dKj+B67/Z38g1
         Bem5mCFnw9Jhqk/XyoXMGsxHyMr9f4fyw+8kOLwKr/2qhEXuuf8Z+jtp0nyJmMpq7C
         NOePNs6HJ0cHf+elvoNCo5KJ+Ry6ZhUbzbbJosbtLXtvc4uf76FuLGqHTNZp4vGuHd
         XM5qAWIJ9VeTMKehwJflR6S9pRcdS9sLA3aH+U9F4/2rXQgdOz4hnAIj6ucJ1conu4
         xFZgMCTzSdeaw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4SLT0382240688;
        Tue, 28 May 2019 14:29:00 -0700
Date:   Tue, 28 May 2019 14:29:00 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-qfwuih8cvmk9doh7k5k244eq@git.kernel.org>
Cc:     peterz@infradead.org, namhyung@kernel.org, acme@redhat.com,
        ak@linux.intel.com, linux-kernel@vger.kernel.org, jolsa@kernel.org,
        tmricht@linux.ibm.com, adrian.hunter@intel.com,
        songliubraving@fb.com, alexander.shishkin@linux.intel.com,
        mingo@kernel.org, tglx@linutronix.de, sdf@google.com, hpa@zytor.com
Reply-To: jolsa@kernel.org, tmricht@linux.ibm.com, adrian.hunter@intel.com,
          linux-kernel@vger.kernel.org, ak@linux.intel.com,
          acme@redhat.com, namhyung@kernel.org, peterz@infradead.org,
          hpa@zytor.com, tglx@linutronix.de, sdf@google.com,
          alexander.shishkin@linux.intel.com, mingo@kernel.org,
          songliubraving@fb.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf test vmlinux-kallsyms: Ignore aliases to
 _etext when searching on kallsyms
Git-Commit-ID: 93f678b9ae8feb7f7cec29c2dcbb5756ad22d9a1
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

Commit-ID:  93f678b9ae8feb7f7cec29c2dcbb5756ad22d9a1
Gitweb:     https://git.kernel.org/tip/93f678b9ae8feb7f7cec29c2dcbb5756ad22d9a1
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 24 May 2019 15:39:00 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 28 May 2019 09:52:23 -0300

perf test vmlinux-kallsyms: Ignore aliases to _etext when searching on kallsyms

No need to search for aliases for the symbol that marks the end of the
kernel text segment, the following patch will make such symbols not to
be found when searching in the kallsyms maps causing this test to fail.

So as a prep patch to avoid breaking bisection, ignore such symbols.

Tested-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Stanislav Fomichev <sdf@google.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Link: https://lkml.kernel.org/n/tip-qfwuih8cvmk9doh7k5k244eq@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/vmlinux-kallsyms.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/vmlinux-kallsyms.c b/tools/perf/tests/vmlinux-kallsyms.c
index 7691980b7df1..f101576d1c72 100644
--- a/tools/perf/tests/vmlinux-kallsyms.c
+++ b/tools/perf/tests/vmlinux-kallsyms.c
@@ -161,9 +161,16 @@ next_pair:
 
 				continue;
 			}
-		} else
+		} else if (mem_start == kallsyms.vmlinux_map->end) {
+			/*
+			 * Ignore aliases to _etext, i.e. to the end of the kernel text area,
+			 * such as __indirect_thunk_end.
+			 */
+			continue;
+		} else {
 			pr_debug("ERR : %#" PRIx64 ": %s not on kallsyms\n",
 				 mem_start, sym->name);
+		}
 
 		err = -1;
 	}
