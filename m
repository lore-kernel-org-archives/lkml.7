Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6732C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFED22186A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbfCTPn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 11:43:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36986 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726295AbfCTPn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 11:43:56 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2KFfebg023344
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 11:43:55 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rbqbq48yt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 11:43:54 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 20 Mar 2019 15:43:52 -0000
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 20 Mar 2019 15:43:49 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2KFhoug17563706
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Mar 2019 15:43:50 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 110C5B2065;
        Wed, 20 Mar 2019 15:43:50 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E7622B2066;
        Wed, 20 Mar 2019 15:43:49 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 20 Mar 2019 15:43:49 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 4B51116C30D6; Wed, 20 Mar 2019 08:44:40 -0700 (PDT)
Date:   Wed, 20 Mar 2019 08:44:40 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, tglx@linutronix.de,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH v2] rcu: Allow to eliminate softirq processing from
 rcutree
Reply-To: paulmck@linux.ibm.com
References: <20190315111130.4902-1-bigeasy@linutronix.de>
 <20190318022434.GE4102@linux.ibm.com>
 <20190319114419.qlsw3i5bmndoyvao@linutronix.de>
 <20190320113219.d6c3gouqbnsnl5nj@linutronix.de>
 <20190320152146.GH4102@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190320152146.GH4102@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19032015-0068-0000-0000-000003A88F92
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010789; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01177127; UDB=6.00615755; IPR=6.00957822;
 MB=3.00026075; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-20 15:43:51
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032015-0069-0000-0000-000047E1A171
Message-Id: <20190320154440.GA16332@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-20_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903200118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 08:21:46AM -0700, Paul E. McKenney wrote:
> On Wed, Mar 20, 2019 at 12:32:19PM +0100, Sebastian Andrzej Siewior wrote:
> > On 2019-03-19 12:44:19 [+0100], To Paul E. McKenney wrote:
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index 0f31b79eb6761..0a719f726e149 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > …
> > > +/*
> > > + * Spawn per-CPU RCU core processing kthreads.
> > > + */
> > > +static int __init rcu_spawn_core_kthreads(void)
> > > +{
> > > +	int cpu;
> > > +
> > > +	for_each_possible_cpu(cpu)
> > > +		per_cpu(rcu_data.rcu_cpu_has_work, cpu) = 0;
> > > +	if (!IS_ENABLED(CONFIG_RCU_BOOST) && !rcu_softirq_enabled)
> > 
> > and this needs to become
> > -       if (!IS_ENABLED(CONFIG_RCU_BOOST) && !rcu_softirq_enabled)
> > +       if (!IS_ENABLED(CONFIG_RCU_BOOST) && rcu_softirq_enabled)
> > 
> > With this change and hunk that I just sent to Joel I get thee three RCU
> > modes with and without BOOST booted.
> > 
> > Unless there is something (and Paul agrees that the Joel hunk is
> > correct) I would post a v3 with those changes included.
> 
> Well, I did get a bunch of grace-period hangs of various sorts when I
> ran rcutorture like this:
> 
> 	tools/testing/selftests/rcutorture/bin/kvm.sh --memory 1G --bootargs rcunosoftirq
> 
> I also got a silent hard hang on TREE03.  And an rcutorture forward-progress
> failure, which goes along with the grace-period hangs.
> 
> So something does need adjustment.  I will try again with this change.

And it does seem to work better.  I will give it more intense testing
later on, but in the meantime I have merged this change into your
earlier patch.

We will see whether or not I am able summon up the courage to push it
into v5.2, however.  ;-)

							Thanx, Paul

> > > +		return 0;
> > > +	WARN_ONCE(smpboot_register_percpu_thread(&rcu_cpu_thread_spec), "%s: Could not start rcub kthread, OOM is now expected behavior\n", __func__);
> > > +	return 0;
> > > +}
> > > +early_initcall(rcu_spawn_core_kthreads);
> > 
> > Sebastian
> > 

