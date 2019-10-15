Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70462ECE58E
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 08:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E9A92089C
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 08:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbfJOI7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 04:59:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60480 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727922AbfJOI7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 04:59:07 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 37D174E93D
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 08:59:07 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id v18so9778681wro.16
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 01:59:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MOmAFdPDWrDEa5AvaNMUKf7NziX00yqzV1UZ/AfIuGk=;
        b=c64Cqx65MzTDq6S+Lm0GzKkco2D1orRLrtdoEuPGanDBwEhDx0IJ6dutmU8fwmHX7f
         jrYU/7SzydHW2cR0X713LtS9Ckz/Fyf7xASqkli1+HxQcZtDIhuYORDd/uFYHeuYksdo
         s9TSe0QSrohw5BP5bSXbsIat9/fNXSWBpTvF+8Kzz8+B52WFcelYF0fA5kIVoZn6YW/K
         Tr8o5Rp8ndfomVd2fbzPHXpSaytowgSwWztCdwkw9YwhUgBzkMaGVfB4iOePWoSKGnhe
         FnUuyHLHvlbTrTNTlgEWvmbgIpyHViXMPPg+pgEpj3r6rZRLYx0LmS6U6s8bGxbAyStK
         L+uw==
X-Gm-Message-State: APjAAAUGZlxrH8NLcVKyJhZHNDLvFvyOKDK03e+X9EwqAagcVrfQmpor
        df/KZGPvE10p7YaPEe5g3mwI+iF/Rd25WciMfZ/N3hTGWclcn9MEA/pFII0fo9zklw3tmVoWmp4
        6aaAI+FYKk1XNyKJZyWwGhPuV
X-Received: by 2002:a05:600c:2201:: with SMTP id z1mr18946723wml.169.1571129945824;
        Tue, 15 Oct 2019 01:59:05 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyRgJTYqmv94g8xe+OJCo1AUwh7aXyZIoNlBixvs7ZRNcsijmTRxDzwTcNbJ60P+WUjyGjxfA==
X-Received: by 2002:a05:600c:2201:: with SMTP id z1mr18946700wml.169.1571129945485;
        Tue, 15 Oct 2019 01:59:05 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d001:591b:c73b:6c41? ([2001:b07:6468:f312:d001:591b:c73b:6c41])
        by smtp.gmail.com with ESMTPSA id r13sm30920817wrn.0.2019.10.15.01.59.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2019 01:59:05 -0700 (PDT)
Subject: Re: [RFC v2 2/2] x86/kvmclock: Introduce kvm-hostclock clocksource.
To:     Suleiman Souhlal <suleiman@google.com>
Cc:     rkrcmar@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>, sboyd@kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        kvm@vger.kernel.org, Suleiman Souhlal <ssouhlal@freebsd.org>,
        tfiga@chromium.org, Vitaly Kuznetsov <vkuznets@redhat.com>
References: <20191010073055.183635-1-suleiman@google.com>
 <20191010073055.183635-3-suleiman@google.com>
 <2e6e5b14-fa68-67bd-1436-293659c8d92c@redhat.com>
 <CABCjUKAsO9bOW9-VW1gk0O_U=9V6Zhft8LjpcqXVbDVTvWJ5Hw@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <b98fcfc6-2759-7293-b3b5-0282830c9379@redhat.com>
Date:   Tue, 15 Oct 2019 10:59:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CABCjUKAsO9bOW9-VW1gk0O_U=9V6Zhft8LjpcqXVbDVTvWJ5Hw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/10/19 10:39, Suleiman Souhlal wrote:
> I think we have that already (pvtk->flags).
> I'll change the if statement above to use pvtk instead of pv_timekeeper.

Of course, thanks.

>>> +kvm_hostclock_init(void)
>>> +{
>>> +     unsigned long pa;
>>> +
>>> +     pa = __pa(&pv_timekeeper);
>>> +     wrmsrl(MSR_KVM_TIMEKEEPER_EN, pa);
>>
>>
>> As Vitaly said, a new CPUID bit must be defined in
>> Documentation/virt/kvm/cpuid.txt, and used here.  Also please make bit 0
>> an enable bit.
> 
> I think I might not be able to move the enable bit to 0 because we
> need the generation count (pvclock_timekeeper.gen) to be the first
> word of the struct due to the way we copy the data to userspace,
> similarly to how kvm_setup_pvclock_page() does it.

I mean bit 0 of the MSR.

Thanks,

Paolo
