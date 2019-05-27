Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDCA2C072B1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 17:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A438B208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 17:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfE0RtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 13:49:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46348 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726484AbfE0RtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 13:49:05 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4RHgdaq005624
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 13:49:03 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2srkep2pnc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 13:49:03 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 27 May 2019 18:49:02 +0100
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 27 May 2019 18:48:58 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4RHmvtU34078884
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 May 2019 17:48:57 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C37B5B2066;
        Mon, 27 May 2019 17:48:57 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A2480B205F;
        Mon, 27 May 2019 17:48:57 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.199.73])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 27 May 2019 17:48:57 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id B664216C0E7C; Mon, 27 May 2019 10:49:01 -0700 (PDT)
Date:   Mon, 27 May 2019 10:49:01 -0700
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <810a0dae47c90c39015903c413303fcee89ab5eb.camel@perches.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19052717-2213-0000-0000-000003967C92
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011172; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01209412; UDB=6.00635328; IPR=6.00990438;
 MB=3.00027075; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-27 17:49:02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052717-2214-0000-0000-00005E9A550E
Message-Id: <20190527174901.GL28207@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-27_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905270125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 10:21:22AM -0700, Joe Perches wrote:
> On Mon, 2019-05-27 at 09:10 -0700, Paul E. McKenney wrote:
> > On Mon, May 27, 2019 at 10:49:57AM +0200, Andrea Parri wrote:
> > > Quoting Paul [1]:
> > > 
> > >   "Given that a quick (and perhaps error-prone) search of the uses
> > >    of rcu_assign_pointer() in v5.1 didn't find a single use of the
> > >    return value, let's please instead change the documentation and
> > >    implementation to eliminate the return value."
> > > 
> > > [1] https://lkml.kernel.org/r/20190523135013.GL28207@linux.ibm.com
> > 
> > Queued, thank you!
> > 
> > Adding the checkpatch maintainers on CC as well.  The "do { } while
> > (0)" prevents the return value from being used, by design.  Given the
> > checkpatch complaint, is there some better way to achieve this?
> 
> Not sure what the checkpatch complaint is here.

Checkpatch seems to want at least two statements in each
"do { } while (0)" macro definition:

WARNING: Single statement macros should not use a do {} while (0) loop

> Reading the link above, there seems to be a compiler warning.

The compiler warning is a theoretical issue that is being fixed by this
patch, and the patch is giving the checkpatch warning.

> Perhaps a statement expression macro with no return value?
> 
> #define rcu_assign_pointer(p, v)	({ (p) = (v); ; })

This is at best an acquired taste for me...

							Thanx, Paul

