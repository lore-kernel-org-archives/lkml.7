Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F635C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 10:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C09520820
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 10:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407511AbfIWKBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 06:01:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44024 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407492AbfIWKBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 06:01:15 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8431969061
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 10:01:15 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id s25so4762375wmh.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 03:01:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zLUtLu/KnWnoHcEa1QOKwZwcnw55ztopnQ9cohxkH6o=;
        b=Efu5sDKXVWgkkd4odERoNZ/7WlB7eTBKhxvUqFav4DGrHW2zXDjjAISe/E9fFrY8xW
         bS7AuhgOujftmMipa+4dnmNvPf6HlECyfIepdKg125iZp5jNwEfvjQpNVW7azlU1bp4F
         9vI0mnBqI92OPWIfgo9nt2BVg3ejpOOdhH2Qf/a6fTThFaDnIF2rtJMpollYLRtkOogn
         SZ/a0V7zQZSYe9RM1ka/k/eFhBvwCrENPqleacmOtbJpn5wcRVvEWb8juyvX8GiJu2q7
         hshuJF1/1VioHDOByn0lC+d7NosftTucoCW1YsYmTzhLuFhQVTXh/skukgXHywq3zghU
         ayNw==
X-Gm-Message-State: APjAAAX0Tq+oAQtlZ3zPRVHjCKUqlMXuOHjHnd9BvAPqjyuTuiTn9He8
        RLtPLtEPZtTbkegkclcarxs1iit2RFbtwCEsHFrVZba08pJpRBvM7R3loFXVxgrL62xiBLbHSR7
        IzmSri37imqZryFNQVO0E6oWC
X-Received: by 2002:a05:600c:2108:: with SMTP id u8mr13679635wml.13.1569232873865;
        Mon, 23 Sep 2019 03:01:13 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzf6DaFBwbPJTjPYZbiX3JiRzzjw1+nWOqSyWiHD2a7XEhD9MUyWlT8nL2XJ6rB4p5x8F7MbA==
X-Received: by 2002:a05:600c:2108:: with SMTP id u8mr13679624wml.13.1569232873623;
        Mon, 23 Sep 2019 03:01:13 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9520:22e6:6416:5c36? ([2001:b07:6468:f312:9520:22e6:6416:5c36])
        by smtp.gmail.com with ESMTPSA id l6sm12303726wmg.2.2019.09.23.03.01.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 03:01:12 -0700 (PDT)
Subject: Re: [PATCH 16/17] KVM: retpolines: x86: eliminate retpoline from
 svm.c exit handlers
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190920212509.2578-1-aarcange@redhat.com>
 <20190920212509.2578-17-aarcange@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <b8ec371a-58ac-3c40-4825-e67c2768b37e@redhat.com>
Date:   Mon, 23 Sep 2019 12:01:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190920212509.2578-17-aarcange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/19 23:25, Andrea Arcangeli wrote:
> +#ifdef CONFIG_RETPOLINE
> +	if (exit_code == SVM_EXIT_MSR)
> +		return msr_interception(svm);
> +	else if (exit_code == SVM_EXIT_VINTR)
> +		return interrupt_window_interception(svm);
> +	else if (exit_code == SVM_EXIT_INTR)
> +		return intr_interception(svm);
> +	else if (exit_code == SVM_EXIT_HLT)
> +		return halt_interception(svm);
> +	else if (exit_code == SVM_EXIT_NPF)
> +		return npf_interception(svm);
> +	else if (exit_code == SVM_EXIT_CPUID)
> +		return cpuid_interception(svm);
> +#endif

Same here; msr_interception and npf_interception are the main ones we
care about, plus io_interception which isn't listed probably because it
depends on the virtual hardware.

Paolo
