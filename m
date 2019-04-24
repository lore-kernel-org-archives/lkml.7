Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95BDAC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D0EB218DA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbfDXIWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 04:22:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39508 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726733AbfDXIWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 04:22:40 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3O8KDD8072380
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 04:22:39 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s2gttsjp7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 04:22:38 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 24 Apr 2019 09:22:37 +0100
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 24 Apr 2019 09:22:33 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3O8MWu535979280
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Apr 2019 08:22:32 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0CA60B205F;
        Wed, 24 Apr 2019 08:22:32 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BF563B2066;
        Wed, 24 Apr 2019 08:22:31 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.142.230])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 24 Apr 2019 08:22:31 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 6502016C239C; Wed, 24 Apr 2019 01:22:31 -0700 (PDT)
Date:   Wed, 24 Apr 2019 01:22:31 -0700
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
        Kernel development list <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 1/3] tools: memory-model: Prepare for data-race detection
Reply-To: paulmck@linux.ibm.com
References: <Pine.LNX.4.44L0.1904221211440.1384-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1904221211440.1384-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19042408-0064-0000-0000-000003D0367C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010985; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01193609; UDB=6.00625730; IPR=6.00974432;
 MB=3.00026572; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-24 08:22:36
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042408-0065-0000-0000-00003D2F6EEA
Message-Id: <20190424082231.GF3923@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-24_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904240072
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 12:17:45PM -0400, Alan Stern wrote:
> This patch makes some slight alterations to linux-kernel.cat in
> preparation for adding support for data-race detection to the
> Linux-Kernel Memory Model.
> 
> 	The definitions of relations involved in Acquire, Release, and
> 	unlock-lock ordering are moved up earlier in the source file.
> 
> 	The rmb relation is factored through the new R4rmb class: the
> 	class of reads to which rmb will apply.
> 
> 	The definition of the fence relation is moved earlier, and it
> 	is split up into read- and write-fences (rmb and wmb) and all
> 	the others.
> 
> This should not make any functional changes.
> 
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

Thank you, Alan, I have queued all three onto -rcu for review and testing.
FYI, I rebased my smp_mb__{before,after}_atomic() patch on top of yours
to avoid the conflict.

Which demonstrates non-commutativity of patches.  Your patches conflict
with mine, but mine does not conflict with yours.  ;-)

							Thanx, Paul

> ---
> 
> 
>  tools/memory-model/linux-kernel.cat |   16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> Index: usb-devel/tools/memory-model/linux-kernel.cat
> ===================================================================
> --- usb-devel.orig/tools/memory-model/linux-kernel.cat
> +++ usb-devel/tools/memory-model/linux-kernel.cat
> @@ -26,8 +26,14 @@ include "lock.cat"
>  (* Basic relations *)
>  (*******************)
>  
> +(* Release Acquire *)
> +let acq-po = [Acquire] ; po ; [M]
> +let po-rel = [M] ; po ; [Release]
> +let po-unlock-rf-lock-po = po ; [UL] ; rf ; [LKR] ; po
> +
>  (* Fences *)
> -let rmb = [R \ Noreturn] ; fencerel(Rmb) ; [R \ Noreturn]
> +let R4rmb = R \ Noreturn	(* Reads for which rmb works *)
> +let rmb = [R4rmb] ; fencerel(Rmb) ; [R4rmb]
>  let wmb = [W] ; fencerel(Wmb) ; [W]
>  let mb = ([M] ; fencerel(Mb) ; [M]) |
>  	([M] ; fencerel(Before-atomic) ; [RMW] ; po? ; [M]) |
> @@ -36,13 +42,10 @@ let mb = ([M] ; fencerel(Mb) ; [M]) |
>  	([M] ; po ; [UL] ; (co | po) ; [LKW] ;
>  		fencerel(After-unlock-lock) ; [M])
>  let gp = po ; [Sync-rcu | Sync-srcu] ; po?
> -
>  let strong-fence = mb | gp
>  
> -(* Release Acquire *)
> -let acq-po = [Acquire] ; po ; [M]
> -let po-rel = [M] ; po ; [Release]
> -let po-unlock-rf-lock-po = po ; [UL] ; rf ; [LKR] ; po
> +let nonrw-fence = strong-fence | po-rel | acq-po
> +let fence = nonrw-fence | wmb | rmb
>  
>  (**********************************)
>  (* Fundamental coherence ordering *)
> @@ -65,7 +68,6 @@ let rwdep = (dep | ctrl) ; [W]
>  let overwrite = co | fr
>  let to-w = rwdep | (overwrite & int)
>  let to-r = addr | (dep ; rfi)
> -let fence = strong-fence | wmb | po-rel | rmb | acq-po
>  let ppo = to-r | to-w | fence | (po-unlock-rf-lock-po & int)
>  
>  (* Propagation: Ordering from release operations and strong fences. *)
> 
> 

