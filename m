Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C4AC31E40
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 09:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10E24208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 09:24:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731323AbfHOJY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 05:24:29 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38260 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730204AbfHOJY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 05:24:28 -0400
Received: by mail-wm1-f67.google.com with SMTP id m125so725624wmm.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 02:24:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=x84LMNNTuJo9sta6FIQCvGMribLZzm6UX96aqLVwiNc=;
        b=eGYv/llvqJDoz7Blc4ZcHeakMQgE/ZtiTQTctp6xx92b3spYR1VgshCFpWQqAlhHFB
         YOvXL1xU90DF1j2UUXn1/q59UtAs4IPfhB2budU7kjsjgcttwvoDVwCVo890+qE4xoFs
         VMqpqxU/ZAUw2y97b9f1ne4mztcKpN/Zu6kP1zA/Q3rJHNW9TgB80HmGjjWwPVnBCEE5
         XTP/iRJ2Lelfh4E7XqXiNJs6LxV98uf00esqSEBQnueDG6BwXO30WGwNFnXFmfUV3We/
         232sOedAL6Mh1WWothDkvZGRriWmSXvz+lUvxqDXO3y45AN6qcmFRl3VlyKTefFqcYqe
         vDXA==
X-Gm-Message-State: APjAAAUPPWB6tuF0C7p8yoV5VlAs2tBTq9nypqbRxKdX8MAcssGIPRyt
        SXN4KaCRS8/0y8aipdFXVlxvJA==
X-Google-Smtp-Source: APXvYqx8qgEzJjuKDHGRJH3OXvRcljUB1bEcjCi+jKW6Fepk1pJNTIPKClD4tx/zHPFs5fNXuLh86Q==
X-Received: by 2002:a1c:61d4:: with SMTP id v203mr1865635wmb.164.1565861066691;
        Thu, 15 Aug 2019 02:24:26 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id p7sm989293wmh.38.2019.08.15.02.24.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 15 Aug 2019 02:24:26 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jim Mattson <jmattson@google.com>
Subject: Re: [PATCH v4 2/7] x86: kvm: svm: propagate errors from skip_emulated_instruction()
In-Reply-To: <20190815001952.GA24750@linux.intel.com>
References: <20190813135335.25197-1-vkuznets@redhat.com> <20190813135335.25197-3-vkuznets@redhat.com> <20190813180759.GF13991@linux.intel.com> <87d0h89jk3.fsf@vitty.brq.redhat.com> <20190815001952.GA24750@linux.intel.com>
Date:   Thu, 15 Aug 2019 11:24:25 +0200
Message-ID: <87wofe93xy.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> On Wed, Aug 14, 2019 at 11:34:52AM +0200, Vitaly Kuznetsov wrote:
>> Sean Christopherson <sean.j.christopherson@intel.com> writes:
>>
>> > x86_emulate_instruction() doesn't set vcpu->run->exit_reason when emulation
>> > fails with EMULTYPE_SKIP, i.e. this will exit to userspace with garbage in
>> > the exit_reason.
>> 
>> Oh, nice catch, will take a look!
>
> Don't worry about addressing this.  Paolo has already queued the series,
> and I've got a patch set waiting that purges emulation_result entirely
> that I'll post once your series hits kvm/queue.

Sometimes being slow and lazy pays off :-)

Thanks a lot!

-- 
Vitaly
