Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09438C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDC3F206DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbfCMPwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 11:52:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51974 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725868AbfCMPv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 11:51:59 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2DFj3Ka033958
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 11:51:57 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2r749a9w7a-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 11:51:57 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 13 Mar 2019 15:51:57 -0000
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 13 Mar 2019 15:51:53 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2DFpqJa24051758
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Mar 2019 15:51:52 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0ED67B2067;
        Wed, 13 Mar 2019 15:51:52 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E57B3B2064;
        Wed, 13 Mar 2019 15:51:51 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 13 Mar 2019 15:51:51 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id E99F816C196D; Wed, 13 Mar 2019 08:51:55 -0700 (PDT)
Date:   Wed, 13 Mar 2019 08:51:55 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        luto@kernel.org, byungchul.park@lge.com
Subject: Re: [PATCH tip/core/rcu 06/19] rcu: Add warning to detect
 half-interrupts
Reply-To: paulmck@linux.ibm.com
References: <20180829222021.GA29944@linux.vnet.ibm.com>
 <20180829222047.319-6-paulmck@linux.vnet.ibm.com>
 <20190311133939.GA29747@google.com>
 <20190311222903.GR13351@linux.ibm.com>
 <20190312150514.GB249405@google.com>
 <20190312152034.GZ13351@linux.ibm.com>
 <20190313150948.GA84821@google.com>
 <20190313112726.01d974fc@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313112726.01d974fc@gandalf.local.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19031315-0060-0000-0000-0000031BB8D4
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010751; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01173822; UDB=6.00613753; IPR=6.00954486;
 MB=3.00025961; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-13 15:51:56
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031315-0061-0000-0000-00004898D22E
Message-Id: <20190313155155.GN13351@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-13_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903130112
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 11:27:26AM -0400, Steven Rostedt wrote:
> On Wed, 13 Mar 2019 11:09:48 -0400
> Joel Fernandes <joel@joelfernandes.org> wrote:
> 
> > AFAICS, lockdep does not specifically track when we enter an interrupt, but
> > rather only tracks when interrupts are enabled/disabled.
> 
> It does:
> 
> #define __irq_enter()					\
> 	do {						\
> 		account_irq_enter_time(current);	\
> 		preempt_count_add(HARDIRQ_OFFSET);	\
> 		trace_hardirq_enter();			\
> 	} while (0)
> 
> # define trace_hardirq_enter()			\
> do {						\
> 	current->hardirq_context++;		\
> } while (0)
> 
> 
> And if the hardirq_context ever does not match "in_irq()" lockdep will
> complain loudly.

Good to know, thank you!

Does this mean that there is a better approach that Joel's suggestion?
I believe he would end up with something like this:

	WARN_ON_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && !in_irq());

It would be nice if there is something like this:

	lockdep_assert_in_irq_handler();

But I haven't seen this.  (Not that I have looked particularly hard for
such a thing, mind you!)

							Thanx, Paul

