Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA5D3C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 18:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6736217F4
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 18:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390147AbfHHSLT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 14:11:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:62210 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725785AbfHHSLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 14:11:19 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x78I7cWY127018
        for <linux-kernel@vger.kernel.org>; Thu, 8 Aug 2019 14:11:18 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u8pg5duhm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 14:11:17 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 8 Aug 2019 19:11:16 +0100
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 8 Aug 2019 19:11:12 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x78IBB3x13697810
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Aug 2019 18:11:11 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8F45FB206C;
        Thu,  8 Aug 2019 18:11:11 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7A03EB2068;
        Thu,  8 Aug 2019 18:11:11 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  8 Aug 2019 18:11:11 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id AF7AF16C8EB1; Thu,  8 Aug 2019 11:11:12 -0700 (PDT)
Date:   Thu, 8 Aug 2019 11:11:12 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Byungchul Park <byungchul.park@lge.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, Rao Shoaib <rao.shoaib@oracle.com>,
        max.byungchul.park@gmail.com, kernel-team@android.com,
        kernel-team@lge.com, Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC v1 1/2] rcu/tree: Add basic support for kfree_rcu
 batching
Reply-To: paulmck@linux.ibm.com
References: <20190806212041.118146-1-joel@joelfernandes.org>
 <20190806235631.GU28441@linux.ibm.com>
 <20190807094504.GB169551@google.com>
 <20190808102610.GA7227@X58A-UD3R>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808102610.GA7227@X58A-UD3R>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19080818-0064-0000-0000-00000406E49F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011571; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01243948; UDB=6.00656251; IPR=6.01025426;
 MB=3.00028095; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-08 18:11:16
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19080818-0065-0000-0000-00003E98BA38
Message-Id: <20190808181112.GQ28441@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-08_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908080162
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 07:26:10PM +0900, Byungchul Park wrote:
> On Wed, Aug 07, 2019 at 05:45:04AM -0400, Joel Fernandes wrote:
> > On Tue, Aug 06, 2019 at 04:56:31PM -0700, Paul E. McKenney wrote:
> 
> [snip]
> 
> > > On Tue, Aug 06, 2019 at 05:20:40PM -0400, Joel Fernandes (Google) wrote:
> > > Of course, I am hoping that a later patch uses an array of pointers built
> > > at kfree_rcu() time, similar to Rao's patch (with or without kfree_bulk)
> > > in order to reduce per-object cache-miss overhead.  This would make it
> > > easier for callback invocation to keep up with multi-CPU kfree_rcu()
> > > floods.
> > 
> > I think Byungchul tried an experiment with array of pointers and wasn't
> > immediately able to see a benefit. Perhaps his patch needs a bit more polish
> > or another test-case needed to show benefit due to cache-misses, and the perf
> > tool could be used to show if cache misses were reduced. For this initial
> > pass, we decided to keep it without the array optimization.
> 
> I'm still seeing no improvement with kfree_bulk().
> 
> I've been thinking I could see improvement with kfree_bulk() because:
> 
>    1. As you guys said, the number of cache misses will be reduced.
>    2. We can save (N - 1) irq-disable instructions while N kfrees.
>    3. As Joel said, saving/restoring CPU status that kfree() does inside
>       is not required.
> 
> But even with the following patch applied, the result was same as just
> batching test. We might need to get kmalloc objects from random
> addresses to maximize the result when using kfree_bulk() and this is
> even closer to real practical world too.
> 
> And the second and third reasons doesn't seem to work as much as I
> expected.
> 
> Do you have any idea? Or what do you think about it?

I would not expect kfree_batch() to help all that much unless the
pre-grace-period kfree_rcu() code segregated the objects on a per-slab
basis.

							Thanx, Paul

> Thanks,
> Byungchul
> 
> -----8<-----
> diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
> index 988e1ae..6f2ab06 100644
> --- a/kernel/rcu/rcuperf.c
> +++ b/kernel/rcu/rcuperf.c
> @@ -651,10 +651,10 @@ struct kfree_obj {
>  				return -ENOMEM;
>  		}
>  
> -		for (i = 0; i < kfree_alloc_num; i++) {
> -			if (!kfree_no_batch) {
> -				kfree_rcu(alloc_ptrs[i], rh);
> -			} else {
> +		if (!kfree_no_batch) {
> +			kfree_bulk(kfree_alloc_num, (void **)alloc_ptrs);
> +		} else {
> +			for (i = 0; i < kfree_alloc_num; i++) {
>  				rcu_callback_t cb;
>  
>  				cb = (rcu_callback_t)(unsigned long)offsetof(struct kfree_obj, rh);
> 

