Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9952C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 11:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1A55219F6
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 11:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574163234;
	bh=UfZ8wC+rkmc7a6hdYY+NDtyFfycZhcf+vxcJ0ndlwmU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1wUwf/qIZB1lVLbUfI5GkZqYp9odLA0FJ1ecxbyNObZyfKjgAaSQdFIf68bMgVN/Z
	 J4PL+/XtPnuXlVp/2RBSKzDXg8T8b/rbQB4F9QdkzqL7Dn9MaMBesSvILIowENLuJ5
	 a85UP8mqbUigtkOwQ+IaVy+oj1eQ3da8f8WNWqM8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbfKSLdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 06:33:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:47828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728030AbfKSLdw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 06:33:52 -0500
Received: from quaco.ghostprotocols.net (179.176.11.138.dynamic.adsl.gvt.net.br [179.176.11.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 030B2222D1;
        Tue, 19 Nov 2019 11:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574163231;
        bh=UfZ8wC+rkmc7a6hdYY+NDtyFfycZhcf+vxcJ0ndlwmU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M7RJF2KYmu2S01aa9ax0YNH6mu2ewgBbDSOYKVl1wFSE1p0Bb+7Ya8hWLtLi3eWRi
         MTNt3DQ5riinHV2SZBrNgybPH0grLgmOW1nIk2M5yV1iVknOg/zwOwLI5rsh+9oXAu
         hpPnn+QL+ZJsbz2w1/3S1e2xpXY/QCeLbs5nR7m8=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 14/25] perf map: Use bitmap for booleans
Date:   Tue, 19 Nov 2019 08:32:34 -0300
Message-Id: <20191119113245.19593-15-acme@kernel.org>
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
index a31e80991189..e2466aa5bb41 100644
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
-- 
2.21.0

