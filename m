Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BBBC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 08:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20935207FC
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 08:09:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729275AbfIMIJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 04:09:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29414 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727834AbfIMIJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 04:09:01 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8D87hTF119355
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 04:09:00 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uytcjnx0n-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 04:08:59 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <huntbag@linux.vnet.ibm.com>;
        Fri, 13 Sep 2019 09:08:42 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 13 Sep 2019 09:08:40 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8D88djp22085834
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Sep 2019 08:08:39 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 85A814C046;
        Fri, 13 Sep 2019 08:08:39 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 808EE4C040;
        Fri, 13 Sep 2019 08:08:38 +0000 (GMT)
Received: from boston16h.aus.stglabs.ibm.com (unknown [9.3.23.78])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 13 Sep 2019 08:08:38 +0000 (GMT)
From:   Abhishek Goel <huntbag@linux.vnet.ibm.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shuah@kernel.org, trenn@suse.com, ego@linux.vnet.ibm.com,
        Abhishek Goel <huntbag@linux.vnet.ibm.com>
Subject: [PATCH v2] cpupower : Handle set and info subcommands correctly
Date:   Fri, 13 Sep 2019 03:07:12 -0500
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
x-cbid: 19091308-0008-0000-0000-0000031522A9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19091308-0009-0000-0000-00004A33951D
Message-Id: <20190913080712.26383-1-huntbag@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-13_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909130078
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cpupower tool has set and info options which are being used only by
x86 machines. This patch removes support for these two subcommands
from generic cpupower utility. Thus, these two subcommands will now be
available only for intel.
This removes the ambiguous error message while using set option in case
of using non-intel systems.

Without this patch on a non-intel box:

root@ubuntu:~# cpupower info
System does not support Intel's performance bias setting

root@ubuntu:~# cpupower set -b 10
Error setting perf-bias value on CPU

With this patch on a non-intel box:

root@ubuntu:~# cpupower info
Supported commands are:
        frequency-info
        frequency-set
        idle-info
        idle-set
        monitor
        help

Same result for set subcommand.

This patch does not affect results on a intel box.

Signed-off-by: Abhishek Goel <huntbag@linux.vnet.ibm.com>
Acked-by: Thomas Renninger <trenn@suse.de>
---

changes from v1:
	Instead of bailing out early in set and info commands, in V2, we
	are cutting out support for these two commands for non-intel
	systems.

 tools/power/cpupower/utils/cpupower.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/power/cpupower/utils/cpupower.c b/tools/power/cpupower/utils/cpupower.c
index 8e3d08042825..babb9ab3afb1 100644
--- a/tools/power/cpupower/utils/cpupower.c
+++ b/tools/power/cpupower/utils/cpupower.c
@@ -52,8 +52,10 @@ static struct cmd_struct commands[] = {
 	{ "frequency-set",	cmd_freq_set,	1	},
 	{ "idle-info",		cmd_idle_info,	0	},
 	{ "idle-set",		cmd_idle_set,	1	},
+#if defined(__x86_64__) || defined(__i386__)
 	{ "set",		cmd_set,	1	},
 	{ "info",		cmd_info,	0	},
+#endif
 	{ "monitor",		cmd_monitor,	0	},
 	{ "help",		cmd_help,	0	},
 	/*	{ "bench",	cmd_bench,	1	}, */
-- 
2.17.1

