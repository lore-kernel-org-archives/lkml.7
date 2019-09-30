Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4AB5C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 15:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF55E20815
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 15:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731974AbfI3P2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 11:28:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52315 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731127AbfI3P2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 11:28:01 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 58C6D4628B
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 15:28:01 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id n3so6102402wmf.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 08:28:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=1hKWQ8fyjtR8kDPezJtQ9It33dYqosk+4D7m4oHWLsM=;
        b=DXxEMv1gGtSQi6camEPX2oxSSlnfChtsk/2gQK2UXMRxReU6vKFTyVX9saPydShl85
         W+LjapCIB1j0BmE9S+gA1TsC1ybqGQOejcGaGgUfhwtBynjWgSaQs8Vv01iDXU89ZNfQ
         dXXQ7PmzpI+lbMRzGbOKTwZy4uhcaBAf5V5YSvqL8V4s7Z2MMAy6Unq6T5zWKTHwso9u
         LFJs2B7KAK0BYyZ41c+ydnNTeSB0A700W0bcHFlWR0/T04pDPSUKdzfmgod9Dn+3DOWD
         pj3PlR0HLW907DrXmF+nzgs/AOWtEb6roWJViDvN58KPRWTCv7dhf4S2deizjokw3qWJ
         9qUQ==
X-Gm-Message-State: APjAAAUS0MEE+qKg/Q9UCfuOLa0byVEGHf5o+TukqSS8KGmTCbCQ6/Xa
        VQbOPo9RhgDSr3RrOkyAT+kk6P3FPl7Qnu3uWwswwHfrVDfHMPGatoYeyCArz+Lz9/S0P7n5SKi
        R5pKbyIKWtv70qnNJWpadd0Kg
X-Received: by 2002:a5d:66ce:: with SMTP id k14mr14425597wrw.258.1569857280057;
        Mon, 30 Sep 2019 08:28:00 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwQh4W43HEXgL9tL21uSH1S6sYMhC1NrfmFDMghmMierpsalTevwZVaciqHcGxptBzm4zyI7Q==
X-Received: by 2002:a5d:66ce:: with SMTP id k14mr14425579wrw.258.1569857279840;
        Mon, 30 Sep 2019 08:27:59 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id m62sm16269316wmm.35.2019.09.30.08.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 08:27:59 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Reto Buerki <reet@codelabs.ch>,
        Liran Alon <liran.alon@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH v2 8/8] KVM: x86: Fold decache_cr3() into cache_reg()
In-Reply-To: <20190930150430.GA14693@linux.intel.com>
References: <20190927214523.3376-1-sean.j.christopherson@intel.com> <20190927214523.3376-9-sean.j.christopherson@intel.com> <87a7am3v9u.fsf@vitty.brq.redhat.com> <20190930150430.GA14693@linux.intel.com>
Date:   Mon, 30 Sep 2019 17:27:58 +0200
Message-ID: <87y2y53itd.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> On Mon, Sep 30, 2019 at 12:58:53PM +0200, Vitaly Kuznetsov wrote:
>> Sean Christopherson <sean.j.christopherson@intel.com> writes:
>> 
>> > Handle caching CR3 (from VMX's VMCS) into struct kvm_vcpu via the common
>> > cache_reg() callback and drop the dedicated decache_cr3().  The name
>> > decache_cr3() is somewhat confusing as the caching behavior of CR3
>> > follows that of GPRs, RFLAGS and PDPTRs, (handled via cache_reg()), and
>> > has nothing in common with the caching behavior of CR0/CR4 (whose
>> > decache_cr{0,4}_guest_bits() likely provided the 'decache' verbiage).
>> >
>> > Note, this effectively adds a BUG() if KVM attempts to cache CR3 on SVM.
>> > Opportunistically add a WARN_ON_ONCE() in VMX to provide an equivalent
>> > check.
>> 
>> Just to justify my idea of replacing such occasions with
>> KVM_INTERNAL_ERROR by setting a special 'kill ASAP' bit somewhere:
>> 
>> This WARN_ON_ONCE() falls in the same category (IMO).
>
> Maybe something like KVM_BUG_ON?  E.g.:
>
> #define KVM_BUG_ON(kvm, cond)		\
> ({					\
> 	int r;				\
> 					\
> 	if (r = WARN_ON_ONCE(cond))	\
> 		kvm->vm_bugged = true;	\
> 	r;				\
> )}
> 	

Yes, that's more or less what I meant! (to me 'vm_bugged' sounds like
there was a bug in the VM but the bug is actually in KVM so maybe
something like 'kvm_internal_bug' to make it explicit?)

-- 
Vitaly
