Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A729C3A59D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 14:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE42922CF7
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 14:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730116AbfHTOoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 10:44:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18826 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729810AbfHTOoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 10:44:19 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7KEXrV3127343;
        Tue, 20 Aug 2019 10:44:13 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ugh4mx4kn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Aug 2019 10:44:10 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7KETxDJ025305;
        Tue, 20 Aug 2019 14:44:07 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma02dal.us.ibm.com with ESMTP id 2ue9768dvk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Aug 2019 14:44:07 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7KEi68C49414526
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Aug 2019 14:44:06 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C4FCB2066;
        Tue, 20 Aug 2019 14:44:06 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 403E4B2065;
        Tue, 20 Aug 2019 14:44:06 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 20 Aug 2019 14:44:06 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 1910216C388E; Tue, 20 Aug 2019 07:44:07 -0700 (PDT)
Date:   Tue, 20 Aug 2019 07:44:07 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH -rcu dev 1/3] rcu/tree: tick_dep_set/clear_cpu should
 accept bits instead of masks
Message-ID: <20190820144407.GM28441@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190816025311.241257-1-joel@joelfernandes.org>
 <20190819123837.GC27088@lenoir>
 <20190819144632.GW28441@linux.ibm.com>
 <20190819163226.GE27088@lenoir>
 <20190819164420.GA28441@linux.ibm.com>
 <20190820120843.GA2093@lenoir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820120843.GA2093@lenoir>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-20_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908200145
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 02:08:45PM +0200, Frederic Weisbecker wrote:
> On Mon, Aug 19, 2019 at 09:44:20AM -0700, Paul E. McKenney wrote:
> > On Mon, Aug 19, 2019 at 06:32:27PM +0200, Frederic Weisbecker wrote:
> > > > But would the following patch make sense?  This would not help for (say)
> > > > use of TICK_MASK_BIT_POSIX_TIMER instead of TICK_DEP_BIT_POSIX_TIMER, but
> > > > would help for any new values that might be added later on.  And currently
> > > > for TICK_DEP_MASK_CLOCK_UNSTABLE and TICK_DEP_MASK_RCU.
> > > 
> > > I'd rather make the TICK_DEP_MASK_* values private to kernel/time/tick-sched.c but
> > > that means I need to re-arrange a bit include/trace/events/timer.h
> > 
> > That would be even better!  For one thing, it would detect misuse of
> > -all- of the _MASK_ values.  ;-)
> 
> :o)
> 
> > 
> > > I'm looking into it. Meanwhile, your below patch that checks for the max value is
> > > still valuable.
> > 
> > If I were to push it, it would be v5.5 before it showed up.  My guess
> > is therefore that I should keep it for my own internal use in the near
> > term, but not push it.  If you would like to take it, feel free to use
> > my Signed-off-by.
> 
> Ok, applying.

Thank you, Frederic!

							Thanx, Paul
