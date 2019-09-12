Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86480C5ACAE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 10:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63FBF20678
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 10:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731316AbfILKxz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 06:53:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54286 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731204AbfILKxz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 06:53:55 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DE9E1C0568FA
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 10:53:54 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id 4so1019962wmj.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 03:53:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=F2/22McNqXu2675zlE4drufzM0q9TuqFfPiUeK7sLs8=;
        b=KMgIv8yNAmGFjEK1qzxaWSP/03X93kTY99HLKBuBK3OCAMp2308RECT+Pwaj6ZSddy
         AjAKMWIfz/5mQa6JAGyH3pppHYnNHlnJ50jKFKf3dixkxWP3kLMbgnnNP8plP1xqy+ls
         eAh4Us1XZWHCaAwGiSHvQ0twrLZaTivyIZoWhVNbL7WhwPJAHatl/yzMDVMTimC2p4sT
         Mhpo4A9IyDqYsNc4pfO/qP2sT8m12NVFAYAjDOjGoXljvu2i6tRJSQL8hM0n8Cmj+Oz6
         ffJUYZfC94skurhG+auPM1CnbG1A8V7sv6/yfTl8jKTqfn9HxC2oOQvqwYEKGQEuAN/k
         QRnA==
X-Gm-Message-State: APjAAAXYKFC6o6OPp9RRNwRy1uIz5Yh7UfagvM/8EOrMHNf2Uz/cIA1f
        HmVuFnb0EVL7Tb797Ownxlve8h7dzvIhHVfy5cQtBrIq50T3V6s/qL447cO8bugugd6gJg6Yw5+
        DRtw9+fk1CFRwLhkhDIXzwpnE
X-Received: by 2002:adf:9c81:: with SMTP id d1mr18127712wre.123.1568285633424;
        Thu, 12 Sep 2019 03:53:53 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxxKcoyAmyDMGRGzHyI3ySQclYgNKAb2uu8KJpoZguHmsq7+ZolY8KGFJv9C6/WKJVkStMPqw==
X-Received: by 2002:adf:9c81:: with SMTP id d1mr18127684wre.123.1568285633189;
        Thu, 12 Sep 2019 03:53:53 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id c132sm6786713wme.27.2019.09.12.03.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2019 03:53:52 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kvm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] KVM: x86: work around leak of uninitialized stack contents
In-Reply-To: <CABXRUiTD=yRRQFfSdS=2e9QaO-PEgvZ=LBar927rL04G59nHxQ@mail.gmail.com>
References: <20190912041817.23984-1-huangfq.daxian@gmail.com> <87tv9hew2k.fsf@vitty.brq.redhat.com> <CABXRUiTD=yRRQFfSdS=2e9QaO-PEgvZ=LBar927rL04G59nHxQ@mail.gmail.com>
Date:   Thu, 12 Sep 2019 12:53:51 +0200
Message-ID: <87r24leqf4.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fuqian Huang <huangfq.daxian@gmail.com> writes:

> Vitaly Kuznetsov <vkuznets@redhat.com> 於 2019年9月12日週四 下午4:51寫道：
>>
>> Fuqian Huang <huangfq.daxian@gmail.com> writes:
>>
>> > Emulation of VMPTRST can incorrectly inject a page fault
>> > when passed an operand that points to an MMIO address.
>> > The page fault will use uninitialized kernel stack memory
>> > as the CR2 and error code.
>> >
>> > The right behavior would be to abort the VM with a KVM_EXIT_INTERNAL_ERROR
>> > exit to userspace;
>>
>> Hm, why so? KVM_EXIT_INTERNAL_ERROR is basically an error in KVM, this
>> is not a proper reaction to a userspace-induced condition (or ever).
>>
>> I also looked at VMPTRST's description in Intel's manual and I can't
>> find and explicit limitation like "this must be normal memory". We're
>> just supposed to inject #PF "If a page fault occurs in accessing the
>> memory destination operand."
>>
>> In case it seems to be too cumbersome to handle VMPTRST to MMIO and we
>> think that nobody should be doing that I'd rather prefer injecting #GP.
>>
>> Please tell me what I'm missing :-)
>
> I found it during the code review, and it looks like the problem the
> commit 353c0956a618 ("KVM: x86: work around leak of uninitialized
> stack contents (CVE-2019-7222)")
> mentions. So I fixed it in a similar way.
>

Oh, yes, I'm not against the fix at all, I was just wondering about why
you think we need to kill the guest in this case.

-- 
Vitaly
