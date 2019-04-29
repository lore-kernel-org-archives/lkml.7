Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B068C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 20:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EA3E2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 20:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729411AbfD2Ukt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 16:40:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42788 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729322AbfD2Uks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 16:40:48 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3TKbEso082959
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 16:40:47 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s655g7web-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 16:40:47 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 29 Apr 2019 21:40:46 +0100
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 29 Apr 2019 21:40:42 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3TKefSr27066476
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Apr 2019 20:40:42 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E2FA0B2065;
        Mon, 29 Apr 2019 20:40:41 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C1A0CB2064;
        Mon, 29 Apr 2019 20:40:41 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.213.184])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 29 Apr 2019 20:40:41 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id ADED016C1355; Mon, 29 Apr 2019 13:40:41 -0700 (PDT)
Date:   Mon, 29 Apr 2019 13:40:41 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] rcu/sync: simplify the state machine
Reply-To: paulmck@linux.ibm.com
References: <20190425164054.GA21309@redhat.com>
 <20190425165055.GC21412@redhat.com>
 <20190427210230.GE3923@linux.ibm.com>
 <20190428222652.GA30908@linux.ibm.com>
 <20190429160603.GC17715@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429160603.GC17715@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19042920-0064-0000-0000-000003D44337
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011018; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01196227; UDB=6.00627318; IPR=6.00977076;
 MB=3.00026653; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-29 20:40:44
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042920-0065-0000-0000-00003D42A626
Message-Id: <20190429204041.GU3923@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-29_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=767 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904290134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 06:06:04PM +0200, Oleg Nesterov wrote:
> On 04/28, Paul E. McKenney wrote:
> >
> > And it still looks good after review, so I have pushed it.
> 
> Thanks!
> 
> > I did add
> > READ_ONCE() and WRITE_ONCE() to unprotected uses of ->gp_state, but
> > please let me know if I messed anything up.
> 
> Well, at least WRITE_ONCE()'s look certainly unneeded to me, gp_state
> is protected by rss_lock.
> 
> WARN_ON_ONCE(gp_state) can read gp_state lockless, but even in this case
> I do not understand what READ_ONCE() tries to prevent...
> 
> Nevermind, this won't hurt and as I already said I don't understand the
> _ONCE() magic anyway ;)

If I understand correctly, rcu_sync_is_idle() can be inline and returns
->gp_state.  Without the READ_ONCE(), the compiler might fuse reads from
consecutive calls to rcu_sync_is_idle() or (under register pressure)
re-read from it, getting inconsistent results.  For example, this:

	tmp = rcu_sync_is_idle(rsp);
	do_something(tmp);
	do_something_else(tmp);

Might become this:

	do_something(rcu_sync_is_idle(rsp));
	do_something_else(rcu_sync_is_idle(rsp));

This might actually be harmless given current calls, but it would be at
best an accident waiting to happen.

Or am I missing something here?

							Thanx, Paul

