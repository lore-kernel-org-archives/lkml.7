Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3772BC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF32921734
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369147;
	bh=GCTrwiX6cZK4phrSma1KqS8xeaM9+gAzsLy5RnurTZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=C/O1RZ5lODXyQbBtq6TfgKT1jjzurVfqa8S8lPDhRY8Sfq1S2AXBtzm7p7BVbtuFa
	 BrzfkHKN/B3ODvJTcw0Bc1/Q0TINy2kbDBBUepIMFxm83Nm4YVVVj6v9gj13TqGIlz
	 dBTdkZQ3bUTqUURVIhJ9LOKxGfX8WWjHO1tP48Mg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387396AbfDDJMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:12:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:52404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732901AbfDDJMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:12:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEB112054F;
        Thu,  4 Apr 2019 09:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369141;
        bh=GCTrwiX6cZK4phrSma1KqS8xeaM9+gAzsLy5RnurTZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MPeQcIbUPIYrW1iVst3OgyhX8UzMlbcBgU2qAHbU4dx4ZIEnBrj0En8mmH8c2S1Ik
         Zwxe2eMIx2d+bzyLnhqig03ylxWJoLz4KcOfaQiqa/G6GUuM7wNNZjh8UlunAan31S
         7RwOl05IdW1eezac+dMI+6RZFQBblhDIdMzou3uM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wei Li <liwei391@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 099/246] perf annotate: Fix getting source line failure
Date:   Thu,  4 Apr 2019 10:46:39 +0200
Message-Id: <20190404084622.610359161@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 11db1ad4513d6205d2519e1a30ff4cef746e3243 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/annotate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 70de8f6b3aee..9142fd294e76 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1889,6 +1889,7 @@ int symbol__annotate(struct symbol *sym, struct map *map,
 		     struct annotation_options *options,
 		     struct arch **parch)
 {
+	struct annotation *notes = symbol__annotation(sym);
 	struct annotate_args args = {
 		.privsize	= privsize,
 		.evsel		= evsel,
@@ -1919,6 +1920,7 @@ int symbol__annotate(struct symbol *sym, struct map *map,
 
 	args.ms.map = map;
 	args.ms.sym = sym;
+	notes->start = map__rip_2objdump(map, sym->start);
 
 	return symbol__disassemble(sym, &args);
 }
@@ -2794,8 +2796,6 @@ int symbol__annotate2(struct symbol *sym, struct map *map, struct perf_evsel *ev
 
 	symbol__calc_percent(sym, evsel);
 
-	notes->start = map__rip_2objdump(map, sym->start);
-
 	annotation__set_offsets(notes, size);
 	annotation__mark_jump_targets(notes, sym);
 	annotation__compute_ipc(notes, size);
-- 
2.19.1



