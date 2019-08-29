Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494E8C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 02:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B351205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 02:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfH2CHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 22:07:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42556 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbfH2CHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 22:07:48 -0400
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C086F19CF89
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 02:07:47 +0000 (UTC)
Received: by mail-pf1-f200.google.com with SMTP id 22so1216268pfn.22
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 19:07:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UTtKaYO8o58VEORaJUygfO/C/Qe47dsETN2hRJwgzxg=;
        b=nep/LneIpDAMMY08avo08eRvk5R//HOfyNXYTursqTBrohm2itmEmwiXp036UK+gKG
         ZAeJbYI79VQQG3A3nGt3aMlRDDMGFIb4bzB+vzyoLKJVBeeZZmR6d32M34zKDsjHKRLA
         +fWmZwY6UElz7n02C6e2MoKWytweZqZJY2bi0TMpMZB03OkQJz1I6oJ95yB2F+d+s+aq
         JNx8PxxY0R5z8peR+TaDvY3Aqxrth4VnVbEwG35BD1nolscjl+7/A/4rQZWA3g3wEhLw
         3jZZsk2BtzgIDQ0Wk4zd/q/nnxmEeBBgXXI0bhFrOuDy1g5KzCv4kxulpBqXVErR5x+k
         DIvQ==
X-Gm-Message-State: APjAAAXVv9SMCiQjb1fhWY6SvrNqDzQIihudxIR2wrTA6+TjsOZ2yksD
        61LIzOZ2SK/UC4QcUW8bYrPF2C3yvaWZ1kWBN4hhoEreTTB+3B8G85fg0vaYn26b9AvqFJo5mO6
        7wRGJideVFN1RzO7YTnzJJQJG
X-Received: by 2002:a17:902:e85:: with SMTP id 5mr7690876plx.16.1567044465653;
        Wed, 28 Aug 2019 19:07:45 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy1v0THXMa4o8JzVoqol5UIv4TY6YkL5ICskh6qbw7hwVx/XkLZASaMg3qfmccT4+NHQppfLA==
X-Received: by 2002:a17:902:e85:: with SMTP id 5mr7690860plx.16.1567044465445;
        Wed, 28 Aug 2019 19:07:45 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id e6sm856619pfl.37.2019.08.28.19.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 19:07:44 -0700 (PDT)
Date:   Thu, 29 Aug 2019 10:07:34 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Andrew Jones <drjones@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 3/4] KVM: selftests: Introduce VM_MODE_PXXV48_4K
Message-ID: <20190829020734.GF8729@xz-x1>
References: <20190827131015.21691-1-peterx@redhat.com>
 <20190827131015.21691-4-peterx@redhat.com>
 <20190828114104.wvqdhvapf774ivq2@kamzik.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190828114104.wvqdhvapf774ivq2@kamzik.brq.redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 01:41:04PM +0200, Andrew Jones wrote:

[...]

> > +#define DEBUG printf
> 
> If this is going to be some general thing, then maybe we should do it
> like this
> 
> #ifndef NDEBUG
> #define dprintf printf
> #endif

Ok.

> 
> 
> > +
> >  /* Minimum allocated guest virtual and physical addresses */
> >  #define KVM_UTIL_MIN_VADDR		0x2000
> >  
> > @@ -38,12 +40,19 @@ enum vm_guest_mode {
> >  	VM_MODE_P48V48_64K,
> >  	VM_MODE_P40V48_4K,
> >  	VM_MODE_P40V48_64K,
> > +	VM_MODE_PXXV48_4K,	/* For 48bits VA but ANY bits PA */
> >  	NUM_VM_MODES,
> >  };
> >  
> >  #ifdef __aarch64__
> >  #define VM_MODE_DEFAULT VM_MODE_P40V48_4K
> > -#else
> > +#endif
> > +
> > +#ifdef __x86_64__
> > +#define VM_MODE_DEFAULT VM_MODE_PXXV48_4K
> > +#endif
> > +
> > +#ifndef VM_MODE_DEFAULT
> >  #define VM_MODE_DEFAULT VM_MODE_P52V48_4K
> >  #endif
> 
> nit: how about
> 
> #if defined(__aarch64__)
> ...
> #elif defined(__x86_64__)
> ...
> #else
> ...
> #endif

Yes, better!

> 
> >  
> > diff --git a/tools/testing/selftests/kvm/lib/aarch64/processor.c b/tools/testing/selftests/kvm/lib/aarch64/processor.c
> > index 486400a97374..86036a59a668 100644
> > --- a/tools/testing/selftests/kvm/lib/aarch64/processor.c
> > +++ b/tools/testing/selftests/kvm/lib/aarch64/processor.c
> > @@ -264,6 +264,9 @@ void aarch64_vcpu_setup(struct kvm_vm *vm, int vcpuid, struct kvm_vcpu_init *ini
> >  	case VM_MODE_P52V48_4K:
> >  		TEST_ASSERT(false, "AArch64 does not support 4K sized pages "
> >  				   "with 52-bit physical address ranges");
> > +	case VM_MODE_PXXV48_4K:
> > +		TEST_ASSERT(false, "AArch64 does not support 4K sized pages "
> > +				   "with ANY-bit physical address ranges");
> >  	case VM_MODE_P52V48_64K:
> >  		tcr_el1 |= 1ul << 14; /* TG0 = 64KB */
> >  		tcr_el1 |= 6ul << 32; /* IPS = 52 bits */
> > diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> > index 0c7c4368bc14..8c6f872a8793 100644
> > --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> > +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> > @@ -8,6 +8,7 @@
> >  #include "test_util.h"
> >  #include "kvm_util.h"
> >  #include "kvm_util_internal.h"
> > +#include "processor.h"
> >  
> >  #include <assert.h>
> >  #include <sys/mman.h>
> > @@ -101,12 +102,13 @@ static void vm_open(struct kvm_vm *vm, int perm)
> >  }
> >  
> >  const char * const vm_guest_mode_string[] = {
> > -	"PA-bits:52, VA-bits:48, 4K pages",
> > -	"PA-bits:52, VA-bits:48, 64K pages",
> > -	"PA-bits:48, VA-bits:48, 4K pages",
> > -	"PA-bits:48, VA-bits:48, 64K pages",
> > -	"PA-bits:40, VA-bits:48, 4K pages",
> > -	"PA-bits:40, VA-bits:48, 64K pages",
> > +	"PA-bits:52,  VA-bits:48, 4K pages",
> > +	"PA-bits:52,  VA-bits:48, 64K pages",
> > +	"PA-bits:48,  VA-bits:48, 4K pages",
> > +	"PA-bits:48,  VA-bits:48, 64K pages",
> > +	"PA-bits:40,  VA-bits:48, 4K pages",
> > +	"PA-bits:40,  VA-bits:48, 64K pages",
> > +	"PA-bits:ANY, VA-bits:48, 4K pages",
> 
> nit: while formatting we could align the 'K's in the 64/4K column

Ok.

> 
> >  };
> >  _Static_assert(sizeof(vm_guest_mode_string)/sizeof(char *) == NUM_VM_MODES,
> >  	       "Missing new mode strings?");
> > @@ -185,6 +187,32 @@ struct kvm_vm *_vm_create(enum vm_guest_mode mode, uint64_t phy_pages,
> >  		vm->page_size = 0x10000;
> >  		vm->page_shift = 16;
> >  		break;
> > +	case VM_MODE_PXXV48_4K:
> > +#ifdef __x86_64__
> > +		{
> > +			struct kvm_cpuid_entry2 *entry;
> > +
> > +			/* SDM 4.1.4 */
> > +			entry = kvm_get_supported_cpuid_entry(0x80000008);
> > +			if (entry) {
> > +				vm->pa_bits = entry->eax & 0xff;
> > +				vm->va_bits = (entry->eax >> 8) & 0xff;
> > +			} else {
> > +				vm->pa_bits = vm->va_bits = 32;
> > +			}
> > +			TEST_ASSERT(vm->va_bits == 48, "Linear address width "
> > +				    "(%d bits) not supported", vm->va_bits);
> > +			vm->pgtable_levels = 4;
> > +			vm->page_size = 0x1000;
> > +			vm->page_shift = 12;
> > +			DEBUG("Guest physical address width detected: %d\n",
> > +			      vm->pa_bits);
> > +		}
> 
> How about making this a function that lives in x86_64/processor.c?

Done.  Also I fixed up the overlooked PAE calculation which should be
36 rather than 32 bits PA.

> 
> > +#else
> > +		TEST_ASSERT(false, "VM_MODE_PXXV48_4K not supported on "
> > +			    "non-x86 platforms");
> 
> This should make the above aarch64_vcpu_setup() change unnecessary.

I tend to prefer keeping both because if some non-arm arch removed it
then aarch64 has another chance to assert.

Thanks,

-- 
Peter Xu
