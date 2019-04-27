Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D88C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 18:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 225DA2087F
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 18:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbfD0SEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 14:04:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35844 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725950AbfD0SEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 14:04:06 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3RI3wjF072813
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2019 14:04:05 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s4fyra2rf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2019 14:04:05 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sat, 27 Apr 2019 19:04:04 +0100
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 27 Apr 2019 19:04:03 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3RI2lO827394194
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 27 Apr 2019 18:02:47 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 29843B2068;
        Sat, 27 Apr 2019 18:02:47 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0528CB2067;
        Sat, 27 Apr 2019 18:02:47 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.220.189])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sat, 27 Apr 2019 18:02:46 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id A606716C0E9F; Sat, 27 Apr 2019 11:02:46 -0700 (PDT)
Date:   Sat, 27 Apr 2019 11:02:46 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, andrea.parri@amarulasolutions.com
Subject: Question about sched_setaffinity()
Reply-To: paulmck@linux.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19042718-0072-0000-0000-000004220FCA
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011006; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01195222; UDB=6.00626710; IPR=6.00976064;
 MB=3.00026624; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-27 18:04:04
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042718-0073-0000-0000-00004BFD9E12
Message-Id: <20190427180246.GA15502@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-27_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1031 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=930 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904270129
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Peter!

TL;DR: If a normal !PF_NO_SETAFFINITY kthread invokes sched_setaffinity(),
and sched_setaffinity() returns 0, is it expected behavior for that
kthread to be running on some CPU other than one of the ones specified by
the in_mask argument?  All CPUs are online, and there is no CPU-hotplug
activity taking place.

							Thanx, Paul

Details:

I have long showed the following "toy" synchronize_rcu() implementation:

	void synchronize_rcu(void)
	{
		int cpu;

		for_each_online_cpu(cpu)
			run_on(cpu);
	}

I decided that if I was going to show it, I should test it.  And it
occurred to me that run_on() can be a call to sched_setaffinity():

	void synchronize_rcu(void)
	{
		int cpu;

		for_each_online_cpu(cpu)
			sched_setaffinity(current->pid, cpumask_of(cpu));
	}

This actually passes rcutorture.  But, as Andrea noted, not klitmus.
After some investigation, it turned out that klitmus was creating kthreads
with PF_NO_SETAFFINITY, hence the failures.  But that prompted me to
put checks into my code: After all, rcutorture can be fooled.

	void synchronize_rcu(void)
	{
		int cpu;

		for_each_online_cpu(cpu) {
			sched_setaffinity(current->pid, cpumask_of(cpu));
			WARN_ON_ONCE(raw_smp_processor_id() != cpu);
		}
	}

This triggers fairly quickly, usually in less than a minute of rcutorture
testing.  And further investigation shows that sched_setaffinity()
always returned 0.  So I tried this hack:

	void synchronize_rcu(void)
	{
		int cpu;

		for_each_online_cpu(cpu) {
			while (raw_smp_processor_id() != cpu)
				sched_setaffinity(current->pid, cpumask_of(cpu));
			WARN_ON_ONCE(raw_smp_processor_id() != cpu);
		}
	}

This never triggers, and rcutorture's grace-period rate is not significantly
affected.

Is this expected behavior?  Is there some configuration or setup that I
might be missing?

