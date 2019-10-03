Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3241EC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4B7920865
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D0335bC8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391738AbfJCRUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 13:20:55 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:35401 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391402AbfJCRUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 13:20:50 -0400
Received: by mail-io1-f66.google.com with SMTP id q10so7432696iop.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 10:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ROjHpOzRZ1zg7WsRiQrsstI6c6vwOIlKKBBg25nDNqk=;
        b=D0335bC8HZS3gKgpq9/MbcCeRnChpkvTNsagSyEn+nX4Q66b/GjQa+jGa9VLRijhdp
         +4/K9Xg0Y7HYA9njZsMwMHuWibsQjQplH/6OqiU61hWQkDwovpFzOc3vX4RSV+onmoFU
         fuOmeep+KClIz8DgBwxcYEUZAADoyGsGTjAAJrTFOS2aDEfXnY6UeJUBwxB7pYvaKfuA
         ccIQNpadl8Bg6CmlpzaRIKH0JtcRMCYEfpaGnTi1mJEsfEVKeFJsahJ6HOyyiQLEMRYP
         S9sRthmJeuN/dM72n/06mzHCc/HGiDGvfjUK3EoE2KcEr53m4Wkf4JVgVjuxJAguKgqz
         HHDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ROjHpOzRZ1zg7WsRiQrsstI6c6vwOIlKKBBg25nDNqk=;
        b=p5g7BPPbvAYEY8nj/Y0qAt3uu3yesFsJXOe55GbXz8QxtoizoxSfD//wE+MKNDqH//
         E+1mp4C7hL9WIgIEeEbWKypQ41ZwdexFPtHMsUkfgm+1SQVD/QK5BC+d3AWh0iH948vw
         4pZQx2BVMtNfN9vkXlHdQBe6tDx6OWRWYAzz9oNfOotTF9CW+klkXj4e75hqXjpRbGhg
         PWRoDwUhCeYOfx83le/WcZbX5msV9/Raly0aJFZVj9hFwAolsRysTLF5iRTGSJ5xmLwv
         36pWcbM7ny/dtcu/FtairCBCqkeSCb0YW8O5b0JgzzRXaxXg59I0+N6tX5s1KFV9PrqO
         AJOw==
X-Gm-Message-State: APjAAAWZZfwCgT0xdZAO1agI8gOmQW+tGhSXr4IXVRgwGVlrzcyIC4RR
        LfS6pg4wBWj8UYtkpRS3xQR79tN+7Mm2DkoZOZuoaQ==
X-Google-Smtp-Source: APXvYqzL90yczrm6KgnTH/j6j0Ki2GG5BtxT9O9oxONR7BoG3dTFpzTDIl8D91aHq8CRqKKtzfaEeKbF7TDeeU5YvrY=
X-Received: by 2002:a02:ba17:: with SMTP id z23mr10366196jan.24.1570123249112;
 Thu, 03 Oct 2019 10:20:49 -0700 (PDT)
MIME-Version: 1.0
References: <1570097418-42233-1-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1570097418-42233-1-git-send-email-pbonzini@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 3 Oct 2019 10:20:38 -0700
Message-ID: <CALMp9eRFUeSB035VEC61CzAg6PY=aApjyiQoSnRydH788COL4w@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: x86: omit absent pmu MSRs from MSR list
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 3, 2019 at 3:10 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> INTEL_PMC_MAX_GENERIC is currently 32, which exceeds the 18 contiguous
> MSR indices reserved by Intel for event selectors.  Since some machines
> actually have MSRs past the reserved range, these may survive the
Not past, but *within* the reserved range.
> filtering of msrs_to_save array and would be rejected by KVM_GET/SET_MSR.
> To avoid this, cut the list to whatever CPUID reports for the host's
> architectural PMU.
>
> Reported-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> Suggested-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> Cc: Jim Mattson <jmattson@google.com>
> Fixes: e2ada66ec418 ("kvm: x86: Add Intel PMU MSRs to msrs_to_save[]", 2019-08-21)
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/kvm/x86.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 8072acaaf028..31607174f442 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -5105,13 +5105,14 @@ long kvm_arch_vm_ioctl(struct file *filp,
>
>  static void kvm_init_msr_list(void)
>  {
> +       struct x86_pmu_capability x86_pmu;
>         u32 dummy[2];
>         unsigned i, j;
>
>         BUILD_BUG_ON_MSG(INTEL_PMC_MAX_FIXED != 4,
>                          "Please update the fixed PMCs in msrs_to_save[]");
> -       BUILD_BUG_ON_MSG(INTEL_PMC_MAX_GENERIC != 32,
> -                        "Please update the generic perfctr/eventsel MSRs in msrs_to_save[]");
> +
> +       perf_get_x86_pmu_capability(&x86_pmu);
>
>         for (i = j = 0; i < ARRAY_SIZE(msrs_to_save); i++) {
>                 if (rdmsr_safe(msrs_to_save[i], &dummy[0], &dummy[1]) < 0)
> @@ -5153,6 +5154,15 @@ static void kvm_init_msr_list(void)
>                                 intel_pt_validate_hw_cap(PT_CAP_num_address_ranges) * 2)
>                                 continue;
>                         break;
> +               case MSR_ARCH_PERFMON_PERFCTR0 ... MSR_ARCH_PERFMON_PERFCTR0 + 31:
You've truncated the list I originally provided, so I think this need
only go to MSR_ARCH_PERFMON_PERFCTR0 + 17. Otherwise, we could lose
some valuable MSRs.
> +                       if (msrs_to_save[i] - MSR_ARCH_PERFMON_PERFCTR0 >=
> +                           min(INTEL_PMC_MAX_GENERIC, x86_pmu.num_counters_gp))
Why involve INTEL_PMC_MAX_GENERIC here?
> +                               continue;
> +                       break;
> +               case MSR_ARCH_PERFMON_EVENTSEL0 ... MSR_ARCH_PERFMON_EVENTSEL0 + 31:
Same as the two comments above.
> +                       if (msrs_to_save[i] - MSR_ARCH_PERFMON_EVENTSEL0 >=
> +                           min(INTEL_PMC_MAX_GENERIC, x86_pmu.num_counters_gp))
> +                               continue;
>                 }
>                 default:
>                         break;
> --
> 1.8.3.1
>
