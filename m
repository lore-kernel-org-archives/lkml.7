Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A93C742BA
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 13:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C619D2080A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 13:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbfGLNOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 09:14:14 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34427 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbfGLNON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 09:14:13 -0400
Received: by mail-wr1-f65.google.com with SMTP id 31so9977653wrm.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 06:14:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VfT/FB70SYUZvSibHy6qxOxJHNCuzEaHFG9lYiqHVks=;
        b=XDyCqClsFCX4P8N7DdrfueTc+QEck0hDVCBh4e82K8zR5CrgsgXhTCNQws235NPrN7
         gh1tBwudsOFfBgRhUiKs2n4YBDARRkW0iwRlUd1Z9yU55oHPqtU04fH9KmZvJJ3FdDLX
         ABl8yPZGgz3W5AdReW4HCIFTuWcr4SeXIaTQG8hscjkK5KFvIL5eU9//MktrCjadnMdv
         l+iasLAr0HQtKq2E2JNIZnbBXUEa35CPPirIbwgSKTvPxzIgbns+7xZ3XnKq5Tw7smta
         PVJLqZyERmk3wwUEruQwrSf/lZuRNXw5u7ThTzXoPT+of3NMbyW3pVdH6mIZaBv9gA5X
         qzMQ==
X-Gm-Message-State: APjAAAXN4lRtNZlUbcYQIhS+QLuc/suOcu/FEGNrTbaQxpZDpKemM9j9
        Z9Qh7JrIYrQsiA4uITfaEwFubQ==
X-Google-Smtp-Source: APXvYqxnCJN8ifBfaBldPbdVFdYWJmrV4AScCeUD8wYtYP4cKMb0VPikXLVesfil1bA6/91dAetwrw==
X-Received: by 2002:a5d:564e:: with SMTP id j14mr11365756wrw.1.1562937251761;
        Fri, 12 Jul 2019 06:14:11 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d066:6881:ec69:75ab? ([2001:b07:6468:f312:d066:6881:ec69:75ab])
        by smtp.gmail.com with ESMTPSA id b2sm10615526wrp.72.2019.07.12.06.14.10
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jul 2019 06:14:11 -0700 (PDT)
Subject: Re: [PATCH 1/2] x86: kvm: avoid -Wsometimes-uninitized warning
To:     Arnd Bergmann <arnd@arndb.de>, Roman Kagan <rkagan@virtuozzo.com>
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Liran Alon <liran.alon@oracle.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>
References: <20190712091239.716978-1-arnd@arndb.de>
 <20190712120249.GA27820@rkaganb.sw.ru>
 <CAK8P3a3+QSRQkitXiDFLYvyYvOS+Q4sXb=xA_XPeX2O2zQ5kgw@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <b7da5e91-f23c-9f5d-2c61-07e7fc7af9b1@redhat.com>
Date:   Fri, 12 Jul 2019 15:14:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3+QSRQkitXiDFLYvyYvOS+Q4sXb=xA_XPeX2O2zQ5kgw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/19 15:02, Arnd Bergmann wrote:
> I think what happens here is that clang does not treat the return
> code of track the return code of is_64_bit_mode() as a constant
> expression, and therefore assumes that the if() condition
> may or may not be true, for the purpose of determining whether
> the variable is used without an inialization. This would hold even
> if it later eliminates the code leading up to the if() in an optimization
> stage. IS_ENABLED(CONFIG_X86_64) however is a constant
> expression, so with the patch, it understands this.
> 
> In contrast, gcc seems to perform all the inlining first, and
> then see if some variable is used uninitialized in the final code.
> This gives additional information to the compiler, but makes the
> outcome less predictable since it depends on optimization flags
> and architecture specific behavior.
> 
> Both approaches have their own sets of false positive and false
> negative warnings.

True, on the other hand constant returns are not really rocket science. :)

Maybe change is_long_mode to a macro if !CONFIG_X86_64?  That would be
better if clang likes it.

Paolo
