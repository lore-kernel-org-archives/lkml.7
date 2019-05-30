Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FAFC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 15:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 039DB25734
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 15:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbfE3PRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 11:17:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49150 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727611AbfE3PRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 11:17:53 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4UFHok7060131
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 11:17:52 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2stg3bvm12-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 11:17:50 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 30 May 2019 16:16:55 +0100
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 30 May 2019 16:16:50 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4UFGnld13959444
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 15:16:49 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3F03CB205F;
        Thu, 30 May 2019 15:16:49 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 20D45B2066;
        Thu, 30 May 2019 15:16:49 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.216])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 30 May 2019 15:16:49 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id E14E616C373B; Thu, 30 May 2019 08:16:50 -0700 (PDT)
Date:   Thu, 30 May 2019 08:16:50 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/21] Torture-test updates for v5.3
Reply-To: paulmck@linux.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19053015-0040-0000-0000-000004F68402
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011185; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01210791; UDB=6.00636161; IPR=6.00991825;
 MB=3.00027120; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-30 15:16:54
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19053015-0041-0000-0000-000009029E54
Message-Id: <20190530151650.GA422@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-30_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=43 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905300108
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series contains torture-test updates:

1.	Make jitter.sh select from only online CPUs, courtesy of
	Joel Fernandes.

2.	Add cpu0 to the set of CPUs to add jitter, courtesy of Joel
	Fernandes.

3.	Add cond_resched() to forward-progress free-up loop.

4.	Fix stutter_wait() return value and freelist checks.

5.	Allow inter-stutter interval to be specified.

6.	Make kvm-find-errors.sh and kvm-recheck.sh provide exit status.

7.	Provide rudimentary Makefile.

8.	Exempt tasks RCU from timely draining of grace periods.

9.	Exempt TREE01 from forward-progress testing.

10.	Give the scheduler a chance on PREEMPT && NO_HZ_FULL kernels.

11.	Halt forward-progress checks at end of run.

12.	Add trivial RCU implementation.

13.	Tweak kvm options, courtesy of Sebastian Andrzej Siewior.

14.	Capture qemu output.

15.	Add function graph-tracing cheat sheet.

16.	Run kernel build in source directory.

17.	Make --cpus override idleness calculations.

18.	Add --trust-make to suppress "make clean".

19.	Dump trace buffer for callback pipe drain failures.

20.	Suppress propagating trace_printk() warning.

21.	Upper case solves the case of the vanishing NULL pointer.

							Thanx, Paul

------------------------------------------------------------------------

 include/linux/torture.h                                     |    2 
 kernel/locking/locktorture.c                                |    2 
 kernel/rcu/rcu.h                                            |    5 
 kernel/rcu/rcutorture.c                                     |  104 ++++++++++--
 kernel/rcu/update.c                                         |   13 +
 kernel/torture.c                                            |   23 +-
 tools/testing/selftests/rcutorture/Makefile                 |    3 
 tools/testing/selftests/rcutorture/bin/configinit.sh        |   41 +---
 tools/testing/selftests/rcutorture/bin/cpus2use.sh          |    5 
 tools/testing/selftests/rcutorture/bin/functions.sh         |   13 +
 tools/testing/selftests/rcutorture/bin/jitter.sh            |   13 +
 tools/testing/selftests/rcutorture/bin/kvm-build.sh         |    9 -
 tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh   |    3 
 tools/testing/selftests/rcutorture/bin/kvm-recheck.sh       |   13 +
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh    |   23 +-
 tools/testing/selftests/rcutorture/bin/kvm.sh               |   14 +
 tools/testing/selftests/rcutorture/bin/parse-build.sh       |    2 
 tools/testing/selftests/rcutorture/bin/parse-console.sh     |    1 
 tools/testing/selftests/rcutorture/configs/rcu/CFcommon     |    3 
 tools/testing/selftests/rcutorture/configs/rcu/TREE01.boot  |    1 
 tools/testing/selftests/rcutorture/configs/rcu/TRIVIAL      |   14 +
 tools/testing/selftests/rcutorture/configs/rcu/TRIVIAL.boot |    3 
 22 files changed, 231 insertions(+), 79 deletions(-)

