Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B07C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 09:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B34D720637
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 09:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Taai8JJO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbfLDJmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 04:42:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59160 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726632AbfLDJmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 04:42:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575452552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yeu2jri5tiEVORSR6i6yLjnJmv9GRGrMpUSNBJnPLoo=;
        b=Taai8JJOseRjyu1w+fUEQCvxKE4ytZSufR5jjTzMCzHTFJ9qKTnPIfnzPWDV6ZKmiJZXwJ
        NesxDDiv4yOa1TYL0FsErSgitSNGlhByymrQUAT0ZyNUGKHPeIMHbSYifRA9AOPqPoFzc+
        9osKgQSsSokxR6fKchCNlj7QEuv/OQ0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-Gv6gbTJFMRmHookLKMdmCQ-1; Wed, 04 Dec 2019 04:42:31 -0500
Received: by mail-wr1-f71.google.com with SMTP id v17so3351956wrm.17
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 01:42:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Yeu2jri5tiEVORSR6i6yLjnJmv9GRGrMpUSNBJnPLoo=;
        b=hKEL1y+6F43evQ0t6ozwr+A79J1dFqxENVA/WKPRYK/qDNDgRzC8zU0BCKAuOJq/b5
         eWn0GrWvOQ5LmkyWmwUQ6NE+GdPPpZvNVMH6Od/jxs7kG84N2a+4N9vLL2sbl9BUKzMG
         R5QbA+BdGKngX0UezoVDLESY6ZEyrZS+pPHNglHbofyT+WFD1jd7dqgmbO6AFMRlE23v
         0QILk1JCXJ4GL1tZ7WoBgJztm+RLsYOjyTp5G6vwz3hpgwZwgHtWchq2PWZW0Mgvv/et
         Tq/IyYLkkHmMtFVEJoXNG52STymYkbYy5JQc3Tq6vJVZ0cL4wUunQYfkkCwOGim8hQsI
         ZE3A==
X-Gm-Message-State: APjAAAX7CDhhaRFHQ1jCc25bn84pFQVk8GwwIwQvDzIr/G9ECV7Uhl4x
        rjxx0+9YF6XH2swixLo0xjAuyjmfXRrcZPr7aSyFvBIB3QFEytxDm5lx6zciiAHt6Dl3iBciNHe
        kf6ZOuvpfX9fYLU0vi6QO2t06
X-Received: by 2002:a5d:4a91:: with SMTP id o17mr3152705wrq.232.1575452550106;
        Wed, 04 Dec 2019 01:42:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqwc0V9i5e3LV/9uQON1wDN8u/+wYDBDXJVfstcq/t3k86JPELREp5McTHLyZgS2EnO20PNKuw==
X-Received: by 2002:a5d:4a91:: with SMTP id o17mr3152639wrq.232.1575452549489;
        Wed, 04 Dec 2019 01:42:29 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:8dc6:5dd5:2c0a:6a9a? ([2001:b07:6468:f312:8dc6:5dd5:2c0a:6a9a])
        by smtp.gmail.com with ESMTPSA id v3sm7236647wru.32.2019.12.04.01.42.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2019 01:42:29 -0800 (PST)
Subject: Re: [PATCH RFC 01/15] KVM: Move running VCPU from ARM to common code
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
References: <20191129213505.18472-1-peterx@redhat.com>
 <20191129213505.18472-2-peterx@redhat.com>
 <20191203190126.GC19877@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a9d3301c-4c2f-9624-dc52-1033b940ef06@redhat.com>
Date:   Wed, 4 Dec 2019 10:42:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191203190126.GC19877@linux.intel.com>
Content-Language: en-US
X-MC-Unique: Gv6gbTJFMRmHookLKMdmCQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/12/19 20:01, Sean Christopherson wrote:
> In case it was clear, I strongly dislike adding kvm_get_running_vcpu().
> IMO, it's a unnecessary hack.  The proper change to ensure a valid vCPU is
> seen by mark_page_dirty_in_ring() when there is a current vCPU is to
> plumb the vCPU down through the various call stacks.  Looking up the call
> stacks for mark_page_dirty() and mark_page_dirty_in_slot(), they all
> originate with a vcpu->kvm within a few functions, except for the rare
> case where the write is coming from a non-vcpu ioctl(), in which case
> there is no current vCPU.
> 
> The proper change is obviously much bigger in scope and would require
> touching gobs of arch specific code, but IMO the end result would be worth
> the effort.  E.g. there's a decent chance it would reduce the API between
> common KVM and arch specific code by eliminating the exports of variants
> that take "struct kvm *" instead of "struct kvm_vcpu *".

It's not that simple.  In some cases, the "struct kvm *" cannot be
easily replaced with a "struct kvm_vcpu *" without making the API less
intuitive; for example think of a function that takes a kvm_vcpu pointer
but then calls gfn_to_hva(vcpu->kvm) instead of the expected
kvm_vcpu_gfn_to_hva(vcpu).

That said, looking at the code again after a couple years I agree that
the usage of kvm_get_running_vcpu() is ugly.  But I don't think it's
kvm_get_running_vcpu()'s fault, rather it's the vCPU argument in
mark_page_dirty_in_slot and mark_page_dirty_in_ring that is confusing
and we should not be adding.

kvm_get_running_vcpu() basically means "you can use the per-vCPU ring
and avoid locking", nothing more.  Right now we need the vCPU argument
in mark_page_dirty_in_ring for kvm_arch_vcpu_memslots_id(vcpu), but that
is unnecessary and is the real source of confusion (possibly bugs too)
if it gets out of sync.

Instead, let's add an as_id field to struct kvm_memory_slot (which is
trivial to initialize in __kvm_set_memory_region), and just do

	as_id = slot->as_id;
	vcpu = kvm_get_running_vcpu();

in mark_page_dirty_in_ring.

Paolo

