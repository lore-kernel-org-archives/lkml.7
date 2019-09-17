Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7DDEC4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 13:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6586206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 13:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbfIQNd4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 09:33:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33208 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbfIQNd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 09:33:56 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1958681F11
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 13:33:56 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id m14so1313678wru.17
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 06:33:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=40YR/NqB5wwWzIKovyeLWwFjAHh78u21LsyykmnxUSs=;
        b=tPgqn6mL1FbxgHdZiygp0l2fqBA5exXkdQYrSKOZ05Zb4GcARMt4ViGQzGpZT0/Tnb
         iGlkF2zNZzt/jL9PHQBrH9fziqF021qKHtOepP/XZZ7JkaeCd4WCUjsAkD1XV2B/3SrE
         eDK0xKKwpuFxotMbcgLE0iDJr+KQS7SW/VSMpqOEJE0z5tsOa2aI9gzsMstk+iysiCMU
         Z8V9eaibzf2aaIT1FYlJ+2WHW+C+tzbZ4s+t2CQLea5mG3gdZOZRTZqIKPFzcyjCIE4D
         XZwW/78E+530rsnUPOG9hVcOOXHzPyPFqdcQqvJIA3MrDti9XylN4GS4xTlx3T3Kwv0S
         p73g==
X-Gm-Message-State: APjAAAXGB2HGXXyF7T0MvtRbr5e9+xQq/kWNqfMjFVCAFC/Uu8u/aIl+
        hsBVKl9rNWgh0scK6qQTIDisLjiXdYaXkJxvOSAGEL7PbLPCXOLRUfi3fFTwHHdy6gB+AzyRxCp
        O9gijxOMMQ05tdahl5QD2V6Nh
X-Received: by 2002:a1c:23d7:: with SMTP id j206mr3628128wmj.57.1568727234524;
        Tue, 17 Sep 2019 06:33:54 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzsUMFxBPdGRNMeEL6QFpBx/vUdORE51BaSjWK6NJei9RZcM21gbeW4FWTgRxldB18oQF1f3A==
X-Received: by 2002:a1c:23d7:: with SMTP id j206mr3628104wmj.57.1568727234251;
        Tue, 17 Sep 2019 06:33:54 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c46c:2acb:d8d2:21d8? ([2001:b07:6468:f312:c46c:2acb:d8d2:21d8])
        by smtp.gmail.com with ESMTPSA id b184sm3823721wmg.47.2019.09.17.06.33.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2019 06:33:53 -0700 (PDT)
Subject: Re: [PATCH] KVM: x86: Manually flush collapsible SPTEs only when
 toggling flags
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190911191952.31126-1-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <47331a39-7f74-661c-b248-266eec420efa@redhat.com>
Date:   Tue, 17 Sep 2019 15:33:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190911191952.31126-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/09/19 21:19, Sean Christopherson wrote:
> Zapping collapsible sptes, a.k.a. 4k sptes that can be promoted into a
> large page, is only necessary when changing only the dirty logging flag
> of a memory region.  If the memslot is also being moved, then all sptes
> for the memslot are zapped when it is invalidated.  When a memslot is
> being created, it is impossible for there to be existing dirty mappings,
> e.g. KVM can have MMIO sptes, but not present, and thus dirty, sptes.
> 
> Note, the comment and logic are shamelessly borrowed from MIPS's version
> of kvm_arch_commit_memory_region().
> 
> Fixes: 3ea3b7fa9af06 ("kvm: mmu: lazy collapse small sptes into large sptes")
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/x86.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index b4cfd786d0b6..70e82e8f5c41 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -9635,8 +9635,13 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
>  	 * Scan sptes if dirty logging has been stopped, dropping those
>  	 * which can be collapsed into a single large-page spte.  Later
>  	 * page faults will create the large-page sptes.
> +	 *
> +	 * There is no need to do this in any of the following cases:
> +	 * CREATE:	No dirty mappings will already exist.
> +	 * MOVE/DELETE:	The old mappings will already have been cleaned up by
> +	 *		kvm_arch_flush_shadow_memslot()
>  	 */
> -	if ((change != KVM_MR_DELETE) &&
> +	if (change == KVM_MR_FLAGS_ONLY &&
>  		(old->flags & KVM_MEM_LOG_DIRTY_PAGES) &&
>  		!(new->flags & KVM_MEM_LOG_DIRTY_PAGES))
>  		kvm_mmu_zap_collapsible_sptes(kvm, new);
> 

Queued, thanks.

Paolo
