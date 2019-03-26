Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E2DC10F05
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C65FF20811
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:31:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732938AbfCZXbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 19:31:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58812 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732546AbfCZXbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 19:31:02 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2QNT4Qw122383
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 19:31:01 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rfuyg3rb7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 19:31:00 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 26 Mar 2019 23:30:59 -0000
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Mar 2019 23:30:55 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2QNUsFH13565970
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 23:30:54 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EE94EB2066;
        Tue, 26 Mar 2019 23:30:53 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CF21CB205F;
        Tue, 26 Mar 2019 23:30:53 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 26 Mar 2019 23:30:53 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id EA1E016C60F3; Tue, 26 Mar 2019 16:30:54 -0700 (PDT)
Date:   Tue, 26 Mar 2019 16:30:54 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/9] Torture-test updates for v5.2
Reply-To: paulmck@linux.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19032623-0052-0000-0000-000003A18883
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010820; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000282; SDB=6.01180139; UDB=6.00617576; IPR=6.00960854;
 MB=3.00026170; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-26 23:30:59
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032623-0053-0000-0000-00006048DF83
Message-Id: <20190326233054.GA21523@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-26_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=15 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=905 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903260158
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series contains torture-test updates:

1.	Don't try to offline the last CPU.

2.	Convert rcutorture scripting to SPDX license identifier.

3.	Make rcutorture_extend_mask() comment match the code.

4.	Remove ->ext_irq_conflict field.

5.	Fix expected forward progress duration in OOM notifier, courtesy
	of Neeraj Upadhyay.

6.	Fix cleanup path for invalid torture_type strings.

7.	Fix cleanup path for invalid perf_type strings.

8.	NULL cxt.lwsa and cxt.lrsa to allow locktorture bad-arg detection.

9.	Suppress false-positive CONFIG_INITRAMFS_SOURCE complaint.

							Thanx, Paul

------------------------------------------------------------------------

 kernel/locking/locktorture.c                                         |    2 +
 kernel/rcu/rcuperf.c                                                 |    5 ++
 kernel/rcu/rcutorture.c                                              |   14 +++----
 kernel/torture.c                                                     |    2 +
 tools/testing/selftests/rcutorture/bin/configNR_CPUS.sh              |   17 +-------
 tools/testing/selftests/rcutorture/bin/config_override.sh            |   17 +-------
 tools/testing/selftests/rcutorture/bin/configcheck.sh                |   19 ++--------
 tools/testing/selftests/rcutorture/bin/configinit.sh                 |   17 +-------
 tools/testing/selftests/rcutorture/bin/cpus2use.sh                   |   17 +-------
 tools/testing/selftests/rcutorture/bin/functions.sh                  |   17 +-------
 tools/testing/selftests/rcutorture/bin/jitter.sh                     |   17 +-------
 tools/testing/selftests/rcutorture/bin/kvm-build.sh                  |   17 +-------
 tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh            |    5 ++
 tools/testing/selftests/rcutorture/bin/kvm-recheck-lock.sh           |   17 +-------
 tools/testing/selftests/rcutorture/bin/kvm-recheck-rcu.sh            |   17 +-------
 tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuperf-ftrace.sh |   17 +-------
 tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuperf.sh        |   17 +-------
 tools/testing/selftests/rcutorture/bin/kvm-recheck.sh                |   17 +-------
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh             |   17 +-------
 tools/testing/selftests/rcutorture/bin/kvm.sh                        |   17 +-------
 tools/testing/selftests/rcutorture/bin/mkinitrd.sh                   |   15 -------
 tools/testing/selftests/rcutorture/bin/parse-build.sh                |   17 +-------
 tools/testing/selftests/rcutorture/bin/parse-console.sh              |   17 +-------
 tools/testing/selftests/rcutorture/configs/lock/ver_functions.sh     |   17 +-------
 tools/testing/selftests/rcutorture/configs/rcu/ver_functions.sh      |   17 +-------
 tools/testing/selftests/rcutorture/configs/rcuperf/ver_functions.sh  |   17 +-------
 26 files changed, 64 insertions(+), 321 deletions(-)

