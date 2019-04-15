Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 507A3C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 10:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 257F4206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 10:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbfDOK4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 06:56:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58226 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726751AbfDOK4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 06:56:46 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3FAtfD4026369
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 06:56:45 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rvr6s92px-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 06:56:44 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 15 Apr 2019 11:56:44 +0100
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 15 Apr 2019 11:56:42 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3FAufM733554584
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Apr 2019 10:56:41 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 67F31B2066;
        Mon, 15 Apr 2019 10:56:41 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 48118B205F;
        Mon, 15 Apr 2019 10:56:41 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.174.176])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 15 Apr 2019 10:56:41 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 623F816C0B95; Mon, 15 Apr 2019 03:56:45 -0700 (PDT)
Date:   Mon, 15 Apr 2019 03:56:45 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Alleged fix for writer stall on -rcu branch dev
Reply-To: paulmck@linux.ibm.com
References: <20190409221426.GA11212@linux.ibm.com>
 <20190410181538.3ocva5lmh7ghrisr@linutronix.de>
 <20190410184105.GR14111@linux.ibm.com>
 <20190410191918.g2yqnsmuqukmzdfe@linutronix.de>
 <20190410203302.GT14111@linux.ibm.com>
 <20190411000610.GA3867@linux.ibm.com>
 <20190413142153.GA17704@linux.ibm.com>
 <20190415104047.mrtmv6w6kq5m44fp@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415104047.mrtmv6w6kq5m44fp@linutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19041510-0068-0000-0000-000003B53E78
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010931; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01189390; UDB=6.00623175; IPR=6.00970177;
 MB=3.00026449; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-15 10:56:43
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041510-0069-0000-0000-0000482AA8BA
Message-Id: <20190415105645.GQ14111@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-15_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904150075
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 12:40:47PM +0200, Sebastian Andrzej Siewior wrote:
> On 2019-04-13 07:21:53 [-0700], Paul E. McKenney wrote:
> > 
> > And after ramping up the stress in rcutorture a bit, I am able to
> > reproduce this CPU stall involving offlining on my systems.  My plan is
> > my usual one:  Keep increasing rcutorture stress to get it to reproduce
> > in reasonable time, add diagnostics as appropriate, and continue making
> > forward-progress improvements in RCU itself.
> 
> I *think* this one is also new:
> 
> |Assertion failure in /home/bigeasy/linux-rt/tools/testing/selftests/rcutorture/res/2019.04.14-14:28:40/TREE03.37/console.log TREE03
> |Summary: Warnings: 6 Call Traces: 6
> https://breakpoint.cc/console-03.37.log

This is new in rcutorture as well.  It is complaining that we just got
done with a stutter interval (in which torturing temporarily stops)
but not everything has progressed through the callback chain to be freed.
And in this case it is happening during rcutorture shutdown, so I need
to check the callback -- I might need end-of-run checks in that WARN_ON().

> |Assertion failure in /home/bigeasy/linux-rt/tools/testing/selftests/rcutorture/res/2019.04.14-14:28:40/TREE03.39/console.log TREE03
> |Summary: Warnings: 4 Call Traces: 4
> https://breakpoint.cc/console-03.39.log

And the same here.  So neither count against you.  ;-)

							Thanx, Paul

> This is still commit 33e04e451279 ("torture: Allow inter-stutter interval to be
> specified").
> 
> > Thank you very much for locating this one!!!
> 
> You are welcome.
> 
> > 							Thanx, Paul
> 
> Sebastian
> 

