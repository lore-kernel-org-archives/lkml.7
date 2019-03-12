Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBB7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEC062087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552412527;
	bh=oGf+5LegI56IgcTMe7d5Lc16yUWmJTa+ihAuOpei0lg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ScOT9N8TxnevA3qOYMnKP90zCe6nQz7p1U5vuIZ90eaRnRwLJbaOZO7wtFQayYuWT
	 LTdnqdl1huQJzXfBsMC3R99jPe2EqsXtpuDE7rA1M3sAkMlMD/Z6SyrsoxAWgE1MOa
	 mYzq03gXlesfNSodVXCB8r/COxC52tXBPpaH8BDY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729608AbfCLRmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:42:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:57266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728965AbfCLRQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:16:01 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AB8921741;
        Tue, 12 Mar 2019 17:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410961;
        bh=oGf+5LegI56IgcTMe7d5Lc16yUWmJTa+ihAuOpei0lg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mbqgMOzlrPskpPY+KZevR5FdbDv073b6FEqkq4OlXVfYpHPxw1suk6cIsbArKQ2Tz
         IEoUrEV9wXcRynlDFkS8Iy+j8r4TWdU6L3XrCXUNeTZyvnkWm9douhvqA747msL+4M
         4mng++it5P+TA1WgSbPPbUl3GSCctZeOwgXH5Ivk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephane Eranian <eranian@google.com>,
        Jiri Olsa <jolsa@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 046/135] perf tools: Handle TOPOLOGY headers with no CPU
Date:   Tue, 12 Mar 2019 10:08:13 -0700
Message-Id: <20190312170345.381710194@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170341.127810985@linuxfoundation.org>
References: <20190312170341.127810985@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
index 1ccbd3342069..383674f448fc 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -134,7 +134,12 @@ struct cpu_map *cpu_map__new(const char *cpu_list)
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
@@ -181,8 +186,10 @@ struct cpu_map *cpu_map__new(const char *cpu_list)
 
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



