Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD521C3A5A6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 20:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72CA322CF8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 20:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567025221;
	bh=+JlOTX/KGjL63tnz2ZhTCi5fAGICnMnE2ef/Bn50qog=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=fGLIEt1rLN1TPLLkrSBJp5/tfDm/Dkw/x8qtA6QN2mN5wid9dBD8zo/AjoxmxjIHV
	 N0cJWELoAUvtRakOWMlNhdAIzs4Kl5hUpFYJXc/ccUBXyPOviIOS+vCfvAukrv8xe+
	 qS/Y9fBHYu8MSrW/lUUv+Fx7wK+v1s4jIiC2ZR7M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbfH1UrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 16:47:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:6002 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726400AbfH1UrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 16:47:00 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7SKjEsP095912;
        Wed, 28 Aug 2019 16:46:26 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2up0bks425-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Aug 2019 16:46:25 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x7SKjHUq096153;
        Wed, 28 Aug 2019 16:46:25 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2up0bks41f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Aug 2019 16:46:25 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7SKjdLb030640;
        Wed, 28 Aug 2019 20:46:24 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma01dal.us.ibm.com with ESMTP id 2unb3t03rs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Aug 2019 20:46:24 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7SKkNpu24641864
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Aug 2019 20:46:23 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3BAEDB205F;
        Wed, 28 Aug 2019 20:46:23 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1CAE5B2066;
        Wed, 28 Aug 2019 20:46:23 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 28 Aug 2019 20:46:23 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id D9FBC16C1700; Wed, 28 Aug 2019 13:46:24 -0700 (PDT)
Date:   Wed, 28 Aug 2019 13:46:24 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, byungchul.park@lge.com,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        kernel-team@android.com
Subject: Re: [PATCH 0/5] kfree_rcu() additions for -rcu
Message-ID: <20190828204624.GV26530@linux.ibm.com>
Reply-To: paulmck@kernel.org
References: <5d657e30.1c69fb81.54250.01dc@mx.google.com>
 <20190828202808.GT26530@linux.ibm.com>
 <20190828203458.GA75931@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828203458.GA75931@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-28_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908280202
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 04:34:58PM -0400, Joel Fernandes wrote:
> On Wed, Aug 28, 2019 at 01:28:08PM -0700, Paul E. McKenney wrote:
> > On Tue, Aug 27, 2019 at 03:01:54PM -0400, Joel Fernandes (Google) wrote:
> > > Hi,
> > > 
> > > This is a series on top of the patch "rcu/tree: Add basic support for kfree_rcu() batching".
> > > 
> > > Link: http://lore.kernel.org/r/20190814160411.58591-1-joel@joelfernandes.org
> > > 
> > > It adds performance tests, some clean ups and removal of "lazy" RCU callbacks.
> > > 
> > > Now that kfree_rcu() is handled separately from call_rcu(), we also get rid of
> > > kfree "lazy" handling from tree RCU as suggested by Paul which will be unused.
> > > This also results in a nice negative delta as well.
> > > 
> > > Joel Fernandes (Google) (5):
> > > rcu/rcuperf: Add kfree_rcu() performance Tests
> > > rcu/tree: Add multiple in-flight batches of kfree_rcu work
> > > rcu/tree: Add support for debug_objects debugging for kfree_rcu()
> > > rcu: Remove kfree_rcu() special casing and lazy handling
> > > rcu: Remove kfree_call_rcu_nobatch()
> > > 
> > > Documentation/RCU/stallwarn.txt               |  13 +-
> > > .../admin-guide/kernel-parameters.txt         |  13 ++
> > > include/linux/rcu_segcblist.h                 |   2 -
> > > include/linux/rcutiny.h                       |   5 -
> > > include/linux/rcutree.h                       |   1 -
> > > include/trace/events/rcu.h                    |  32 ++--
> > > kernel/rcu/rcu.h                              |  27 ---
> > > kernel/rcu/rcu_segcblist.c                    |  25 +--
> > > kernel/rcu/rcu_segcblist.h                    |  25 +--
> > > kernel/rcu/rcuperf.c                          | 173 +++++++++++++++++-
> > > kernel/rcu/srcutree.c                         |   4 +-
> > > kernel/rcu/tiny.c                             |  29 ++-
> > > kernel/rcu/tree.c                             | 145 ++++++++++-----
> > > kernel/rcu/tree.h                             |   1 -
> > > kernel/rcu/tree_plugin.h                      |  42 +----
> > > kernel/rcu/tree_stall.h                       |   6 +-
> > > 16 files changed, 337 insertions(+), 206 deletions(-)
> > 
> > Looks like a 131-line positive delta to me.  ;-)
> 
> Not if you overlook the rcuperf changes which is just test code. :-D ;-)

Which suggests that you should move the "nice negative delta" comment
to the commits that actually have nice negative deltas.  ;-)

							Thanx, Paul
