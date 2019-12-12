Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF93C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 09:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 108C1214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 09:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dMt3lmj0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbfLLJU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 04:20:56 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46913 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726786AbfLLJUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 04:20:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576142453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c1G9apC9II0161yXPFzDEH3wx0KxsMSJnaDldD2g76U=;
        b=dMt3lmj04b7cEFDPEoA04q+MRENKRBCeZEpFLB7uHXYltrjo58K9lSahvG9zCxCnZNo52K
        B7fV0fvDKS5nzD1PezIkI/UmMKgsbN8OTa/ZTXhWc2Vy/9eP5Spe0bp78zHGxm6RyyMa5e
        6EZ+zXHmJX5dhE0jPvxhiEMFhUsj8eM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-YMq8VnenN-CIMf_FXY2iHA-1; Thu, 12 Dec 2019 04:20:52 -0500
X-MC-Unique: YMq8VnenN-CIMf_FXY2iHA-1
Received: by mail-wm1-f72.google.com with SMTP id o24so388226wmh.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 01:20:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=c1G9apC9II0161yXPFzDEH3wx0KxsMSJnaDldD2g76U=;
        b=aWbzjgXW6aR1Zx3SP9pBgrWYNqBt3aXxIx/6kgO73lhGDWvrqY6e3QCzvUjnnwt9A/
         Bin9tPe16Ofz2sE2JZLgeS8PYTjShINDG0+kIvBkq0sF4XFUdgmzW9xJqCEaeigs2jxR
         oXUrnspIJCHIgfmcXGWgUGdGciajwS/hzUVGyib+rPLb/fGtduQWiDS1RrnB3IQVUmTX
         5IcotQRh+6aqNSzUGU9tYoUSgnHS91brm6FrXNQrgWnsnX4DpoPxQwanqAFZCj03gqFG
         iMRa/2qgvaML36p27iUqhLcAm1TPrvyi7s6/umQkh5I6tQBeXyQowSnJNQHfyPPmrO/1
         Kz0w==
X-Gm-Message-State: APjAAAVB+kjaprKoVjaWH00b5PaVwzqcoH3U79WgQxnk6eSO4hnSXuyr
        /i/nC/pdOu9XPFPA7zsjEubAT1KTSXd93CtlM5Ov/WOe29hKIqZhRU/xvaDwCNP7InW/G5WAK0b
        47io9Z0387B01kVfxMvAQ4u5m
X-Received: by 2002:a7b:c450:: with SMTP id l16mr5375161wmi.31.1576142451446;
        Thu, 12 Dec 2019 01:20:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqzt6ESc3tpdS7ka1TyUc68OXq/63koGWEkD7s+pabgFOqIR52EHIlGmtMmuPt9Dg3JuZhn+JA==
X-Received: by 2002:a7b:c450:: with SMTP id l16mr5375132wmi.31.1576142451251;
        Thu, 12 Dec 2019 01:20:51 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id t1sm5594411wma.43.2019.12.12.01.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 01:20:50 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     linmiaohe <linmiaohe@huawei.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com,
        sean.j.christopherson@intel.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Subject: Re: [PATCH v2 4/4] KVM: hyperv: Fix some typos in vcpu unimpl info
In-Reply-To: <1576138718-32728-5-git-send-email-linmiaohe@huawei.com>
References: <1576138718-32728-1-git-send-email-linmiaohe@huawei.com> <1576138718-32728-5-git-send-email-linmiaohe@huawei.com>
Date:   Thu, 12 Dec 2019 10:20:51 +0100
Message-ID: <87h825c32k.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

linmiaohe <linmiaohe@huawei.com> writes:

> From: Miaohe Lin <linmiaohe@huawei.com>
>
> Fix some typos in vcpu unimpl info and a writing error in the comment.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  arch/x86/kvm/hyperv.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index c7d4640b7b1c..b255b9e865e5 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -1059,7 +1059,7 @@ static int kvm_hv_set_msr_pw(struct kvm_vcpu *vcpu, u32 msr, u64 data,
>  			return 1;
>  		break;
>  	default:
> -		vcpu_unimpl(vcpu, "Hyper-V uhandled wrmsr: 0x%x data 0x%llx\n",
> +		vcpu_unimpl(vcpu, "Hyper-V unhandled wrmsr: 0x%x data 0x%llx\n",
>  			    msr, data);
>  		return 1;
>  	}
> @@ -1122,7 +1122,7 @@ static int kvm_hv_set_msr(struct kvm_vcpu *vcpu, u32 msr, u64 data, bool host)
>  			return 1;
>  
>  		/*
> -		 * Clear apic_assist portion of f(struct hv_vp_assist_page
> +		 * Clear apic_assist portion of struct hv_vp_assist_page
>  		 * only, there can be valuable data in the rest which needs
>  		 * to be preserved e.g. on migration.
>  		 */
> @@ -1179,7 +1179,7 @@ static int kvm_hv_set_msr(struct kvm_vcpu *vcpu, u32 msr, u64 data, bool host)
>  			return 1;
>  		break;
>  	default:
> -		vcpu_unimpl(vcpu, "Hyper-V uhandled wrmsr: 0x%x data 0x%llx\n",
> +		vcpu_unimpl(vcpu, "Hyper-V unhandled wrmsr: 0x%x data 0x%llx\n",
>  			    msr, data);
>  		return 1;
>  	}

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Thanks!

-- 
Vitaly

