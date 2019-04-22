Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7180C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 15:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B745A2077C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 15:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nVwzGb9U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfDVPx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 11:53:59 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:53752 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbfDVPx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 11:53:59 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3MFhvFZ042577;
        Mon, 22 Apr 2019 15:53:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=p6QQHopwwRKosDP8LgXQQJFuBnjWTvmMyvM3QBAwZPs=;
 b=nVwzGb9UmyBgLZDHQqi3rPJ23CxEoryF1f8o39v2FRVYKH8i/lwhqUZiwJ1PtDhhj7ub
 Eooi4WvCj7SOatNLxVBP2Awq2TvG8Wt0ayk6KeBvbY847PF++lNId9Cy+GCcHeObCC7W
 Kmqu55EGmFw1StvhPdkU8cXaoVu+ZnNckd+ICnlqeO9JPjELISO9c4rG97hhdBRSSzWq
 Xo+LH1KW8r3UuFbM8Ub+tU8Xe7ITtXVtheWpl0uaz8NddrWP0yTohC9hxq9EWPsv9ILD
 DV31tzY1UdK4XzjktdnWt4WjP3zDW9DSTPZtqYkTZbEonMmYYyEG242hYrqdTAm+tbLH eA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2rytusq1qn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Apr 2019 15:53:34 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3MFqLkI007803;
        Mon, 22 Apr 2019 15:53:33 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2s0f0v0qcj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Apr 2019 15:53:33 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3MFrVJx003002;
        Mon, 22 Apr 2019 15:53:31 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 22 Apr 2019 08:53:31 -0700
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id C19976A00F4; Mon, 22 Apr 2019 11:53:33 -0400 (EDT)
Date:   Mon, 22 Apr 2019 11:53:33 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Like Xu <like.xu@linux.intel.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: x86: Add Intel CPUID.1F cpuid emulation support
Message-ID: <20190422155333.GB32647@char.us.oracle.com>
References: <1555915234-2536-1-git-send-email-like.xu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555915234-2536-1-git-send-email-like.xu@linux.intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9235 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904220119
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9235 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904220119
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 02:40:34PM +0800, Like Xu wrote:
> Expose Intel V2 Extended Topology Enumeration Leaf to guest only when
> host system has multiple software-visible die within each package.

Is there some doc on this?

The https://software.intel.com/en-us/articles/intel-64-architecture-processor-topology-enumeration
has a date of 2012.


> 
> Signed-off-by: Like Xu <like.xu@linux.intel.com>
> ---
>  arch/x86/kvm/cpuid.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index fd39516..9fc14f2 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -65,6 +65,16 @@ u64 kvm_supported_xcr0(void)
>  	return xcr0;
>  }
>  
> +/* We need to check if the host cpu has multi-chip packaging technology. */
> +static bool kvm_supported_intel_mcp(void)
> +{
> +	u32 eax, ignored;
> +
> +	cpuid_count(0x1f, 0, &eax, &ignored, &ignored, &ignored);
> +
> +	return boot_cpu_data.x86_vendor == X86_VENDOR_INTEL && (eax != 0);
> +}
> +
>  #define F(x) bit(X86_FEATURE_##x)
>  
>  int kvm_update_cpuid(struct kvm_vcpu *vcpu)
> @@ -426,6 +436,7 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
>  	switch (function) {
>  	case 0:
>  		entry->eax = min(entry->eax, (u32)(f_intel_pt ? 0x14 : 0xd));
> +		entry->eax = kvm_supported_intel_mcp() ? 0x1f : entry->eax;
>  		break;
>  	case 1:
>  		entry->edx &= kvm_cpuid_1_edx_x86_features;
> @@ -544,6 +555,8 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
>  		entry->edx = edx.full;
>  		break;
>  	}
> +	/* function 0x1f has additional index. */
> +	case 0x1f:
>  	/* function 0xb has additional index. */
>  	case 0xb: {
>  		int i, level_type;
> -- 
> 1.8.3.1
> 
