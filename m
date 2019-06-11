Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C95CC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5964721841
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560279907;
	bh=DaiUIK2AbpOxeSYqzvgO5D33dU7Q5HQyX6dITJgvpKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cRX5EMnuIyTJbNOJHOah3Dw6cfuKcf8f7dVCdzH7TfiSk/bh3tbSnouw4Fb18GN1p
	 +JaDNqR4JbHni66lAfqZHRoF0xki5RR/2rrKvKf/yXzCQPQ4//M10yiouDgX9JB6Zu
	 PwprVfioQHqAvU4Za8mndAzhBstErJDvaJGQatkw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407410AbfFKTFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 15:05:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:41298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407398AbfFKTFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 15:05:04 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B42D2183E;
        Tue, 11 Jun 2019 19:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560279903;
        bh=DaiUIK2AbpOxeSYqzvgO5D33dU7Q5HQyX6dITJgvpKY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2Id+fTmve6OkQVoxKf4SE4HJqt4deLk4Af5crKtDcmbbcqP5OFTgKpOheEr/Z8FMR
         WfnbAcJT170nlJA29evureShvH3E5IXETERFRxXkQFRbAcg+5GUV0kBZ+m2cBMCUhu
         jUN/8TuDri+trz0e+SFF+riaTESboHgvm5KALriM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Thomas Richter <tmricht@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 83/85] perf report: Fix OOM error in TUI mode on s390
Date:   Tue, 11 Jun 2019 15:59:09 -0300
Message-Id: <20190611185911.11645-84-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611185911.11645-1-acme@kernel.org>
References: <20190611185911.11645-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Richter <tmricht@linux.ibm.com>

Debugging a OOM error using the TUI interface revealed this issue
on s390:

[tmricht@m83lp54 perf]$ cat /proc/kallsyms |sort
....
00000001119b7158 B radix_tree_node_cachep
00000001119b8000 B __bss_stop
00000001119b8000 B _end
000003ff80002850 t autofs_mount	[autofs4]
000003ff80002868 t autofs_show_options	[autofs4]
000003ff80002a98 t autofs_evict_inode	[autofs4]
....

There is a huge gap between the last kernel symbol
__bss_stop/_end and the first kernel module symbol
autofs_mount (from autofs4 module).

After reading the kernel symbol table via functions:

 dso__load()
 +--> dso__load_kernel_sym()
      +--> dso__load_kallsyms()
	   +--> __dso_load_kallsyms()
	        +--> symbols__fixup_end()

the symbol __bss_stop has a start address of 1119b8000 and
an end address of 3ff80002850, as can be seen by this debug statement:

  symbols__fixup_end __bss_stop start:0x1119b8000 end:0x3ff80002850

The size of symbol __bss_stop is 0x3fe6e64a850 bytes!
It is the last kernel symbol and fills up the space until
the first kernel module symbol.

This size kills the TUI interface when executing the following
code:

  process_sample_event()
    hist_entry_iter__add()
      hist_iter__report_callback()
        hist_entry__inc_addr_samples()
          symbol__inc_addr_samples(symbol = __bss_stop)
            symbol__cycles_hist()
               annotated_source__alloc_histograms(...,
				                symbol__size(sym),
		                                ...)

This function allocates memory to save sample histograms.
The symbol_size() marco is defined as sym->end - sym->start, which
results in above value of 0x3fe6e64a850 bytes and
the call to calloc() in annotated_source__alloc_histograms() fails.

The histgram memory allocation might fail, make this failure
no-fatal and continue processing.

Output before:
[tmricht@m83lp54 perf]$ ./perf --debug stderr=1 report -vvvvv \
					      -i ~/slow.data 2>/tmp/2
[tmricht@m83lp54 perf]$ tail -5 /tmp/2
  __symbol__inc_addr_samples(875): ENOMEM! sym->name=__bss_stop,
		start=0x1119b8000, addr=0x2aa0005eb08, end=0x3ff80002850,
		func: 0
problem adding hist entry, skipping event
0x938b8 [0x8]: failed to process type: 68 [Cannot allocate memory]
[tmricht@m83lp54 perf]$

Output after:
[tmricht@m83lp54 perf]$ ./perf --debug stderr=1 report -vvvvv \
					      -i ~/slow.data 2>/tmp/2
[tmricht@m83lp54 perf]$ tail -5 /tmp/2
   symbol__inc_addr_samples map:0x1597830 start:0x110730000 end:0x3ff80002850
   symbol__hists notes->src:0x2aa2a70 nr_hists:1
   symbol__inc_addr_samples sym:unlink_anon_vmas src:0x2aa2a70
   __symbol__inc_addr_samples: addr=0x11094c69e
   0x11094c670 unlink_anon_vmas: period++ [addr: 0x11094c69e, 0x2e, evidx=0]
   	=> nr_samples: 1, period: 526008
[tmricht@m83lp54 perf]$

There is no error about failed memory allocation and the TUI interface
shows all entries.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Link: http://lkml.kernel.org/r/90cb5607-3e12-5167-682d-978eba7dafa8@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 0b8573fd9b05..15be9d271f55 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -932,9 +932,8 @@ static int symbol__inc_addr_samples(struct symbol *sym, struct map *map,
 	if (sym == NULL)
 		return 0;
 	src = symbol__hists(sym, evsel->evlist->nr_entries);
-	if (src == NULL)
-		return -ENOMEM;
-	return __symbol__inc_addr_samples(sym, map, src, evsel->idx, addr, sample);
+	return (src) ?  __symbol__inc_addr_samples(sym, map, src, evsel->idx,
+						   addr, sample) : 0;
 }
 
 static int symbol__account_cycles(u64 addr, u64 start,
-- 
2.20.1

