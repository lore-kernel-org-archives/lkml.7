Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E80DDC282E2
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 22:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE6C5217FA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 22:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dy9xftlf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbfDSWd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 18:33:59 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39136 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfDSWd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 18:33:58 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3JMK5gM146347;
        Fri, 19 Apr 2019 22:33:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=PnmhG2raMFjR7rjL+Fe2rAbXljXWWb7EydX0mFf1t2o=;
 b=dy9xftlf50p3WyZjspuLmvtmeXVd/HJVaUryTrc7iqS/Xq0wKvqPj5nT/WRHMpE+8p9+
 b/dRlgr2plbU/Wa7lfMJbVzuwtCNgs49t/rC+vSHl9jSZB8EpH4yrtJs+AfrV0rDoAiw
 4Cnam+RBPkfOYQ8s7+pP6wy/BbKSQDfzKI1Xv7DH7YZ4+0cT4Z9xji3XDa2Wm7Vl32j8
 3aJWU/Q1hlTxctz+Eg2k5KcpcPPmdD87nIDAl60f9aWYu8PORwsyEYWQKIzRlJSicMsy
 FmLCTSTL6TMhott7x/7Ms9uGE/qJTkNtS7TGVk74teqtpdPne2TTtvPFcKHD8TWDGdMu KA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2ryjv90s79-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Apr 2019 22:33:42 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3JMXOU2185790;
        Fri, 19 Apr 2019 22:33:42 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2ryjut3bww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Apr 2019 22:33:42 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x3JMXe61018785;
        Fri, 19 Apr 2019 22:33:41 GMT
Received: from dhcp-10-132-91-102.usdhcp.oraclecorp.com (/10.132.91.102)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 19 Apr 2019 15:33:40 -0700
Subject: Re: [PATCH] KVM: nVMX: allow tests to use bad virtual-APIC page
 address
To:     Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
References: <1555335333-23636-2-git-send-email-pbonzini@redhat.com>
From:   Krish Sadhukhan <krish.sadhukhan@oracle.com>
Message-ID: <d2b38c0c-8466-7f88-d60f-bdaa20d6282f@oracle.com>
Date:   Fri, 19 Apr 2019 15:33:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <1555335333-23636-2-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9232 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904190156
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9232 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904190155
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/15/2019 06:35 AM, Paolo Bonzini wrote:
> As mentioned in the comment, there are some special cases where we can simply
> clear the TPR shadow bit from the CPU-based execution controls in the vmcs02.
> Handle them so that we can remove some XFAILs from vmx.flat.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   arch/x86/kvm/vmx/nested.c | 25 ++++++++++++++++---------
>   arch/x86/kvm/vmx/vmx.c    |  2 +-
>   arch/x86/kvm/vmx/vmx.h    |  2 ++
>   3 files changed, 19 insertions(+), 10 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 7ec9bb1dd723..a22af5a85540 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -2873,20 +2873,27 @@ static void nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
>   		/*
>   		 * If translation failed, VM entry will fail because
>   		 * prepare_vmcs02 set VIRTUAL_APIC_PAGE_ADDR to -1ull.
> -		 * Failing the vm entry is _not_ what the processor
> -		 * does but it's basically the only possibility we
> -		 * have.  We could still enter the guest if CR8 load
> -		 * exits are enabled, CR8 store exits are enabled, and
> -		 * virtualize APIC access is disabled; in this case
> -		 * the processor would never use the TPR shadow and we
> -		 * could simply clear the bit from the execution
> -		 * control.  But such a configuration is useless, so
> -		 * let's keep the code simple.
>   		 */
>   		if (!is_error_page(page)) {
>   			vmx->nested.virtual_apic_page = page;
>   			hpa = page_to_phys(vmx->nested.virtual_apic_page);
>   			vmcs_write64(VIRTUAL_APIC_PAGE_ADDR, hpa);
> +		} else if (nested_cpu_has(vmcs12, CPU_BASED_CR8_LOAD_EXITING) &&
> +		           nested_cpu_has(vmcs12, CPU_BASED_CR8_STORE_EXITING) &&
> +			   !nested_cpu_has2(vmcs12, SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES)) {
> +			/*
> +			 * The processor will never use the TPR shadow, simply
> +			 * clear the bit from the execution control.  Such a
> +			 * configuration is useless, but it happens in tests.
> +			 * For any other configuration, failing the vm entry is
> +			 * _not_ what the processor does but it's basically the
> +			 * only possibility we have.
> +			 */
> +			vmcs_clear_bits(CPU_BASED_VM_EXEC_CONTROL,
> +					CPU_BASED_TPR_SHADOW);
> +		} else {
> +			printk("bad virtual-APIC page address\n");
> +			dump_vmcs();
>   		}
>   	}
>   
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index f8054dc1de65..14cacfd7ffd0 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -5603,7 +5603,7 @@ static void vmx_dump_dtsel(char *name, uint32_t limit)
>   	       vmcs_readl(limit + GUEST_GDTR_BASE - GUEST_GDTR_LIMIT));
>   }
>   
> -static void dump_vmcs(void)
> +void dump_vmcs(void)
>   {
>   	u32 vmentry_ctl = vmcs_read32(VM_ENTRY_CONTROLS);
>   	u32 vmexit_ctl = vmcs_read32(VM_EXIT_CONTROLS);
> diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
> index a1e00d0a2482..f879529906b4 100644
> --- a/arch/x86/kvm/vmx/vmx.h
> +++ b/arch/x86/kvm/vmx/vmx.h
> @@ -517,4 +517,6 @@ static inline void decache_tsc_multiplier(struct vcpu_vmx *vmx)
>   	vmcs_write64(TSC_MULTIPLIER, vmx->current_tsc_ratio);
>   }
>   
> +void dump_vmcs(void);
> +
>   #endif /* __KVM_X86_VMX_H */

Reviewed-by: Krish Sadhukhan <krish.sadhukhan@oracle.com>
