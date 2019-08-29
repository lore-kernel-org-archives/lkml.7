Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F9FC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 16:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC1802339E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 16:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567096414;
	bh=stlitDKT6CoDo2PN1STSDjd7461H+0V2Qt0pnIeQi7A=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=rcjEQ/Yb6HGL/MwlB+UIYg1T32yld84OhYPMZUTXX3XUAcyzkYwZfS++l05T9jgzK
	 E7ElSrF57WCXBuMwk6F0uhkzGHEpRPp+Obpe/EKlf1Wviz3GS7Cel75zb0rrZSfWcT
	 hXmuFZQlr7T9MVBVlcj3Qjho8FiEUj54IYB88PqU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbfH2Qde (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 12:33:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63426 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726973AbfH2Qdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 12:33:33 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7TGWriX025432;
        Thu, 29 Aug 2019 12:32:59 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2upfu0pqdg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Aug 2019 12:32:59 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x7TGWx6V025707;
        Thu, 29 Aug 2019 12:32:59 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2upfu0pqb7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Aug 2019 12:32:58 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7TGUYSw018370;
        Thu, 29 Aug 2019 16:32:55 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma01dal.us.ibm.com with ESMTP id 2unb3t6rp5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Aug 2019 16:32:55 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7TGWsmi16122704
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Aug 2019 16:32:54 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AA6F0B205F;
        Thu, 29 Aug 2019 16:32:54 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 873D7B2065;
        Thu, 29 Aug 2019 16:32:54 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.151.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 29 Aug 2019 16:32:54 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 2A82216C0C06; Thu, 29 Aug 2019 09:32:55 -0700 (PDT)
Date:   Thu, 29 Aug 2019 09:32:55 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>, kernel-team@android.com,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC v1 2/2] rcu/tree: Remove dynticks_nmi_nesting counter
Message-ID: <20190829163255.GA15605@linux.ibm.com>
Reply-To: paulmck@kernel.org
References: <20190828202330.GS26530@linux.ibm.com>
 <20190828210525.GB75931@google.com>
 <20190828211904.GX26530@linux.ibm.com>
 <20190828214241.GD75931@google.com>
 <20190828220108.GC26530@linux.ibm.com>
 <20190828221444.GA100789@google.com>
 <20190828231247.GE26530@linux.ibm.com>
 <20190829015155.GB100789@google.com>
 <20190829034336.GD4125@linux.ibm.com>
 <20190829135907.GC63638@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829135907.GC63638@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-29_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=847 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908290175
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 09:59:07AM -0400, Joel Fernandes wrote:
> On Wed, Aug 28, 2019 at 08:43:36PM -0700, Paul E. McKenney wrote:
> [snip] 
> > On the tracing patch...  That patch might be a good idea regardless,
> > but I bet that the reason that you felt the sudden need for it was due
> > to the loss of information in your eventual ->dynticks_nesting field.
> > After all, the value 0x1 might be an interrupt from idle, or it might
> > just as easily be a task running in the kernel at process level.
> 
> True, however what really triggered me to do it was the existing code which
> does not distinguish between entry/exit from USER and IDLE.
> 
> > The reason the patch might nevertheless be a good idea is that redundant
> > information can be helpful when debugging.  Especially when debugging
> > new architecture-specific code, which is when RCU's dyntick-idle warnings
> > tend to find bugs.
> 
> Sure, and also that it is more readable to ordinary human beings than "++="
> and "--=" :-D.

And those considerations did figure into my deciding that the tracing
change was likely a good thing in any case.  ;-)

							Thanx, Paul
