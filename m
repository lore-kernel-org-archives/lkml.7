Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB04C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 16:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5CB4217D7
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 16:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733083AbfHHQTE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 12:19:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32734 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728020AbfHHQTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 12:19:04 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x78GDC5x132960
        for <linux-kernel@vger.kernel.org>; Thu, 8 Aug 2019 12:19:02 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u8mmcypq6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 12:19:02 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 8 Aug 2019 17:19:01 +0100
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 8 Aug 2019 17:18:58 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x78GIvou13173300
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Aug 2019 16:18:57 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 63424B205F;
        Thu,  8 Aug 2019 16:18:57 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4666FB2064;
        Thu,  8 Aug 2019 16:18:57 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  8 Aug 2019 16:18:57 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 5CF0E16C8EB1; Thu,  8 Aug 2019 09:18:58 -0700 (PDT)
Date:   Thu, 8 Aug 2019 09:18:58 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH rcu] rcu/nocb: rcu_segcblist_set_len() can be static
Reply-To: paulmck@linux.ibm.com
References: <201908081009.37BaOO5n%lkp@intel.com>
 <20190808023258.jomwku7gtzwqc76w@48261080c7f1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808023258.jomwku7gtzwqc76w@48261080c7f1>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19080816-0064-0000-0000-00000406DFB4
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011571; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01243910; UDB=6.00656229; IPR=6.01025389;
 MB=3.00028094; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-08 16:19:00
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19080816-0065-0000-0000-00003E9873F1
Message-Id: <20190808161858.GO28441@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-08_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908080152
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 10:32:58AM +0800, kbuild test robot wrote:
> 
> Fixes: ab2ef5c7b4d1 ("rcu/nocb: Atomic ->len field in rcu_segcblist structure")
> Signed-off-by: kbuild test robot <lkp@intel.com>

Good catch!  Queued with updated commit log, thank you!

							Thanx, Paul

> ---
>  rcu_segcblist.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
> index ff431cc830378..84bbffaaede83 100644
> --- a/kernel/rcu/rcu_segcblist.c
> +++ b/kernel/rcu/rcu_segcblist.c
> @@ -58,7 +58,7 @@ struct rcu_head *rcu_cblist_dequeue(struct rcu_cblist *rclp)
>  }
>  
>  /* Set the length of an rcu_segcblist structure. */
> -void rcu_segcblist_set_len(struct rcu_segcblist *rsclp, long v)
> +static void rcu_segcblist_set_len(struct rcu_segcblist *rsclp, long v)
>  {
>  #ifdef CONFIG_RCU_NOCB_CPU
>  	atomic_long_set(&rsclp->len, v);
> @@ -74,7 +74,7 @@ void rcu_segcblist_set_len(struct rcu_segcblist *rsclp, long v)
>   * This increase is fully ordered with respect to the callers accesses
>   * both before and after.
>   */
> -void rcu_segcblist_add_len(struct rcu_segcblist *rsclp, long v)
> +static void rcu_segcblist_add_len(struct rcu_segcblist *rsclp, long v)
>  {
>  #ifdef CONFIG_RCU_NOCB_CPU
>  	smp_mb__before_atomic(); /* Up to the caller! */
> @@ -104,7 +104,7 @@ void rcu_segcblist_inc_len(struct rcu_segcblist *rsclp)
>   * with the actual number of callbacks on the structure.  This exchange is
>   * fully ordered with respect to the callers accesses both before and after.
>   */
> -long rcu_segcblist_xchg_len(struct rcu_segcblist *rsclp, long v)
> +static long rcu_segcblist_xchg_len(struct rcu_segcblist *rsclp, long v)
>  {
>  #ifdef CONFIG_RCU_NOCB_CPU
>  	return atomic_long_xchg(&rsclp->len, v);

