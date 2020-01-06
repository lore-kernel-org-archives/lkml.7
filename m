Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8DFC3F68F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A083C2081E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QtjcFB+D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbgAFUTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 15:19:42 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:37307 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbgAFUTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 15:19:42 -0500
Received: by mail-io1-f67.google.com with SMTP id k24so19608606ioc.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 12:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8cEtudWCtdf6T3TMjKJwqF9jbkVULslZxeRKZ27Kc2s=;
        b=QtjcFB+DYa5pkgsRjodVAvu18u5iUIdjoDtsQfyPg0cR2KUvdk6NSqhCFic8jOgE8i
         +/atQtyFL2WCfmgZuTf8l1sdjJz4ad1dbppZzgdWM4JzY4jOr+oTqIY8jGd5pQBIL1Mx
         sAOhoZ4wnKAwncJdDWNTuHaq8q3S+jprxcKyvHnZSUFHERkZ2HW4lwVgfu5drNiPtk0m
         s9yGNQr32VnTU0zc3tX/3RIm2xxKtSX0p1u5O6RPGKYGaIk5GU6C9Vo4I+eBGp+42Cw1
         WYp4V5JGMW6YIAuyr9NTOmmOlJIVupTC5pDpOg/KpLc3wHzd/tAiJixszOZcFhEXI0jf
         MClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8cEtudWCtdf6T3TMjKJwqF9jbkVULslZxeRKZ27Kc2s=;
        b=l6jS9v6U9NKe9EqKy5g1DZrBk1GDTtPmAFtF0yUdw4bEPNae2PHWFvoEPsRV091CvN
         Wb+pTknzOQhlcrlq9QUlNKWxM1K51xGx4Ki4rvmZ3iFuD210iLpH6q4x4Lkwd6EFwHcq
         gCCjJ2ZO8lUkAHtHoOrHmWWA4NYt4r2Ua71Fc58jiEWEiLPb50ps4s9sy80iLyFnznf5
         u6+Y1jQfItrDipG+Wpo2uqSYdP3sjfHupf5F6MsHYl9AG2Pfy75gxilqrZ8WWJTOWR28
         97rNVDidgNfl86fN4A4s9REoFEohD4+2ROx4TzlzXZC3c5Z/0tVaINF1wTSsIivwHn+e
         86rg==
X-Gm-Message-State: APjAAAXsZkMJMQqPNAxxuvAn9uTJzxR4GPYKe0pzPhJKwXufHyIpmwr3
        iJELt4Qf9WhjGQCTHIWkAzQSjZfz2l/Rd2gIV2lp6g==
X-Google-Smtp-Source: APXvYqwB0MqyFY0NlYniQH2GAgfw3+4V5Y4bkxqU/VtEtdJT4o0YGAbxlFo4+429pMjJn1SvNXIHBzLCnfX1NSJTpLs=
X-Received: by 2002:a5d:9904:: with SMTP id x4mr68099509iol.119.1578341981709;
 Mon, 06 Jan 2020 12:19:41 -0800 (PST)
MIME-Version: 1.0
References: <20191211204753.242298-1-pomonis@google.com> <20191211204753.242298-13-pomonis@google.com>
In-Reply-To: <20191211204753.242298-13-pomonis@google.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Mon, 6 Jan 2020 12:19:30 -0800
Message-ID: <CALMp9eS+8kwmTyYDieNkhbRMBW-rkphKh4fmtV3X2d9XVh3U8Q@mail.gmail.com>
Subject: Re: [PATCH v2 12/13] KVM: x86: Protect DR-based index computations
 from Spectre-v1/L1TF attacks
To:     Marios Pomonis <pomonis@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nick Finco <nifi@google.com>, Andrew Honig <ahonig@google.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 12:49 PM Marios Pomonis <pomonis@google.com> wrote:
>
> This fixes a Spectre-v1/L1TF vulnerability in __kvm_set_dr() and
> kvm_get_dr().
> Both kvm_get_dr() and kvm_set_dr() (a wrapper of __kvm_set_dr()) are
> exported symbols so KVM should tream them conservatively from a security
> perspective.
>
> Fixes: commit 020df0794f57 ("KVM: move DR register access handling into generic code")
>
> Signed-off-by: Nick Finco <nifi@google.com>
> Signed-off-by: Marios Pomonis <pomonis@google.com>
> Reviewed-by: Andrew Honig <ahonig@google.com>
> Cc: stable@vger.kernel.org

Reviewed-by: Jim Mattson <jmattson@google.com>
