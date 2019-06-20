Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20DA8C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2E1A20656
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DflsZjsC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfFTStX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:49:23 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:46365 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbfFTStX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:49:23 -0400
Received: by mail-io1-f65.google.com with SMTP id i10so1003247iol.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 11:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=81FbK2MGDTB2Q0Lt6NRfym4JTD/ft6H2LYFu0+BpVcc=;
        b=DflsZjsCnlZp08kXiOJJ6An2xdgV238TPGSiu9uyyUsm9OkUN9/kKo8e1beLAXMUbS
         qYuVZwvv6dE53Bwjs0e/+mlKTcc4RWSX9KTRRYn7tsr6nz4atgpQDZIU1e7F3pQscX7V
         xeY02wHBTNOq5EPowL5/HcAv8R6jLa6CCxKMQJ+/h4GXoyINhupnIQvG2/ZKFFPKAo6E
         uiKgoJD2/9di1J8WllMZyF1MLZ0ycEF9Q/mch1G52EvvfcJIhzDnzc6lLgffnA53jaAS
         +ZoRG4bMQrNjoDucqSIPk6YNxGNuNctcvOf5l1pnh9ikc514sEfEv/sRTm7MHgbcUXgk
         ZoTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=81FbK2MGDTB2Q0Lt6NRfym4JTD/ft6H2LYFu0+BpVcc=;
        b=tp3bYdwk/44A4Pf1/BwthuDzC2F6SNz9hQYnGinPNPF6DRGvCZ7sF8tYB5KffUvRwQ
         4Ad4+JxXhz9shLrMW8O6eyrwOYVGSn+YIbYqxhOiG71CIJK03VSDiRVZaEn81+JGRPwq
         nRLI1f4kSSDymB3MN7beWmBh+anyExSwkbTq0pLCTtIGXewoPciePlg4A2sGMNmx4IgB
         cxeFlnQl582HEFvpdKi2BHmwQ481kkNk0Aynm6WSlIICTM3usK+u2wWHZz48Ck41El7k
         4XCpcOulYEs3dEWObFHbWD1FWjfahSNl6aqObXfuGwRXM79/VCbqzMWC4za4qMarAn1N
         C5JA==
X-Gm-Message-State: APjAAAWGbhRC+dilxYx7tdflGY6xpImgM99QEHg2WOsPssjs91ouHQOu
        6grJNSbK1FDbU+P9Okkkb8UDNHWbXXbXhxiJAhW3Ig==
X-Google-Smtp-Source: APXvYqw3T+wT6RqXErOCAGICJIb6qphtc1KJTX8sfmv5CUYrd3Eq+yqn3DloJYm0LiXeiKSznCHZUlDvmeyAD1VHIhA=
X-Received: by 2002:a6b:b40b:: with SMTP id d11mr10574591iof.122.1561056562075;
 Thu, 20 Jun 2019 11:49:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190620110240.25799-1-vkuznets@redhat.com> <20190620110240.25799-2-vkuznets@redhat.com>
In-Reply-To: <20190620110240.25799-2-vkuznets@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 20 Jun 2019 11:49:11 -0700
Message-ID: <CALMp9eTZSWA-7SOHS=2xrMKaXv_imKpURHGcDpfgusF+JDXFMg@mail.gmail.com>
Subject: Re: [PATCH RFC 1/5] x86: KVM: svm: don't pretend to advance RIP in
 case wrmsr_interception() results in #GP
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 4:02 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> svm->next_rip is only used by skip_emulated_instruction() and in case
> kvm_set_msr() fails we rightfully don't do that. Move svm->next_rip
> advancement to 'else' branch to avoid creating false impression that
> it's always advanced.
>
> By the way, rdmsr_interception() has it right already.

I think I actually prefer the current placement, because this allows
the code that's common to both kvm-amd.ko and kvm-intel.ko to be
hoisted into the vendor-agnostic kvm module. Also, this hard-coded '2'
should be going away, right?
