Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 697B0C742A5
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 07:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2727B208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 07:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VR8Wm8/0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbfGLHmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 03:42:24 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:34828 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfGLHmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 03:42:24 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6C7cwS0075741;
        Fri, 12 Jul 2019 07:41:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=Hqtemgq0/vKq7WKvzyTPGJ5M4ed+ytO/KDHOyeR5Kag=;
 b=VR8Wm8/0R14XVpIrQWlP302kEwRZZNDGHxUJeqJ32skhKnHoy8wtRjXWiRDe55dTwcOK
 4C3poH0LdwIf8mbbqchF6vboU0PYNQ5q7unlVMiToZoeDtEcm8z6BUjmyRs6ZXnjc5L1
 VkS7bVSdF0se7R9Bcds9ttf+0a2+aIONUo81jB2TwI6fGEQ/0Nd7j9ehAPPmx0MImekD
 1Tl9b41yuDg4PzX0MPktQM+/8QC6mI1XzsSZZpyXxkZVM05p0MKyNPrb8NgU8aBpoS8g
 pAPNx5nAiYcBKepZV5U3q40+TUbyPoAyBquU5nCspPFitCvGba5POLE4Hvbyeg+J0v0/ uA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2tjkkq40tx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jul 2019 07:41:31 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6C7bi5C079515;
        Fri, 12 Jul 2019 07:41:31 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2tn1j20jnw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jul 2019 07:41:30 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6C7fLMh020987;
        Fri, 12 Jul 2019 07:41:25 GMT
Received: from [10.191.17.234] (/10.191.17.234)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 12 Jul 2019 00:41:21 -0700
Subject: Re: [PATCH] xen/pv: Fix a boot up hang triggered by int3 self test
To:     linux-kernel@vger.kernel.org
Cc:     xen-devel@lists.xenproject.org, x86@kernel.org,
        srinivas.eeda@oracle.com,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
References: <1562820438-30328-1-git-send-email-zhenzhong.duan@oracle.com>
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
Organization: Oracle Corporation
Message-ID: <fa73ab45-235d-b338-ddd1-1628ed70d801@oracle.com>
Date:   Fri, 12 Jul 2019 15:41:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1562820438-30328-1-git-send-email-zhenzhong.duan@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9315 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907120079
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9315 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907120079
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the noise, it looks description is wrong.

This is not a double pop, but xen pv taking the path

with create_gap=0, I'll send a v2.

Zhenzhong

On 2019/7/11 12:47, Zhenzhong Duan wrote:
> Commit 7457c0da024b ("x86/alternatives: Add int3_emulate_call()
> selftest") reveals a bug in XEN PV int3 assemble code. There is
> a double pop of register R11 and RCX currupting the exception
> frame, one in xen_int3 and the other in xen_xenint3.
>
> We see below hang at bootup:
>
> general protection fault: 0000 [#1] SMP NOPTI
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.2.0+ #6
> RIP: e030:int3_magic+0x0/0x7
> Call Trace:
>   alternative_instructions+0x3d/0x12e
>   check_bugs+0x7c9/0x887
>   ?__get_locked_pte+0x178/0x1f0
>   start_kernel+0x4ff/0x535
>   ?set_init_arg+0x55/0x55
>   xen_start_kernel+0x571/0x57a
>
> Fix it by removing xen_xenint3.
>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> ---
>   arch/x86/include/asm/traps.h | 2 +-
>   arch/x86/xen/enlighten_pv.c  | 2 +-
>   arch/x86/xen/xen-asm_64.S    | 1 -
>   3 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
> index 7d6f3f3..f2bd284 100644
> --- a/arch/x86/include/asm/traps.h
> +++ b/arch/x86/include/asm/traps.h
> @@ -40,7 +40,7 @@
>   asmlinkage void xen_divide_error(void);
>   asmlinkage void xen_xennmi(void);
>   asmlinkage void xen_xendebug(void);
> -asmlinkage void xen_xenint3(void);
> +asmlinkage void xen_int3(void);
>   asmlinkage void xen_overflow(void);
>   asmlinkage void xen_bounds(void);
>   asmlinkage void xen_invalid_op(void);
> diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
> index 4722ba2..2138d69 100644
> --- a/arch/x86/xen/enlighten_pv.c
> +++ b/arch/x86/xen/enlighten_pv.c
> @@ -596,7 +596,7 @@ struct trap_array_entry {
>   
>   static struct trap_array_entry trap_array[] = {
>   	{ debug,                       xen_xendebug,                    true },
> -	{ int3,                        xen_xenint3,                     true },
> +	{ int3,                        xen_int3,                        true },
>   	{ double_fault,                xen_double_fault,                true },
>   #ifdef CONFIG_X86_MCE
>   	{ machine_check,               xen_machine_check,               true },
> diff --git a/arch/x86/xen/xen-asm_64.S b/arch/x86/xen/xen-asm_64.S
> index 1e9ef0b..ebf610b 100644
> --- a/arch/x86/xen/xen-asm_64.S
> +++ b/arch/x86/xen/xen-asm_64.S
> @@ -32,7 +32,6 @@ xen_pv_trap divide_error
>   xen_pv_trap debug
>   xen_pv_trap xendebug
>   xen_pv_trap int3
> -xen_pv_trap xenint3
>   xen_pv_trap xennmi
>   xen_pv_trap overflow
>   xen_pv_trap bounds
