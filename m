Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE34DC3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 07:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AA962077C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 07:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbfHPHQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 03:16:47 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46042 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbfHPHQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 03:16:47 -0400
Received: by mail-wr1-f65.google.com with SMTP id q12so559843wrj.12
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 00:16:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EJIVlcVrChaIchPRvi0VZFSGzF07MglN/xDgbO0U5g8=;
        b=dFE8+bQZlrZw2ixx7ri4h9WGmhjqSTWiKEq88OIrL/7lE3MAyM0XzHHThG9OHKwg7I
         A5Epcl/LIS4qrpE7De/KpO92UX8IF1degGbCb0yjsMd5feYECRAsCvubQrPGsMnp1Nkb
         jcslBcdVAjOoskvq10KFLisGv5woZIL5DMmGMK/vHO2AvSVFNkP1Fwe/PsXsB8KQyeyZ
         5heiUpIBIQ8KKZgvVmAANunTlIxGdPH8EJ93WQEpe2joV8IwEgeb2DrrMFtHXyAGAK05
         K+4B6FohwbH26k0OumMAy3vFNr1DD7hPGoSrSMSo4slzrnVc3rbXh2w3rvOyWz+0NBMa
         sDPw==
X-Gm-Message-State: APjAAAU0megdNBhbeZqPNDdl6Us0VW6QrJKYH5uYfK0JhHhYaVpXxuSn
        UUfqlzxgEwcr5Kvfid04r4r1lw==
X-Google-Smtp-Source: APXvYqzTfq2WpNnyBkTVV943/NPrjFUPf4oiM2s4KVceIdYqfb9LPPM0nQxqCppVTo2b/jit8oFZxQ==
X-Received: by 2002:adf:9050:: with SMTP id h74mr8738567wrh.191.1565939805105;
        Fri, 16 Aug 2019 00:16:45 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:399c:411e:1ccb:f240? ([2001:b07:6468:f312:399c:411e:1ccb:f240])
        by smtp.gmail.com with ESMTPSA id g26sm3184169wmh.32.2019.08.16.00.16.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2019 00:16:44 -0700 (PDT)
Subject: Re: [PATCH] KVM: x86/MMU: Zap all when removing memslot if VM has
 assigned device
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alex Willamson <alex.williamson@redhat.com>
References: <1565855169-29491-1-git-send-email-pbonzini@redhat.com>
 <20190815151228.32242-1-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <6c040867-2978-5c57-bbd1-3000593ed538@redhat.com>
Date:   Fri, 16 Aug 2019 09:16:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190815151228.32242-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/08/19 17:12, Sean Christopherson wrote:
> Alex Williamson reported regressions with device assignment when KVM
> changed its memslot removal logic to zap only the SPTEs for the memslot
> being removed.  The source of the bug is unknown at this time, and root
> causing the issue will likely be a slow process.  In the short term, fix
> the regression by zapping all SPTEs when removing a memslot from a VM
> with assigned device(s).
> 
> Fixes: 4e103134b862 ("KVM: x86/mmu: Zap only the relevant pages when removing a memslot", 2019-02-05)
> Reported-by: Alex Willamson <alex.williamson@redhat.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
> 
> An alternative idea to a full revert.  I assume this would be easy to
> backport, and also easy to revert or quirk depending on where the bug
> is hiding.

We're not sure that it only happens with assigned devices; it's just
that assigned BARs are the memslots that are more likely to be
reprogrammed at boot.  So this patch feels unsafe.

Paolo

> 
>  arch/x86/kvm/mmu.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
> index 8f72526e2f68..358b93882ac6 100644
> --- a/arch/x86/kvm/mmu.c
> +++ b/arch/x86/kvm/mmu.c
> @@ -5659,6 +5659,17 @@ static void kvm_mmu_invalidate_zap_pages_in_memslot(struct kvm *kvm,
>  	bool flush;
>  	gfn_t gfn;
>  
> +	/*
> +	 * Zapping only the removed memslot introduced regressions for VMs with
> +	 * assigned devices.  It is unknown what piece of code is buggy.  Until
> +	 * the source of the bug is identified, zap everything if the VM has an
> +	 * assigned device.
> +	 */
> +	if (kvm_arch_has_assigned_device(kvm)) {
> +		kvm_mmu_zap_all(kvm);
> +		return;
> +	}
> +
>  	spin_lock(&kvm->mmu_lock);
>  
>  	if (list_empty(&kvm->arch.active_mmu_pages))
> 

