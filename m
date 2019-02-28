Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1306C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AE81218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731779AbfB1Hsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 02:48:52 -0500
Received: from terminus.zytor.com ([198.137.202.136]:56075 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725918AbfB1Hsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 02:48:52 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1S7mUj92950559
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 27 Feb 2019 23:48:30 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1S7mTfo2950556;
        Wed, 27 Feb 2019 23:48:29 -0800
Date:   Wed, 27 Feb 2019 23:48:29 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Wei Li <tipbot@zytor.com>
Message-ID: <tip-11db1ad4513d6205d2519e1a30ff4cef746e3243@git.kernel.org>
Cc:     peterz@infradead.org, hpa@zytor.com, acme@redhat.com,
        mingo@kernel.org, liwei391@huawei.com, jolsa@kernel.org,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        yao.jin@linux.intel.com, alexander.shishkin@linux.intel.com,
        tglx@linutronix.de
Reply-To: hpa@zytor.com, acme@redhat.com, peterz@infradead.org,
          jolsa@kernel.org, namhyung@kernel.org, liwei391@huawei.com,
          mingo@kernel.org, yao.jin@linux.intel.com,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          alexander.shishkin@linux.intel.com
In-Reply-To: <20190221095716.39529-1-liwei391@huawei.com>
References: <20190221095716.39529-1-liwei391@huawei.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf annotate: Fix getting source line failure
Git-Commit-ID: 11db1ad4513d6205d2519e1a30ff4cef746e3243
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

Commit-ID:  11db1ad4513d6205d2519e1a30ff4cef746e3243
Gitweb:     https://git.kernel.org/tip/11db1ad4513d6205d2519e1a30ff4cef746e3243
Author:     Wei Li <liwei391@huawei.com>
AuthorDate: Thu, 21 Feb 2019 17:57:16 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 21 Feb 2019 17:00:35 -0300

perf annotate: Fix getting source line failure

The output of "perf annotate -l --stdio xxx" changed since commit 425859ff0de33
("perf annotate: No need to calculate notes->start twice") removed notes->start
assignment in symbol__calc_lines(). It will get failed in
find_address_in_section() from symbol__tty_annotate() subroutine as the
a2l->addr is wrong. So the annotate summary doesn't report the line number of
source code correctly.

Before fix:

  liwei@euler:~/main_code/hulk_work/hulk/tools/perf$ cat common_while_1.c
  void hotspot_1(void)
  {
	volatile int i;

	for (i = 0; i < 0x10000000; i++);
	for (i = 0; i < 0x10000000; i++);
	for (i = 0; i < 0x10000000; i++);
  }

  int main(void)
  {
	hotspot_1();

	return 0;
  }
  liwei@euler:~/main_code/hulk_work/hulk/tools/perf$ gcc common_while_1.c -g -o common_while_1

  liwei@euler:~/main_code/hulk_work/hulk/tools/perf$ sudo ./perf record ./common_while_1
  [ perf record: Woken up 2 times to write data ]
  [ perf record: Captured and wrote 0.488 MB perf.data (12498 samples) ]
  liwei@euler:~/main_code/hulk_work/hulk/tools/perf$ sudo ./perf annotate -l -s hotspot_1 --stdio

  Sorted summary for file /home/liwei/main_code/hulk_work/hulk/tools/perf/common_while_1
  ----------------------------------------------

   19.30 common_while_1[32]
   19.03 common_while_1[4e]
   19.01 common_while_1[16]
    5.04 common_while_1[13]
    4.99 common_while_1[4b]
    4.78 common_while_1[2c]
    4.77 common_while_1[10]
    4.66 common_while_1[2f]
    4.59 common_while_1[51]
    4.59 common_while_1[35]
    4.52 common_while_1[19]
    4.20 common_while_1[56]
    0.51 common_while_1[48]
   Percent |      Source code & Disassembly of common_while_1 for cycles:ppp (12480 samples, percent: local period)
  -----------------------------------------------------------------------------------------------------------------
         :
         :
         :
         :         Disassembly of section .text:
         :
         :         00000000000005fa <hotspot_1>:
         :         hotspot_1():
         :         void hotspot_1(void)
         :         {
    0.00 :   5fa:   push   %rbp
    0.00 :   5fb:   mov    %rsp,%rbp
         :                 volatile int i;
         :
         :                 for (i = 0; i < 0x10000000; i++);
    0.00 :   5fe:   movl   $0x0,-0x4(%rbp)
    0.00 :   605:   jmp    610 <hotspot_1+0x16>
    0.00 :   607:   mov    -0x4(%rbp),%eax
   common_while_1[10]    4.77 :   60a:   add    $0x1,%eax
   common_while_1[13]    5.04 :   60d:   mov    %eax,-0x4(%rbp)
   common_while_1[16]   19.01 :   610:   mov    -0x4(%rbp),%eax
   common_while_1[19]    4.52 :   613:   cmp    $0xfffffff,%eax
      0.00 :   618:   jle    607 <hotspot_1+0xd>
           :                 for (i = 0; i < 0x10000000; i++);
  ...

After fix:

  liwei@euler:~/main_code/hulk_work/hulk/tools/perf$ sudo ./perf record ./common_while_1
  [ perf record: Woken up 2 times to write data ]
  [ perf record: Captured and wrote 0.488 MB perf.data (12500 samples) ]
  liwei@euler:~/main_code/hulk_work/hulk/tools/perf$ sudo ./perf annotate -l -s hotspot_1 --stdio

  Sorted summary for file /home/liwei/main_code/hulk_work/hulk/tools/perf/common_while_1
  ----------------------------------------------

   33.34 common_while_1.c:5
   33.34 common_while_1.c:6
   33.32 common_while_1.c:7
   Percent |      Source code & Disassembly of common_while_1 for cycles:ppp (12482 samples, percent: local period)
  -----------------------------------------------------------------------------------------------------------------
         :
         :
         :
         :         Disassembly of section .text:
         :
         :         00000000000005fa <hotspot_1>:
         :         hotspot_1():
         :         void hotspot_1(void)
         :         {
    0.00 :   5fa:   push   %rbp
    0.00 :   5fb:   mov    %rsp,%rbp
         :                 volatile int i;
         :
         :                 for (i = 0; i < 0x10000000; i++);
    0.00 :   5fe:   movl   $0x0,-0x4(%rbp)
    0.00 :   605:   jmp    610 <hotspot_1+0x16>
    0.00 :   607:   mov    -0x4(%rbp),%eax
   common_while_1.c:5    4.70 :   60a:   add    $0x1,%eax
    4.89 :   60d:   mov    %eax,-0x4(%rbp)
   common_while_1.c:5   19.03 :   610:   mov    -0x4(%rbp),%eax
   common_while_1.c:5    4.72 :   613:   cmp    $0xfffffff,%eax
    0.00 :   618:   jle    607 <hotspot_1+0xd>
         :                 for (i = 0; i < 0x10000000; i++);
    0.00 :   61a:   movl   $0x0,-0x4(%rbp)
    0.00 :   621:   jmp    62c <hotspot_1+0x32>
    0.00 :   623:   mov    -0x4(%rbp),%eax
   common_while_1.c:6    4.54 :   626:   add    $0x1,%eax
    4.73 :   629:   mov    %eax,-0x4(%rbp)
   common_while_1.c:6   19.54 :   62c:   mov    -0x4(%rbp),%eax
   common_while_1.c:6    4.54 :   62f:   cmp    $0xfffffff,%eax
  ...

Signed-off-by: Wei Li <liwei391@huawei.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Fixes: 425859ff0de33 ("perf annotate: No need to calculate notes->start twice")
Link: http://lkml.kernel.org/r/20190221095716.39529-1-liwei391@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 2468b8aa0b6b..11a8a447a3af 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1891,6 +1891,7 @@ int symbol__annotate(struct symbol *sym, struct map *map,
 		     struct annotation_options *options,
 		     struct arch **parch)
 {
+	struct annotation *notes = symbol__annotation(sym);
 	struct annotate_args args = {
 		.privsize	= privsize,
 		.evsel		= evsel,
@@ -1921,6 +1922,7 @@ int symbol__annotate(struct symbol *sym, struct map *map,
 
 	args.ms.map = map;
 	args.ms.sym = sym;
+	notes->start = map__rip_2objdump(map, sym->start);
 
 	return symbol__disassemble(sym, &args);
 }
@@ -2796,8 +2798,6 @@ int symbol__annotate2(struct symbol *sym, struct map *map, struct perf_evsel *ev
 
 	symbol__calc_percent(sym, evsel);
 
-	notes->start = map__rip_2objdump(map, sym->start);
-
 	annotation__set_offsets(notes, size);
 	annotation__mark_jump_targets(notes, sym);
 	annotation__compute_ipc(notes, size);
