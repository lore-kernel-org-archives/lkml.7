Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD67EC43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 12:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8C5421823
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 12:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h2L4BFik"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729404AbfLEMnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 07:43:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37367 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729117AbfLEMnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 07:43:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575549799;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q1WWgL8RuF7Fs6ltC0qLeONxSmgpXtqUlxEFsxvFm70=;
        b=h2L4BFikSImluv5NCO4YEZKZ/j4mlAJiQ0u6WWdISl7FwmVA3rMqBUTDp+Y955wsfhv52g
        H2s9x7mVvT9DLXe3esxEWjzFdnULQ/TNwMj0Q8pXvxS7bAozh8SQJLtSoxAjbua6YTW0YR
        QalTzyh/q/5WSZGcixRQ+yYMjlFG3Cg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-elPFAFaIMW6WOSTa7c8OAg-1; Thu, 05 Dec 2019 07:43:16 -0500
Received: by mail-wr1-f70.google.com with SMTP id j13so1470711wrr.20
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 04:43:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q1WWgL8RuF7Fs6ltC0qLeONxSmgpXtqUlxEFsxvFm70=;
        b=ZbdzfhxpeqYxsR04Sv1ynI5T1t92lXJKfGf2vHk8zHuIt49C7Zf/ThdGJBCgwjWBwR
         nOdpcclOrODB5L7At4fDw7KTdObhL5mtPl4FOvwZUPHB9L4vFXMqsc0uZfjAQCq3IJWB
         2p7DlWR/JH4YgO0TmeFqhhJEZYg2U8SzGg8+2QsqFNTXd4IPAjCVsrga2AipMPX9pnUq
         PyFD3YL+PqRMZbreZ+fUJLjELREyzGG3hfr0RkSJ+2JodS4YBFO27yhDoLcFcFc4rTIw
         XGHpVScnWD6ZVAFUOOOvNYipEXk0gtPm35HWPcGNyIJJALMcOUkvX9YiakktOTlGRVK1
         09vQ==
X-Gm-Message-State: APjAAAU+g6Np6eLETiv455NPhA+xMn0yd5LaWpFFpDRmH7SEA4GWhgqW
        NRscStWhisKRzwnaQuDjN8DUvgTY5RBv4lZbCbQgcs/PqnblPfl2WM4bjxGpW0vM1n4W/R42Oh3
        2La8w832263GbKeCQvp+17QCn
X-Received: by 2002:a7b:cf16:: with SMTP id l22mr5136174wmg.79.1575549795077;
        Thu, 05 Dec 2019 04:43:15 -0800 (PST)
X-Google-Smtp-Source: APXvYqxtlO4z7GX9u/dCNLdQj6viEVF9+IodBKkT+pZtFOZQY3Da/hnmj69WiiFuDi52LhUSCM+UcA==
X-Received: by 2002:a7b:cf16:: with SMTP id l22mr5136156wmg.79.1575549794833;
        Thu, 05 Dec 2019 04:43:14 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:541f:a977:4b60:6802? ([2001:b07:6468:f312:541f:a977:4b60:6802])
        by smtp.gmail.com with ESMTPSA id d10sm11953556wrw.64.2019.12.05.04.43.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2019 04:43:14 -0800 (PST)
Subject: Re: [PATCH v5 0/6] KVM: X86: Cleanups on dest_mode and headers
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Nitesh Narayan Lal <nitesh@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
References: <20191204190721.29480-1-peterx@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9359243b-eaaa-99aa-af75-371587e75eb5@redhat.com>
Date:   Thu, 5 Dec 2019 13:43:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191204190721.29480-1-peterx@redhat.com>
Content-Language: en-US
X-MC-Unique: elPFAFaIMW6WOSTa7c8OAg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I actually prefer 0 to APIC_DEST_NOSHORT, but who am I to complain if
someone else is actually cleaning things up.

Queued, thanks.

Paolo

On 04/12/19 20:07, Peter Xu wrote:
> v5:
> - rename param of ioapic_to_lapic_dest_mode to dest_mode_logical [Sean]
> - in patch 5, also do s/short_hand/shorthand/ for kvm_apic_match_dest [Vitaly]
> - one more r-b picked
> 
> v4:
> - address all comments from Vitaly, adding r-bs properly
> - added one more trivial patch:
>   "KVM: X86: Conert the last users of "shorthand = 0" to use macros"
> 
> v3:
> - address all the comments from both Vitaly and Sean
> - since at it, added patches:
>   "KVM: X86: Fix kvm_bitmap_or_dest_vcpus() to use irq shorthand"
>   "KVM: X86: Drop KVM_APIC_SHORT_MASK and KVM_APIC_DEST_MASK"
> 
> Each patch explains itself.
> 
> Please have a look, thanks.
> 
> Peter Xu (6):
>   KVM: X86: Fix kvm_bitmap_or_dest_vcpus() to use irq shorthand
>   KVM: X86: Move irrelevant declarations out of ioapic.h
>   KVM: X86: Use APIC_DEST_* macros properly in kvm_lapic_irq.dest_mode
>   KVM: X86: Drop KVM_APIC_SHORT_MASK and KVM_APIC_DEST_MASK
>   KVM: X86: Fix callers of kvm_apic_match_dest() to use correct macros
>   KVM: X86: Conert the last users of "shorthand = 0" to use macros
> 
>  arch/x86/include/asm/kvm_host.h |  5 +++++
>  arch/x86/kvm/hyperv.c           |  1 +
>  arch/x86/kvm/ioapic.c           | 24 +++++++++++++++---------
>  arch/x86/kvm/ioapic.h           |  6 ------
>  arch/x86/kvm/irq.h              |  3 +++
>  arch/x86/kvm/irq_comm.c         | 12 +++++++-----
>  arch/x86/kvm/lapic.c            |  9 +++------
>  arch/x86/kvm/lapic.h            |  9 +++++----
>  arch/x86/kvm/svm.c              |  4 ++--
>  arch/x86/kvm/x86.c              |  4 ++--
>  10 files changed, 43 insertions(+), 34 deletions(-)
> 

