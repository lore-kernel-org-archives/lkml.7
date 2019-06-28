Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C65EC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 06:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 379462070D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 06:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbfF1G6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 02:58:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26414 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726719AbfF1G6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 02:58:11 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5S6vl7F063789
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 02:58:10 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tdba1e27w-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 02:58:09 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Fri, 28 Jun 2019 07:58:08 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 28 Jun 2019 07:58:05 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5S6w4J825166148
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jun 2019 06:58:04 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B3C1A4054;
        Fri, 28 Jun 2019 06:58:04 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F9A9A405B;
        Fri, 28 Jun 2019 06:58:03 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Fri, 28 Jun 2019 06:58:02 +0000 (GMT)
Date:   Fri, 28 Jun 2019 06:58:02 +0000
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH RESEND v3] sched/isolation: Prefer housekeeping cpu in
 local node
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <1561682593-12071-1-git-send-email-wanpengli@tencent.com>
 <1561682593-12071-2-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1561682593-12071-2-git-send-email-wanpengli@tencent.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
x-cbid: 19062806-0012-0000-0000-0000032D4AF3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062806-0013-0000-0000-000021668BCF
Message-Id: <20190628065802.GA27699@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-28_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906280079
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Wanpeng Li <kernellwp@gmail.com> [2019-06-28 08:43:13]:


>  
> +/*
> + * sched_numa_find_closest() - given the NUMA topology, find the cpu
> + *                             closest to @cpu from @cpumask.
> + * cpumask: cpumask to find a cpu from
> + * cpu: cpu to be close to
> + *
> + * returns: cpu, or >= nr_cpu_ids when nothing found (or !NUMA).

One nit:
I dont see sched_numa_find_closest returning anything greater than
nr_cpu_ids. So 's/>= //' for the above comment.

> + */
> +int sched_numa_find_closest(const struct cpumask *cpus, int cpu)
> +{
> +#ifdef CONFIG_NUMA
> +	int i, j = cpu_to_node(cpu);
> +
> +	for (i = 0; i < sched_domains_numa_levels; i++) {
> +		cpu = cpumask_any_and(cpus, sched_domains_numa_masks[i][j]);
> +		if (cpu < nr_cpu_ids)
> +			return cpu;
> +	}
> +#endif
> +	return nr_cpu_ids;
> +}
> +

Should we have a static function for sched_numa_find_closest instead of
having #ifdef in the function?

>  static int __sdt_alloc(const struct cpumask *cpu_map)
>  {
>  	struct sched_domain_topology_level *tl;

-- 
Thanks and Regards
Srikar Dronamraju

