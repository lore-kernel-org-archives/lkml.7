Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C00C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 20:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87DF221783
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 20:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zb7ukMZD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbfJBU6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 16:58:03 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41572 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728900AbfJBU6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 16:58:03 -0400
Received: by mail-io1-f68.google.com with SMTP id n26so510744ioj.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 13:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mxH4ymsGMb4jOpypYiX3Ngcl2ReJUcFD+OtXu9cpO30=;
        b=Zb7ukMZDW3GVvpTCDpYW5lmOKDSHHWjljNPsTm+oq5S0HxsYLJcaqMCDnQlb/twjub
         7QRJWuVWopM4Q9UWBp/G+dGWBByImCUEarWQYpMH2N0GyPAEmeVnmq8M3APWN0rNbIA7
         OqzIA74SRLchR5auxdp0tZeBvOqKbw7sVmrM12w1FkUgv89vQkuUlav91g9qLzIC6wke
         yWmYYPAMJESjpwdfALypK03bjosTQV08LeSXMhcZjj/OTbVIqkLHX7OMiGYlD3WSAZtf
         KvDyqKWeGp8mp2N4uOh83Bzh9CvjP7MqUWC1Vf57Mclaly/Dycb4aqy8ptYzjvIqJ4zc
         mRqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mxH4ymsGMb4jOpypYiX3Ngcl2ReJUcFD+OtXu9cpO30=;
        b=oZZsvkKtf/C7jUPOJSGOqEYZ8CC0JOmFCUD0C7QXSor3I0Zusvq8vMGSuf8DwTkk+f
         YxqN/+Q1NvgaHJVkwbWGOKQQKi3afg2XPRCeELDx4Xd9+Tym+W9DJjC5Wa8qUWGHpXDW
         ykld50SiETOvRuvHao1mWVVsgKc20Z/pTr3EWzCpz2LZ4xqk4f6Bs7Ox8mSxkPWwM/Ta
         TLK2u7uVjU9HDqWE27xKfS0wDY1jcZb92seZd8ZZvmXxsVeL0q6tXerT8bThhfbKGPqf
         6Ao9Zd++GZxNBfDI8Qy3SFlLT4bpFZIOxH2cZCtRFeiBbhTdg3QSsk/0RG6jqnV2Li9m
         JluQ==
X-Gm-Message-State: APjAAAVxlXeaUHeYrFuCTeMigyFmCoD/1hAMgeKwAGUkDrFNDkhUXhtZ
        6tPUHiy/wLUP3bqsNJCXf2UCstasz16faWOiIXa0Jg==
X-Google-Smtp-Source: APXvYqxTRTIwYH44WcXiALssV8QMLilhWTytjwXm9GXdcjbXaUQbGPn9KB0oaZ6gd6fOKVTGVQL0SLlZStUSjNvsn4s=
X-Received: by 2002:a6b:9085:: with SMTP id s127mr5338252iod.26.1570049882086;
 Wed, 02 Oct 2019 13:58:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190927021927.23057-1-weijiang.yang@intel.com> <20190927021927.23057-8-weijiang.yang@intel.com>
In-Reply-To: <20190927021927.23057-8-weijiang.yang@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 2 Oct 2019 13:57:50 -0700
Message-ID: <CALMp9eQNDNmmCr8DM-2fMVYvQ-eTEpeE=bW8+BLbfxmBsTmQvg@mail.gmail.com>
Subject: Re: [PATCH v7 7/7] KVM: x86: Add user-space access interface for CET MSRs
To:     Yang Weijiang <weijiang.yang@intel.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 7:17 PM Yang Weijiang <weijiang.yang@intel.com> wrote:
>
> There're two different places storing Guest CET states, the states
> managed with XSAVES/XRSTORS, as restored/saved
> in previous patch, can be read/write directly from/to the MSRs.
> For those stored in VMCS fields, they're access via vmcs_read/
> vmcs_write.
>
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 83 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 83 insertions(+)
>
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 44913e4ab558..5265db7cd2af 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -1671,6 +1671,49 @@ static int vmx_get_msr_feature(struct kvm_msr_entry *msr)
>         return 0;
>  }
>
> +static int check_cet_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)

I'd suggest changing return type to bool, since you are essentially
returning true or false.

> +{
> +       u64 kvm_xss = kvm_supported_xss();
> +
> +       switch (msr_info->index) {
> +       case MSR_IA32_PL0_SSP ... MSR_IA32_PL2_SSP:
> +               if (!(kvm_xss | XFEATURE_MASK_CET_KERNEL))
'|' should be '&'
> +                       return 1;
> +               if (!msr_info->host_initiated &&
> +                   !guest_cpuid_has(vcpu, X86_FEATURE_SHSTK))
> +                       return 1;
> +               break;
> +       case MSR_IA32_PL3_SSP:
> +               if (!(kvm_xss | XFEATURE_MASK_CET_USER))
'|' should be '&'
> +                       return 1;
> +               if (!msr_info->host_initiated &&
> +                   !guest_cpuid_has(vcpu, X86_FEATURE_SHSTK))
> +                       return 1;
> +               break;
> +       case MSR_IA32_U_CET:
> +               if (!(kvm_xss | XFEATURE_MASK_CET_USER))
'|' should be '&'
> +                       return 1;
> +               if (!msr_info->host_initiated &&
> +                   !guest_cpuid_has(vcpu, X86_FEATURE_SHSTK) &&
> +                   !guest_cpuid_has(vcpu, X86_FEATURE_IBT))
> +                       return 1;
> +               break;
> +       case MSR_IA32_S_CET:
> +               if (!msr_info->host_initiated &&
> +                   !guest_cpuid_has(vcpu, X86_FEATURE_SHSTK) &&
> +                   !guest_cpuid_has(vcpu, X86_FEATURE_IBT))
> +                       return 1;
> +               break;
> +       case MSR_IA32_INT_SSP_TAB:
> +               if (!msr_info->host_initiated &&
> +                   !guest_cpuid_has(vcpu, X86_FEATURE_SHSTK))
> +                       return 1;
> +               break;
> +       default:
> +               return 1;
> +       }
> +       return 0;
> +}
>  /*
>   * Reads an msr value (of 'msr_index') into 'pdata'.
>   * Returns 0 on success, non-0 otherwise.
> @@ -1788,6 +1831,26 @@ static int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>                 else
>                         msr_info->data = vmx->pt_desc.guest.addr_a[index / 2];
>                 break;
> +       case MSR_IA32_S_CET:
> +               if (check_cet_msr(vcpu, msr_info))
> +                       return 1;
> +               msr_info->data = vmcs_readl(GUEST_S_CET);
Have we ensured that this VMCS field exists?
> +               break;
> +       case MSR_IA32_INT_SSP_TAB:
> +               if (check_cet_msr(vcpu, msr_info))
> +                       return 1;
> +               msr_info->data = vmcs_readl(GUEST_INTR_SSP_TABLE);
Have we ensured that this VMCS field exists?
> +               break;
> +       case MSR_IA32_U_CET:
Can this be lumped together with MSR_IA32_PL0_SSP ... MSR_IA32_PL3_SSP, below?
> +               if (check_cet_msr(vcpu, msr_info))
> +                       return 1;
> +               rdmsrl(MSR_IA32_U_CET, msr_info->data);
> +               break;
> +       case MSR_IA32_PL0_SSP ... MSR_IA32_PL3_SSP:
> +               if (check_cet_msr(vcpu, msr_info))
> +                       return 1;
> +               rdmsrl(msr_info->index, msr_info->data);
> +               break;
>         case MSR_TSC_AUX:
>                 if (!msr_info->host_initiated &&
>                     !guest_cpuid_has(vcpu, X86_FEATURE_RDTSCP))
> @@ -2039,6 +2102,26 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>                 else
>                         vmx->pt_desc.guest.addr_a[index / 2] = data;
>                 break;
> +       case MSR_IA32_S_CET:
> +               if (check_cet_msr(vcpu, msr_info))
> +                       return 1;
Bits 9:6 must be zero.
> +               vmcs_writel(GUEST_S_CET, data);
Have we ensured that this VMCS field exists?
> +               break;
> +       case MSR_IA32_INT_SSP_TAB:
> +               if (check_cet_msr(vcpu, msr_info))
> +                       return 1;
Must be canonical. vCPU must support longmode.
> +               vmcs_writel(GUEST_INTR_SSP_TABLE, data);
Have we ensured that this VMCS field exists?
> +               break;
> +       case MSR_IA32_U_CET:
> +               if (check_cet_msr(vcpu, msr_info))
> +                       return 1;
Bits 9:6 must be zero.
> +               wrmsrl(MSR_IA32_U_CET, data);
> +               break;
> +       case MSR_IA32_PL0_SSP ... MSR_IA32_PL3_SSP:
> +               if (check_cet_msr(vcpu, msr_info))
> +                       return 1;
'Data' must be canonical and 4-byte aligned. High dword must be zero
on vCPUs that don't support longmode.
> +               wrmsrl(msr_info->index, data);
> +               break;
>         case MSR_TSC_AUX:
>                 if (!msr_info->host_initiated &&
>                     !guest_cpuid_has(vcpu, X86_FEATURE_RDTSCP))
> --
> 2.17.2
>
