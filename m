Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97EDCC76191
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 20:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 662B82147A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 20:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H/w87sNB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbfGUU5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 16:57:44 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40190 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbfGUU5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 16:57:44 -0400
Received: by mail-pf1-f195.google.com with SMTP id p184so16338322pfp.7
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2019 13:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=9F+JC+6LFsWKhUDWDvarnJN98+mFen9oXJXgzo0bSVU=;
        b=H/w87sNB0a3V+xk2M+jLVLQK59lF76tosZO4VtHv6z4KcZ8NNe7kyUuAe+lpkEX0CV
         pyFMClI7v1vi3HEadpcpd68msmofnTynhugJIFxcINUwkkT8qGgif5HAFUQVu1UBOnEj
         6EBZGmgaVM7aRT9eJSoXy7+6VbQsmfP+0A+cgGP3Ou2hoLCcSaf635W7B4wc1Xs/5nrT
         zpAtLRfh+qWoNm7UpbexEHw4Z5mYdrf4HiExRzITUk7w0I9opkHJCHonc7OgifwzLGPA
         JCBM2CwY/zTPfC1nMULwOtuxSRmqr/p3p5f9QBunjNlNURxnhm2ZmKA4hnm0tY/BKC1f
         XX3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=9F+JC+6LFsWKhUDWDvarnJN98+mFen9oXJXgzo0bSVU=;
        b=Nd3wYbCf6BhVJJUIl1O9SJzxLeTwNzGGmS5wYETmM3p+m8YM4+G2QPrOWUT5TvwQtc
         ofKsTGKL+DIFk4PXomlFX5DHLadTcTV0VinotlsWwb3dbF4WsMu23iih+OZmSJ4Xt++h
         450Hob0BVUJcLzEF4K/1NU7/g4IBV9Yly1kHrQE+JIiWlmfPg9qs4CVBwMcoIumg82ne
         XultGrzNjkoBt1SiRfoKeU3VvBsR9NPiPjuaBGFuxCll8RBmCL9CwgcvfgxD0y1yKa2P
         4g4d/KHnhdWRHI5mBrBY4G49oWk160rQ/phOE7BRx56XWdBCyYhxsGRTtOOHMbhpJj4v
         ufRg==
X-Gm-Message-State: APjAAAV7TPXfjZdUo7v/Ib3ySzAEoZ+rklnTRfrFX2te68wm8li4H/4C
        TYdyXaP2ojBFGmfB7xMcc/rM8Q==
X-Google-Smtp-Source: APXvYqy/R3sPr935zDxzmCU0exLHv3/58+pLAknmNb6Kk+mmYSGJCP0x5aeWxQsIXyXJn9OKZFm+wQ==
X-Received: by 2002:a65:62d7:: with SMTP id m23mr68104938pgv.358.1563742662844;
        Sun, 21 Jul 2019 13:57:42 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id d14sm47652555pfo.154.2019.07.21.13.57.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 21 Jul 2019 13:57:41 -0700 (PDT)
Date:   Sun, 21 Jul 2019 13:57:41 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     "Singh, Brijesh" <brijesh.singh@amd.com>
cc:     Cfir Cohen <cfir@google.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?Q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@suse.de>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 08/11] KVM: X86: Introduce KVM_HC_PAGE_ENC_STATUS
 hypercall
In-Reply-To: <20190710201244.25195-9-brijesh.singh@amd.com>
Message-ID: <alpine.DEB.2.21.1907211354220.58367@chino.kir.corp.google.com>
References: <20190710201244.25195-1-brijesh.singh@amd.com> <20190710201244.25195-9-brijesh.singh@amd.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jul 2019, Singh, Brijesh wrote:

> diff --git a/Documentation/virtual/kvm/hypercalls.txt b/Documentation/virtual/kvm/hypercalls.txt
> index da24c138c8d1..94f0611f4d88 100644
> --- a/Documentation/virtual/kvm/hypercalls.txt
> +++ b/Documentation/virtual/kvm/hypercalls.txt
> @@ -141,3 +141,17 @@ a0 corresponds to the APIC ID in the third argument (a2), bit 1
>  corresponds to the APIC ID a2+1, and so on.
>  
>  Returns the number of CPUs to which the IPIs were delivered successfully.
> +
> +7. KVM_HC_PAGE_ENC_STATUS
> +-------------------------
> +Architecture: x86
> +Status: active
> +Purpose: Notify the encryption status changes in guest page table (SEV guest)
> +
> +a0: the guest physical address of the start page
> +a1: the number of pages
> +a2: encryption attribute
> +
> +   Where:
> +	* 1: Encryption attribute is set
> +	* 0: Encryption attribute is cleared
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 26d1eb83f72a..b463a81dc176 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1199,6 +1199,8 @@ struct kvm_x86_ops {
>  	uint16_t (*nested_get_evmcs_version)(struct kvm_vcpu *vcpu);
>  
>  	bool (*need_emulation_on_page_fault)(struct kvm_vcpu *vcpu);
> +	int (*page_enc_status_hc)(struct kvm *kvm, unsigned long gpa,
> +				  unsigned long sz, unsigned long mode);
>  };
>  
>  struct kvm_arch_async_pf {
> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index 3089942f6630..431718309359 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -135,6 +135,8 @@ struct kvm_sev_info {
>  	int fd;			/* SEV device fd */
>  	unsigned long pages_locked; /* Number of pages locked */
>  	struct list_head regions_list;  /* List of registered regions */
> +	unsigned long *page_enc_bmap;
> +	unsigned long page_enc_bmap_size;
>  };
>  
>  struct kvm_svm {
> @@ -1910,6 +1912,8 @@ static void sev_vm_destroy(struct kvm *kvm)
>  
>  	sev_unbind_asid(kvm, sev->handle);
>  	sev_asid_free(kvm);
> +
> +	kvfree(sev->page_enc_bmap);
>  }
>  
>  static void avic_vm_destroy(struct kvm *kvm)

Adding Cfir who flagged this kvfree().

Other freeing of sev->page_enc_bmap in this patch also set 
sev->page_enc_bmap_size to 0 and neither set sev->page_enc_bmap to NULL 
after freeing it.

For extra safety, is it possible to sev->page_enc_bmap = NULL anytime the 
bitmap is kvfreed?

> @@ -2084,6 +2088,7 @@ static void avic_set_running(struct kvm_vcpu *vcpu, bool is_run)
>  
>  static void svm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
>  {
> +	struct kvm_sev_info *sev = &to_kvm_svm(vcpu->kvm)->sev_info;
>  	struct vcpu_svm *svm = to_svm(vcpu);
>  	u32 dummy;
>  	u32 eax = 1;
> @@ -2105,6 +2110,12 @@ static void svm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
>  
>  	if (kvm_vcpu_apicv_active(vcpu) && !init_event)
>  		avic_update_vapic_bar(svm, APIC_DEFAULT_PHYS_BASE);
> +
> +	/* reset the page encryption bitmap */
> +	if (sev_guest(vcpu->kvm)) {
> +		kvfree(sev->page_enc_bmap);
> +		sev->page_enc_bmap_size = 0;
> +	}
>  }
>  
>  static int avic_init_vcpu(struct vcpu_svm *svm)

What is protecting sev->page_enc_bmap and sev->page_enc_bmap_size in calls 
to svm_vcpu_reset()?
