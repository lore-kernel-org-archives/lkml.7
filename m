Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBEB8ECE58F
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 08:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAB4D2064B
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 08:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbfJOI2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 04:28:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52068 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728847AbfJOI2l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 04:28:41 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3328E4E4E6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 08:28:41 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id s19so5162587wmj.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 01:28:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Pb5c9lwLTcI2EdDTvk1a+i+Hv8sTLnOmEVzrLcGSMOs=;
        b=NdAmS8Vb6C9+I7NBqfEB/twXDTN0Ye/voTRRFXMyBOkeBHLB20WvyLHn00L7dyMqF0
         /ZqjMhfWL5fM1djqffyCfa9akWn8KhYSj54rsPLkNAHlKwcY6L7mE1poOalLxx+y1QV8
         HCD2EBf699k8RhH65bx+R+388jgqWFBIORluD6lnwRBQIRAnYLKktUzgKkEZ2hoIRbMr
         GdtP0udoe0y+5AeaOiB/ijNO5a4KSL3rzDdQKrOsOpx8CbzSJguJSfHf6KhhmvPdwr3m
         VQ6+ob37TA/mHttejvFeKKbA6qGS7HBjscauupaYo43yiiZC9zBibianO8DK4LhySzMG
         KXMQ==
X-Gm-Message-State: APjAAAW6LyOS9HR8Tnedvh/Ch0XdB6w09+8NJpjoMokUN0vbf2LzGyd+
        pt2Xzn5mxDI/AyV8XkQ1WzoMfjI+dSRyvnf+KCqZxQim8VcJxrPtKd9k/SUrOoIeOIcT40I6sCy
        NaK+qHHrHIUucjU37PVwZVxGc
X-Received: by 2002:adf:f64f:: with SMTP id x15mr8751668wrp.381.1571128119764;
        Tue, 15 Oct 2019 01:28:39 -0700 (PDT)
X-Google-Smtp-Source: APXvYqydeaTS8NVPSDeM3SIMjYGP5LXxc6Bs4/otlg35Zr761dlYB9jclfIYgdQG3CIX1gNG955ISQ==
X-Received: by 2002:adf:f64f:: with SMTP id x15mr8751651wrp.381.1571128119461;
        Tue, 15 Oct 2019 01:28:39 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d001:591b:c73b:6c41? ([2001:b07:6468:f312:d001:591b:c73b:6c41])
        by smtp.gmail.com with ESMTPSA id o22sm49779359wra.96.2019.10.15.01.28.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2019 01:28:38 -0700 (PDT)
Subject: Re: [PATCH 12/14] KVM: retpolines: x86: eliminate retpoline from
 vmx.c exit handlers
To:     Andrea Arcangeli <aarcange@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
References: <20190928172323.14663-1-aarcange@redhat.com>
 <20190928172323.14663-13-aarcange@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <933ca564-973d-645e-fe9c-9afb64edba5b@redhat.com>
Date:   Tue, 15 Oct 2019 10:28:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190928172323.14663-13-aarcange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/09/19 19:23, Andrea Arcangeli wrote:
> Reducing this list to only EXIT_REASON_MSR_WRITE,
> EXIT_REASON_PREEMPTION_TIMER, EXIT_REASON_EPT_MISCONFIG,
> EXIT_REASON_IO_INSTRUCTION increases the computation time of the
> hrtimer guest testcase on Haswell i5-4670T CPU @ 2.30GHz by 7% with
> the default spectre v2 mitigation enabled in the host and guest. On
> skylake as opposed there's no measurable difference with the short
> list. To put things in prospective on Haswell the same hrtimer
> workload (note: it never calls cpuid and it never attempts to trigger
> more vmexit on purpose) in guest takes 16.3% longer to compute on
> upstream KVM running in the host than with the KVM mono v1 patchset
> applied to the host kernel, while on skylake the same takes only 5.4%
> more time (both with the default mitigations enabled in guest and
> host).
> 
> It's also unclear why EXIT_REASON_IO_INSTRUCTION should be included.

If you're including EXIT_REASON_EPT_MISCONFIG (MMIO access) then you
should include EXIT_REASON_IO_INSTRUCTION too.  Depending on the devices
that are in the guest, the doorbell register might be MMIO or PIO.

> +		if (exit_reason == EXIT_REASON_MSR_WRITE)
> +			return kvm_emulate_wrmsr(vcpu);
> +		else if (exit_reason == EXIT_REASON_PREEMPTION_TIMER)
> +			return handle_preemption_timer(vcpu);
> +		else if (exit_reason == EXIT_REASON_PENDING_INTERRUPT)
> +			return handle_interrupt_window(vcpu);
> +		else if (exit_reason == EXIT_REASON_EXTERNAL_INTERRUPT)
> +			return handle_external_interrupt(vcpu);
> +		else if (exit_reason == EXIT_REASON_HLT)
> +			return kvm_emulate_halt(vcpu);
> +		else if (exit_reason == EXIT_REASON_PAUSE_INSTRUCTION)
> +			return handle_pause(vcpu);
> +		else if (exit_reason == EXIT_REASON_MSR_READ)
> +			return kvm_emulate_rdmsr(vcpu);
> +		else if (exit_reason == EXIT_REASON_CPUID)
> +			return kvm_emulate_cpuid(vcpu);
> +		else if (exit_reason == EXIT_REASON_EPT_MISCONFIG)
> +			return handle_ept_misconfig(vcpu);

So, the difference between my suggested list (which I admit is just
based on conjecture, not benchmarking) is that you add
EXIT_REASON_PAUSE_INSTRUCTION, EXIT_REASON_PENDING_INTERRUPT,
EXIT_REASON_EXTERNAL_INTERRUPT, EXIT_REASON_HLT, EXIT_REASON_MSR_READ,
EXIT_REASON_CPUID.

Which of these make a difference for the hrtimer testcase?  It's of
course totally fine to use benchmarks to prove that my intuition was
bad---but you must also use them to show why your intuition is right. :)

Paolo
