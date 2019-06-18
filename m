Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E4AC31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 16:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0079221530
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 16:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729886AbfFRQBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 12:01:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:3932 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729209AbfFRQBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 12:01:41 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5IFvQ99103215;
        Tue, 18 Jun 2019 12:00:17 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t724g32ud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jun 2019 12:00:17 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x5IFvYBc103895;
        Tue, 18 Jun 2019 12:00:15 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t724g32td-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jun 2019 12:00:15 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x5IFtFRo012294;
        Tue, 18 Jun 2019 16:00:14 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma01wdc.us.ibm.com with ESMTP id 2t4ra6mnf5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jun 2019 16:00:14 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5IG0D7G32571842
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jun 2019 16:00:13 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C465B208D;
        Tue, 18 Jun 2019 16:00:13 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 58606B2071;
        Tue, 18 Jun 2019 16:00:13 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.26])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 18 Jun 2019 16:00:13 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 8ED1916C5DF4; Tue, 18 Jun 2019 09:00:14 -0700 (PDT)
Date:   Tue, 18 Jun 2019 09:00:14 -0700
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
Subject: Re: [PATCH v2] lockdep: fix warning: print_lock_trace defined but
 not used
Message-ID: <20190618160014.GP26519@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190609135114.GX28207@linux.ibm.com>
 <20190610000933.29578-1-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190610000933.29578-1-jhubbard@nvidia.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-18_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906180126
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 09, 2019 at 05:09:33PM -0700, john.hubbard@gmail.com wrote:
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
> Fix this by annotating print_lock_trace() with "__maybe_unused".
> Thanks to Paul E. McKenney for suggesting this less intrusive fix,
> as compared to adding more ifdef noise.
> 
> Fixes: 0d2cc3b34532 ("locking/lockdep: Move valid_state() inside CONFIG_TRACE_IRQFLAGS && CONFIG_PROVE_LOCKING")
> 
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Tested-by: Paul E. McKenney <paulmck@linux.ibm.com>

> ---
>  kernel/locking/lockdep.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index c47788fa85f9..2726dafdb29b 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -2818,7 +2818,8 @@ static inline int validate_chain(struct task_struct *curr,
>  	return 1;
>  }
> 
> -static void print_lock_trace(struct lock_trace *trace, unsigned int spaces)
> +static void __maybe_unused print_lock_trace(struct lock_trace *trace,
> +					    unsigned int spaces)
>  {
>  }
>  #endif
> -- 
> 2.21.0
> 
