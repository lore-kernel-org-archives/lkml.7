Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC281C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 19:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1B5D21D7B
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 19:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387620AbfIYT3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 15:29:50 -0400
Received: from mga02.intel.com ([134.134.136.20]:10678 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729004AbfIYT3u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 15:29:50 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Sep 2019 12:29:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,549,1559545200"; 
   d="scan'208";a="196094863"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.41])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Sep 2019 12:29:49 -0700
Date:   Wed, 25 Sep 2019 12:29:49 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] KVM: LAPIC: Loose fluctuation filter for auto tune
 lapic_timer_advance_ns
Message-ID: <20190925192949.GM31852@linux.intel.com>
References: <1569390424-22031-1-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1569390424-22031-1-git-send-email-wanpengli@tencent.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 01:47:04PM +0800, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> 5000 guest cycles delta is easy to encounter on desktop, per-vCPU 
> lapic_timer_advance_ns always keeps at 1000ns initial value, lets 
> loose fluctuation filter a bit to make auto tune can make some 
> progress.
> 
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
>  arch/x86/kvm/lapic.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index 3a3a685..258407e 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -67,7 +67,7 @@
>  
>  static bool lapic_timer_advance_dynamic __read_mostly;
>  #define LAPIC_TIMER_ADVANCE_ADJUST_MIN 100
> -#define LAPIC_TIMER_ADVANCE_ADJUST_MAX 5000
> +#define LAPIC_TIMER_ADVANCE_ADJUST_MAX 10000
>  #define LAPIC_TIMER_ADVANCE_ADJUST_INIT 1000
>  /* step-by-step approximation to mitigate fluctuation */
>  #define LAPIC_TIMER_ADVANCE_ADJUST_STEP 8
> @@ -1504,7 +1504,7 @@ static inline void adjust_lapic_timer_advance(struct kvm_vcpu *vcpu,
>  		timer_advance_ns += ns/LAPIC_TIMER_ADVANCE_ADJUST_STEP;
>  	}
>  
> -	if (unlikely(timer_advance_ns > LAPIC_TIMER_ADVANCE_ADJUST_MAX))
> +	if (unlikely(timer_advance_ns > LAPIC_TIMER_ADVANCE_ADJUST_MAX/2))

Doh, missed that these are two different time domains in the original
review, i.e. ns vs. cycles.

We should use separate defines for the filter since that check is done
in cycles.  Not sure what names to use to keep things somewhat clear.

Maybe s/ADJUST/EXPIRE for the cycles, and s/ADJUST/NS for the ns ones?
E.g.:

#define LAPIC_TIMER_ADVANCE_EXPIRE_MIN	100
#define LAPIC_TIMER_ADVANCE_EXPIRE_MAX	10000
#define LAPIC_TIMER_ADVANCE_NS_MAX	5000
#define LAPIC_TIMER_ADVANCE_NS_INIT	1000

>  		timer_advance_ns = LAPIC_TIMER_ADVANCE_ADJUST_INIT;
>  	apic->lapic_timer.timer_advance_ns = timer_advance_ns;
>  }
> -- 
> 2.7.4
> 
