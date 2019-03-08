Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C90C4C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 21:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DE762081B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 21:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfCHVSr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 16:18:47 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37638 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726375AbfCHVSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 16:18:47 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x28L3lcw005993
        for <linux-kernel@vger.kernel.org>; Fri, 8 Mar 2019 16:18:45 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2r3wthnyju-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 16:18:45 -0500
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 8 Mar 2019 21:18:44 -0000
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 8 Mar 2019 21:18:41 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x28LIeBk23003182
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Mar 2019 21:18:40 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7BBF9B2064;
        Fri,  8 Mar 2019 21:18:40 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5F098B2066;
        Fri,  8 Mar 2019 21:18:40 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  8 Mar 2019 21:18:40 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 3F0CA16C2A1A; Fri,  8 Mar 2019 13:18:40 -0800 (PST)
Date:   Fri, 8 Mar 2019 13:18:40 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Neeraj Upadhyay <neeraju@codeaurora.org>
Cc:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu/tree_plugin: Fix nohz status in stall warning
Reply-To: paulmck@linux.ibm.com
References: <1552069309-24392-1-git-send-email-neeraju@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552069309-24392-1-git-send-email-neeraju@codeaurora.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19030821-0068-0000-0000-000003A20785
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010728; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01171551; UDB=6.00612381; IPR=6.00952195;
 MB=3.00025898; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-08 21:18:43
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19030821-0069-0000-0000-000047C174FD
Message-Id: <20190308211840.GW13351@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-08_18:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903080147
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 11:51:49PM +0530, Neeraj Upadhyay wrote:
> Fix stall warning, to show correct nohz marker.
> 
> Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>

Good eyes, thank you!

I applied and pushed all three with modified commit logs.  Please check
to make sure that I didn't mess anything up.  If testing and reviews
are OK, I expect to submit them for the v5.2 merge window.

I had to hand-apply this one, so in future patches could you please
generate them against -rcu?  It may be found here:

	git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git

							Thanx, Paul

> ---
>  kernel/rcu/tree_plugin.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 97dba50..93da32c 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -1659,7 +1659,7 @@ static void print_cpu_stall_fast_no_hz(char *cp, int cpu)
>  		rdp->last_accelerate & 0xffff, jiffies & 0xffff,
>  		".l"[rdp->all_lazy],
>  		".L"[!rcu_segcblist_n_nonlazy_cbs(&rdp->cblist)],
> -		".D"[!rdp->tick_nohz_enabled_snap]);
> +		".D"[!!rdp->tick_nohz_enabled_snap]);
>  }
> 
>  #else /* #ifdef CONFIG_RCU_FAST_NO_HZ */
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
> member of the Code Aurora Forum, hosted by The Linux Foundation
> 

