Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97BDBC5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 03:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69D3021721
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 03:03:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfGCDDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 23:03:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5116 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727049AbfGCDDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 23:03:53 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6331eE1041474
        for <linux-kernel@vger.kernel.org>; Tue, 2 Jul 2019 23:03:52 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tghx3bx0q-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 23:03:52 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Wed, 3 Jul 2019 04:03:50 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 3 Jul 2019 04:03:47 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6333kJY40632704
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 3 Jul 2019 03:03:46 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0D242A4040;
        Wed,  3 Jul 2019 03:03:46 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 93D9FA4057;
        Wed,  3 Jul 2019 03:03:43 +0000 (GMT)
Received: from [9.85.75.18] (unknown [9.85.75.18])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  3 Jul 2019 03:03:43 +0000 (GMT)
Subject: Re: [RFC PATCH v2 10/12] powerpc/ptrace: create ptrace_get_debugreg()
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, mikey@neuling.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <cover.1561735587.git.christophe.leroy@c-s.fr>
 <483ffd1c62d270d7079b41e1747f34d254390c24.1561735588.git.christophe.leroy@c-s.fr>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Wed, 3 Jul 2019 08:33:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <483ffd1c62d270d7079b41e1747f34d254390c24.1561735588.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19070303-0008-0000-0000-000002F94C54
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19070303-0009-0000-0000-0000226697FC
Message-Id: <6d47ed55-2b55-4c48-71cd-ef9d420a388d@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-03_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907030035
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/28/19 9:17 PM, Christophe Leroy wrote:
> Create ptrace_get_debugreg() to handle PTRACE_GET_DEBUGREG and
> reduce ifdef mess
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/kernel/ptrace/ptrace-adv.c   |  9 +++++++++
>  arch/powerpc/kernel/ptrace/ptrace-decl.h  |  2 ++
>  arch/powerpc/kernel/ptrace/ptrace-noadv.c | 13 +++++++++++++
>  arch/powerpc/kernel/ptrace/ptrace.c       | 18 ++----------------
>  4 files changed, 26 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/ptrace/ptrace-adv.c b/arch/powerpc/kernel/ptrace/ptrace-adv.c
> index 86e71fa6c5c8..dcc765940344 100644
> --- a/arch/powerpc/kernel/ptrace/ptrace-adv.c
> +++ b/arch/powerpc/kernel/ptrace/ptrace-adv.c
> @@ -83,6 +83,15 @@ void user_disable_single_step(struct task_struct *task)
>  	clear_tsk_thread_flag(task, TIF_SINGLESTEP);
>  }
>  
> +int ptrace_get_debugreg(struct task_struct *child, unsigned long addr,
> +			unsigned long __user *datalp)
> +{
> +	/* We only support one DABR and no IABRS at the moment */

No DABR / IABR in ptrace-adv.c

> +	if (addr > 0)
> +		return -EINVAL;
> +	return put_user(child->thread.debug.dac1, datalp);
> +}
> +
>  int ptrace_set_debugreg(struct task_struct *task, unsigned long addr, unsigned long data)
>  {
>  	/* For ppc64 we support one DABR and no IABR's at the moment (ppc64).
> diff --git a/arch/powerpc/kernel/ptrace/ptrace-decl.h b/arch/powerpc/kernel/ptrace/ptrace-decl.h
> index bdba09a87aea..4b4b6a1d508a 100644
> --- a/arch/powerpc/kernel/ptrace/ptrace-decl.h
> +++ b/arch/powerpc/kernel/ptrace/ptrace-decl.h
> @@ -176,6 +176,8 @@ int tm_cgpr32_set(struct task_struct *target, const struct user_regset *regset,
>  extern const struct user_regset_view user_ppc_native_view;
>  
>  /* ptrace-(no)adv */
> +int ptrace_get_debugreg(struct task_struct *child, unsigned long addr,
> +			unsigned long __user *datalp);
>  int ptrace_set_debugreg(struct task_struct *task, unsigned long addr, unsigned long data);
>  long ppc_set_hwdebug(struct task_struct *child, struct ppc_hw_breakpoint *bp_info);
>  long ppc_del_hwdebug(struct task_struct *child, long data);
> diff --git a/arch/powerpc/kernel/ptrace/ptrace-noadv.c b/arch/powerpc/kernel/ptrace/ptrace-noadv.c
> index 7db330c94538..985cca136f85 100644
> --- a/arch/powerpc/kernel/ptrace/ptrace-noadv.c
> +++ b/arch/powerpc/kernel/ptrace/ptrace-noadv.c
> @@ -64,6 +64,19 @@ void user_disable_single_step(struct task_struct *task)
>  	clear_tsk_thread_flag(task, TIF_SINGLESTEP);
>  }
>  
> +int ptrace_get_debugreg(struct task_struct *child, unsigned long addr,
> +			unsigned long __user *datalp)
> +{
> +	unsigned long dabr_fake;
> +
> +	/* We only support one DABR and no IABRS at the moment */
> +	if (addr > 0)
> +		return -EINVAL;
> +	dabr_fake = ((child->thread.hw_brk.address & (~HW_BRK_TYPE_DABR)) |
> +		     (child->thread.hw_brk.type & HW_BRK_TYPE_DABR));
> +	return put_user(dabr_fake, datalp);
> +}
> +
>  int ptrace_set_debugreg(struct task_struct *task, unsigned long addr, unsigned long data)
>  {
>  #ifdef CONFIG_HAVE_HW_BREAKPOINT
> diff --git a/arch/powerpc/kernel/ptrace/ptrace.c b/arch/powerpc/kernel/ptrace/ptrace.c
> index 377e0e541d5f..e789afae6f56 100644
> --- a/arch/powerpc/kernel/ptrace/ptrace.c
> +++ b/arch/powerpc/kernel/ptrace/ptrace.c
> @@ -211,23 +211,9 @@ long arch_ptrace(struct task_struct *child, long request,
>  		break;
>  	}
>  
> -	case PTRACE_GET_DEBUGREG: {
> -#ifndef CONFIG_PPC_ADV_DEBUG_REGS
> -		unsigned long dabr_fake;
> -#endif
> -		ret = -EINVAL;
> -		/* We only support one DABR and no IABRS at the moment */
> -		if (addr > 0)
> -			break;
> -#ifdef CONFIG_PPC_ADV_DEBUG_REGS
> -		ret = put_user(child->thread.debug.dac1, datalp);
> -#else
> -		dabr_fake = ((child->thread.hw_brk.address & (~HW_BRK_TYPE_DABR)) |
> -			     (child->thread.hw_brk.type & HW_BRK_TYPE_DABR));
> -		ret = put_user(dabr_fake, datalp);
> -#endif
> +	case PTRACE_GET_DEBUGREG:
> +		ret = ptrace_get_debugreg(child, addr, datalp);
>  		break;
> -	}
>  
>  	case PTRACE_SET_DEBUGREG:
>  		ret = ptrace_set_debugreg(child, addr, data);
> 

Otherwise,

Reviewed-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

