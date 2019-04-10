Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B22C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 23:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35A0020645
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 23:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mVDbyWMn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfDJXgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 19:36:42 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:55520 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfDJXgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 19:36:42 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3ANYKFo155407;
        Wed, 10 Apr 2019 23:36:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=5CeB9sCERxbeedFWprX4rtcGmvvmLuMTxuYgkfpqdwI=;
 b=mVDbyWMnUCaqdq0NFbV5Nl4mSY+cfJcgES7RbdmW/Jtw7WzEw1A1bldoW790X+ONJzvx
 S2yn9TgYqxFaVcgLh5dFEwHqiyANsKKtdHSRvBknX5TfYJkn+f2Jew7BsghCbPVftCnK
 Vk2grgZ9D37XkhbeuWSHJetl0jhWsuhnDR6IAn0MynCzViPKGTruHEMp2C1CvCqfV4wh
 N45R9oV2+69/4nzkaxWOuveiwT4wOZPMWwW+VjRL6Wi+qlm0xMryMT/z1BDN1VxsiheV
 c+2QELnPSffs7xbHxDMB1z+HlgA9d10RqBUIlhLzeECEeKASLImLh+913oJl+nUI33lB cw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2rpkht5x7y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Apr 2019 23:36:39 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3ANZkDi001405;
        Wed, 10 Apr 2019 23:36:38 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2rpytcgs9f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Apr 2019 23:36:38 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x3ANabTw019741;
        Wed, 10 Apr 2019 23:36:37 GMT
Received: from dhcp-10-132-91-102.usdhcp.oraclecorp.com (/10.132.91.102)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 10 Apr 2019 16:36:37 -0700
Subject: Re: [PATCH] KVM: x86: optimize check for valid PAT value
To:     Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
References: <1554890126-347-1-git-send-email-pbonzini@redhat.com>
From:   Krish Sadhukhan <krish.sadhukhan@oracle.com>
Message-ID: <b4d714a8-3ca5-8ec7-afe0-b7f8f324c39e@oracle.com>
Date:   Wed, 10 Apr 2019 16:36:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <1554890126-347-1-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9223 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904100154
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9223 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904100154
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/10/2019 02:55 AM, Paolo Bonzini wrote:
> This check will soon be done on every nested vmentry and vmexit,
> "parallelize" it using bitwise operations.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   arch/x86/kvm/mtrr.c    | 10 +---------
>   arch/x86/kvm/vmx/vmx.c |  2 +-
>   arch/x86/kvm/x86.h     |  8 ++++++++
>   3 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/arch/x86/kvm/mtrr.c b/arch/x86/kvm/mtrr.c
> index e9ea2d45ae66..9f72cc427158 100644
> --- a/arch/x86/kvm/mtrr.c
> +++ b/arch/x86/kvm/mtrr.c
> @@ -48,11 +48,6 @@ static bool msr_mtrr_valid(unsigned msr)
>   	return false;
>   }
>   
> -static bool valid_pat_type(unsigned t)
> -{
> -	return t < 8 && (1 << t) & 0xf3; /* 0, 1, 4, 5, 6, 7 */
> -}
> -
>   static bool valid_mtrr_type(unsigned t)
>   {
>   	return t < 8 && (1 << t) & 0x73; /* 0, 1, 4, 5, 6 */
> @@ -67,10 +62,7 @@ bool kvm_mtrr_valid(struct kvm_vcpu *vcpu, u32 msr, u64 data)
>   		return false;
>   
>   	if (msr == MSR_IA32_CR_PAT) {
> -		for (i = 0; i < 8; i++)
> -			if (!valid_pat_type((data >> (i * 8)) & 0xff))
> -				return false;
> -		return true;
> +		return kvm_pat_valid(data);
>   	} else if (msr == MSR_MTRRdefType) {
>   		if (data & ~0xcff)
>   			return false;
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index b6c533afbf27..b74679732cfc 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -1891,7 +1891,7 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>   		break;
>   	case MSR_IA32_CR_PAT:
>   		if (vmcs_config.vmentry_ctrl & VM_ENTRY_LOAD_IA32_PAT) {
> -			if (!kvm_mtrr_valid(vcpu, MSR_IA32_CR_PAT, data))
> +			if (!kvm_pat_valid(data))
>   				return 1;
>   			vmcs_write64(GUEST_IA32_PAT, data);
>   			vcpu->arch.pat = data;
> diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
> index 28406aa1136d..7bc7ac9d2a44 100644
> --- a/arch/x86/kvm/x86.h
> +++ b/arch/x86/kvm/x86.h
> @@ -347,4 +347,12 @@ static inline void kvm_after_interrupt(struct kvm_vcpu *vcpu)
>   	__this_cpu_write(current_vcpu, NULL);
>   }
>   
> +static inline bool kvm_pat_valid(u64 data)
> +{
> +	if (data & 0xF8F8F8F8F8F8F8F8)
> +		return false;
> +	/* 0, 1, 4, 5, 6, 7 are valid values.  */
> +	return (data | ((data & 0x0202020202020202) << 1)) == data;
> +}
> +
>   #endif

Reviewed-by: Krish Sadhukhan <krish.sadhukhan@oracle.com>
