Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27D3C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 15:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8831920896
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 15:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729414AbfCYPxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 11:53:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36920 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727238AbfCYPxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 11:53:49 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2PFdLs3058898
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 11:53:48 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rf07gq5da-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 11:53:47 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 25 Mar 2019 15:53:46 -0000
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Mar 2019 15:53:41 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2PFrevu20185192
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Mar 2019 15:53:40 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D778CB2064;
        Mon, 25 Mar 2019 15:53:40 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A9A67B2066;
        Mon, 25 Mar 2019 15:53:40 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 25 Mar 2019 15:53:40 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id CAA1A16C2A52; Mon, 25 Mar 2019 08:53:41 -0700 (PDT)
Date:   Mon, 25 Mar 2019 08:53:41 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, byungchul.park@lge.com,
        kernel-team@android.com, rcu@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC 2/2] rcutree: Add checks for dynticks counters in
 rcu_is_cpu_rrupt_from_idle
Reply-To: paulmck@linux.ibm.com
References: <20190323012939.15185-1-joel@joelfernandes.org>
 <20190323012939.15185-2-joel@joelfernandes.org>
 <20190323030251.GB136835@google.com>
 <20190324234351.GX4102@linux.ibm.com>
 <20190325133646.GA182885@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325133646.GA182885@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19032515-0064-0000-0000-000003BFCC8D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010812; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000282; SDB=6.01179510; UDB=6.00617196; IPR=6.00960221;
 MB=3.00026149; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-25 15:53:44
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032515-0065-0000-0000-00003CD525B1
Message-Id: <20190325155341.GC4102@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-25_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903250116
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 09:36:46AM -0400, Joel Fernandes wrote:
> On Sun, Mar 24, 2019 at 04:43:51PM -0700, Paul E. McKenney wrote:
> > On Fri, Mar 22, 2019 at 11:02:51PM -0400, Joel Fernandes wrote:
> > > On Fri, Mar 22, 2019 at 09:29:39PM -0400, Joel Fernandes (Google) wrote:
> > > > In the future we would like to combine the dynticks and dynticks_nesting
> > > > counters thus leading to simplifying the code. At the moment we cannot
> > > > do that due to concerns about usermode upcalls appearing to RCU as half
> > > > of an interrupt. Byungchul tried to do it in [1] but the
> > > > "half-interrupt" concern was raised. It is half because, what RCU
> > > > expects is rcu_irq_enter() and rcu_irq_exit() pairs when the usermode
> > > > exception happens. However, only rcu_irq_enter() is observed. This
> > > > concern may not be valid anymore, but at least it used to be the case.
> > > > 
> > > > Out of abundance of caution, Paul added warnings [2] in the RCU code
> > > > which if not fired by 2021 may allow us to assume that such
> > > > half-interrupt scenario cannot happen any more, which can lead to
> > > > simplification of this code.
> > > > 
> > > > Summary of the changes are the following:
> > > > 
> > > > (1) In preparation for this combination of counters in the future, we
> > > > first need to first be sure that rcu_rrupt_from_idle cannot be called
> > > > from anywhere but a hard-interrupt because previously, the comments
> > > > suggested otherwise so let us be sure. We discussed this here [3]. We
> > > > use the services of lockdep to accomplish this.
> > > > 
> > > > (2) Further rcu_rrupt_from_idle() is not explicit about how it is using
> > > > the counters which can lead to weird future bugs. This patch therefore
> > > > makes it more explicit about the specific counter values being tested
> > > > 
> > > > (3) Lastly, we check for counter underflows just to be sure these are
> > > > not happening, because the previous code in rcu_rrupt_from_idle() was
> > > > allowing the case where the counters can underflow, and the function
> > > > would still return true. Now we are checking for specific values so let
> > > > us be confident by additional checking, that such underflows don't
> > > > happen. Any case, if they do, we should fix them and the screaming
> > > > warning is appropriate. All these checks checks are NOOPs if PROVE_RCU
> > > > and PROVE_LOCKING are disabled.
> > > > 
> > > > [1] https://lore.kernel.org/patchwork/patch/952349/
> > > > [2] Commit e11ec65cc8d6 ("rcu: Add warning to detect half-interrupts")
> > > > [3] https://lore.kernel.org/lkml/20190312150514.GB249405@google.com/
> > > > 
> > > > Cc: byungchul.park@lge.com
> > > > Cc: kernel-team@android.com
> > > > Cc: rcu@vger.kernel.org
> > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > ---
> > > >  kernel/rcu/tree.c | 21 +++++++++++++++++----
> > > >  1 file changed, 17 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > index 9180158756d2..d94c8ed29f6b 100644
> > > > --- a/kernel/rcu/tree.c
> > > > +++ b/kernel/rcu/tree.c
> > > > @@ -381,16 +381,29 @@ static void __maybe_unused rcu_momentary_dyntick_idle(void)
> > > >  }
> > > >  
> > > >  /**
> > > > - * rcu_is_cpu_rrupt_from_idle - see if idle or immediately interrupted from idle
> > > > + * rcu_is_cpu_rrupt_from_idle - see if interrupted from idle
> > > >   *
> > > > - * If the current CPU is idle or running at a first-level (not nested)
> > > > + * If the current CPU is idle and running at a first-level (not nested)
> > > >   * interrupt from idle, return true.  The caller must have at least
> > > >   * disabled preemption.
> > > >   */
> > > >  static int rcu_is_cpu_rrupt_from_idle(void)
> > > >  {
> > > > -	return __this_cpu_read(rcu_data.dynticks_nesting) <= 0 &&
> > > > -	       __this_cpu_read(rcu_data.dynticks_nmi_nesting) <= 1;
> > > > +	/* Called only from within the scheduling-clock interrupt */
> > > > +	lockdep_assert_in_irq();
> > > > +
> > > > +	/* Check for counter underflows */
> > > > +	RCU_LOCKDEP_WARN(
> > > > +		(__this_cpu_read(rcu_data.dynticks_nesting) < 0) &&
> > > > +		(__this_cpu_read(rcu_data.dynticks_nmi_nesting) < 0),
> > > 
> > >  
> > > This condition for the warning is supposed to be || instead of &&. Sorry.
> > > 
> > > Or, I will just use 2 RCU_LOCKDEP_WARN(s) here, that's better.
> > 
> > Also, the dynticks_nmi_nesting being zero is a bug given that we know
> > we are in an interrupt handler, right?  Or am I off by one again?
> 
> You are right, we can do additional checking for making sure its never zero.
> I refreshed the patch as below, does this look Ok?
> 
> ---8<-----------------------
> 
> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> Subject: [RFC v2] rcutree: Add checks for dynticks counters in
> 
> In the future we would like to combine the dynticks and dynticks_nesting
> counters thus leading to simplifying the code. At the moment we cannot
> do that due to concerns about usermode upcalls appearing to RCU as half
> of an interrupt. Byungchul tried to do it in [1] but the
> "half-interrupt" concern was raised. It is half because, what RCU
> expects is rcu_irq_enter() and rcu_irq_exit() pairs when the usermode
> exception happens. However, only rcu_irq_enter() is observed. This
> concern may not be valid anymore, but at least it used to be the case.
> 
> Out of abundance of caution, Paul added warnings [2] in the RCU code
> which if not fired by 2021 may allow us to assume that such
> half-interrupt scenario cannot happen any more, which can lead to
> simplification of this code.
> 
> Summary of the changes are the following:
> 
> (1) In preparation for this combination of counters in the future, we
> first need to first be sure that rcu_rrupt_from_idle cannot be called
> from anywhere but a hard-interrupt because previously, the comments
> suggested otherwise so let us be sure. We discussed this here [3]. We
> use the services of lockdep to accomplish this.
> 
> (2) Further rcu_rrupt_from_idle() is not explicit about how it is using
> the counters which can lead to weird future bugs. This patch therefore
> makes it more explicit about the specific counter values being tested
> 
> (3) Lastly, we check for counter underflows just to be sure these are
> not happening, because the previous code in rcu_rrupt_from_idle() was
> allowing the case where the counters can underflow, and the function
> would still return true. Now we are checking for specific values so let
> us be confident by additional checking, that such underflows don't
> happen. Any case, if they do, we should fix them and the screaming
> warning is appropriate. All these checks checks are NOOPs if PROVE_RCU
> and PROVE_LOCKING are disabled.
> 
> [1] https://lore.kernel.org/patchwork/patch/952349/
> [2] Commit e11ec65cc8d6 ("rcu: Add warning to detect half-interrupts")
> [3] https://lore.kernel.org/lkml/20190312150514.GB249405@google.com/
> 
> Cc: byungchul.park@lge.com
> Cc: kernel-team@android.com
> Cc: rcu@vger.kernel.org
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Looks better!  I have applied this and its predecessor, if in backwards
order.  (Will fix, rebase coming up anyway.)

I do like your Cc-ing kernel-team@android.com -- one less thing for me
to remember!  ;-)

							Thanx, Paul

> ---
>  kernel/rcu/tree.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 9180158756d2..c2a56de098da 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -381,16 +381,29 @@ static void __maybe_unused rcu_momentary_dyntick_idle(void)
>  }
>  
>  /**
> - * rcu_is_cpu_rrupt_from_idle - see if idle or immediately interrupted from idle
> + * rcu_is_cpu_rrupt_from_idle - see if interrupted from idle
>   *
> - * If the current CPU is idle or running at a first-level (not nested)
> + * If the current CPU is idle and running at a first-level (not nested)
>   * interrupt from idle, return true.  The caller must have at least
>   * disabled preemption.
>   */
>  static int rcu_is_cpu_rrupt_from_idle(void)
>  {
> -	return __this_cpu_read(rcu_data.dynticks_nesting) <= 0 &&
> -	       __this_cpu_read(rcu_data.dynticks_nmi_nesting) <= 1;
> +	/* Called only from within the scheduling-clock interrupt */
> +	lockdep_assert_in_irq();
> +
> +	/* Check for counter underflows */
> +	RCU_LOCKDEP_WARN(_this_cpu_read(rcu_data.dynticks_nesting) < 0,
> +			 "RCU dynticks_nesting counter underflow!");
> +	RCU_LOCKDEP_WARN(_this_cpu_read(rcu_data.dynticks_nmi_nesting) <= 0,
> +			 "RCU dynticks_nmi_nesting counter underflow/zero!");
> +
> +	/* Are we at first interrupt nesting level? */
> +	if (__this_cpu_read(rcu_data.dynticks_nmi_nesting) != 1)
> +		return false;
> +
> +	/* Does CPU appear to be idle from an RCU standpoint? */
> +	return __this_cpu_read(rcu_data.dynticks_nesting) == 0;
>  }
>  
>  #define DEFAULT_RCU_BLIMIT 10     /* Maximum callbacks per rcu_do_batch. */
> -- 
> 2.21.0.392.gf8f6787159e-goog
> 

