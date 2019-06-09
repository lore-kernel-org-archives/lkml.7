Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B36BC28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 13:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6514420868
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 13:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbfFINvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 09:51:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38934 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728581AbfFINvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 09:51:19 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x59Dl45S124893
        for <linux-kernel@vger.kernel.org>; Sun, 9 Jun 2019 09:51:18 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t0t4cn1wu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2019 09:51:17 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sun, 9 Jun 2019 14:51:16 +0100
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 9 Jun 2019 14:51:12 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x59DpBUT41222642
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 9 Jun 2019 13:51:11 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 88C23B2064;
        Sun,  9 Jun 2019 13:51:11 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 75416B205F;
        Sun,  9 Jun 2019 13:51:11 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.156.65])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun,  9 Jun 2019 13:51:11 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 07BFF16C4293; Sun,  9 Jun 2019 06:51:15 -0700 (PDT)
Date:   Sun, 9 Jun 2019 06:51:15 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     john.hubbard@gmail.com
Cc:     LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 1/1] lockdep: fix warning: print_lock_trace defined but
 not used
Reply-To: paulmck@linux.ibm.com
References: <20190521070808.3536-1-jhubbard@nvidia.com>
 <20190521070808.3536-2-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190521070808.3536-2-jhubbard@nvidia.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19060913-2213-0000-0000-0000039C2B6C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011238; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01215500; UDB=6.00639022; IPR=6.00996591;
 MB=3.00027243; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-09 13:51:15
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19060913-2214-0000-0000-00005EC927F0
Message-Id: <20190609135114.GX28207@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-09_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906090104
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 12:08:08AM -0700, john.hubbard@gmail.com wrote:
> From: John Hubbard <jhubbard@nvidia.com>
> 
> Commit 0d2cc3b34532 ("locking/lockdep: Move valid_state() inside
> CONFIG_TRACE_IRQFLAGS && CONFIG_PROVE_LOCKING") moved the only usage of
> print_lock_trace() that was originally outside of the CONFIG_PROVE_LOCKING
> case. It moved that usage into a different case: CONFIG_PROVE_LOCKING &&
> CONFIG_TRACE_IRQFLAGS. That leaves things not symmetrical, and as a result,
> the following warning fires on my build, when I have
> 
> !CONFIG_TRACE_IRQFLAGS && !CONFIG_PROVE_LOCKING
> 
> set:
> 
> kernel/locking/lockdep.c:2821:13: warning: ‘print_lock_trace’ defined
>     but not used [-Wunused-function]
> 
> Fix this by only defining print_lock_trace() in cases in which is it
> called.
> 
> Fixes: 0d2cc3b34532 ("locking/lockdep: Move valid_state() inside CONFIG_TRACE_IRQFLAGS && CONFIG_PROVE_LOCKING")
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  kernel/locking/lockdep.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index d06190fa5082..3065dc36c27a 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -2817,11 +2817,14 @@ static inline int validate_chain(struct task_struct *curr,
>  	return 1;
>  }
> 
> +#if defined(CONFIG_TRACE_IRQFLAGS)
>  static void print_lock_trace(struct lock_trace *trace, unsigned int spaces)

This works, but another approach is to put "__maybe_unused" in the
above declaration, which avoids the need to have "#if" in a .c file.
But this file already has quite a few #if and #ifdef commands, so maybe
it is OK here.

Also, "#ifdef CONFIG_TRACE_IRQFLAGS" is a bit more conventional than
the above, should the "__maybe_unused" be undesirable.

Yet another approach is to move this function to include/linux/lockdep.h,
where #ifdef is considered less objectionable.

But I must defer to the maintainers.

							Thanx, Paul

>  {
>  }
>  #endif
> 
> +#endif
> +
>  /*
>   * We are building curr_chain_key incrementally, so double-check
>   * it from scratch, to make sure that it's done correctly:
> -- 
> 2.21.0
> 

