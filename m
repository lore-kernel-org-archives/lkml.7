Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 483C5C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 16:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24B672241E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 16:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbfKSQ5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 11:57:08 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:52839 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728637AbfKSQ5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 11:57:06 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iX6oF-0007QG-A8; Tue, 19 Nov 2019 17:56:59 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4E18E1C19CC;
        Tue, 19 Nov 2019 17:56:49 +0100 (CET)
Date:   Tue, 19 Nov 2019 16:56:49 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf map: Use bitmap for booleans
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-g5545pcq4ff0wr17tfb1piqt@git.kernel.org>
References: <tip-g5545pcq4ff0wr17tfb1piqt@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157418260927.12247.7477192419256385944.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     dbc984c961667b1ce48a0337b5bcd3b8c9cb2098
Gitweb:        https://git.kernel.org/tip/dbc984c961667b1ce48a0337b5bcd3b8c9cb2098
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Mon, 18 Nov 2019 16:26:29 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 18 Nov 2019 16:29:01 -03:00

perf map: Use bitmap for booleans

The map->priv and map->erange_warned are seldom used, the first only in
tests/vmlinux-kallsyms.c, the later only when hist_entry__inc_addr_samples()
returns -ERANGE in 'perf top', which are really rare occasions, so make
them a bool bitfield.

This will open up space for other members on the first cacheline.

  $ pahole -C map ~/bin/perf
  struct map {
  	union {
  		struct rb_node rb_node __attribute__((__aligned__(8))); /*     0    24 */
  		struct list_head node;                   /*     0    16 */
  	} __attribute__((__aligned__(8)));                                               /*     0    24 */
  	u64                        start;                /*    24     8 */
  	u64                        end;                  /*    32     8 */
  	_Bool                      erange_warned:1;      /*    40: 0  1 */
  	_Bool                      priv:1;               /*    40: 1  1 */

  	/* XXX 6 bits hole, try to pack */
  	/* XXX 3 bytes hole, try to pack */

  	u32                        prot;                 /*    44     4 */
  	u32                        flags;                /*    48     4 */

  	/* XXX 4 bytes hole, try to pack */

  	u64                        pgoff;                /*    56     8 */
  	/* --- cacheline 1 boundary (64 bytes) --- */
  	u64                        reloc;                /*    64     8 */
  	u32                        maj;                  /*    72     4 */
  	u32                        min;                  /*    76     4 */
  	u64                        ino;                  /*    80     8 */
  	u64                        ino_generation;       /*    88     8 */
  	u64                        (*map_ip)(struct map *, u64); /*    96     8 */
  	u64                        (*unmap_ip)(struct map *, u64); /*   104     8 */
  	struct dso *               dso;                  /*   112     8 */
  	refcount_t                 refcnt;               /*   120     4 */

  	/* size: 128, cachelines: 2, members: 17 */
  	/* sum members: 116, holes: 2, sum holes: 7 */
  	/* sum bitfield members: 2 bits, bit holes: 1, sum bit holes: 6 bits */
  	/* padding: 4 */
  	/* forced alignments: 1 */
  } __attribute__((__aligned__(8)));
  $

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-g5545pcq4ff0wr17tfb1piqt@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/map.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index a31e809..e2466aa 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -25,8 +25,8 @@ struct map {
 	};
 	u64			start;
 	u64			end;
-	bool			erange_warned;
-	u32			priv;
+	bool			erange_warned:1;
+	bool			priv:1;
 	u32			prot;
 	u32			flags;
 	u64			pgoff;
