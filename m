Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E659FC31E43
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 17:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C747520820
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 17:11:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbfFJRLR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 13:11:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34636 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728289AbfFJRLN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 13:11:13 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D4E40C18B2DB;
        Mon, 10 Jun 2019 17:11:12 +0000 (UTC)
Received: from flask (unknown [10.43.2.83])
        by smtp.corp.redhat.com (Postfix) with SMTP id D77026061B;
        Mon, 10 Jun 2019 17:11:10 +0000 (UTC)
Received: by flask (sSMTP sendmail emulation); Mon, 10 Jun 2019 19:11:10 +0200
Date:   Mon, 10 Jun 2019 19:11:10 +0200
From:   Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 1/3] KVM: LAPIC: Make lapic timer unpinned when timer
 is injected by posted-interrupt
Message-ID: <20190610171110.GB8389@flask>
References: <1559799086-13912-1-git-send-email-wanpengli@tencent.com>
 <1559799086-13912-2-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1559799086-13912-2-git-send-email-wanpengli@tencent.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 10 Jun 2019 17:11:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2019-06-06 13:31+0800, Wanpeng Li:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> Make lapic timer unpinned when timer is injected by posted-interrupt,
> the emulated timer can be offload to the housekeeping cpus.
> 
> The host admin should fine tuned, e.g. dedicated instances scenario 
> w/ nohz_full cover the pCPUs which vCPUs resident, several pCPUs 
> surplus for housekeeping, disable mwait/hlt/pause vmexits to occupy 
> the pCPUs, fortunately preemption timer is disabled after mwait is 
> exposed to guest which makes emulated timer offload can be possible. 
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
>  arch/x86/kvm/lapic.c            | 20 ++++++++++++++++----
>  arch/x86/kvm/x86.c              |  5 +++++
>  arch/x86/kvm/x86.h              |  2 ++
>  include/linux/sched/isolation.h |  2 ++
>  kernel/sched/isolation.c        |  6 ++++++
>  5 files changed, 31 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index fcf42a3..09b7387 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -127,6 +127,12 @@ static inline u32 kvm_x2apic_id(struct kvm_lapic *apic)
>  	return apic->vcpu->vcpu_id;
>  }
>  
> +static inline bool posted_interrupt_inject_timer_enabled(struct kvm_vcpu *vcpu)
> +{
> +	return pi_inject_timer && kvm_vcpu_apicv_active(vcpu) &&
> +		kvm_mwait_in_guest(vcpu->kvm);

I'm torn about the mwait dependency.  It covers a lot of the targeted
user base, but the relation is convoluted and not fitting perfectly.

What do you think about making posted_interrupt_inject_timer_enabled()
just

	pi_inject_timer && kvm_vcpu_apicv_active(vcpu)

and disarming the vmx preemption timer when
posted_interrupt_inject_timer_enabled(), just like we do with mwait now?

Thanks.
