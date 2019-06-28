Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A54C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 08:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32BC5208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 08:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbfF1Ios (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 04:44:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54464 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726385AbfF1Ios (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 04:44:48 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5S8gYod012220
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 04:44:47 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tdduxcfpc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 04:44:46 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Fri, 28 Jun 2019 09:44:44 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 28 Jun 2019 09:44:41 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5S8ifEg49938448
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jun 2019 08:44:41 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EE0C6A4054;
        Fri, 28 Jun 2019 08:44:40 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D084A4060;
        Fri, 28 Jun 2019 08:44:39 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Fri, 28 Jun 2019 08:44:39 +0000 (GMT)
Date:   Fri, 28 Jun 2019 08:44:38 +0000
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH RESEND v3] sched/isolation: Prefer housekeeping cpu in
 local node
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <1561682593-12071-1-git-send-email-wanpengli@tencent.com>
 <1561682593-12071-2-git-send-email-wanpengli@tencent.com>
 <20190628065802.GA27699@linux.vnet.ibm.com>
 <CANRm+Cz4R5OOga34DDepCP_yOtXXCqTxD8bs_rvgtQbjS8d1hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CANRm+Cz4R5OOga34DDepCP_yOtXXCqTxD8bs_rvgtQbjS8d1hw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
x-cbid: 19062808-4275-0000-0000-000003472E69
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062808-4276-0000-0000-0000385739BE
Message-Id: <20190628084438.GA22550@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-28_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906280102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> -#endif /* CONFIG_NUMA */
> -
>  /*
>   * sched_numa_find_closest() - given the NUMA topology, find the cpu
>   *                             closest to @cpu from @cpumask.
>   * cpumask: cpumask to find a cpu from
>   * cpu: cpu to be close to
>   *
> - * returns: cpu, or >= nr_cpu_ids when nothing found (or !NUMA).
> + * returns: cpu, or nr_cpu_ids when nothing found.
>   */
>  int sched_numa_find_closest(const struct cpumask *cpus, int cpu)
>  {
> -#ifdef CONFIG_NUMA
>      int i, j = cpu_to_node(cpu);
> 
>      for (i = 0; i < sched_domains_numa_levels; i++) {
> @@ -1754,10 +1751,11 @@ int sched_numa_find_closest(const struct
> cpumask *cpus, int cpu)
>          if (cpu < nr_cpu_ids)
>              return cpu;
>      }
> -#endif
>      return nr_cpu_ids;
>  }
> 
> +#endif /* CONFIG_NUMA */
> +
>  static int __sdt_alloc(const struct cpumask *cpu_map)
>  {
>      struct sched_domain_topology_level *tl;
> 

Looks good to me.

Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

-- 
Thanks and Regards
Srikar Dronamraju

