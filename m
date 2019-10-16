Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49718FA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 15:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29BC72168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 15:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393009AbfJPPn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 11:43:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41226 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728143AbfJPPnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 11:43:55 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6510D8535C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 15:43:55 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id 190so1383695wme.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 08:43:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nhY9YqzszUFd4RrH6E4lGS+ky+sUcMNkuo5x1ttpMi4=;
        b=npW6Z3B0P9GWfqUPoR4kFe6LSskF47uv7eyBciJjOzJxkI7KrZSA9Bcj6QAhK003Sk
         sJ5FAUoyt+naANpnMKDFFjNqq46zzRpH6GgBU8bYl7jiwoHu75YxR6M9zUTS87DNHMyu
         tCbXwYKvglDTP3Q0wMmQyvgpToPDeEgsYcNVxEcxp/QFOZPZj6bfLeS9yyWQUq7cSN4j
         228vAkZMsT8hEDunMrhgQiepfGNL778/ZsKaYtc/IfpBNqMqvk0/sW+vLhlegqjQbFug
         E3zpXBQzASyecnma5ScPh/SNdMqiSI4y6NeGq/ZAgNqTFdv1t/UfOWt9OX5CEZFcyPYd
         dmbA==
X-Gm-Message-State: APjAAAWGOYKxLKAUdLp6fOQJKi6AsUM4zbyl1igZBXdOPjaydT/grlt+
        WCHK61fak5ST9l4Y9kNg7+UGvha+zVOziJhTeAP8mfGXWjBRVr4lX/Kz9uqXawKcEWJo8YPPSRj
        IyuDazaSRKeSoF2SZ71rPIRl+
X-Received: by 2002:a05:6000:1c7:: with SMTP id t7mr3258852wrx.198.1571240633563;
        Wed, 16 Oct 2019 08:43:53 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx2W8txY71EldDBse2zN1F1PijCT+k7OzSblQA4BTfrwaQ8qF50czeeiiu6UijsFaW+yzCTXA==
X-Received: by 2002:a05:6000:1c7:: with SMTP id t7mr3258837wrx.198.1571240633280;
        Wed, 16 Oct 2019 08:43:53 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d001:591b:c73b:6c41? ([2001:b07:6468:f312:d001:591b:c73b:6c41])
        by smtp.gmail.com with ESMTPSA id h17sm2447959wmb.33.2019.10.16.08.43.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2019 08:43:52 -0700 (PDT)
Subject: Re: [PATCH v9 09/17] x86/split_lock: Handle #AC exception for split
 lock
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Xiaoyao Li <xiaoyao.li@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, kvm@vger.kernel.org
References: <20190626203637.GC245468@romley-ivt3.sc.intel.com>
 <alpine.DEB.2.21.1906262338220.32342@nanos.tec.linutronix.de>
 <20190925180931.GG31852@linux.intel.com>
 <3ec328dc-2763-9da5-28d6-e28970262c58@redhat.com>
 <alpine.DEB.2.21.1910161142560.2046@nanos.tec.linutronix.de>
 <57f40083-9063-5d41-f06d-fa1ae4c78ec6@redhat.com>
 <alpine.DEB.2.21.1910161244060.2046@nanos.tec.linutronix.de>
 <3a12810b-1196-b70a-aa2e-9fe17dc7341a@redhat.com>
 <b2c42a64-eb42-1f18-f609-42eec3faef18@intel.com>
 <d2fc3cbe-1506-94fc-73a4-8ed55dc9337d@redhat.com>
 <20191016154116.GA5866@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <d235ed9a-314c-705c-691f-b31f2f8fa4e8@redhat.com>
Date:   Wed, 16 Oct 2019 17:43:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191016154116.GA5866@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/10/19 17:41, Sean Christopherson wrote:
> On Wed, Oct 16, 2019 at 04:08:14PM +0200, Paolo Bonzini wrote:
>> SIGBUS (actually a new KVM_EXIT_INTERNAL_ERROR result from KVM_RUN is
>> better, but that's the idea) is for when you're debugging guests.
>> Global disable (or alternatively, disable SMT) is for production use.
> 
> Alternatively, for guests without split-lock #AC enabled, what if KVM were
> to emulate the faulting instruction with split-lock detection temporarily
> disabled?

Yes we can get fancy, but remember that KVM is not yet supporting
emulation of locked instructions.  Adding it is possible but shouldn't
be in the critical path for the whole feature.

How would you disable split-lock detection temporarily?  Just tweak
MSR_TEST_CTRL for the time of running the one instruction, and cross
fingers that the sibling doesn't notice?

Thanks,

Paolo

> The emulator can presumably handle all such lock instructions, and an
> unhandled instruction would naturally exit to userspace.
> 
> The latency of VM-Enter+VM-Exit should be enough to guard against DoS from
> a malicious guest.  KVM could also artificially rate-limit a guest that is
> generating copious amounts of split-lock #ACs.
> 

