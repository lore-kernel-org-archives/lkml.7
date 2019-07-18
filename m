Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB60C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 13:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CD8A21841
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 13:18:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390385AbfGRNSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 09:18:55 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45477 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbfGRNSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 09:18:54 -0400
Received: by mail-wr1-f65.google.com with SMTP id f9so28634764wre.12
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 06:18:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mEVAjfkq7OMpRBKdhALaEN7JTbLll/ByQWI1BOsbqL8=;
        b=fTw6mqGWVW96n5pJ8dbP4DjHy7+TsI++yQNl8C139MFnruwNUv7vN44+ImuL1OY4OZ
         HhnI93h7AI/eieLGXgQovoYZ9Irx0mm0tozA7zVAaU9tXtsaS/y9+/hdahoCb3njTbed
         fZAr/8fsNyAYW7UzIXnSqZdeEpIepSbKHgKy4HPJP5+HxtkktRtj0jL2+RMz2PMQvtdL
         TAoBBFvY5FSVfx9TebZLqKPbtYLqd0gMAYdyBZ6C5jKUQzUTaIXd7U1eKmRV3mphse5M
         9IxUfEGwgjudLEnN9KRAg3CweamSZBjjiD+4Yk0TaDiRjKcRdkvg08n+Y+WCuDhC5j/r
         NaYw==
X-Gm-Message-State: APjAAAUdnD7ye/41FbioS+J19rUP/vI4CMQXAA6bJPnX5J2Q4lJrobxX
        vCd+ePKLa86eUjyOXkQz3R3xpw==
X-Google-Smtp-Source: APXvYqym+1/Te37GQsHiaf/NBjXwzk5+HxsedDWH52Azhd+jZ+GsMFR5zgvGB1TuWVoWqrSqFp9R5g==
X-Received: by 2002:adf:dd03:: with SMTP id a3mr2105031wrm.87.1563455932572;
        Thu, 18 Jul 2019 06:18:52 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e427:3beb:1110:dda2? ([2001:b07:6468:f312:e427:3beb:1110:dda2])
        by smtp.gmail.com with ESMTPSA id x20sm21036282wmc.1.2019.07.18.06.18.51
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 06:18:51 -0700 (PDT)
Subject: Re: [PATCH v2 04/22] x86/kvm: Don't call kvm_spurious_fault() from
 .fixup
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <cover.1563413318.git.jpoimboe@redhat.com>
 <64a9b64d127e87b6920a97afde8e96ea76f6524e.1563413318.git.jpoimboe@redhat.com>
 <65bbf58d-f88b-c7d6-523b-6e35f4972bf2@redhat.com>
 <20190718131654.GE28096@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <1b891612-18e6-48ed-cfb5-05e8aca79dcb@redhat.com>
Date:   Thu, 18 Jul 2019 15:18:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190718131654.GE28096@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/19 15:16, Sean Christopherson wrote:
>> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
>>
>> This has a side effect of adding a jump in a generally hot path, but
>> let's hope that the speculation gods for once help us.
> Any reason not to take the same approach as vmx_vmenter() and ud2 directly
> from fixup?  I've never found kvm_spurious_fault() to be all that helpful,
> IMO it's a win win. :-)

Honestly I've never seen a backtrace from here but I would rather not
regret this when a customer encounters it...

Paolo
