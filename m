Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF5CC4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 11:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D587218AF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 11:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404246AbfIILlm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 07:41:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:8788 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729627AbfIILll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 07:41:41 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x89BRRTP091300
        for <linux-kernel@vger.kernel.org>; Mon, 9 Sep 2019 07:41:40 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uwma8wcw5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 07:41:39 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tmricht@linux.ibm.com>;
        Mon, 9 Sep 2019 12:41:37 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 9 Sep 2019 12:41:34 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x89BfXeb45416592
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 Sep 2019 11:41:33 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 47A53A4051;
        Mon,  9 Sep 2019 11:41:33 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0412EA4040;
        Mon,  9 Sep 2019 11:41:33 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  9 Sep 2019 11:41:32 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     brueckner@linux.ibm.com, gor@linux.ibm.com,
        heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH 1/3] perf jvmti: Link against tools/lib/string.h to have weak strlcpy()
Date:   Mon,  9 Sep 2019 13:41:14 +0200
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190909114116.50469-1-tmricht@linux.ibm.com>
References: <20190909114116.50469-1-tmricht@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19090911-4275-0000-0000-00000363323A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19090911-4276-0000-0000-000038758232
Message-Id: <20190909114116.50469-2-tmricht@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-09_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=929 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909090121
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

That is needed in systems such some S/390 distros.

 [root@m35lp76 perf]# readelf -s jvmti/jvmti-in.o | fgrep strlcpy
   408: 0000000000002bc8   216 FUNC    WEAK   DEFAULT  116 strlcpy
 [root@m35lp76 perf]#

Suggested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/jvmti/Build | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/perf/jvmti/Build b/tools/perf/jvmti/Build
index eaeb8cb5379b..202cadaaf097 100644
--- a/tools/perf/jvmti/Build
+++ b/tools/perf/jvmti/Build
@@ -1,8 +1,21 @@
 jvmti-y += libjvmti.o
 jvmti-y += jvmti_agent.o
 
+# For strlcpy
+jvmti-y += libstring.o libctype.o
+
 CFLAGS_jvmti         = -fPIC -DPIC -I$(JDIR)/include -I$(JDIR)/include/linux
 CFLAGS_REMOVE_jvmti  = -Wmissing-declarations
 CFLAGS_REMOVE_jvmti += -Wstrict-prototypes
 CFLAGS_REMOVE_jvmti += -Wextra
 CFLAGS_REMOVE_jvmti += -Wwrite-strings
+
+CFLAGS_libstring.o += -Wno-unused-parameter -DETC_PERFCONFIG="BUILD_STR($(ETC_PERFCONFIG_SQ))"
+
+$(OUTPUT)jvmti/libstring.o: ../lib/string.c FORCE
+	$(call rule_mkdir)
+	$(call if_changed_dep,cc_o_c)
+
+$(OUTPUT)jvmti/libctype.o: ../lib/ctype.c FORCE
+	$(call rule_mkdir)
+	$(call if_changed_dep,cc_o_c)
-- 
2.21.0

