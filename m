Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D161AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A633E2070D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731509AbfCZQCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 12:02:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53022 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728314AbfCZQCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 12:02:14 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2QFs3WY077551
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 12:02:13 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rfnh1wqte-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 12:02:06 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 26 Mar 2019 16:01:45 -0000
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Mar 2019 16:01:41 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2QG1eqv22413504
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 16:01:40 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1A0C7B206A;
        Tue, 26 Mar 2019 16:01:40 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E11F2B2066;
        Tue, 26 Mar 2019 16:01:39 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 26 Mar 2019 16:01:39 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 785F616C2A63; Tue, 26 Mar 2019 09:01:40 -0700 (PDT)
Date:   Tue, 26 Mar 2019 09:01:40 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Shuah Khan <shuah@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] rcutorture: Select from only online CPUs
Reply-To: paulmck@linux.ibm.com
References: <20190323034619.15792-1-joel@joelfernandes.org>
 <20190325150133.GA4102@linux.ibm.com>
 <CAEXW_YRDfOEr-hdbKGDC6amRaaqTCCBsowRhVwDqJd-1BoO17g@mail.gmail.com>
 <20190325164253.GE4102@linux.ibm.com>
 <CAEXW_YT8dS--pBrQoBO=G_d+4Ffi7o2++PQukh6dyNHqX-TLBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YT8dS--pBrQoBO=G_d+4Ffi7o2++PQukh6dyNHqX-TLBg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19032616-0052-0000-0000-000003A16040
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010818; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000282; SDB=6.01179989; UDB=6.00617486; IPR=6.00960704;
 MB=3.00026165; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-26 16:01:44
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032616-0053-0000-0000-000060480345
Message-Id: <20190326160140.GP4102@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-26_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903260111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 06:40:17PM -0400, Joel Fernandes wrote:
> On Mon, Mar 25, 2019 at 12:42 PM Paul E. McKenney <paulmck@linux.ibm.com> wrote:
> >
> > On Mon, Mar 25, 2019 at 12:33:37PM -0400, Joel Fernandes wrote:
> > > On Mon, Mar 25, 2019 at 11:02 AM Paul E. McKenney <paulmck@linux.ibm.com> wrote:
> > > >
> > > > On Fri, Mar 22, 2019 at 11:46:19PM -0400, Joel Fernandes (Google) wrote:
> > > > > The rcutorture jitter.sh script selects a random CPU but does not check
> > > > > if it is offline or online. This leads to taskset errors many times. On
> > > > > my machine, hyper threading is disabled so half the cores are offline
> > > > > causing taskset errors a lot of times. Let us fix this by checking from
> > > > > only the online CPUs on the system.
> > > > >
> > > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > >
> > > > Good catch!
> > > >
> > > > Please see below for one suggestion for simplification.
> > > >
> > > >                                                         Thanx, Paul
> > > >
> > > > > ---
> > > > >  tools/testing/selftests/rcutorture/bin/jitter.sh | 11 ++++++++++-
> > > > >  1 file changed, 10 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/tools/testing/selftests/rcutorture/bin/jitter.sh b/tools/testing/selftests/rcutorture/bin/jitter.sh
> > > > > index 3633828375e3..53bf9d99b5cd 100755
> > > > > --- a/tools/testing/selftests/rcutorture/bin/jitter.sh
> > > > > +++ b/tools/testing/selftests/rcutorture/bin/jitter.sh
> > > > > @@ -47,10 +47,19 @@ do
> > > > >               exit 0;
> > > > >       fi
> > > > >
> > > > > -     # Set affinity to randomly selected CPU
> > > > > +     # Set affinity to randomly selected online CPU
> > > > >       cpus=`ls /sys/devices/system/cpu/*/online |
> > > >
> > > >         cpus=`grep 1 /sys/devices/system/cpu/*/online |
> > >
> > > Yes, this is better. Lets do it this way :)
> > >
> > > > >               sed -e 's,/[^/]*$,,' -e 's/^[^0-9]*//' |
> > > > >               grep -v '^0*$'`
> > > >
> > > > Of course, now I have no idea why I excluded CPU 0...  :-/
> > >
> > > Yes, I was wondering as well about that :-)
> >
> > Please feel free to try including CPU 0 and running the set of single-CPU
> > rcutorture scenarios.  ;-)
> 
> Will do and then will update the patch by adding the CPU back, if all
> is well. Thanks.

And rcutorture doesn't like the rcu_is_cpu_rrupt_from_idle() patch on
scenarios SRCU-P, TASKS01, and TREE05, which are the Tree RCU scenarios
that enable CONFIG_PROVE_RCU.  The compiler error is:

kernel/rcu/tree.c:391:2: error: implicit declaration of function ‘_this_cpu_read’ [-Werror=implicit-function-declaration]

My guess is that the initial underscore needs to go.  I will drop
these two patches in favor of an update from you.  ;-)

							Thanx, Paul

