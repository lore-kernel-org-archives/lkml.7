Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9722CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 10:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 803BF2075A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 10:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X22GlBz5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731879AbfJVKrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 06:47:19 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55958 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730197AbfJVKrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 06:47:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571741237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:openpgp;
        bh=HTbnzNCtOppqAIupH8V/pMGxUXq85ReOJIxDUGQeUjo=;
        b=X22GlBz5gtdVsEusPh2/kOJ0p9r1ASwivX85MZcfv8UcxrGrK10cqQtpH44gSvMLdHejxY
        OCYve7BJvjse2nGgxAAmtc2RbI5yeN0cGqTWgOTzJU6cXGZVnVNiTp6F8SmBYwXwj4/AI6
        e526LAt2QxfYvO/XaWk4nDyAvXmuSOI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-3yueXF6FMNK-bhwy1_p3Mg-1; Tue, 22 Oct 2019 06:47:13 -0400
Received: by mail-wr1-f69.google.com with SMTP id x9so2604194wrq.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 03:47:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8zCq6QLAMRjL/CHEEMgWUvZyUh8kWvlSdVdD6Q6SWo0=;
        b=gFRSnwg+41cTlf+yYSToGyB7LnL8MbrVPuEIM/nIrZ+z8/Yn6/jQWoPpX7fM0gLZsS
         jC+lcQACiblHa4xtPVPidJwk8ZJorytjUMBQzkJ1lBvKL6KJpPCZ1j/4Xl2FCdLLTk0F
         xMmNdZSg/5C3KQT4Sk5T1NEEYEZt2gmPenLYUUpQ9LBHGbXT6yHboaUKJF3oS/J33p71
         Lkdwsm3UAAL/t9aG4tdK3dtuMZSNmmCqLNFxPvb4ExeHFfI4lJhFRBaIQx4hyVWII7Y0
         YrtGEJO3d5kYAc8j5bjbi7bvjgPVh5RhsoB9VJDWeG14NFqpTiaf4aiysBbUxowXyJxi
         //9w==
X-Gm-Message-State: APjAAAUY3zB1qgjmJnxOYz73ebe7dS6935YtnA1bhBulTamDQSSHfQOc
        nXT7Ww/e21Y56qbR6Xe4EZfB5/RX45NjEtUmyCLRpoD5kj+D5ng84i1olLIYutPWVkZASCE9mj9
        m7lviU8kSktRWpT3ve/8r0Vma
X-Received: by 2002:a05:600c:22d7:: with SMTP id 23mr2363978wmg.31.1571741232405;
        Tue, 22 Oct 2019 03:47:12 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxmt/TPxoHGsfz2ZLkS3GfXvsQS9YJWhWM+xuxarVHcPZp4Pw3oXisS5P3+nqsdpibJx7RdwA==
X-Received: by 2002:a05:600c:22d7:: with SMTP id 23mr2363951wmg.31.1571741232110;
        Tue, 22 Oct 2019 03:47:12 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:45c:4f58:5841:71b2? ([2001:b07:6468:f312:45c:4f58:5841:71b2])
        by smtp.gmail.com with ESMTPSA id u1sm16024041wmc.38.2019.10.22.03.47.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2019 03:47:11 -0700 (PDT)
Subject: Re: [PATCH v3 6/6] KVM: x86/vPMU: Add lazy mechanism to release
 perf_event per vPMC
To:     Like Xu <like.xu@linux.intel.com>, peterz@infradead.org,
        kvm@vger.kernel.org
Cc:     like.xu@intel.com, linux-kernel@vger.kernel.org,
        jmattson@google.com, sean.j.christopherson@intel.com,
        wei.w.wang@intel.com, kan.liang@intel.com
References: <20191021160651.49508-1-like.xu@linux.intel.com>
 <20191021160651.49508-7-like.xu@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <c17a9d77-2c30-b3c0-4652-57f0b9252f3b@redhat.com>
Date:   Tue, 22 Oct 2019 12:47:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191021160651.49508-7-like.xu@linux.intel.com>
Content-Language: en-US
X-MC-Unique: 3yueXF6FMNK-bhwy1_p3Mg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/19 18:06, Like Xu wrote:
> =20
> +=09=09__set_bit(INTEL_PMC_IDX_FIXED + i, pmu->pmc_in_use);
>  =09=09reprogram_fixed_counter(pmc, new_ctrl, i);
>  =09}
> =20
> @@ -329,6 +330,11 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>  =09    (boot_cpu_has(X86_FEATURE_HLE) || boot_cpu_has(X86_FEATURE_RTM)) =
&&
>  =09    (entry->ebx & (X86_FEATURE_HLE|X86_FEATURE_RTM)))
>  =09=09pmu->reserved_bits ^=3D HSW_IN_TX|HSW_IN_TX_CHECKPOINTED;
> +
> +=09bitmap_set(pmu->all_valid_pmc_idx,
> +=09=090, pmu->nr_arch_gp_counters);
> +=09bitmap_set(pmu->all_valid_pmc_idx,
> +=09=09INTEL_PMC_MAX_GENERIC, pmu->nr_arch_fixed_counters);

The offset needs to be INTEL_PMC_IDX_FIXED for GP counters, and 0 for
fixed counters, otherwise pmc_in_use and all_valid_pmc_idx are not in sync.

Paolo

