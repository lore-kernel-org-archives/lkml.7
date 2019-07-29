Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE77C76192
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 09:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 744CB20693
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 09:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbfG2JaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 05:30:20 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41032 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727931AbfG2JaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 05:30:19 -0400
Received: by mail-wr1-f66.google.com with SMTP id c2so57809179wrm.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 02:30:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9avy5m8auN2z87gWKpbvtw9ce3O/3bqjjaiEc9X8IB4=;
        b=l0EBy8mRk0PZpNrnPM8xY/uRDq+soEJyuSoJMmNsmMlmeyK+xU4Uy513PH8z0h1X1k
         PYS1HaEQ0Ln7M3PyV+ISPjGHaq9wM4CSzGBOTflDpWLJar5q7GNKFjOACyUa8XlnR3Xs
         tU8ilaZvgVK/d4BJk25g5YgC6Afr5moxsmBT7Bne5FfnpNN+LIGeT2P8xhqGkpI8IfcP
         zpJpuND9Be5qkEUEVAD8BOsD+tmmOq71rAnTL0arK9PXyzG+6nvlplg1Xl5Nm/daM7Q3
         cqISDqthefPZnqO03Fv+INIX1dKt5aizDzco+SBY3yha5t7zEA6oHE4qH45qWwn7A/Q2
         NHrg==
X-Gm-Message-State: APjAAAUmohHiJuzVJk/YpUzs7kDECiBpK5KP3RNou7W7nUOogfZLal3J
        1L9bSxDs8pZ2K6ArYyhVu4zoSw==
X-Google-Smtp-Source: APXvYqy0ukqUzu8jgOYkuviFDoJUTuAF/SmhWh3Yh9peouGgMoj42CbJFnks9ZQse0UPz648OOpZQw==
X-Received: by 2002:adf:f28a:: with SMTP id k10mr41842741wro.343.1564392617641;
        Mon, 29 Jul 2019 02:30:17 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:29d3:6123:6d5f:2c04? ([2001:b07:6468:f312:29d3:6123:6d5f:2c04])
        by smtp.gmail.com with ESMTPSA id w24sm48173380wmc.30.2019.07.29.02.30.16
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 02:30:17 -0700 (PDT)
Subject: Re: [PATCH stable-4.19 1/2] KVM: nVMX: do not use dangling shadow
 VMCS after guest reset
To:     Jack Wang <jack.wang.usish@gmail.com>,
        Sasha Levin <sashal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>, stable@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <20190725104645.30642-1-vkuznets@redhat.com>
 <20190725104645.30642-2-vkuznets@redhat.com>
 <CA+res+RfqpT=g1QbCqr3OkHVzFFSAt3cfCYNcwqiemWmOifFxg@mail.gmail.com>
 <2ea5d588-8573-6653-b848-0b06d1f98310@redhat.com>
 <CA+res+ShqmPcJWj+0F7X8=0DM_ys8HCP+rjg4Nv-7o06EipJQw@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <471a1023-4f0a-5727-e7b2-48701f75188f@redhat.com>
Date:   Mon, 29 Jul 2019 11:30:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CA+res+ShqmPcJWj+0F7X8=0DM_ys8HCP+rjg4Nv-7o06EipJQw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/07/19 11:29, Jack Wang wrote:
> Thanks Paolo for confirmation. I'm asking because we had one incident
> in our production with 4.14.129 kernel,
> System is Skylake Gold cpu, first kvm errors, host hung afterwards
> 
> kernel: [1186161.091160] kvm: vmptrld           (null)/6bfc00000000 failed
> kernel: [1186161.091537] kvm: vmclear fail:           (null)/6bfc00000000
> kernel: [1186186.490300] watchdog: BUG: soft lockup - CPU#54 stuck for
> 23s! [qemu:16639]
> 
> Hi Sasha, hi Greg,
> 
> Would be great if you can pick this patch also to 4.14 kernel.

Acked-by: Paolo Bonzini <pbonzini@redhat.com>
