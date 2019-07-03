Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24104C5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9EEE218FC
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="Qfmw8rq2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbfGCAuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 20:50:19 -0400
Received: from mx0a-00190b01.pphosted.com ([67.231.149.131]:34862 "EHLO
        mx0a-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727099AbfGCAuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 20:50:18 -0400
Received: from pps.filterd (m0122332.ppops.net [127.0.0.1])
        by mx0a-00190b01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6306Sx4010435;
        Wed, 3 Jul 2019 01:11:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=jan2016.eng;
 bh=NBhp0VNKqsN8dR0Rg+MFGXOHNBagdyx9X/DM8wfLcf4=;
 b=Qfmw8rq2YnE7ynSepSyR5vfsAcWLcD+GfT9TIsaXwBE31fWdxW+1ttuyRZcE99t0CjZX
 OWBNaF10zftvthk5Un1Ho9cMyS5qrWd0OAfevyBap3OB80DHXlrNv5g3sTsJ8+KQnY9X
 a8L+L+4I7uP7uHxet83E+lNx8H5WLdmERlXhKe6qDzwjll/sczS0x7Pbfov0wVkk9zXY
 CgHMNjPqI3SNRjZLdon8S+PXPn9sVOyCi85AKN9N7iuNIGikcYrAPgoJUJKKN55XF4xp
 rS7zsgbyWqso3B76rnqqMqfOjf34y8xZXy/p7LDn8zRAXnBj+XLZVnwDtSVuOt6HXB94 lQ== 
Received: from prod-mail-ppoint3 (prod-mail-ppoint3.akamai.com [96.6.114.86] (may be forged))
        by mx0a-00190b01.pphosted.com with ESMTP id 2tft0ddefx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Jul 2019 01:11:12 +0100
Received: from pps.filterd (prod-mail-ppoint3.akamai.com [127.0.0.1])
        by prod-mail-ppoint3.akamai.com (8.16.0.27/8.16.0.27) with SMTP id x6302MSK021891;
        Tue, 2 Jul 2019 20:11:11 -0400
Received: from email.msg.corp.akamai.com ([172.27.123.34])
        by prod-mail-ppoint3.akamai.com with ESMTP id 2te3b09eb1-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 02 Jul 2019 20:11:10 -0400
Received: from USMA1EX-CAS1.msg.corp.akamai.com (172.27.123.30) by
 usma1ex-dag1mb4.msg.corp.akamai.com (172.27.123.104) with Microsoft SMTP
 Server (TLS) id 15.0.1473.3; Tue, 2 Jul 2019 20:10:49 -0400
Received: from igorcastle.kendall.corp.akamai.com (172.29.170.135) by
 USMA1EX-CAS1.msg.corp.akamai.com (172.27.123.30) with Microsoft SMTP Server
 id 15.0.1473.3 via Frontend Transport; Tue, 2 Jul 2019 20:10:49 -0400
Received: by igorcastle.kendall.corp.akamai.com (Postfix, from userid 29659)
        id A151C61D57; Tue,  2 Jul 2019 20:10:47 -0400 (EDT)
From:   Igor Lubashev <ilubashe@akamai.com>
To:     <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        James Morris <jmorris@namei.org>,
        Igor Lubashev <ilubashe@akamai.com>
Subject: [PATCH 0/3] perf: Use capabilities instead of uid and euid
Date:   Tue, 2 Jul 2019 20:10:02 -0400
Message-ID: <1562112605-6235-1-git-send-email-ilubashe@akamai.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-02_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907020268
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-02_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907020269
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel is using capabilities instead of uid and euid to restrict access to
kernel pointers and tracing facilities.  This patch series updates the perf to
better match the security model used by the kernel.

This series enables instructions in Documentation/admin-guide/perf-security.rst
to actually work, even when kernel.perf_event_paranoid=2 and
kernel.kptr_restrict=1.

The series consists of three patches:

  01: perf: Add capability-related utilities
    Add utility functions to check capabilities and perf_event_paranoid checks.

  02: perf: Use CAP_SYS_ADMIN with perf_event_paranoid checks
    Replace the use of euid==0 with a check for CAP_SYS_ADMIN whenever
    perf_event_paranoid level is verified.

  03: perf: Use CAP_SYSLOG with kptr_restrict checks
    Replace the use of uid and euid with a check for CAP_SYSLOG when
    kptr_restrict is verified (similar to kernel/kallsyms.c and lib/vsprintf.c).
    Consult perf_event_paranoid when kptr_restrict==0 (see kernel/kallsyms.c).

I tested this by following Documentation/admin-guide/perf-security.rst
guidelines and setting sysctls:

   kernel.perf_event_paranoid=2
   kernel.kptr_restrict=1

As an unpriviledged user who is in perf_users group (setup via instructions
above), I executed:
   perf record -a -- sleep 1

Without the patch, perf record did not capture any kernel functions.
With the patch, perf included all kernel funcitons.

Igor Lubashev (3):
  perf: Add capability-related utilities
  perf: Use CAP_SYS_ADMIN with perf_event_paranoid checks
  perf: Use CAP_SYSLOG with kptr_restrict checks

 tools/perf/Makefile.config           |  2 +-
 tools/perf/arch/arm/util/cs-etm.c    |  3 ++-
 tools/perf/arch/arm64/util/arm-spe.c |  3 ++-
 tools/perf/arch/x86/util/intel-bts.c |  3 ++-
 tools/perf/arch/x86/util/intel-pt.c  |  2 +-
 tools/perf/util/Build                |  1 +
 tools/perf/util/cap.c                | 24 ++++++++++++++++++++++++
 tools/perf/util/cap.h                | 10 ++++++++++
 tools/perf/util/event.h              |  1 +
 tools/perf/util/evsel.c              |  2 +-
 tools/perf/util/python-ext-sources   |  1 +
 tools/perf/util/symbol.c             | 15 +++++++++++----
 tools/perf/util/util.c               |  9 +++++++++
 13 files changed, 66 insertions(+), 10 deletions(-)
 create mode 100644 tools/perf/util/cap.c
 create mode 100644 tools/perf/util/cap.h

-- 
2.7.4

