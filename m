Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E669EC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 20:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAFE22173C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 20:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Hr4DKIN+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404905AbfHHUWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 16:22:42 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43153 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404590AbfHHUWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 16:22:42 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x78KMV893321910
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 8 Aug 2019 13:22:31 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x78KMV893321910
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565295752;
        bh=jGSbvkcc9gvV/Z7/TnETW4JyOHuIdmYewXw9ers7l1U=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Hr4DKIN+ovhwsh6iIyfgRpRW5RywRHVDXfEYIkiDfLW2yb3sgDEBUxqwAFdh7IzJo
         56DIzpiXYAtfD3STI7AIEoEft1c/CzwvN2xZHJXYeR3qd7jUIDZS1KG4tN0aIumaDq
         nHpIRapiXmlYzcMa+K9KmRRhlTXZoqJ87CYUr5CrYoqwl1YSB3mzfZg6zvyC9ZY0Nw
         PsIJabgrDdGdGkqajaxlgTTg2+jFnThFQ/dQEGR/R6PviBT+uM0R+4JPMMlEayboln
         6tKqZ8fDK8na2j3dfKCbC6GxanWbPnYt3HFJqRehA446jsMpb3QCHR5ULxfZYY/uH7
         KlVZANOpqLMNQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x78KMVoh3321907;
        Thu, 8 Aug 2019 13:22:31 -0700
Date:   Thu, 8 Aug 2019 13:22:31 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Richter <tipbot@zytor.com>
Message-ID: <tip-b9c0a64901d5bdec6eafd38d1dc8fa0e2974fccb@git.kernel.org>
Cc:     brueckner@linux.ibm.com, tmricht@linux.ibm.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        heiko.carstens@de.ibm.com, acme@redhat.com, gor@linux.ibm.com,
        mingo@kernel.org, klaus.theurich@de.ibm.com
Reply-To: brueckner@linux.ibm.com, tmricht@linux.ibm.com,
          linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
          heiko.carstens@de.ibm.com, acme@redhat.com, mingo@kernel.org,
          gor@linux.ibm.com, klaus.theurich@de.ibm.com
In-Reply-To: <20190724122703.3996-2-tmricht@linux.ibm.com>
References: <20190724122703.3996-2-tmricht@linux.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf annotate: Fix s390 gap between kernel end
 and module start
Git-Commit-ID: b9c0a64901d5bdec6eafd38d1dc8fa0e2974fccb
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

Commit-ID:  b9c0a64901d5bdec6eafd38d1dc8fa0e2974fccb
Gitweb:     https://git.kernel.org/tip/b9c0a64901d5bdec6eafd38d1dc8fa0e2974fccb
Author:     Thomas Richter <tmricht@linux.ibm.com>
AuthorDate: Wed, 24 Jul 2019 14:27:03 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 8 Aug 2019 15:41:25 -0300

perf annotate: Fix s390 gap between kernel end and module start

During execution of command 'perf top' the error message:

   Not enough memory for annotating '__irf_end' symbol!)

is emitted from this call sequence:
  __cmd_top
    perf_top__mmap_read
      perf_top__mmap_read_idx
        perf_event__process_sample
          hist_entry_iter__add
            hist_iter__top_callback
              perf_top__record_precise_ip
                hist_entry__inc_addr_samples
                  symbol__inc_addr_samples
                    symbol__get_annotation
                      symbol__alloc_hist

In this function the size of symbol __irf_end is calculated. The size of
a symbol is the difference between its start and end address.

When the symbol was read the first time, its start and end was set to:

   symbol__new: __irf_end 0xe954d0-0xe954d0

which is correct and maps with /proc/kallsyms:

   root@s8360046:~/linux-4.15.0/tools/perf# fgrep _irf_end /proc/kallsyms
   0000000000e954d0 t __irf_end
   root@s8360046:~/linux-4.15.0/tools/perf#

In function symbol__alloc_hist() the end of symbol __irf_end is

  symbol__alloc_hist sym:__irf_end start:0xe954d0 end:0x3ff80045a8

which is identical with the first module entry in /proc/kallsyms

This results in a symbol size of __irf_req for histogram analyses of
70334140059072 bytes and a malloc() for this requested size fails.

The root cause of this is function
  __dso__load_kallsyms()
  +-> symbols__fixup_end()

Function symbols__fixup_end() enlarges the last symbol in the kallsyms
map:

   # fgrep __irf_end /proc/kallsyms
   0000000000e954d0 t __irf_end
   #

to the start address of the first module:
   # cat /proc/kallsyms | sort  | egrep ' [tT] '
   ....
   0000000000e952d0 T __security_initcall_end
   0000000000e954d0 T __initramfs_size
   0000000000e954d0 t __irf_end
   000003ff800045a8 T fc_get_event_number       [scsi_transport_fc]
   000003ff800045d0 t store_fc_vport_disable    [scsi_transport_fc]
   000003ff800046a8 T scsi_is_fc_rport  [scsi_transport_fc]
   000003ff800046d0 t fc_target_setup   [scsi_transport_fc]

On s390 the kernel is located around memory address 0x200, 0x10000 or
0x100000, depending on linux version. Modules however start some- where
around 0x3ff xxxx xxxx.

This is different than x86 and produces a large gap for which histogram
allocation fails.

Fix this by detecting the kernel's last symbol and do no adjustment for
it. Introduce a weak function and handle s390 specifics.

Reported-by: Klaus Theurich <klaus.theurich@de.ibm.com>
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Hendrik Brueckner <brueckner@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/20190724122703.3996-2-tmricht@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/s390/util/machine.c | 17 +++++++++++++++++
 tools/perf/util/symbol.c            |  7 ++++++-
 tools/perf/util/symbol.h            |  1 +
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/tools/perf/arch/s390/util/machine.c b/tools/perf/arch/s390/util/machine.c
index de26b1441a48..c8c86a0c9b79 100644
--- a/tools/perf/arch/s390/util/machine.c
+++ b/tools/perf/arch/s390/util/machine.c
@@ -6,6 +6,7 @@
 #include "machine.h"
 #include "api/fs/fs.h"
 #include "debug.h"
+#include "symbol.h"
 
 int arch__fix_module_text_start(u64 *start, u64 *size, const char *name)
 {
@@ -33,3 +34,19 @@ int arch__fix_module_text_start(u64 *start, u64 *size, const char *name)
 
 	return 0;
 }
+
+/* On s390 kernel text segment start is located at very low memory addresses,
+ * for example 0x10000. Modules are located at very high memory addresses,
+ * for example 0x3ff xxxx xxxx. The gap between end of kernel text segment
+ * and beginning of first module's text segment is very big.
+ * Therefore do not fill this gap and do not assign it to the kernel dso map.
+ */
+void arch__symbols__fixup_end(struct symbol *p, struct symbol *c)
+{
+	if (strchr(p->name, '[') == NULL && strchr(c->name, '['))
+		/* Last kernel symbol mapped to end of page */
+		p->end = roundup(p->end, page_size);
+	else
+		p->end = c->start;
+	pr_debug4("%s sym:%s end:%#lx\n", __func__, p->name, p->end);
+}
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 173f3378aaa0..4efde7879474 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -92,6 +92,11 @@ static int prefix_underscores_count(const char *str)
 	return tail - str;
 }
 
+void __weak arch__symbols__fixup_end(struct symbol *p, struct symbol *c)
+{
+	p->end = c->start;
+}
+
 const char * __weak arch__normalize_symbol_name(const char *name)
 {
 	return name;
@@ -218,7 +223,7 @@ void symbols__fixup_end(struct rb_root_cached *symbols)
 		curr = rb_entry(nd, struct symbol, rb_node);
 
 		if (prev->end == prev->start && prev->end != curr->start)
-			prev->end = curr->start;
+			arch__symbols__fixup_end(prev, curr);
 	}
 
 	/* Last entry */
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 12755b42ea93..183f630cb5f1 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -288,6 +288,7 @@ const char *arch__normalize_symbol_name(const char *name);
 #define SYMBOL_A 0
 #define SYMBOL_B 1
 
+void arch__symbols__fixup_end(struct symbol *p, struct symbol *c);
 int arch__compare_symbol_names(const char *namea, const char *nameb);
 int arch__compare_symbol_names_n(const char *namea, const char *nameb,
 				 unsigned int n);
