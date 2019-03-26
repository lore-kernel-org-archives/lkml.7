Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE473C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C686D20811
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732637AbfCZXlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 19:41:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53442 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730333AbfCZXlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 19:41:20 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2QNXdD4004246
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 19:41:18 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rfvt9t845-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 19:41:18 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 26 Mar 2019 23:41:17 -0000
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Mar 2019 23:41:14 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2QNfD5i24182842
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 23:41:13 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4E5E1B2064;
        Tue, 26 Mar 2019 23:41:13 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 30514B205F;
        Tue, 26 Mar 2019 23:41:13 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 26 Mar 2019 23:41:13 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 4F9AD16C121C; Tue, 26 Mar 2019 16:41:14 -0700 (PDT)
Date:   Tue, 26 Mar 2019 16:41:14 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org
Cc:     stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
Subject: [PATCH RFC memory-model 0/21] LKMM updates for review
Reply-To: paulmck@linux.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19032623-0072-0000-0000-00000410BC81
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010820; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000282; SDB=6.01180142; UDB=6.00617577; IPR=6.00960857;
 MB=3.00026170; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-26 23:41:17
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032623-0073-0000-0000-00004B9D62EE
Message-Id: <20190326234114.GA23843@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-26_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=836 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903260159
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series contains LKMM updates:

1.	Make scripts be executable.

2.	Fix comment in MP+poonceonces.litmus, courtesy of Andrea Parri.

3.	Do not use "herd" to refer to "herd7", courtesy of Andrea Parri.

4.	Rewrite "KERNEL I/O BARRIER EFFECTS" section of memory-barriers.txt,
	courtesy of Will Deacon.

5-6.	Make LKMM scripts note timeouts instead of just saying that
	the validation was bad.

7.	Make LKMM scripts identify litmus-test typos and use of
	unsupported primitives instead of just saying that the validation
	was bad.

8.	Add support for synchronize_srcu_expedited().

9.	Make LKMM scripts detect unconditional deadlocks.

10-21.	Leverage Boqun Feng's C-to-assembly litmus-test-translation
	capability to allow verifying LKMM against hardware models
	for checkalllitmus.sh.  This is a work in progress.

							Thanx, Paul

------------------------------------------------------------------------

 Documentation/memory-barriers.txt                     |  115 +++++++++------
 tools/memory-model/linux-kernel.def                   |    1 
 tools/memory-model/litmus-tests/.gitignore            |    4 
 tools/memory-model/litmus-tests/MP+poonceonces.litmus |    2 
 tools/memory-model/litmus-tests/README                |    2 
 tools/memory-model/lock.cat                           |    2 
 tools/memory-model/scripts/README                     |   12 -
 tools/memory-model/scripts/checkalllitmus.sh          |   29 +--
 tools/memory-model/scripts/checklitmus.sh             |  101 +++++--------
 tools/memory-model/scripts/cmplitmushist.sh           |   53 ++++++
 tools/memory-model/scripts/judgelitmus.sh             |  114 +++++++++++---
 tools/memory-model/scripts/parseargs.sh               |   11 +
 tools/memory-model/scripts/runlitmus.sh               |  137 ++++++++++++++----
 tools/memory-model/scripts/runlitmushist.sh           |    3 
 tools/memory-model/scripts/simpletest.sh              |   35 ++++
 15 files changed, 425 insertions(+), 196 deletions(-)

