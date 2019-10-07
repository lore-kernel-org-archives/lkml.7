Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A6E3ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 14:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF0382196E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 14:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbfJGOt1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 10:49:27 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44232 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727970AbfJGOtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 10:49:25 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iHUK6-0005yC-6B; Mon, 07 Oct 2019 16:49:18 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 719281C0DC9;
        Mon,  7 Oct 2019 16:49:15 +0200 (CEST)
Date:   Mon, 07 Oct 2019 14:49:15 -0000
From:   "tip-bot2 for Andi Kleen" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf script brstackinsn: Fix recovery from
 LBR/binary mismatch
Cc:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190927233546.11533-1-andi@firstfloor.org>
References: <20190927233546.11533-1-andi@firstfloor.org>
MIME-Version: 1.0
Message-ID: <157045975542.9978.14015561869362479880.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     e98df280bc2a499fd41d7f9e2d6733884de69902
Gitweb:        https://git.kernel.org/tip/e98df280bc2a499fd41d7f9e2d6733884de69902
Author:        Andi Kleen <ak@linux.intel.com>
AuthorDate:    Fri, 27 Sep 2019 16:35:44 -07:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 30 Sep 2019 17:29:52 -03:00

perf script brstackinsn: Fix recovery from LBR/binary mismatch

When the LBR data and the instructions in a binary do not match the loop
printing instructions could get confused and print a long stream of
bogus <bad> instructions.

The problem was that if the instruction decoder cannot decode an
instruction it ilen wasn't initialized, so the loop going through the
basic block would continue with the previous value.

Harden the code to avoid such problems:

- Make sure ilen is always freshly initialized and is 0 for bad
  instructions.

- Do not overrun the code buffer while printing instructions

- Print a warning message if the final jump is not on an instruction
  boundary.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Link: http://lore.kernel.org/lkml/20190927233546.11533-1-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 286fc70..67be8d3 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1063,7 +1063,7 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
 			continue;
 
 		insn = 0;
-		for (off = 0;; off += ilen) {
+		for (off = 0; off < (unsigned)len; off += ilen) {
 			uint64_t ip = start + off;
 
 			printed += ip__fprintf_sym(ip, thread, x.cpumode, x.cpu, &lastsym, attr, fp);
@@ -1074,6 +1074,7 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
 					printed += print_srccode(thread, x.cpumode, ip);
 				break;
 			} else {
+				ilen = 0;
 				printed += fprintf(fp, "\t%016" PRIx64 "\t%s\n", ip,
 						   dump_insn(&x, ip, buffer + off, len - off, &ilen));
 				if (ilen == 0)
@@ -1083,6 +1084,8 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
 				insn++;
 			}
 		}
+		if (off != (unsigned)len)
+			printed += fprintf(fp, "\tmismatch of LBR data and executable\n");
 	}
 
 	/*
@@ -1123,6 +1126,7 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
 		goto out;
 	}
 	for (off = 0; off <= end - start; off += ilen) {
+		ilen = 0;
 		printed += fprintf(fp, "\t%016" PRIx64 "\t%s\n", start + off,
 				   dump_insn(&x, start + off, buffer + off, len - off, &ilen));
 		if (ilen == 0)
