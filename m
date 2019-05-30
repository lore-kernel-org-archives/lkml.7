Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DACEC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 15:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BC7A25CA1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 15:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbfE3PS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 11:18:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32976 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727841AbfE3PSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 11:18:24 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4UFINEj135689
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 11:18:23 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sthh50ctk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 11:18:21 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 30 May 2019 16:17:18 +0100
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 30 May 2019 16:17:13 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4UFHB8T27328600
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 15:17:12 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D902CB2070;
        Thu, 30 May 2019 15:17:11 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BAA6CB2066;
        Thu, 30 May 2019 15:17:11 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.216])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 30 May 2019 15:17:11 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 8D53716C4086; Thu, 30 May 2019 08:17:13 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E . McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 02/21] rcutorture: Add cpu0 to the set of CPUs to add jitter
Date:   Thu, 30 May 2019 08:16:53 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190530151650.GA422@linux.ibm.com>
References: <20190530151650.GA422@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19053015-0064-0000-0000-000003E70FAB
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011185; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01210791; UDB=6.00636161; IPR=6.00991825;
 MB=3.00027120; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-30 15:17:16
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19053015-0065-0000-0000-00003DABA811
Message-Id: <20190530151712.1612-2-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-30_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=15 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905300108
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

jitter.sh currently does not add CPU0 to the list of CPUs for adding of
jitter. Let us add it to this list even when it is not hot-pluggable.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 tools/testing/selftests/rcutorture/bin/jitter.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/jitter.sh b/tools/testing/selftests/rcutorture/bin/jitter.sh
index 81c6e6ab5d83..dc49a3ba6111 100755
--- a/tools/testing/selftests/rcutorture/bin/jitter.sh
+++ b/tools/testing/selftests/rcutorture/bin/jitter.sh
@@ -36,8 +36,12 @@ do
 
 	# Set affinity to randomly selected online CPU
 	cpus=`grep 1 /sys/devices/system/cpu/*/online |
-		sed -e 's,/[^/]*$,,' -e 's/^[^0-9]*//' |
-		grep -v '^0*$'`
+		sed -e 's,/[^/]*$,,' -e 's/^[^0-9]*//'`
+
+	# Do not leave out poor old cpu0 which may not be hot-pluggable
+	if [ ! -f "/sys/devices/system/cpu/cpu0/online" ]; then
+		cpus="0 $cpus"
+	fi
 
 	cpumask=`awk -v cpus="$cpus" -v me=$me -v n=$n 'BEGIN {
 		srand(n + me + systime());
-- 
2.17.1

