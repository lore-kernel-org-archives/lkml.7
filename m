Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE37C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 01:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70AFB208CB
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 01:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gl1EbjqX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbfF1BJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 21:09:09 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47296 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbfF1BJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 21:09:08 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5S14brK110704;
        Fri, 28 Jun 2019 01:08:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=xdQ9tQX++Tq3JFVCidpP8GhdgYcyDhJfqp3vOvK9dow=;
 b=gl1EbjqXYLCqmYfYq/83xQh/3H3zFLbrcwPyasgRDPElT3d3XMvFlUhdMZcD02j6yd2Q
 vK9I4EVIcBx6ybTkXbZov97Bvor0SgpZ3jo9jQkTaiK31pBZutR4PPACb1R1EFX5ELw6
 MC/fj6S9z50vKWs00Zolsksz+Or7TNRZat4MASrlBsjJyMaQ6nb7JpJ335z5cbFReVIV
 lBzyUcGrfc1BOhKGvuUWtPfb0ltgkTCL+nR+I3II7+Pz44SLRMwd3eeYqvBF2YsHGQUV
 tvCpkFCUbdKItKSG6tfnlbDOdSl4sGjim1py4GdiDCdldiR0/Y4L/Cpdi0HGrJdSiXnh tw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2t9cyqtxtr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jun 2019 01:08:14 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5S17vNe156640;
        Fri, 28 Jun 2019 01:08:13 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2t9p6vmkyb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jun 2019 01:08:13 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5S185Nx005800;
        Fri, 28 Jun 2019 01:08:08 GMT
Received: from [10.132.91.175] (/10.132.91.175)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 27 Jun 2019 18:08:05 -0700
Subject: Re: [PATCH v3 6/7] x86/smpboot: introduce per-cpu variable for HT
 siblings
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, steven.sistare@oracle.com,
        dhaval.giani@oracle.com, daniel.lezcano@linaro.org,
        vincent.guittot@linaro.org, viresh.kumar@linaro.org,
        tim.c.chen@linux.intel.com, mgorman@techsingularity.net
References: <20190627012919.4341-1-subhra.mazumdar@oracle.com>
 <20190627012919.4341-7-subhra.mazumdar@oracle.com>
 <alpine.DEB.2.21.1906270844500.32342@nanos.tec.linutronix.de>
From:   Subhra Mazumdar <subhra.mazumdar@oracle.com>
Message-ID: <9661a38e-3475-25c9-1c65-10b42b3888d6@oracle.com>
Date:   Thu, 27 Jun 2019 18:02:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1906270844500.32342@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9301 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906280004
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9301 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906280003
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/26/19 11:51 PM, Thomas Gleixner wrote:
> On Wed, 26 Jun 2019, subhra mazumdar wrote:
>
>> Introduce a per-cpu variable to keep the number of HT siblings of a cpu.
>> This will be used for quick lookup in select_idle_cpu to determine the
>> limits of search.
> Why? The number of siblings is constant at least today unless you play
> silly cpu hotplug games. A bit more justification for adding yet another
> random storage would be appreciated.
Using cpumask_weight every time in select_idle_cpu to compute the no. of
SMT siblings can be costly as cpumask_weight may not be O(1) for systems
with large no. of CPUs (e.g 8 socket, each socket having lots of cores).
Over 512 CPUs the bitmask will span multiple cache lines and touching
multiple cache lines in the fast path of scheduler can cost more than we
save from this optimization. Even in single cache line it loops in longs.
We want to touch O(1) cache lines and do O(1) operations, hence
pre-compute it in per-CPU variable.
>
>> This patch does it only for x86.
> # grep 'This patch' Documentation/process/submitting-patches.rst
>
> IOW, we all know already that this is a patch and from the subject prefix
> and the diffstat it's pretty obvious that this is x86 only.
>
> So instead of documenting the obvious, please add proper context to justify
> the change.
Ok. The extra per-CPU optimization was done only for x86 as we cared about
it the most and make it future proof. I will add for other architectures.
>   
>> +/* representing number of HT siblings of each CPU */
>> +DEFINE_PER_CPU_READ_MOSTLY(unsigned int, cpumask_weight_sibling);
>> +EXPORT_PER_CPU_SYMBOL(cpumask_weight_sibling);
> Why does this need an export? No module has any reason to access this.
I will remove it
>
>>   /* representing HT and core siblings of each logical CPU */
>>   DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_core_map);
>>   EXPORT_PER_CPU_SYMBOL(cpu_core_map);
>> @@ -520,6 +524,8 @@ void set_cpu_sibling_map(int cpu)
>>   
>>   	if (!has_mp) {
>>   		cpumask_set_cpu(cpu, topology_sibling_cpumask(cpu));
>> +		per_cpu(cpumask_weight_sibling, cpu) =
>> +		    cpumask_weight(topology_sibling_cpumask(cpu));
>>   		cpumask_set_cpu(cpu, cpu_llc_shared_mask(cpu));
>>   		cpumask_set_cpu(cpu, topology_core_cpumask(cpu));
>>   		c->booted_cores = 1;
>> @@ -529,8 +535,12 @@ void set_cpu_sibling_map(int cpu)
>>   	for_each_cpu(i, cpu_sibling_setup_mask) {
>>   		o = &cpu_data(i);
>>   
>> -		if ((i == cpu) || (has_smt && match_smt(c, o)))
>> +		if ((i == cpu) || (has_smt && match_smt(c, o))) {
>>   			link_mask(topology_sibling_cpumask, cpu, i);
>> +			threads = cpumask_weight(topology_sibling_cpumask(cpu));
>> +			per_cpu(cpumask_weight_sibling, cpu) = threads;
>> +			per_cpu(cpumask_weight_sibling, i) = threads;
> This only works for SMT=2, but fails to update the rest for SMT=4.

I guess I assumed that x86 will always be SMT2, will fix this.

Thanks,
Subhra

>
>> @@ -1482,6 +1494,8 @@ static void remove_siblinginfo(int cpu)
>>   
>>   	for_each_cpu(sibling, topology_core_cpumask(cpu)) {
>>   		cpumask_clear_cpu(cpu, topology_core_cpumask(sibling));
>> +		per_cpu(cpumask_weight_sibling, sibling) =
>> +		    cpumask_weight(topology_sibling_cpumask(sibling));
> While remove does the right thing.
>
> Thanks,
>
> 	tglx
