Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA2F4C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 889B720863
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="j1wZziqB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbfFQTwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 15:52:34 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41375 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbfFQTwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:52:33 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HJqDTq3570763
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 12:52:13 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HJqDTq3570763
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560801134;
        bh=9UGAo82x9irO9xkBSNX7/KgQPnKx5nHv7uIX6YoMDA4=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=j1wZziqBaIUF5Z+Ii6ObzviWPcpAnLF61BFXPOMkV4oc8iksxIqVMg0pj1Ki/f5Xg
         bMwVsHLq7FM5U7Xe/lnzFnCmt5Qt1ai64WqMpkl3l1LgtLAcCTJsRtZpIZ2GgQHz4T
         a8b0yS0d4vqk4bClTaXZXOvkMo0rCp/oNLl3KpljSLCXF5dRMHuutR2hAAbEj4envX
         G6Sva0dGn1Fu+6IubLPfn+T9SCLBIfrOXmDXLyQbKWv4AMVvVWWvz/rYPzzVa/yrAv
         Lx9YZUEZFDIXfg+yro6iijPzhWHpRCPCKRWRvW0IGjIDYC0MndCqyKcPhOOVUKqY19
         kyG1aLJ/XF81g==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HJqD5e3570759;
        Mon, 17 Jun 2019 12:52:13 -0700
Date:   Mon, 17 Jun 2019 12:52:13 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Richter <tipbot@zytor.com>
Message-ID: <tip-8a07aa4e9b7b0222129c07afff81634a884b2866@git.kernel.org>
Cc:     brueckner@linux.ibm.com, mingo@kernel.org,
        heiko.carstens@de.ibm.com, hpa@zytor.com, tglx@linutronix.de,
        tmricht@linux.ibm.com, acme@redhat.com,
        brueckner@linux.vnet.ibm.com, linux-kernel@vger.kernel.org
Reply-To: tmricht@linux.ibm.com, acme@redhat.com,
          brueckner@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, heiko.carstens@de.ibm.com, hpa@zytor.com,
          brueckner@linux.ibm.com, mingo@kernel.org
In-Reply-To: <90cb5607-3e12-5167-682d-978eba7dafa8@linux.ibm.com>
References: <90cb5607-3e12-5167-682d-978eba7dafa8@linux.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf report: Fix OOM error in TUI mode on s390
Git-Commit-ID: 8a07aa4e9b7b0222129c07afff81634a884b2866
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

Commit-ID:  8a07aa4e9b7b0222129c07afff81634a884b2866
Gitweb:     https://git.kernel.org/tip/8a07aa4e9b7b0222129c07afff81634a884b2866
Author:     Thomas Richter <tmricht@linux.ibm.com>
AuthorDate: Thu, 23 May 2019 10:25:21 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 10 Jun 2019 16:20:13 -0300

perf report: Fix OOM error in TUI mode on s390

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
