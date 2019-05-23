Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10ACBC04AAC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 08:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC94A20862
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 08:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbfEWIZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 04:25:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41980 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725814AbfEWIZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 04:25:31 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4N8NfPN013210
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 04:25:30 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2snqnn910j-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 04:25:30 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tmricht@linux.ibm.com>;
        Thu, 23 May 2019 09:25:27 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 23 May 2019 09:25:25 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4N8POVn27721754
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 May 2019 08:25:24 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 00B39A4062;
        Thu, 23 May 2019 08:25:24 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AD729A405C;
        Thu, 23 May 2019 08:25:23 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 23 May 2019 08:25:23 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     brueckner@linux.vnet.ibm.com, heiko.carstens@de.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCHv2] perf report: Fix OOM error in TUI mode on s390
Date:   Thu, 23 May 2019 10:25:21 +0200
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
x-cbid: 19052308-0028-0000-0000-000003709C83
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052308-0029-0000-0000-000024304D91
Message-Id: <20190523082521.78080-1-tmricht@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-23_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905230060
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
2.19.1

