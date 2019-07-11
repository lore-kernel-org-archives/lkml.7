Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9203BC74A35
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 13:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65E0A21537
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 13:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbfGKNZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 09:25:17 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37110 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728182AbfGKNZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 09:25:16 -0400
Received: by mail-wr1-f68.google.com with SMTP id n9so6313383wrr.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 06:25:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NiPzgCya2hoSH4eKrxi8qdW5Qk89gH2cnlBBWoaa/xg=;
        b=osrgwGnO4szyykoqbn4E2A6cpNgH45EIW+eW78tBF5fTMm9lU8jdY3Y0p/XiJ3iROM
         rvl8HT88hWGAWH0UlAL0szQuFyrtsHBs51JrBoiYquc65DFMWcbpVsByninNLG/GaeXi
         Iz3r5LY4fHJe56Tp5fzoYL6jP3UA3yaykpRMfeDQubJ+jEVeRbKYH2zC0HNkWOqcFIHD
         nLV8NBGSJxRnJBkGEC6xrj7AzLAMR+2EJ9QCzU0iEhQ32YdAQNd252GS7jidT77F0zrt
         JAxw9DrPJTzRjjK9O/+eOe1Xr26+WiB6qyqphyjsUjox0YLkVxp6Xk+QCcmz3K3UdIut
         P7Bw==
X-Gm-Message-State: APjAAAUyzLZiC+SnrfzJeWw7YpQs/XwWe0Rv9eqc/1dcMeKz1YZTSzPm
        FWTMYrNP3GWkoeOuTe/DTFqbiQ==
X-Google-Smtp-Source: APXvYqxwk8GF3EpHoEhDlHvKnuLbWejXVJYdh2lNTENdeBRa32LLelWUbAycMad3uNrwe2Sr84lu1Q==
X-Received: by 2002:adf:b1cb:: with SMTP id r11mr5074310wra.328.1562851514545;
        Thu, 11 Jul 2019 06:25:14 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d066:6881:ec69:75ab? ([2001:b07:6468:f312:d066:6881:ec69:75ab])
        by smtp.gmail.com with ESMTPSA id t1sm7823335wra.74.2019.07.11.06.25.13
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2019 06:25:13 -0700 (PDT)
Subject: Re: [PATCH v6 2/3] KVM: vmx: Emulate MSR IA32_UMWAIT_CONTROL
To:     Tao Xu <tao3.xu@intel.com>, rkrcmar@redhat.com, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        sean.j.christopherson@intel.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        fenghua.yu@intel.com, xiaoyao.li@linux.intel.com,
        jingqi.liu@intel.com
References: <20190621055747.17060-1-tao3.xu@intel.com>
 <20190621055747.17060-3-tao3.xu@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <43814a5e-12bf-ceb5-e4fb-12bbb32cd4cb@redhat.com>
Date:   Thu, 11 Jul 2019 15:25:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190621055747.17060-3-tao3.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/06/19 07:57, Tao Xu wrote:
> +	if (guest_cpuid_has(vcpu, X86_FEATURE_WAITPKG))
> +		atomic_switch_umwait_control_msr(vmx);
> +

guest_cpuid_has is slow.  Please replace it with a test on
secondary_exec_controls_get(vmx).

Are you going to look into nested virtualization support?  This should
include only 1) allowing setting the enable bit in secondary execution
controls, and passing it through in prepare_vmcs02_early; 2) reflecting
the vmexit in nested_vmx_exit_reflected.

Thanks,

Paolo
