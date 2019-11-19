Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B5FC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 11:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21E29222A2
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 11:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574163239;
	bh=LfH1fwF5nIoSC1ORh19uNeTPNsKHMcTtE1zovaALoYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ci92jKCeCWzQXU9zf9ppACmxsAh7CzNwFQaAoKiMPKTaUEr06YE/R1cjdNfON6cJA
	 tYyB5SWpJmlBgY8f6jWyVLa/qDkzxiNDpnHH7Mn0Z8XgRaJDNqinzsjU8NMhyEzez2
	 Y7i+NbHNDHta7aZczoFHHwHjEejdXC+ltKXAX5FI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbfKSLd5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 06:33:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:47944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728030AbfKSLdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 06:33:55 -0500
Received: from quaco.ghostprotocols.net (179.176.11.138.dynamic.adsl.gvt.net.br [179.176.11.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE9E820679;
        Tue, 19 Nov 2019 11:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574163235;
        bh=LfH1fwF5nIoSC1ORh19uNeTPNsKHMcTtE1zovaALoYs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tXWMYyi6Kg48AzeS/yhjUyxiRs5+LRvVpG3PL6eva3nMwnffWVc/ZZHFYq3gl2Amp
         hznMkl7dP0Ihs3ebl8Zb/Bxk5hrgkhH4YmEDg+rf4189n4cwrGbbcdvFGnczi9s9d4
         h87+FSX0mM2+nDWNdm+QGUgITYHO31H1PeCAV0oQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 15/25] perf map: Move seldom used ->flags field to second cacheline
Date:   Tue, 19 Nov 2019 08:32:35 -0300
Message-Id: <20191119113245.19593-16-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191119113245.19593-1-acme@kernel.org>
References: <20191119113245.19593-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

So we start with:

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

and 'flags' is seldom used when printing details about the map or with
the "cacheline" sort order, we can move them it to the second cacheline,
that will allow combining it with 'refcnt', that is only four bytes:

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
  	u64                        pgoff;                /*    48     8 */
  	u64                        reloc;                /*    56     8 */
  	/* --- cacheline 1 boundary (64 bytes) --- */
  	u32                        maj;                  /*    64     4 */
  	u32                        min;                  /*    68     4 */
  	u64                        ino;                  /*    72     8 */
  	u64                        ino_generation;       /*    80     8 */
  	u64                        (*map_ip)(struct map *, u64); /*    88     8 */
  	u64                        (*unmap_ip)(struct map *, u64); /*    96     8 */
  	struct dso *               dso;                  /*   104     8 */
  	refcount_t                 refcnt;               /*   112     4 */
  	u32                        flags;                /*   116     4 */

  	/* size: 120, cachelines: 2, members: 17 */
  	/* sum members: 116, holes: 1, sum holes: 3 */
  	/* sum bitfield members: 2 bits, bit holes: 1, sum bit holes: 6 bits */
  	/* forced alignments: 1 */
  	/* last cacheline: 56 bytes */
  } __attribute__((__aligned__(8)));
  $

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-2cdw3zlw1mkamaf7nqtdlxfi@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/map.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index e2466aa5bb41..0a6c45f85cd9 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -28,7 +28,6 @@ struct map {
 	bool			erange_warned:1;
 	bool			priv:1;
 	u32			prot;
-	u32			flags;
 	u64			pgoff;
 	u64			reloc;
 	u32			maj, min; /* only valid for MMAP2 record */
@@ -42,6 +41,7 @@ struct map {
 
 	struct dso		*dso;
 	refcount_t		refcnt;
+	u32			flags;
 };
 
 struct kmap;
-- 
2.21.0

