Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395E2C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0933421905
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139184;
	bh=gPqgbgAv43Z+pTS2eiVMCMgsWht366RsZO0rxJYAt3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jc/C1kGXo4gkF34TfXjX9A+8agnCSV4TWpe4hvM7+Jlc/ABJi8WeFH9YWj9xHHn3j
	 Qj7KN46sYIcf7eqq3yyW1Dt9AYd0phE9aMGxVxYYuWzHPoZOf35icdevTCPeuvzpb3
	 RnEKaqedjq0xlzqpTrtnQAxdoPS1hUlvVHaL5kPU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731568AbfDARTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:19:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:47636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730628AbfDARTk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:19:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C19402133D;
        Mon,  1 Apr 2019 17:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139179;
        bh=gPqgbgAv43Z+pTS2eiVMCMgsWht366RsZO0rxJYAt3E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1YpBobFldiZVSfIUmgcv7tL0WTx6SqTegBF1CstSJHP9AsqcxUUTOkSpLDHcR6w1d
         3kBvtaZVkvU54Z5HhE7c0wyE5rXIwfr3dTbozyEzftsKqMAyNtfEkrN30FEJCcLeaM
         CEO2cBg6LcysN9Up9ULZpvrvHre8sxXt9R2/GNog=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kan Liang <kan.liang@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4.19 115/134] perf pmu: Fix parser error for uncore event alias
Date:   Mon,  1 Apr 2019 19:02:31 +0200
Message-Id: <20190401170055.017828410@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170044.243719205@linuxfoundation.org>
References: <20190401170044.243719205@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kan Liang <kan.liang@linux.intel.com>

commit e94d6b7f615e6dfbaf9fba7db6011db561461d0c upstream.

Perf fails to parse uncore event alias, for example:

  # perf stat -e unc_m_clockticks -a --no-merge sleep 1
  event syntax error: 'unc_m_clockticks'
                       \___ parser error

Current code assumes that the event alias is from one specific PMU.

To find the PMU, perf strcmps the PMU name of event alias with the real
PMU name on the system.

However, the uncore event alias may be from multiple PMUs with common
prefix. The PMU name of uncore event alias is the common prefix.

For example, UNC_M_CLOCKTICKS is clock event for iMC, which include 6
PMUs with the same prefix "uncore_imc" on a skylake server.

The real PMU names on the system for iMC are uncore_imc_0 ...
uncore_imc_5.

The strncmp is used to only check the common prefix for uncore event
alias.

With the patch:

  # perf stat -e unc_m_clockticks -a --no-merge sleep 1
  Performance counter stats for 'system wide':

       723,594,722      unc_m_clockticks [uncore_imc_5]
       724,001,954      unc_m_clockticks [uncore_imc_3]
       724,042,655      unc_m_clockticks [uncore_imc_1]
       724,161,001      unc_m_clockticks [uncore_imc_4]
       724,293,713      unc_m_clockticks [uncore_imc_2]
       724,340,901      unc_m_clockticks [uncore_imc_0]

       1.002090060 seconds time elapsed

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Cc: stable@vger.kernel.org
Fixes: ea1fa48c055f ("perf stat: Handle different PMU names with common prefix")
Link: http://lkml.kernel.org/r/1552672814-156173-1-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/perf/util/pmu.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -773,10 +773,20 @@ static void pmu_add_cpu_aliases(struct l
 
 		if (!is_arm_pmu_core(name)) {
 			pname = pe->pmu ? pe->pmu : "cpu";
+
+			/*
+			 * uncore alias may be from different PMU
+			 * with common prefix
+			 */
+			if (pmu_is_uncore(name) &&
+			    !strncmp(pname, name, strlen(pname)))
+				goto new_alias;
+
 			if (strcmp(pname, name))
 				continue;
 		}
 
+new_alias:
 		/* need type casts to override 'const' */
 		__perf_pmu__new_alias(head, NULL, (char *)pe->name,
 				(char *)pe->desc, (char *)pe->event,


