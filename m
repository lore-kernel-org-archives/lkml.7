Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3968DFA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 10:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F37120650
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 10:16:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392317AbfJPKQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 06:16:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41314 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726645AbfJPKQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 06:16:47 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A6205793F4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 10:16:46 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id t11so11486173wro.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 03:16:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FqU17P1qR94N/PHEmxrZJeNNd2E82hqushMeG+PRQqM=;
        b=BVjC4KWtl83OxxomN8djpdmLKzQszHP+8J9D+fymLZXPbQXuWrtYgfjr3JfLWlfl2m
         lhSP3UOuJ7M4QIuAQq3znf4ScsybjsqCxFYvGFZzOK4kWde7bhg6zzcxgflvEtqbdOrr
         gXx9RSPaMLB0kX1bQ5NPJtS45X1VAfNHKSz2QHIT0NUdQoP3Xpjp7vpIaAojoFpNu4Qp
         t4N4Co5ybs0K2GTVTI5/HqopGmwnLqJaVd8SsIjRUIQiDfFTMB6kAh+QZ3gk6xhWzP/5
         U5ETPbPQiL72IBMuy1ebqz4gayeehZyzTEdyYatZgXGRY/UwIaxRyFuolcktepBPcKjD
         /VSg==
X-Gm-Message-State: APjAAAUqsajjwSJ0Qhs3I8++USU9d5+qAX56LFQ2i1vxb5C06MXlm/jg
        wsT07+vt542VW6+DRSiMCLre2+7EgSL4+6BsYWKP0P+i/U+ifqy/p5wvEgDEei5jzdx4sZ02LvT
        /wp38lzmtn76APb/LHlx2yNTl
X-Received: by 2002:a7b:ca54:: with SMTP id m20mr2832438wml.142.1571221005088;
        Wed, 16 Oct 2019 03:16:45 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzsIkx/eCnPYwYgdrORxF+fi7dWkpIzcQ1zHw9HznCWXeTkyvriGZUYtXynSytJfjZaCk3lLg==
X-Received: by 2002:a7b:ca54:: with SMTP id m20mr2832398wml.142.1571221004729;
        Wed, 16 Oct 2019 03:16:44 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d001:591b:c73b:6c41? ([2001:b07:6468:f312:d001:591b:c73b:6c41])
        by smtp.gmail.com with ESMTPSA id u11sm1878652wmd.32.2019.10.16.03.16.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2019 03:16:44 -0700 (PDT)
Subject: Re: [PATCH v9 09/17] x86/split_lock: Handle #AC exception for split
 lock
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
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
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, kvm@vger.kernel.org
References: <1560897679-228028-1-git-send-email-fenghua.yu@intel.com>
 <1560897679-228028-10-git-send-email-fenghua.yu@intel.com>
 <alpine.DEB.2.21.1906262209590.32342@nanos.tec.linutronix.de>
 <20190626203637.GC245468@romley-ivt3.sc.intel.com>
 <alpine.DEB.2.21.1906262338220.32342@nanos.tec.linutronix.de>
 <20190925180931.GG31852@linux.intel.com>
 <3ec328dc-2763-9da5-28d6-e28970262c58@redhat.com>
 <alpine.DEB.2.21.1910161142560.2046@nanos.tec.linutronix.de>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <57f40083-9063-5d41-f06d-fa1ae4c78ec6@redhat.com>
Date:   Wed, 16 Oct 2019 12:16:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1910161142560.2046@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/10/19 11:47, Thomas Gleixner wrote:
> On Wed, 16 Oct 2019, Paolo Bonzini wrote:
>> Just never advertise split-lock
>> detection to guests.  If the host has enabled split-lock detection,
>> trap #AC and forward it to the host handler---which would disable
>> split lock detection globally and reenter the guest.
> 
> Which completely defeats the purpose.

Yes it does.  But Sean's proposal, as I understand it, leads to the
guest receiving #AC when it wasn't expecting one.  So for an old guest,
as soon as the guest kernel happens to do a split lock, it gets an
unexpected #AC and crashes and burns.  And then, after much googling and
gnashing of teeth, people proceed to disable split lock detection.

(Old guests are the common case: you're a cloud provider and your
customers run old stuff; it's a workstation and you want to play that
game that requires an old version of Windows; etc.).

To save them the googling and gnashing of teeth, I guess we can do a
pr_warn_ratelimited on the first split lock encountered by a guest.  (It
has to be ratelimited because userspace could create an arbitrary amount
of guests to spam the kernel logs).  But the end result is the same,
split lock detection is disabled by the user.

The first alternative I thought of was:

- Remove KVM loading of MSR_TEST_CTRL, i.e. KVM *never* writes the CPU's
  actual MSR_TEST_CTRL.  KVM still emulates MSR_TEST_CTRL so that the
  guest can do WRMSR and handle its own #AC faults, but KVM doesn't
  change the value in hardware.

- trap #AC if the guest encounters a split lock while detection is
  disabled, and then disable split-lock detection in the host.

But I discarded it because it still doesn't do anything for malicious
guests, which can trigger #AC as they prefer.  And it makes things
_worse_ for sane guests, because they think split-lock detection is
enabled but they become vulnerable as soon as there is only one
malicious guest on the same machine.

In all of these cases, the common final result is that split-lock
detection is disabled on the host.  So might as well go with the
simplest one and not pretend to virtualize something that (without core
scheduling) is obviously not virtualizable.

Thanks,

Paolo

> 1) Sane guest
> 
> Guest kernel has #AC handler and you basically prevent it from
> detecting malicious user space and killing it. You also prevent #AC
> detection in the guest kernel which limits debugability.
> 
> 2) Malicious guest
> 
> Trigger #AC to disable the host detection and then carry out the DoS 
> attack.


