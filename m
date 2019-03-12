Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B398C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D3B52054F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552411710;
	bh=aHVuDXTHxhEXvg6//V8Vjw1hEo/l6MuWUIFiScQfMqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ppp8xborJnRjad0vNsdTsMZauitbWN3F30EHp6xDturE2hKBkBmLVgFZwh6qH581p
	 m58T6FGWqn857ukxgKoScZrYNATHMuRqiZjhowBGe7aNnFc1FfmHmVzk8lzQgbdUlG
	 GHArpP46yL00dtgnNQd/qB3K3FIp78AwlL/Pq6Fc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729869AbfCLR22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:28:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:33398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729633AbfCLRRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:17:32 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AA6C21850;
        Tue, 12 Mar 2019 17:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552411051;
        bh=aHVuDXTHxhEXvg6//V8Vjw1hEo/l6MuWUIFiScQfMqQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JURZJ4iAqeISpb7xf9A8FIGkivYkt5vJO55rgDy4x5UppXUzLGIdvyjERhvsUzw8R
         DubV9HuxJcl120YCryfch22Sqw9P53/EjBtHGuv98sPDTzxQPVijSxGGGEoC7j2ba+
         tLbXz8VQm5od09MyHT4z/miUMECSNdL2e9T0W7N0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 35/96] perf core: Fix perf_proc_update_handler() bug
Date:   Tue, 12 Mar 2019 10:09:53 -0700
Message-Id: <20190312171037.164023244@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312171034.530434962@linuxfoundation.org>
References: <20190312171034.530434962@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 1a51c5da5acc6c188c917ba572eebac5f8793432 ]

The perf_proc_update_handler() handles /proc/sys/kernel/perf_event_max_sample_rate
syctl variable.  When the PMU IRQ handler timing monitoring is disabled, i.e,
when /proc/sys/kernel/perf_cpu_time_max_percent is equal to 0 or 100,
then no modification to sysctl_perf_event_sample_rate is allowed to prevent
possible hang from wrong values.

The problem is that the test to prevent modification is made after the
sysctl variable is modified in perf_proc_update_handler().

You get an error:

  $ echo 10001 >/proc/sys/kernel/perf_event_max_sample_rate
  echo: write error: invalid argument

But the value is still modified causing all sorts of inconsistencies:

  $ cat /proc/sys/kernel/perf_event_max_sample_rate
  10001

This patch fixes the problem by moving the parsing of the value after
the test.

Committer testing:

  # echo 100 > /proc/sys/kernel/perf_cpu_time_max_percent
  # echo 10001 > /proc/sys/kernel/perf_event_max_sample_rate
  -bash: echo: write error: Invalid argument
  # cat /proc/sys/kernel/perf_event_max_sample_rate
  10001
  #

Signed-off-by: Stephane Eranian <eranian@google.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1547169436-6266-1-git-send-email-eranian@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/events/core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 17339506f9f8..5cbb2eda80b5 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -428,18 +428,18 @@ int perf_proc_update_handler(struct ctl_table *table, int write,
 		void __user *buffer, size_t *lenp,
 		loff_t *ppos)
 {
-	int ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
-
-	if (ret || !write)
-		return ret;
-
+	int ret;
+	int perf_cpu = sysctl_perf_cpu_time_max_percent;
 	/*
 	 * If throttling is disabled don't allow the write:
 	 */
-	if (sysctl_perf_cpu_time_max_percent == 100 ||
-	    sysctl_perf_cpu_time_max_percent == 0)
+	if (write && (perf_cpu == 100 || perf_cpu == 0))
 		return -EINVAL;
 
+	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
+	if (ret || !write)
+		return ret;
+
 	max_samples_per_tick = DIV_ROUND_UP(sysctl_perf_event_sample_rate, HZ);
 	perf_sample_period_ns = NSEC_PER_SEC / sysctl_perf_event_sample_rate;
 	update_perf_cpu_limits();
-- 
2.19.1



