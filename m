Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF77C10F13
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 00:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3C9021773
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 00:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="tjgCByq4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731080AbfDQAgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 20:36:13 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42910 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728237AbfDQAgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 20:36:13 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3H0OCft029440;
        Wed, 17 Apr 2019 00:36:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=VYx8l/OLZY22zLAiBBrv9wYWwlUXBjfJNs0LLrNYpLw=;
 b=tjgCByq4+aFdKsEjJYcTrbbSsBEmmgjnknfdBTHCL7UFrqyh5NlsEED/dkXb6932lgY0
 aJYPagIFPhkU8Bn7a39V2HLXJLPKXqEnC+jigiPQJzIkdTwxu7Z5hddq4EBOZV+Eubtb
 HCoEpAkYjQWSICyCHcM8bRNefKqW1nAZG1KyLIyAh6bxZ1N98CvA2XL+z0bjEwOadXzP
 MPwu919K/mfNCo+DFTvmnbPpLmKM8CNmZxywsI52Ra0kmpLlght/kHcphJ+MFJctDW78
 vYkjQfK5cjzlwOhaYNsYAyMvGgqvuqjU08vEgU24/z7hZzk1io9EceQCqqJ/2kkdyVSM QQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2rvwk3qwap-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Apr 2019 00:36:10 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3H0a9OI130840;
        Wed, 17 Apr 2019 00:36:09 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2rv2tv2dwq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Apr 2019 00:36:09 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3H0a6xb003838;
        Wed, 17 Apr 2019 00:36:06 GMT
Received: from dhcp-10-132-91-102.usdhcp.oraclecorp.com (/10.132.91.102)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 16 Apr 2019 17:36:06 -0700
Subject: Re: [PATCH] KVM: vmx: print more APICv fields in dump_vmcs
To:     Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
References: <1555335333-23636-1-git-send-email-pbonzini@redhat.com>
From:   Krish Sadhukhan <krish.sadhukhan@oracle.com>
Message-ID: <648a74b9-d592-8505-25d7-96a16fed9f51@oracle.com>
Date:   Tue, 16 Apr 2019 17:36:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <1555335333-23636-1-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9229 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904170000
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9229 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904170000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/15/2019 06:35 AM, Paolo Bonzini wrote:
> The SVI, RVI, virtual-APIC page address and APIC-access page address fields
> were left out of dump_vmcs.  Add them.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   arch/x86/kvm/vmx/vmx.c | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index ab432a930ae8..f8054dc1de65 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -5723,8 +5723,17 @@ static void dump_vmcs(void)
>   	if (secondary_exec_control & SECONDARY_EXEC_TSC_SCALING)
>   		pr_err("TSC Multiplier = 0x%016llx\n",
>   		       vmcs_read64(TSC_MULTIPLIER));
> -	if (cpu_based_exec_ctrl & CPU_BASED_TPR_SHADOW)
> -		pr_err("TPR Threshold = 0x%02x\n", vmcs_read32(TPR_THRESHOLD));
> +	if (cpu_based_exec_ctrl & CPU_BASED_TPR_SHADOW) {
> +		if (secondary_exec_control & SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY) {
> +			u16 status = vmcs_read16(GUEST_INTR_STATUS);
> +			pr_err("SVI|RVI = %02x|%02x ", status >> 8, status & 0xff);
> +		}
> +		pr_err(KERN_CONT "TPR Threshold = 0x%02x\n", vmcs_read32(TPR_THRESHOLD));
> +		if (secondary_exec_control & (SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |
> +		    			      SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE))
> +			pr_err("APIC-access addr = 0x%016llx ", vmcs_read64(APIC_ACCESS_ADDR));
> +		pr_err(KERN_CONT "virt-APIC addr=0x%016llx\n", vmcs_read64(VIRTUAL_APIC_PAGE_ADDR));
> +	}
>   	if (pin_based_exec_ctrl & PIN_BASED_POSTED_INTR)
>   		pr_err("PostedIntrVec = 0x%02x\n", vmcs_read16(POSTED_INTR_NV));
>   	if ((secondary_exec_control & SECONDARY_EXEC_ENABLE_EPT))

Reviewed-by: Krish Sadhukhan <krish.sadhukhan@oracle.com>
