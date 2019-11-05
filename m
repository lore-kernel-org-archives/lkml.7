Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BA6C010A3
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 11:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E70C21A4A
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 11:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388331AbfKELaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 06:30:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42298 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730751AbfKELaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 06:30:18 -0500
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 68CD585542
        for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2019 11:30:18 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id j17so11985815wru.13
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 03:30:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OYzljXIn0bNqVrJvPkbOnHR/bI3RA4WdbslOnh+bwC8=;
        b=LSx3WzzD6LUebK6MM2CvovifMWA+m9QWw+IcVHdOIE08BNHnKLdRbDCq83Qp96pbJ3
         Ox3Ys8873qpRCBE5xK3TK19lZL5TJrlXC762H4EU2yhguBxJVLPlBwLKEK8rHS5xhAFx
         i3hc5dwHvDb/uIPxq/sQHyIiOXRMDlEFhpQaVb7xmkx2gnqdj6A56S5+5GFmqJfFXKCu
         DUEGppIZUDyfRFM3Etx4Ey66wyUBQyn5zDNibyIMJFM6jQ9S9iVxFFVmYKRN3yviDhvb
         Yx9p8KhqjyO9RV0+FsxcyREVBLj1VvMIg8etri8NP72p8Bw69higJj/8FKfDVbWCpW1w
         Wiqg==
X-Gm-Message-State: APjAAAU5LRfuylV+6foBadahE3jSWBCtx8LIGAsmq1Rc2md7CdplyaIi
        l48mVNJK+a7FPx8XoSmqDbkm9RrBtgLzucDu4emX6WtLgbpnVqc8HEzxjm2Tdvw+3YuPe3j+nLL
        RGWltbZ9Y2uloLSNKO6+NVWpY
X-Received: by 2002:adf:efcb:: with SMTP id i11mr968869wrp.229.1572953416940;
        Tue, 05 Nov 2019 03:30:16 -0800 (PST)
X-Google-Smtp-Source: APXvYqz+YJdtJw3LbD35YXURNtOgP0zFqk5JLPiYksJ+sKP7qxpdrhSOxXZjL584rEpnZMKWFHMyMg==
X-Received: by 2002:adf:efcb:: with SMTP id i11mr968849wrp.229.1572953416587;
        Tue, 05 Nov 2019 03:30:16 -0800 (PST)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id g133sm647720wme.42.2019.11.05.03.30.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2019 03:30:15 -0800 (PST)
Subject: Re: [PATCH] KVM: X86: Dynamically allocating MSR number
 lists(msrs_to_save[], emulated_msrs[], msr_based_features[])
To:     Chenyi Qiang <chenyi.qiang@intel.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Xiaoyao Li <xiaoyao.li@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20191105092031.8064-1-chenyi.qiang@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4a5fd5b4-64b7-726a-57a5-a5c669ce84f6@redhat.com>
Date:   Tue, 5 Nov 2019 12:30:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191105092031.8064-1-chenyi.qiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/11/19 10:20, Chenyi Qiang wrote:
> The three msr number lists(msrs_to_save[], emulated_msrs[] and
> msr_based_features[]) are global arrays of kvm.ko, which are
> initialized/adjusted (copy supported MSRs forward to override the
> unsupported MSRs) when installing kvm-{intel,amd}.ko, but it doesn't
> reset these three arrays to their initial value when uninstalling
> kvm-{intel,amd}.ko. Thus, at the next installation, kvm-{intel,amd}.ko
> will initialize the modified arrays with some MSRs lost and some MSRs
> duplicated.
> 
> So allocate and initialize these three MSR number lists dynamically when
> installing kvm-{intel,amd}.ko and free them when uninstalling.
> 
> Cc: stable@vger.kernel.org
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
> ---
>  arch/x86/kvm/x86.c | 86 ++++++++++++++++++++++++++++++----------------
>  1 file changed, 57 insertions(+), 29 deletions(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index ff395f812719..08efcf6351cc 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -1132,13 +1132,15 @@ EXPORT_SYMBOL_GPL(kvm_rdpmc);
>   * List of msr numbers which we expose to userspace through KVM_GET_MSRS
>   * and KVM_SET_MSRS, and KVM_GET_MSR_INDEX_LIST.
>   *
> - * This list is modified at module load time to reflect the
> + * The three msr number lists(msrs_to_save, emulated_msrs, msr_based_features)
> + * are allocated and initialized at module load time and freed at unload time.
> + * msrs_to_save is selected from the msrs_to_save_all to reflect the
>   * capabilities of the host cpu. This capabilities test skips MSRs that are
> - * kvm-specific. Those are put in emulated_msrs; filtering of emulated_msrs
> + * kvm-specific. Those are put in emulated_msrs_all; filtering of emulated_msrs
>   * may depend on host virtualization features rather than host cpu features.
>   */
>  
> -static u32 msrs_to_save[] = {
> +const u32 msrs_to_save_all[] = {

This can remain static.

>  	MSR_IA32_SYSENTER_CS, MSR_IA32_SYSENTER_ESP, MSR_IA32_SYSENTER_EIP,
>  	MSR_STAR,
>  #ifdef CONFIG_X86_64
> @@ -1179,9 +1181,10 @@ static u32 msrs_to_save[] = {
>  	MSR_ARCH_PERFMON_EVENTSEL0 + 16, MSR_ARCH_PERFMON_EVENTSEL0 + 17,
>  };
>  
> +static u32 *msrs_to_save;

You can use ARRAY_SIZE to allocate the destination arrays statically.

Paolo
