Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E998AC2D0CF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 13:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD93E20828
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 13:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577107984;
	bh=Z/dplSt9r9WofkvicgxOZVvQjd0WVhmkDb6ugHjockQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LKird4xp0z8/rbXiUoHpn4sp3dmGddpHJ/jVF7dxYAJ46Q/ySeqkDwRhf81YMzaV8
	 2dSkkeISNZchZQO1xEGB6hb55GP1jJwH9b2sYlcShwBHPI0mz6fecMEDm3puC+2MCA
	 IGF4mCsh5nIk7HLroilpz9lWSjvTYJAt2Ve8UNnI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfLWNdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 08:33:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:50908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727029AbfLWNdB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 08:33:01 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32F5E20709;
        Mon, 23 Dec 2019 13:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577107981;
        bh=Z/dplSt9r9WofkvicgxOZVvQjd0WVhmkDb6ugHjockQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dIpDHFgyszqsgPdD2RBm79sBHRWlinjEggpdvwUlHXkUPSXr4kKBhR6pAjD58M0VA
         xGimm+18YDK6AHW4bgY7LVd2nGy0Dco/Y/TMAJpPxfevu6MwamBZ4IxpeL3bb5Dd+L
         g4vQnbokPqXheLmU5BV9Lg87/bve4zx0hgnOAjdY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 3/4] perf map: Set kmap->kmaps backpointer for main kernel map chunks
Date:   Mon, 23 Dec 2019 10:32:40 -0300
Message-Id: <20191223133241.8578-4-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20191223133241.8578-1-acme@kernel.org>
References: <20191223133241.8578-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

When a map is create to represent the main kernel area (vmlinux) with
map__new2() we allocate an extra area to store a pointer to the 'struct
maps' for the kernel maps, so that we can access that struct when
loading ELF files or kallsyms, as we will need to split it in multiple
maps, one per kernel module or ELF section (such as ".init.text").

So when map->dso->kernel is non-zero, it is expected that
map__kmap(map)->kmaps to be set to the tree of kernel maps (modules,
chunks of the main kernel, bpf progs put in place via
PERF_RECORD_KSYMBOL, the main kernel).

This was not the case when we were splitting the main kernel into chunks
for its ELF sections, which ended up making 'perf report --children'
processing a perf.data file with callchains to trip on
__map__is_kernel(), when we press ENTER to see the popup menu for main
histogram entries that starts at a symbol in the ".init.text" ELF
section, e.g.:

-    8.83%     0.00%  swapper     [kernel.vmlinux].init.text  [k] start_kernel
     start_kernel
     cpu_startup_entry
     do_idle
     cpuidle_enter
     cpuidle_enter_state
     intel_idle

Fix it.

Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/lkml/20191218190120.GB13282@kernel.org/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol-elf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 6658fbf196e6..1965aefccb02 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -920,6 +920,9 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
 		if (curr_map == NULL)
 			return -1;
 
+		if (curr_dso->kernel)
+			map__kmap(curr_map)->kmaps = kmaps;
+
 		if (adjust_kernel_syms) {
 			curr_map->start  = shdr->sh_addr + ref_reloc(kmap);
 			curr_map->end	 = curr_map->start + shdr->sh_size;
-- 
2.21.1

