Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A469C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 10:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 563AD20820
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 10:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436680AbfIWKCy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 06:02:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48520 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407586AbfIWKCy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 06:02:54 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D3B4A3B71F
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 10:02:53 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id a4so4623787wrg.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 03:02:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7Y8XgF9VSWF/4IabhykeB5kMw3gTyZVDX47zu96+jbI=;
        b=IaGNKsMwMzQLN8zjOcmWh19ZrPQ74EVw4TzGDrWUDW+G418z1tOKvSgbdDtO2sB33b
         78Zph5XeE9ThCsPd97BzC5LFxZb7FKnHeas2xos9sFD3XlW65G6Q+eF5gJ3px1TNkClA
         qq24JkVtZ4xd7z1P7kCt7EP8YUWgP4wDuvBP/M3aqpQdZqy2AbwQI5AtB2VtST6PLSoa
         ClEdaymCO7rRLP97uV04ULNtlfA9S6JIGxf49pFOluVdBsrgofyRvKiRkHYIvO6/fv1K
         h0mDXNvwV8ZyJaIIF9hsFXznt7SxChI5WTCs8X4dDG0R3FfBU+Lq4vqiTyVDJb8tfjru
         pTtg==
X-Gm-Message-State: APjAAAW8h2+XhjdNVEmV/kdDphkx5kZ9fZw3UgDjJ8aDhHZqzEjDK0PF
        VD3YVKBPg1B4wkgeJxjwgCTQRu+KbzFTg5TjW7ATTHzrZ5zhNMw7iHqTqOQeJ2+Jzg9Z/AnlgpE
        1RYvmvFw6/TXrLLROOhsnGse8
X-Received: by 2002:a7b:c932:: with SMTP id h18mr12000162wml.86.1569232972397;
        Mon, 23 Sep 2019 03:02:52 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwbawnEsOggXmfc7CbN4mNkoTizp76vM/AK7Yl6A6YLO39lVCowu1LjvNDy+wzZGb8IXNI7RQ==
X-Received: by 2002:a7b:c932:: with SMTP id h18mr12000146wml.86.1569232972164;
        Mon, 23 Sep 2019 03:02:52 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9520:22e6:6416:5c36? ([2001:b07:6468:f312:9520:22e6:6416:5c36])
        by smtp.gmail.com with ESMTPSA id g73sm16566505wme.10.2019.09.23.03.02.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 03:02:51 -0700 (PDT)
Subject: Re: [PATCH 10/17] KVM: monolithic: x86: use the external functions
 instead of kvm_x86_ops
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190920212509.2578-1-aarcange@redhat.com>
 <20190920212509.2578-11-aarcange@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <38f723ba-9746-d550-c86f-61807a6f17eb@redhat.com>
Date:   Mon, 23 Sep 2019 12:02:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190920212509.2578-11-aarcange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/19 23:25, Andrea Arcangeli wrote:
> Now that the new methods are plugged in and they are functional use
> them instead of invoking the pointer to functions through kvm_x86_ops.
> 
> Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
> ---
>  arch/x86/include/asm/kvm_host.h |  10 +-
>  arch/x86/kvm/cpuid.c            |  22 +--
>  arch/x86/kvm/hyperv.c           |   6 +-
>  arch/x86/kvm/kvm_cache_regs.h   |  10 +-
>  arch/x86/kvm/lapic.c            |  28 +--
>  arch/x86/kvm/mmu.c              |  26 +--
>  arch/x86/kvm/mmu.h              |   4 +-
>  arch/x86/kvm/pmu.c              |  24 +--
>  arch/x86/kvm/pmu.h              |   2 +-
>  arch/x86/kvm/trace.h            |   4 +-
>  arch/x86/kvm/vmx/pmu_intel.c    |   2 +-
>  arch/x86/kvm/x86.c              | 304 ++++++++++++++++----------------
>  arch/x86/kvm/x86.h              |   2 +-

Let's make the prefix kvm_x86_ instead of kvm_x86_ops_.

Paolo
