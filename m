Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6559CC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D435216C8
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="lPb+nXZ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730445AbfG3Rrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 13:47:39 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54435 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728291AbfG3Rri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 13:47:38 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UHlErx3319525
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 10:47:14 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UHlErx3319525
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564508834;
        bh=t+MkmvfE59ROIbsr4Gdom9ISpz3jiS++m6OWr/CW1Yw=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=lPb+nXZ9+9140fUT4nQfrej7Srsqp96aKOAl4Zvzbh5yOyvMYyKSncS9UGgfrJpSf
         Y+IMiMErPZOVX5DITOkYb96YdbuGm3iqyL8h+QPNsUMJ5EwlXiDcliS2OwBdF2ZWXU
         XYlX3uA2SGIyMRuts7AvwtFJzybyyyr0bvUxOfV7GJZ/7FoH6Qb8nTHqGLAvfCm3TI
         1vpnvzzRDjqKT2w+Jb2pbQaJ9ZXCjYXVXd03UzOPS1t8gh0Br2yVH7KMSYBPx4RW70
         G1a23dtk2sv00pj6dCEGCFTHPQLE1bjuaGHydfdtaSyKEgbj0MxfdlFhUGHsXeO14S
         1vK1KloLwxX8g==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UHlDk33319520;
        Tue, 30 Jul 2019 10:47:13 -0700
Date:   Tue, 30 Jul 2019 10:47:13 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-pd1bpy8i31nta6jqwdex871g@git.kernel.org>
Cc:     hpa@zytor.com, jolsa@kernel.org, adrian.hunter@intel.com,
        tglx@linutronix.de, namhyung@kernel.org, lclaudio@redhat.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org, acme@redhat.com
Reply-To: mingo@kernel.org, linux-kernel@vger.kernel.org,
          lclaudio@redhat.com, namhyung@kernel.org, acme@redhat.com,
          jolsa@kernel.org, hpa@zytor.com, tglx@linutronix.de,
          adrian.hunter@intel.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf include bpf: Add bpf_tail_call() prototype
Git-Commit-ID: 941a7658e065e339ebdaf27b9a7702f9935d1d4a
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

Commit-ID:  941a7658e065e339ebdaf27b9a7702f9935d1d4a
Gitweb:     https://git.kernel.org/tip/941a7658e065e339ebdaf27b9a7702f9935d1d4a
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 15 Jul 2019 15:25:41 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:40 -0300

perf include bpf: Add bpf_tail_call() prototype

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
