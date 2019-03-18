Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF9CEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 953CD2084F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfCRRuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 13:50:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57946 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726626AbfCRRuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 13:50:20 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2IHhwGI113935
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 13:50:19 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2raf9et1fb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 13:50:18 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 18 Mar 2019 17:50:16 -0000
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 18 Mar 2019 17:50:11 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2IHoBie24445096
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Mar 2019 17:50:11 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B2E77B2066;
        Mon, 18 Mar 2019 17:50:10 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9E0CDB2073;
        Mon, 18 Mar 2019 17:50:10 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 18 Mar 2019 17:50:10 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 53F4E16C3C25; Mon, 18 Mar 2019 10:50:59 -0700 (PDT)
Date:   Mon, 18 Mar 2019 10:50:59 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org
Cc:     stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
Subject: LKMM patch status
Reply-To: paulmck@linux.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19031817-0064-0000-0000-000003BBF334
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010780; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01176225; UDB=6.00615208; IPR=6.00956909;
 MB=3.00026037; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-18 17:50:15
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031817-0065-0000-0000-00003CC2FF07
Message-Id: <20190318175059.GA3322@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-18_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=879 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903180131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!


pick 0172d9e32203 tools/memory-model: Rename some RCU relations
pick 284749b0aebb tools/memory-model: Refactor some RCU relations
pick a3f600d92da5 tools/memory-model: Add SRCU support
pick ad9fd20b6dad tools/memory-model: Update README for addition of SRCU
pick 648e717586f2 tools/memory-model: Update Documentation/explanation.txt to include SRCU support
pick 9393998e9ee0 tools/memory-model: Dynamically check SRCU lock-to-unlock matching
pick 034fb712a620 tools/memory-model: Avoid duplicating herdtools versions

	Ready to go, sent for inclusion in tip, and will presumably show
	up there soon.

	http://lkml.kernel.org/r/20190213173650.GA26078@linux.ibm.com

pick 487ecc460732 sched/Documentation/kokr: Update Korean translation to update wake_up() & co. memory-barrier guarantees
pick db467147f131 locking/memory-barriers/kokr: Update Korean translation to replace smp_cond_acquire() with smp_cond_load_acquire()
pick f1887143f598 Documentation/atomic_t: Clarify signed vs unsigned

	These have the needed acks/reviews, so I will send them as RFC
	patches within the next week or two.

pick ece264389af9 tools/memory-model: Make scripts be executable
pick fd4b7b3c6c0d tools/memory-model: Fix comment in MP+poonceonces.litmus
pick e9cc6e9437e2 tools/memory-model: Do not use "herd" to refer to "herd7"
pick 093e4c7dcf79 docs/memory-barriers.txt: Rewrite "KERNEL I/O BARRIER EFFECTS" section

	These all need at least one Reviewed-by or Acked-by.

								Thanx, Paul

