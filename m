Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B62C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 11:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4441D20815
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 11:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732567AbfETLQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 07:16:13 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38042 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731202AbfETLQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 07:16:13 -0400
Received: by mail-wm1-f65.google.com with SMTP id t5so11252654wmh.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 04:16:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=joIiCM9Da390dnqSoP54tpS0tG+Bp+p+mXE87gw748E=;
        b=T+Fkz0firzHSS+64c6o2/gEa+XcikMs0dgqC2noEyUSzPWXpHa+37sJhpZApf/mYbr
         8gdbhm/ponSDWWratvBU/Hsn4M2pofnoBM1EhTT7jFlGFBSWtQnCpA69KJgZPClz0VLR
         xiOtJEuGRSU5+Thwfr9YIcw8MQqA3Yky77q1AZNF1moeoTM/RqElKGeydXEo7v2mHUjV
         bpDN6Ii5BSF+GbbfX0dwW+MhM35jnMKK4hdnyKkdK7jge0SEAGJ0VljX28xaa2pVYHlN
         h2UM62LNipDVKlTBLD9TnZ1GuBFh2BGGcZ3SO+vz9eZlDwatxFlm/EDWRbfDDv3+MrNb
         gPdQ==
X-Gm-Message-State: APjAAAWb4BgVzINzGTFd6VjRRmwXIw1dGUjREW74pKMLnKCQxqfqtkxS
        m/FbA5eG3pF3X1XjGyjDXer0rDSLslzq+w==
X-Google-Smtp-Source: APXvYqyo1i1kPklnr6KsI6wSgJSXhrXqQ6p4hIqkFEkF+YY5nU2Do9SqZs7IX79zGuSbDXRK04IEWQ==
X-Received: by 2002:a1c:48d7:: with SMTP id v206mr10674778wma.152.1558350971238;
        Mon, 20 May 2019 04:16:11 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ac04:eef9:b257:b844? ([2001:b07:6468:f312:ac04:eef9:b257:b844])
        by smtp.gmail.com with ESMTPSA id y17sm14693790wrp.70.2019.05.20.04.16.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 04:16:10 -0700 (PDT)
Subject: Re: [PATCH v4 0/5] KVM: LAPIC: Optimize timer latency further
To:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <1558340289-6857-1-git-send-email-wanpengli@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e6e28a3f-bda7-342c-dc28-5dc899b6fa02@redhat.com>
Date:   Mon, 20 May 2019 13:16:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1558340289-6857-1-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/19 10:18, Wanpeng Li wrote:
> Advance lapic timer tries to hidden the hypervisor overhead between the 
> host emulated timer fires and the guest awares the timer is fired. However, 
> it just hidden the time between apic_timer_fn/handle_preemption_timer -> 
> wait_lapic_expire, instead of the real position of vmentry which is 
> mentioned in the orignial commit d0659d946be0 ("KVM: x86: add option to 
> advance tscdeadline hrtimer expiration"). There is 700+ cpu cycles between 
> the end of wait_lapic_expire and before world switch on my haswell desktop.
> 
> This patchset tries to narrow the last gap(wait_lapic_expire -> world switch), 
> it takes the real overhead time between apic_timer_fn/handle_preemption_timer
> and before world switch into consideration when adaptively tuning timer 
> advancement. The patchset can reduce 40% latency (~1600+ cycles to ~1000+ 
> cycles on a haswell desktop) for kvm-unit-tests/tscdeadline_latency when 
> testing busy waits.
> 
> v3 -> v4:
>  * create timer_advance_ns debugfs entry iff lapic_in_kernel() 
>  * keep if (guest_tsc < tsc_deadline) before the call to __wait_lapic_expire()
> 
> v2 -> v3:
>  * expose 'kvm_timer.timer_advance_ns' to userspace
>  * move the tracepoint below guest_exit_irqoff()
>  * move wait_lapic_expire() before flushing the L1
> 
> v1 -> v2:
>  * fix indent in patch 1/4
>  * remove the wait_lapic_expire() tracepoint and expose by debugfs
>  * move the call to wait_lapic_expire() into vmx.c and svm.c
> 
> Wanpeng Li (5):
>   KVM: LAPIC: Extract adaptive tune timer advancement logic
>   KVM: LAPIC: Fix lapic_timer_advance_ns parameter overflow
>   KVM: LAPIC: Expose per-vCPU timer_advance_ns to userspace
>   KVM: LAPIC: Delay trace advance expire delta
>   KVM: LAPIC: Optimize timer latency further
> 
>  arch/x86/kvm/debugfs.c | 18 +++++++++++++++
>  arch/x86/kvm/lapic.c   | 60 +++++++++++++++++++++++++++++---------------------
>  arch/x86/kvm/lapic.h   |  3 ++-
>  arch/x86/kvm/svm.c     |  4 ++++
>  arch/x86/kvm/vmx/vmx.c |  4 ++++
>  arch/x86/kvm/x86.c     |  9 ++++----
>  6 files changed, 68 insertions(+), 30 deletions(-)
> 

Queued, thanks (2-3 for 5.2, the rest for 5.3).

Paolo
