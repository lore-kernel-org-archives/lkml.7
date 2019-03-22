Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2BAC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C8532183E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553260334;
	bh=Zjw7mmu6xT9vTeHYWUK4aD8C0gy2qMfhMrCXgVfbfME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WRQiCmSYuq0RppwfiVayfgMhuJ2gjEhoG3itexuGr9SNJXiG+OUvYf3xb4B6n1WU4
	 UwKngnkeG479iIUuvFxV8G+UvIZNVMJkeLflzXyZEl3O/OLXNBJ+A4cIp08HIYIxDx
	 Xoka71DRWCHlluQ1e7xRpRHjZhXSJ6hkgff/KUkU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730296AbfCVNMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 09:12:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:60252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729913AbfCVLb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:31:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2D7520449;
        Fri, 22 Mar 2019 11:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254317;
        bh=Zjw7mmu6xT9vTeHYWUK4aD8C0gy2qMfhMrCXgVfbfME=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mZEOENyGlhfithUV+yPYvP2gzsFUR61yvX/mR0uZl9ez9PupIYbk/65MxoVmDCZWl
         6+yNZ2lYfgxMUHhAlDl9KKpEnAdtG0mir+GNP8low3AaOc6atR2YBC4FVsfIW3XIlL
         +ViVx4tkdjQq/ThS8FraMFX8poxOkaYx3XPZupkc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephane Eranian <eranian@google.com>,
        Jiri Olsa <jolsa@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 081/230] perf tools: Handle TOPOLOGY headers with no CPU
Date:   Fri, 22 Mar 2019 12:13:39 +0100
Message-Id: <20190322111242.322481828@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 1497e804d1a6e2bd9107ddf64b0310449f4673eb ]

This patch fixes an issue in cpumap.c when used with the TOPOLOGY
header. In some configurations, some NUMA nodes may have no CPU (empty
cpulist). Yet a cpumap map must be created otherwise perf abort with an
error. This patch handles this case by creating a dummy map.

  Before:

  $ perf record -o - -e cycles noploop 2 | perf script -i -
  0x6e8 [0x6c]: failed to process type: 80

  After:

  $ perf record -o - -e cycles noploop 2 | perf script -i -
  noploop for 2 seconds

Signed-off-by: Stephane Eranian <eranian@google.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1547885559-1657-1-git-send-email-eranian@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/cpumap.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 10af1e7524fb..f1aae86f7f6c 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -124,7 +124,12 @@ struct cpu_map *cpu_map__new(const char *cpu_list)
 	if (!cpu_list)
 		return cpu_map__read_all_cpu_map();
 
-	if (!isdigit(*cpu_list))
+	/*
+	 * must handle the case of empty cpumap to cover
+	 * TOPOLOGY header for NUMA nodes with no CPU
+	 * ( e.g., because of CPU hotplug)
+	 */
+	if (!isdigit(*cpu_list) && *cpu_list != '\0')
 		goto out;
 
 	while (isdigit(*cpu_list)) {
@@ -171,8 +176,10 @@ struct cpu_map *cpu_map__new(const char *cpu_list)
 
 	if (nr_cpus > 0)
 		cpus = cpu_map__trim_new(nr_cpus, tmp_cpus);
-	else
+	else if (*cpu_list != '\0')
 		cpus = cpu_map__default_new();
+	else
+		cpus = cpu_map__dummy_new();
 invalid:
 	free(tmp_cpus);
 out:
-- 
2.19.1



