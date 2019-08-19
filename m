Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3038C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 20:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDB0B214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 20:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbfHSUXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 16:23:09 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:36356 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728055AbfHSUXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 16:23:09 -0400
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7JKLGui016238;
        Mon, 19 Aug 2019 20:22:51 GMT
Received: from g4t3427.houston.hpe.com (g4t3427.houston.hpe.com [15.241.140.73])
        by mx0b-002e3701.pphosted.com with ESMTP id 2ug0d0rxnt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Aug 2019 20:22:51 +0000
Received: from stormcage.eag.rdlabs.hpecorp.net (stormcage.eag.rdlabs.hpecorp.net [128.162.236.70])
        by g4t3427.houston.hpe.com (Postfix) with ESMTP id 0CF0B5C;
        Mon, 19 Aug 2019 20:22:50 +0000 (UTC)
Received: by stormcage.eag.rdlabs.hpecorp.net (Postfix, from userid 48777)
        id BBE5D2014C869; Mon, 19 Aug 2019 15:22:49 -0500 (CDT)
From:   Kyle Meyer <meyerk@hpe.com>
Cc:     Kyle Meyer <meyerk@hpe.com>, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org,
        Russ Anderson <russ.anderson@hpe.com>,
        Kyle Meyer <kyle.meyer@hpe.com>
Subject: [PATCH v3 0/6] perf: Replace MAX_NR_CPUS with dynamic alternatives 
Date:   Mon, 19 Aug 2019 15:22:41 -0500
Message-Id: <20190819202241.87799-1-meyerk@stormcage.eag.rdlabs.hpecorp.net>
X-Mailer: git-send-email 2.12.3
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-19_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=986 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908190207
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The purpose of this patch series is to replace MAX_NR_CPUS with a dynamic value
throughout perf wherever possible using nr_cpus_online, the number of CPUs
online during a record session, and cpu__max_cpu, the possible number of CPUs as
defined in the sysfs. MAX_NR_CPUS is still used by DECLARE_BITMAP at compile
time, however, it's replaced elsewhere.

This patch series was tested using "perf record -a -g" on both an eight socket
(288 CPU) system and a single socket (36 CPU) system. Each system was then
rebooted single socket and eight socket before "perf report" was used to read
the perf.data out file. "perf report --header" was used to confirm that each
perf.data file had information on the correct number of CPUs.

Change since v1:
  Broke PATCH 2/2 into multiple patches.

Changes since v2:
  Replaced env->sibling_cores and env->sibling threads with a local pointer and
  refreshed perf/util/svghelper.

  Kyle Meyer (6):
    perf: Refactor svg_build_topology_map
    perf/util/svghelper: Replace MAX_NR_CPUS with env->nr_cpus_online
    perf/util/stat: Replace MAX_NR_CPUS with cpu__max_cpu
    perf/util/session: Replace MAX_NR_CPUS with nr_cpus_online
    perf/util/machine: Replace MAX_NR_CPUS with nr_cpus_online
    perf/util/header: Replace MAX_NR_CPUS with cpu__max_cpu

 tools/perf/builtin-timechart.c |  5 +----
 tools/perf/util/header.c       |  7 +++---
 tools/perf/util/machine.c      | 12 ++++++-----
 tools/perf/util/session.c      |  6 +++---
 tools/perf/util/stat.c         |  4 ++--
 tools/perf/util/svghelper.c    | 48 +++++++++++++++++++++---------------------
 tools/perf/util/svghelper.h    |  4 +++-
 7 files changed, 44 insertions(+), 42 deletions(-)

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: Russ Anderson <russ.anderson@hpe.com>
Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
-- 
2.12.3

