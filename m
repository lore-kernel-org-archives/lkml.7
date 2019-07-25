Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E51C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C365A22C7B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729266AbfGYQaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 12:30:14 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50305 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbfGYQaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:30:14 -0400
Received: by mail-wm1-f68.google.com with SMTP id v15so45589847wml.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 09:30:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TJee9iv3dQfcDC0wZilFBJPLTspmLKcTYUWHZ1YT3mc=;
        b=aO/9to+ETgpgGDszchqQmlCeaXubjuHsW9eWZMJW3Yo9kBi3eRCzeSKBgzbOFOVRuk
         OOa/42lNED94lIXmKsRSQc9zmIR7ebmNPHt15dMmcVfxmr2Kz///3zLx6san+KqWEmYe
         7oR+jZzVnay5IE7q645OyV6fRXsAfXRwKFtPfD08zap+UGWonQLKmhOu0aHGWiAn3lVY
         0v257MZoyaGkS8C+JTDcRRICz4ew2B4UDVesdcH/5eqoXPPEf4GBwEwTU32X7tsPbgYH
         FllAVl6nnu3+VPhLWj5gjYOcHYnASDh3MDtAQt7M3AUO5yYtNXrSkeKPLydz7zLJPJch
         IxKg==
X-Gm-Message-State: APjAAAW8wSQV2SLB2B2+gZd97iepb6OUXqVAH+4RYEeNEAjTE+UZ9SOJ
        Buk0S/S+uEIxbt8w2i46m9it9Q==
X-Google-Smtp-Source: APXvYqz9H3fBrmL3D9ICTqPd7Cn3mBSxvMw7jKETUjOZrtGbOupCF836qSCXTQ6/2qzyFiNuDh5JjQ==
X-Received: by 2002:a1c:200a:: with SMTP id g10mr75279624wmg.160.1564072212129;
        Thu, 25 Jul 2019 09:30:12 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:cc23:f353:392:d2ee? ([2001:b07:6468:f312:cc23:f353:392:d2ee])
        by smtp.gmail.com with ESMTPSA id v18sm54143073wrs.80.2019.07.25.09.30.11
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 09:30:11 -0700 (PDT)
Subject: Re: [PATCH 5.2 000/413] 5.2.3-stable review
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        wanpengli@tencent.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        patches@kernelci.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>, jmattson@google.com
References: <20190724191735.096702571@linuxfoundation.org>
 <CADYN=9+WLxhmqX3JNL_s-kWSN97G=8WhD=TF=uAuKecJnKcj_Q@mail.gmail.com>
 <20190725113437.GA27429@kroah.com>
 <230a5b34-d23e-8318-0b1f-d23ada7318e0@redhat.com>
 <CA+G9fYsWdmboyquZ=Bs3tkTwRFTzd1yuL0_EVpHOecNi4E_stA@mail.gmail.com>
 <20190725160939.GC18612@linux.intel.com>
 <33f1cfaa-525d-996a-4977-fda32dc368ee@redhat.com>
 <20190725162053.GD18612@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <7bc207e0-0812-e41a-bfd5-e3fbfd43f242@redhat.com>
Date:   Thu, 25 Jul 2019 18:30:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190725162053.GD18612@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/07/19 18:20, Sean Christopherson wrote:
> On Thu, Jul 25, 2019 at 06:10:37PM +0200, Paolo Bonzini wrote:
>> On 25/07/19 18:09, Sean Christopherson wrote:
>>>> This investigation confirms it is a new test code failure on stable-rc 5.2.3
>>> No, it only confirms that kvm-unit-tests/master fails on 5.2.*.  To confirm
>>> a new failure in 5.2.3 you would need to show a test that passes on 5.2.2
>>> and fails on 5.2.3.
>>
>> I think he meant "a failure in new test code". :)
> 
> Ah, that does appear to be the case.  So just to be clear, we're good, right?

Yes.  I'm happy to gather ideas on how to avoid this (i.e. 1) if a
submodule would be useful; 2) where to stick it).

Paolo
