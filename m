Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D9CC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84BCD217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388262AbfGYRGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 13:06:25 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50832 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388079AbfGYRGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 13:06:24 -0400
Received: by mail-wm1-f65.google.com with SMTP id v15so45680120wml.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 10:06:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CYZmvdyjmQ9Y20lUl3LbpkZAg1UJeTYKaJ8xSu9KeRU=;
        b=r5OS9LczrbLyxXnogLx4yhfY/HoYRK1CnL/1LHGS6Tz4HffdYfSouuIWvxm+hGWXxO
         q4cmTAZl/A9mYDdBcJZMAGied7U1HsBF6Z5uyjCHoDG2Wals2XMa3ZxKFPy5o/2PevLm
         deLi1wFNYlPOXv37ZdCuJVLOPFW3KEtAcjImzshlWlcnsXV7JJXLZTh/NMzuY2kcPyT7
         L3+PKEsgbyfLsqR3QJKiB1tx9d/Lnng6Vu4k0e1KINtjfgio9YUp+WiOfUgOS2Rfsr+y
         sBoEDFvQfPP3xzzHcg0bgDiL1Apeav4iYvLGbwlZ80CT5JW7vXLW2wSPnm5JLc7fFFZU
         CBcA==
X-Gm-Message-State: APjAAAXY2ZjSLZPq6GSgmEezAyIjni9B2OB/9dFzWEu4jf8XMZCAsJ9c
        eYMf4lc3KlZy4j+07musf3pniw==
X-Google-Smtp-Source: APXvYqwbvdA1XCrnqMaxgyn3o22zds3kQexwwJkjRqOZdIaK3sdDC0Fu9DQ32DUvi/qqPCP70bshLg==
X-Received: by 2002:a7b:c7d8:: with SMTP id z24mr81271885wmk.10.1564074381887;
        Thu, 25 Jul 2019 10:06:21 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:cc23:f353:392:d2ee? ([2001:b07:6468:f312:cc23:f353:392:d2ee])
        by smtp.gmail.com with ESMTPSA id y16sm102602666wrg.85.2019.07.25.10.06.20
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 10:06:21 -0700 (PDT)
Subject: Re: [PATCH 5.2 000/413] 5.2.3-stable review
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
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
 <7bc207e0-0812-e41a-bfd5-e3fbfd43f242@redhat.com>
 <20190725163946.xt2p3pvxwuabzojj@xps.therub.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <3e55414d-cb4f-8f3f-a359-e374b6298715@redhat.com>
Date:   Thu, 25 Jul 2019 19:06:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190725163946.xt2p3pvxwuabzojj@xps.therub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/07/19 18:39, Dan Rue wrote:
> To your point Paolo - reporting 'fail' because of a missing kernel
> feature is a generic problem we see across test suites, and causes tons
> of pain and misery for CI people. As a general rule, I'd avoid
> submodules, and even branches that track specific kernels. Rather, and I
> don't know if it's possible in this case, but the best way to manage it
> from both a test author and a test runner POV is to wrap the test in
> kernel feature checks, kernel version checks, kernel config checks, etc.
> Report 'skip' if the environment in which the test is running isn't
> sufficient to run the test. Then, you only have to maintain one version
> of the test suite, users can always use the latest, and critically: all
> failures are actual failures.

Note that kvm-unit-tests are not really testing new kernel features;
those are covered by tools/testing/selftests/kvm.  For some of these
kvm-unit-tests there are some CPU features that we can check from the
virtual machine, but those are easy to handle and they produce SKIP
results just fine.

The problematic ones are tests that cover emulation accuracy.  These are
effectively bugfixes, so the failures you see _are_ actual failures.  At
the same time, the bugs are usually inoffensive(*), while the fixes are
invasive and a bad source of cause conflicts in older Linux versions.
This combines so that backporting to stable is not feasible.

Passing the host kernel version would be really ugly because 1) the
tests can run on other hypervisor or emulators or even bare metal, and
of course the host kernel version has no bearing if you're using
userspace emulation 2) there are thousands of tests that would be
littered with kernel version checks of little significance.

So this is why I suggested a submodule: using a submodule effectively
ignores all tests that were added after a given Linus release, and thus
all the failures for which backports are just not going to happen.
However, if Sean's idea of creating a linux-M.N branch in
kvm-unit-tests.git works for you, we can also do that as a stopgap
measure to ease your testing.

Thanks,

Paolo

(*) if they aren't, we *do* mark them for backport!
