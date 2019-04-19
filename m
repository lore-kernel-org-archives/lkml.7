Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BCCBC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55F42222EA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:18:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbfDSSSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:18:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42946 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727450AbfDSSSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:18:12 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3JHsO6m145855
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 13:54:55 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ryjv7ghc1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 13:54:54 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 19 Apr 2019 18:54:53 +0100
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 19 Apr 2019 18:54:49 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3JHsnW734996446
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Apr 2019 17:54:49 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EDBCCB2067;
        Fri, 19 Apr 2019 17:54:48 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D00D3B2066;
        Fri, 19 Apr 2019 17:54:48 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 19 Apr 2019 17:54:48 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 9E79916C0A09; Fri, 19 Apr 2019 10:54:50 -0700 (PDT)
Date:   Fri, 19 Apr 2019 10:54:50 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Documentation: atomic_t.txt: Explain ordering provided
 by smp_mb__{before,after}_atomic()
Reply-To: paulmck@linux.ibm.com
References: <Pine.LNX.4.44L0.1904191312200.1406-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1904191312200.1406-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19041917-0072-0000-0000-0000041C4AE1
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010957; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01191422; UDB=6.00624405; IPR=6.00972222;
 MB=3.00026518; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-19 17:54:53
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041917-0073-0000-0000-00004BE32751
Message-Id: <20190419175450.GC14111@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-19_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904190129
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 01:21:45PM -0400, Alan Stern wrote:
> The description of smp_mb__before_atomic() and smp_mb__after_atomic()
> in Documentation/atomic_t.txt is slightly terse and misleading.  It
> does not clearly state that these barriers only affect the ordering of
> other instructions with respect to the atomic operation.
> 
> This improves the text to make the actual ordering implications clear,
> and also to explain how these barriers differ from a RELEASE or
> ACQUIRE ordering.
> 
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

Queued for further review, thank you, Alan!

							Thanx, Paul

> ---
> 
> 
>  Documentation/atomic_t.txt |   11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> Index: usb-devel/Documentation/atomic_t.txt
> ===================================================================
> --- usb-devel.orig/Documentation/atomic_t.txt
> +++ usb-devel/Documentation/atomic_t.txt
> @@ -171,7 +171,10 @@ The barriers:
>    smp_mb__{before,after}_atomic()
>  
>  only apply to the RMW ops and can be used to augment/upgrade the ordering
> -inherent to the used atomic op. These barriers provide a full smp_mb().
> +inherent to the used atomic op. Unlike normal smp_mb() barriers, they order
> +only the RMW op itself against the instructions preceding the
> +smp_mb__before_atomic() or following the smp_mb__after_atomic(); they do
> +not order instructions on the other side of the RMW op at all.
>  
>  These helper barriers exist because architectures have varying implicit
>  ordering on their SMP atomic primitives. For example our TSO architectures
> @@ -195,7 +198,8 @@ Further, while something like:
>    atomic_dec(&X);
>  
>  is a 'typical' RELEASE pattern, the barrier is strictly stronger than
> -a RELEASE. Similarly for something like:
> +a RELEASE because it orders preceding instructions against both the read
> +and write parts of the atomic_dec(). Similarly, something like:
>  
>    atomic_inc(&X);
>    smp_mb__after_atomic();
> @@ -227,7 +231,8 @@ strictly stronger than ACQUIRE. As illus
>  
>  This should not happen; but a hypothetical atomic_inc_acquire() --
>  (void)atomic_fetch_inc_acquire() for instance -- would allow the outcome,
> -since then:
> +because it would not order the W part of the RMW against the following
> +WRITE_ONCE.  Thus:
>  
>    P1			P2
>  
> 

