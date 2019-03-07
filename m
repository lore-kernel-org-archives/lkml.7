Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 577F8C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 14:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 272672081B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 14:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbfCGOHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 09:07:10 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42414 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbfCGOHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 09:07:09 -0500
Received: by mail-wr1-f67.google.com with SMTP id r5so17572310wrg.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 06:07:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=2o2B7xDdcH1gS2/tnHUgkGtCKZpPUoNskyO457Jl6dE=;
        b=CtB2tS0CEQxJplLoUZZqwCBuwe+B09JmR4gk+krVK1HG6j9BD833O8A9F6JyfCS/4J
         FxRpG0WfcgJSaI6oWGPVOcIALpbuE37twH/drtkh2xLBvauf0k0EfGCFa/5Rzr1d2eML
         jazKjH2LJa68Gn0g2mZUYUhbwWhPF0A55rqHBdbi3b2wUoBL7eIGXnQl79DTrYtQWfwN
         CKHBDktaIYUqJ6FRMURoY/WBDfBy2qe3NEXYcHIqS10S/4dYaC5WX9WxGVGMNdRAaVIu
         tcxMy+v5u6HJ2q+eofLqWyBiBI6qbVPGNvoYyHbzTfsCB2YQm8CPnrKoGFLwxizY7qCh
         EwxA==
X-Gm-Message-State: APjAAAU7ilVNKUn3HhLEnMKqL+CSHjjpl3IJQOUZrMEDZUWXlPiYMpJF
        JCSeDkikfeMfx8vPf5VhEMzA1vMDq/c=
X-Google-Smtp-Source: APXvYqyBS38UaGRmfnLvdXIOHIR+mDQY76HfriSwWgMakg+CwCqql30NIaZdQxtSRXa4WW5DlJBajA==
X-Received: by 2002:adf:e2ca:: with SMTP id d10mr156192wrj.250.1551967627237;
        Thu, 07 Mar 2019 06:07:07 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id c67sm4254037wmd.47.2019.03.07.06.07.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 06:07:06 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc:     kvm@vger.kernel.org, Junaid Shahid <junaids@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 RFC] x86/kvm/mmu: make mmu->prev_roots cache work for NPT case
In-Reply-To: <20190223111552.27221-1-vkuznets@redhat.com>
References: <0c13c94e-3226-8bfd-2dc7-c75aad1c03a2@redhat.com> <20190223111552.27221-1-vkuznets@redhat.com>
Date:   Thu, 07 Mar 2019 15:07:05 +0100
Message-ID: <87ftrylqwm.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vitaly Kuznetsov <vkuznets@redhat.com> writes:

> Alternative patch: remove the filtering from kvm_mmu_get_page() and check
> for direct on call sites. cr4_pae setting in kvm_calc_mmu_role_common()
> can be preserved for consistency.
>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kvm/mmu.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
> index f2d1d230d5b8..7fb8118f2af6 100644
> --- a/arch/x86/kvm/mmu.c
> +++ b/arch/x86/kvm/mmu.c
> @@ -2420,8 +2420,6 @@ static struct kvm_mmu_page *kvm_mmu_get_page(struct kvm_vcpu *vcpu,
>  	role = vcpu->arch.mmu->mmu_role.base;
>  	role.level = level;
>  	role.direct = direct;
> -	if (role.direct)
> -		role.cr4_pae = 0;
>  	role.access = access;
>  	if (!vcpu->arch.mmu->direct_map
>  	    && vcpu->arch.mmu->root_level <= PT32_ROOT_LEVEL) {
> @@ -5176,7 +5174,7 @@ static bool detect_write_misaligned(struct kvm_mmu_page *sp, gpa_t gpa,
>  		 gpa, bytes, sp->role.word);
>  
>  	offset = offset_in_page(gpa);
> -	pte_size = sp->role.cr4_pae ? 8 : 4;
> +	pte_size = (sp->role.cr4_pae && !sp->role.direct) ? 8 : 4;
>  
>  	/*
>  	 * Sometimes, the OS only writes the last one bytes to update status
> @@ -5200,7 +5198,7 @@ static u64 *get_written_sptes(struct kvm_mmu_page *sp, gpa_t gpa, int *nspte)
>  	page_offset = offset_in_page(gpa);
>  	level = sp->role.level;
>  	*nspte = 1;
> -	if (!sp->role.cr4_pae) {
> +	if (!sp->role.cr4_pae || sp->role.direct) {
>  		page_offset <<= 1;	/* 32->64 */
>  		/*
>  		 * A 32-bit pde maps 4MB while the shadow pdes map

While I personally prefer this approach to not setting role.cr4_pae in
kvm_calc_mmu_role_common() I'd like to get maintainers opinion (I did
test the patch with ept=off but I have to admit I don't know much about
shadow page tables which actually use detect_write_misaligned()/
get_written_sptes())

Paolo, Radim, (anyone else) - any thoughts?

-- 
Vitaly
