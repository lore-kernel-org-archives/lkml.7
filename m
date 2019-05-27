Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEAC0C07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 19:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1CCF214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 19:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbfE0TYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 15:24:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36674 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726484AbfE0TYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 15:24:01 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4RJM41H030783
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 15:24:00 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2srny383vu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 15:24:00 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 27 May 2019 20:23:59 +0100
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 27 May 2019 20:23:53 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4RJNqu439387206
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 May 2019 19:23:52 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C6B9CB2067;
        Mon, 27 May 2019 19:23:52 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A48C9B2064;
        Mon, 27 May 2019 19:23:52 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.199.73])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 27 May 2019 19:23:52 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id D347016C396E; Mon, 27 May 2019 12:23:56 -0700 (PDT)
Date:   Mon, 27 May 2019 12:23:56 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joe Perches <joe@perches.com>
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Sasha Levin <sashal@kernel.org>, apw@canonical.com
Subject: Re: [PATCH v2] rcu: Don't return a value from rcu_assign_pointer()
Reply-To: paulmck@linux.ibm.com
References: <1558946997-25559-1-git-send-email-andrea.parri@amarulasolutions.com>
 <20190527161050.GK28207@linux.ibm.com>
 <810a0dae47c90c39015903c413303fcee89ab5eb.camel@perches.com>
 <20190527174901.GL28207@linux.ibm.com>
 <475b18e78ba7e04363fe002315f75d2ce35496f9.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <475b18e78ba7e04363fe002315f75d2ce35496f9.camel@perches.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19052719-0072-0000-0000-00000433DAAD
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011172; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01209443; UDB=6.00635346; IPR=6.00990469;
 MB=3.00027076; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-27 19:23:58
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052719-0073-0000-0000-00004C62F272
Message-Id: <20190527192356.GN28207@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-27_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905270136
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 10:57:52AM -0700, Joe Perches wrote:
> On Mon, 2019-05-27 at 10:49 -0700, Paul E. McKenney wrote:
> > On Mon, May 27, 2019 at 10:21:22AM -0700, Joe Perches wrote:
> > > On Mon, 2019-05-27 at 09:10 -0700, Paul E. McKenney wrote:
> > > > On Mon, May 27, 2019 at 10:49:57AM +0200, Andrea Parri wrote:
> > > > > Quoting Paul [1]:
> > > > > 
> > > > >   "Given that a quick (and perhaps error-prone) search of the uses
> > > > >    of rcu_assign_pointer() in v5.1 didn't find a single use of the
> > > > >    return value, let's please instead change the documentation and
> > > > >    implementation to eliminate the return value."
> > > > > 
> > > > > [1] https://lkml.kernel.org/r/20190523135013.GL28207@linux.ibm.com
> > > > 
> > > > Queued, thank you!
> > > > 
> > > > Adding the checkpatch maintainers on CC as well.  The "do { } while
> > > > (0)" prevents the return value from being used, by design.  Given the
> > > > checkpatch complaint, is there some better way to achieve this?
> > > 
> > > Not sure what the checkpatch complaint is here.
> > 
> > Checkpatch seems to want at least two statements in each
> > "do { } while (0)" macro definition:
> > 
> > WARNING: Single statement macros should not use a do {} while (0) loop
> > 
> > > Reading the link above, there seems to be a compiler warning.
> > 
> > The compiler warning is a theoretical issue that is being fixed by this
> > patch, and the patch is giving the checkpatch warning.
> > 
> > > Perhaps a statement expression macro with no return value?
> > > 
> > > #define rcu_assign_pointer(p, v)	({ (p) = (v); ; })
> > 
> > This is at best an acquired taste for me...
> 
> Another ugly possibility could be:
> 
> #define rcu_assign_pointer(p, v) do {if (1) (p) = (v); } while (0)

And, not to be left out, another ugly possibility might be:

#define rcu_assign_pointer(p, v) ((void)((p) = (v)))

> Possibly the best option would be to ignore checkpatch here
> and just add a comment above the use.

Works for me!

							Thanx, Paul

