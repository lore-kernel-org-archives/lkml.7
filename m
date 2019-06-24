Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F9EC4646B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 23:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77D9720663
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 23:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbfFXXEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 19:04:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40328 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726486AbfFXXEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 19:04:53 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5OMvfrh022547
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 19:04:52 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tb5ysmea2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 19:04:51 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 25 Jun 2019 00:04:50 +0100
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 25 Jun 2019 00:04:47 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5ON4ki036569560
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 23:04:46 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5E43BB2066;
        Mon, 24 Jun 2019 23:04:46 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 408ADB2064;
        Mon, 24 Jun 2019 23:04:46 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.26])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 24 Jun 2019 23:04:46 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id B14B416C373B; Mon, 24 Jun 2019 16:04:49 -0700 (PDT)
Date:   Mon, 24 Jun 2019 16:04:49 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Muchun Song <smuchun@gmail.com>
Cc:     joel@joelfernandes.org, tglx@linutronix.de, mingo@kernel.org,
        rostedt@goodmis.org, frederic@kernel.org,
        alexander.levin@verizon.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] softirq: Replace this_cpu_write with __this_cpu_write if
 irq is disabled
Reply-To: paulmck@linux.ibm.com
References: <20190618143305.2038-1-smuchun@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618143305.2038-1-smuchun@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19062423-2213-0000-0000-000003A40A65
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011323; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01222803; UDB=6.00643448; IPR=6.01003963;
 MB=3.00027451; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-24 23:04:49
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062423-2214-0000-0000-00005EFAED92
Message-Id: <20190624230449.GO26519@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-24_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=886 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906240181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 10:33:05PM +0800, Muchun Song wrote:
> Irq is disabled before this_cpu_write(), so we can Replace this_cpu_write()
> with __this_cpu_write().
> 
> Signed-off-by: Muchun Song <smuchun@gmail.com>

This passes light rcutorture testing, and looks rather low risk.

Tested-by: Paul E. McKenney <paulmck@linux.ibm.com>

> ---
>  kernel/softirq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index 2c3382378d94..eaf3bdf7c749 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -650,7 +650,7 @@ static int takeover_tasklets(unsigned int cpu)
>  	/* Find end, append list for that CPU. */
>  	if (&per_cpu(tasklet_vec, cpu).head != per_cpu(tasklet_vec, cpu).tail) {
>  		*__this_cpu_read(tasklet_vec.tail) = per_cpu(tasklet_vec, cpu).head;
> -		this_cpu_write(tasklet_vec.tail, per_cpu(tasklet_vec, cpu).tail);
> +		__this_cpu_write(tasklet_vec.tail, per_cpu(tasklet_vec, cpu).tail);
>  		per_cpu(tasklet_vec, cpu).head = NULL;
>  		per_cpu(tasklet_vec, cpu).tail = &per_cpu(tasklet_vec, cpu).head;
>  	}
> -- 
> 2.17.1
> 

