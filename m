Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08BF0C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB63B2063F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729905AbfFQVcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 17:32:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47264 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728478AbfFQVcE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 17:32:04 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6778333BCD;
        Mon, 17 Jun 2019 21:32:04 +0000 (UTC)
Received: from flask (unknown [10.43.2.199])
        by smtp.corp.redhat.com (Postfix) with SMTP id 481D178401;
        Mon, 17 Jun 2019 21:32:02 +0000 (UTC)
Received: by flask (sSMTP sendmail emulation); Mon, 17 Jun 2019 23:32:01 +0200
Date:   Mon, 17 Jun 2019 23:32:01 +0200
From:   Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH v4 5/5] KVM: LAPIC: add advance timer support to
 pi_inject_timer
Message-ID: <20190617213201.GA26346@flask>
References: <1560770687-23227-1-git-send-email-wanpengli@tencent.com>
 <1560770687-23227-6-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1560770687-23227-6-git-send-email-wanpengli@tencent.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Mon, 17 Jun 2019 21:32:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2019-06-17 19:24+0800, Wanpeng Li:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> Wait before calling posted-interrupt deliver function directly to add 
> advance timer support to pi_inject_timer.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: Marcelo Tosatti <mtosatti@redhat.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---

Please merge this patch with [2/5], so bisection doesn't break.

>  arch/x86/kvm/lapic.c   | 6 ++++--
>  arch/x86/kvm/lapic.h   | 2 +-
>  arch/x86/kvm/svm.c     | 2 +-
>  arch/x86/kvm/vmx/vmx.c | 2 +-
>  4 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index 1a31389..1a31ba5 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -1462,6 +1462,8 @@ static void apic_timer_expired(struct kvm_lapic *apic, bool can_pi_inject)
>  		return;
>  
>  	if (can_pi_inject && posted_interrupt_inject_timer(apic->vcpu)) {
> +		if (apic->lapic_timer.timer_advance_ns)
> +			kvm_wait_lapic_expire(vcpu, true);

From where does kvm_wait_lapic_expire() take
apic->lapic_timer.expired_tscdeadline?

(I think it would be best to take the functional core of
 kvm_wait_lapic_expire() and make it into a function that takes the
 expired_tscdeadline as an argument.)

Thanks.
