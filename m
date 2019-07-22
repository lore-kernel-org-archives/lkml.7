Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C3DCC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5577021955
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563817147;
	bh=c3B0smuDkmWXSxbZIwbw8pkX6fJx6IjY1J/ZCjJNx00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PK6LOpgpuEPazjxljXzloyVciSJI3quDT7UxwbEUFcsrijnOgTRxCa2CwjMDUKBL1
	 GjcbPfjSjQi/jyvJxBI70p4rFiLOLP4Hz67cTYFm1vataepN4WWXPc09gBHCc4qG9M
	 YA1KTLvv8vXY0R46e2UM4jl04pb/Tx99hbr3p1EA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbfGVRjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 13:39:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:45342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728860AbfGVRjG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 13:39:06 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BA2821903;
        Mon, 22 Jul 2019 17:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563817144;
        bh=c3B0smuDkmWXSxbZIwbw8pkX6fJx6IjY1J/ZCjJNx00=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Em3KCI63NyhBoCQnPQmaldYmCnf1WiN8RXXf1Ko9pbs4OXGgJIZzQWTVUMrhRQczG
         iP0IqSlGSwM4y5T8wMrz5hAEhr+BpdZWc0rM43vyLjjJ01wCINbnOEYRLcpWSZvB/0
         8t4O1UZlETQkudML4nchO0lNWk9g2/5GCFfgv82o=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>
Subject: [PATCH 01/37] perf include bpf: Add bpf_tail_call() prototype
Date:   Mon, 22 Jul 2019 14:38:03 -0300
Message-Id: <20190722173839.22898-2-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190722173839.22898-1-acme@kernel.org>
References: <20190722173839.22898-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Will be used together with BPF_MAP_TYPE_PROG_ARRAY in
tools/perf/examples/bpf/augmented_raw_syscalls.c.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-pd1bpy8i31nta6jqwdex871g@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/include/bpf/bpf.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/include/bpf/bpf.h b/tools/perf/include/bpf/bpf.h
index 2eac6d804b2d..b422aeef5339 100644
--- a/tools/perf/include/bpf/bpf.h
+++ b/tools/perf/include/bpf/bpf.h
@@ -45,6 +45,8 @@ struct ____btf_map_##name __attribute__((section(".maps." #name), used)) \
 static int (*bpf_map_update_elem)(struct bpf_map *map, void *key, void *value, u64 flags) = (void *)BPF_FUNC_map_update_elem;
 static void *(*bpf_map_lookup_elem)(struct bpf_map *map, void *key) = (void *)BPF_FUNC_map_lookup_elem;
 
+static void (*bpf_tail_call)(void *ctx, void *map, int index) = (void *)BPF_FUNC_tail_call;
+
 #define SEC(NAME) __attribute__((section(NAME),  used))
 
 #define probe(function, vars) \
-- 
2.21.0

