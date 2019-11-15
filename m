Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C67C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 07:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C81D420857
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 07:40:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfKOHk1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 02:40:27 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42614 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727080AbfKOHkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 02:40:25 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iVWDL-0002a6-Bs; Fri, 15 Nov 2019 08:40:19 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id EA68E1C08AC;
        Fri, 15 Nov 2019 08:40:18 +0100 (CET)
Date:   Fri, 15 Nov 2019 07:40:18 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf symbols: Stop using map->groups, we can use
 kmaps instead
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-5fy66x5hr5ct9pmw84jkiwvm@git.kernel.org>
References: <tip-5fy66x5hr5ct9pmw84jkiwvm@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157380361854.29467.13535766264249404001.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     f2baa060cd766f4e585339423891e0063179d702
Gitweb:        https://git.kernel.org/tip/f2baa060cd766f4e585339423891e0063179d702
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Mon, 04 Nov 2019 16:09:48 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 12 Nov 2019 08:20:53 -03:00

perf symbols: Stop using map->groups, we can use kmaps instead

To test that that function is being called I just added a probe on that
place, enabled it via 'perf trace' asking for at most 16 levels of
backtraces, system wide, and then ran 'perf top' on another xterm,
voilà:

  # perf probe -x ~/bin/perf dso__process_kernel_symbol
  Added new event:
    probe_perf:dso__process_kernel_symbol (on dso__process_kernel_symbol in /home/acme/bin/perf)

  You can now use it in all perf tools, such as:

  	perf record -e probe_perf:dso__process_kernel_symbol -aR sleep 1

  # perf trace -e probe_perf:dso__process_kernel_symbol/max-stack=16/ --max-events=2
  # perf trace -e probe_perf:dso__process_kernel_symbol/max-stack=16/ --max-events=2
       0.000 :17345/17345 probe_perf:dso__process_kernel_symbol(__probe_ip: 5680224)
                                         dso__process_kernel_symbol (/home/acme/bin/perf)
                                         dso__load_vmlinux (/home/acme/bin/perf)
                                         dso__load_vmlinux_path (/home/acme/bin/perf)
                                         dso__load (/home/acme/bin/perf)
                                         map__load (/home/acme/bin/perf)
                                         thread__find_map (/home/acme/bin/perf)
                                         machine__resolve (/home/acme/bin/perf)
                                         deliver_event (/home/acme/bin/perf)
                                         __ordered_events__flush.part.0 (/home/acme/bin/perf)
                                         process_thread (/home/acme/bin/perf)
                                         start_thread (/usr/lib64/libpthread-2.29.so)
       0.064 :17345/17345 probe_perf:dso__process_kernel_symbol(__probe_ip: 5680224)
                                         dso__process_kernel_symbol (/home/acme/bin/perf)
                                         dso__load_vmlinux (/home/acme/bin/perf)
                                         dso__load_vmlinux_path (/home/acme/bin/perf)
                                         dso__load (/home/acme/bin/perf)
                                         map__load (/home/acme/bin/perf)
                                         thread__find_map (/home/acme/bin/perf)
                                         machine__resolve (/home/acme/bin/perf)
                                         deliver_event (/home/acme/bin/perf)
                                         __ordered_events__flush.part.0 (/home/acme/bin/perf)
                                         process_thread (/home/acme/bin/perf)
                                         start_thread (/usr/lib64/libpthread-2.29.so)
  #
  # perf stat -e probe_perf:dso__process_kernel_symbol
  ^C
   Performance counter stats for 'system wide':

           107,308      probe_perf:dso__process_kernel_symbol

       8.215399813 seconds time elapsed
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-5fy66x5hr5ct9pmw84jkiwvm@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol-elf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 66f4be1..16776d5 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -934,7 +934,7 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
 		 * we still are sure to have a reference to this DSO via
 		 * *curr_map->dso.
 		 */
-		dsos__add(&map->groups->machine->dsos, curr_dso);
+		dsos__add(&kmaps->machine->dsos, curr_dso);
 		/* kmaps already got it */
 		map__put(curr_map);
 		dso__set_loaded(curr_dso);
