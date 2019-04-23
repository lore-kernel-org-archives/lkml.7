Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2567C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 08:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C91132077C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 08:06:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfDWIGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 04:06:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34518 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725888AbfDWIGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 04:06:51 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3N84HSs040886
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 04:06:50 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s1wx536av-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 04:06:49 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 23 Apr 2019 09:06:48 +0100
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 23 Apr 2019 09:06:46 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3N86jKg30343298
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Apr 2019 08:06:45 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2C3C0B206B;
        Tue, 23 Apr 2019 08:06:45 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 06250B2068;
        Tue, 23 Apr 2019 08:06:45 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.142.184])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 23 Apr 2019 08:06:44 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 971E716C6D78; Tue, 23 Apr 2019 01:06:44 -0700 (PDT)
Date:   Tue, 23 Apr 2019 01:06:44 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Jiang Biao <benbjiang@tencent.com>
Cc:     josh@joshtriplett.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu/tree_exp: cleanup initialized but not used rdp
Reply-To: paulmck@linux.ibm.com
References: <20190423012155.30606-1-benbjiang@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423012155.30606-1-benbjiang@tencent.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19042308-2213-0000-0000-0000037C0396
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010978; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01193127; UDB=6.00625439; IPR=6.00973947;
 MB=3.00026552; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-23 08:06:47
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042308-2214-0000-0000-00005E211A48
Message-Id: <20190423080644.GC3923@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-22_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904230060
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 09:21:55AM +0800, Jiang Biao wrote:
> rdp is initialized but never used in synchronize_rcu_expedited(),
> just remove it.
> 
> Signed-off-by: Jiang Biao <benbjiang@tencent.com>

I queued and pushed both patches for testing and review, good eyes,
thank you!  I reworded the subject and commit logs, so could you please
check to make sure that I didn't mess anything up?

							Thanx, Paul

> ---
>  kernel/rcu/tree_exp.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> index 4c2a0189e748..5772612379e4 100644
> --- a/kernel/rcu/tree_exp.h
> +++ b/kernel/rcu/tree_exp.h
> @@ -733,7 +733,6 @@ static void sync_sched_exp_online_cleanup(int cpu)
>   */
>  void synchronize_rcu_expedited(void)
>  {
> -	struct rcu_data *rdp;
>  	struct rcu_exp_work rew;
>  	struct rcu_node *rnp;
>  	unsigned long s;
> @@ -770,7 +769,6 @@ void synchronize_rcu_expedited(void)
>  	}
>  
>  	/* Wait for expedited grace period to complete. */
> -	rdp = per_cpu_ptr(&rcu_data, raw_smp_processor_id());
>  	rnp = rcu_get_root();
>  	wait_event(rnp->exp_wq[rcu_seq_ctr(s) & 0x3],
>  		   sync_exp_work_done(s));
> -- 
> 2.17.2 (Apple Git-113)
> 

