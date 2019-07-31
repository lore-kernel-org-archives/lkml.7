Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E60C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 13:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E25E1206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 13:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbfGaNug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 09:50:36 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54397 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfGaNug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 09:50:36 -0400
Received: by mail-wm1-f65.google.com with SMTP id p74so60868837wme.4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 06:50:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=xiMsAjiDDo/ioi8HvaBXBSlL3/9tipDJZfJL08Je2vI=;
        b=tM0vIUw5rAtqO0JfZDNVsgCliqIKyoBUQEH81j5JWUdP/2DYHbAZcYXykCMdLOEZQS
         +x9Mn+nq7yBnPackGuCOWMP8wiJavSwZ38nuHFE1qnlztWTM0eIxepNzs+BTGSCOh4ep
         Qo807V7M/j7nOpkxoec+vXhPwArbgSIpEuNC+OV25CdiOejdvsCoaM/fzRzO6EbZnnbT
         EKq8i3ltauOlCOwc6GUZWY2Se/eJxyxffnFk+W9o5Jyyk76VcYM+Wup4O718KYoeDWdJ
         HcWfMIdHypt+qLTVeniw5BHzQNl9Il1/oh4Z2k0mp7OgY/b43/2bwmtZ8viZrFI2W/EA
         x/jQ==
X-Gm-Message-State: APjAAAWNBJnvZwqCIzPFsrAsk8i9+foSI6k6K85CQ4e1TAl+BXiZ9Vgi
        Kn4B0GpSISepxPBgWhI1Nz5BAA==
X-Google-Smtp-Source: APXvYqyHaBpgxxRj2uo8Nfd7YRV3VKghabyOA1q/9XZIpgUAeDUPX+n7PU6c96hFKkpOXsnROLRBBg==
X-Received: by 2002:a1c:2dd1:: with SMTP id t200mr287523wmt.1.1564581034087;
        Wed, 31 Jul 2019 06:50:34 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id y24sm49973593wmi.10.2019.07.31.06.50.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 06:50:33 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Jim Mattson <jmattson@google.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH RFC 3/5] x86: KVM: svm: clear interrupt shadow on all paths in skip_emulated_instruction()
In-Reply-To: <CALMp9eQ85h58NMDh-yOYvHN6_2f2T-wu63f+yLnNbwuG+p3Uvw@mail.gmail.com>
References: <20190620110240.25799-1-vkuznets@redhat.com> <20190620110240.25799-4-vkuznets@redhat.com> <CALMp9eQ85h58NMDh-yOYvHN6_2f2T-wu63f+yLnNbwuG+p3Uvw@mail.gmail.com>
Date:   Wed, 31 Jul 2019 15:50:32 +0200
Message-ID: <87ftmm71p3.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Mattson <jmattson@google.com> writes:

> On Thu, Jun 20, 2019 at 4:02 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>>
>> Regardless of the way how we skip instruction, interrupt shadow needs to be
>> cleared.
>
> This change is definitely an improvement, but the existing code seems
> to assume that we never call skip_emulated_instruction on a
> POP-SS/MOV-to-SS/STI. Is that enforced anywhere?

(before I send v1 of the series) I looked at the current code and I
don't think it is enforced, however, VMX version does the same and
honestly I can't think of a situation when we would be doing 'skip' for
such an instruction.... and there's nothing we can easily enforce from
skip_emulated_instruction() as we have no idea what the instruction
is... 

I can of course be totally wrong and would appreciate if someone more
knowledgeable chimes in :-)

-- 
Vitaly
