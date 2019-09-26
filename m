Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C93AC432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EF9E217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569458232;
	bh=kDq+CyTfUApKOLb0gxOUA8fFRRXh7zXuBDKTRLJvlu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M3yIF+RnI47t66A1zARcc82KIYbUdxGyiJQf2qgMx1yc/FLPN0J1DGJxPfzRVUNZR
	 ThSIECw1HYO3Kg2gpDxHWVHo9c+Ec+iF6BCuxiMrYYoeqmRzAp71Ni6rY5qcYMnoaW
	 h6Mi4YWH10a3tAlI9u/FFYdZ6zRw7zhYGNcTYp3I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390756AbfIZAgn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 20:36:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:39482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729174AbfIZAgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 20:36:41 -0400
Received: from quaco.localdomain (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86288217F4;
        Thu, 26 Sep 2019 00:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569458200;
        bh=kDq+CyTfUApKOLb0gxOUA8fFRRXh7zXuBDKTRLJvlu8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BaY8a/mFoljdrEiLIMx1+7aEd+cdWUO3nNz0DvUYyEcSvjpLdecyu9RLzFYU40tT2
         KpqNi+2Cnfc0fRSKcsmmPjwwQtFAAAMYmTQ3MRjnud0XUdvDHF2jm/Y5Xg0Abh+7sz
         45BXsVc6Ibw9MRUfZxJbi9nCUsn8AFNGlPj4xiOc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 62/66] perf evlist: Fix access of freed id arrays
Date:   Wed, 25 Sep 2019 21:32:40 -0300
Message-Id: <20190926003244.13962-63-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190926003244.13962-1-acme@kernel.org>
References: <20190926003244.13962-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

I'm not fully sure if this is the correct fix, but without this I get
crashes on more complex perf stat metric usages. The problem is that
part of the state gets freed when a weak group fails, but then is later
still used. Just don't free the ids, we're going to reuse them anyways
on the weak group retry.

For example:

  % perf stat -M IpB,IpCall,IpTB,IPC,Retiring_SMT,Frontend_Bound_SMT,Kernel_Utilization,CPU_Utilization --metric-only -a -I 1000 sleep 2

  crashes and gives in valgrind:

  =21527== Invalid write of size 8
  ==21527==    at 0x4EE582: hlist_add_head (list.h:644)
  ==21527==    by 0x4EFD3C: perf_evlist__id_hash (evlist.c:477)
  ==21527==    by 0x4EFD99: perf_evlist__id_add (evlist.c:483)
  ==21527==    by 0x4EFF15: perf_evlist__id_add_fd (evlist.c:524)
  ==21527==    by 0x4FC693: store_evsel_ids (evsel.c:2969)
  ==21527==    by 0x4FC76C: perf_evsel__store_ids (evsel.c:2986)
  ==21527==    by 0x450DA7: __run_perf_stat (builtin-stat.c:519)
  ==21527==    by 0x451285: run_perf_stat (builtin-stat.c:636)
  ==21527==    by 0x454619: cmd_stat (builtin-stat.c:1966)
  ==21527==    by 0x4D557D: run_builtin (perf.c:310)
  ==21527==    by 0x4D57EA: handle_internal_command (perf.c:362)
  ==21527==    by 0x4D5931: run_argv (perf.c:406)
  ==21527==  Address 0x12e3f008 is 104 bytes inside a block of size 2,056 free'd
  ==21527==    at 0x4839A0C: free (vg_replace_malloc.c:540)
  ==21527==    by 0x627139: xyarray__delete (xyarray.c:32)
  ==21527==    by 0x4F6BE4: perf_evsel__free_id (evsel.c:1253)
  ==21527==    by 0x4FA11F: evsel__close (evsel.c:1994)
  ==21527==    by 0x4F30A3: perf_evlist__reset_weak_group (evlist.c:1783)
  ==21527==    by 0x450B47: __run_perf_stat (builtin-stat.c:466)
  ==21527==    by 0x451285: run_perf_stat (builtin-stat.c:636)
  ==21527==    by 0x454619: cmd_stat (builtin-stat.c:1966)
  ==21527==    by 0x4D557D: run_builtin (perf.c:310)
  ==21527==    by 0x4D57EA: handle_internal_command (perf.c:362)
  ==21527==    by 0x4D5931: run_argv (perf.c:406)
  ==21527==    by 0x4D5CAE: main (perf.c:531)
  ==21527==  Block was alloc'd at
  ==21527==    at 0x483AB1A: calloc (vg_replace_malloc.c:762)
  ==21527==    by 0x627024: zalloc (zalloc.c:8)
  ==21527==    by 0x627088: xyarray__new (xyarray.c:10)
  ==21527==    by 0x4F6B20: perf_evsel__alloc_id (evsel.c:1237)
  ==21527==    by 0x4FC74E: perf_evsel__store_ids (evsel.c:2983)
  ==21527==    by 0x450DA7: __run_perf_stat (builtin-stat.c:519)
  ==21527==    by 0x451285: run_perf_stat (builtin-stat.c:636)
  ==21527==    by 0x454619: cmd_stat (builtin-stat.c:1966)
  ==21527==    by 0x4D557D: run_builtin (perf.c:310)
  ==21527==    by 0x4D57EA: handle_internal_command (perf.c:362)
  ==21527==    by 0x4D5931: run_argv (perf.c:406)
  ==21527==    by 0x4D5CAE: main (perf.c:531)

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Link: http://lore.kernel.org/lkml/20190923233339.25326-1-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 84c42790dab3..d277a98e62df 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1659,7 +1659,7 @@ struct evsel *perf_evlist__reset_weak_group(struct evlist *evsel_list,
 			is_open = false;
 		if (c2->leader == leader) {
 			if (is_open)
-				evsel__close(c2);
+				perf_evsel__close(&evsel->core);
 			c2->leader = c2;
 			c2->core.nr_members = 0;
 		}
-- 
2.21.0

