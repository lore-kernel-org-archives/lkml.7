Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B055C41514
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 20:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 632992086C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 20:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="CmT7V080"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731858AbfHOUJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 16:09:33 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33652 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730338AbfHOUJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 16:09:32 -0400
Received: by mail-ed1-f67.google.com with SMTP id s15so3234628edx.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 13:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4D//Pp/TZqR7m0Xv97rNg3iy0ay2HnnYAQiblL0c7eU=;
        b=CmT7V080W3Smj4f6SSsvHmEOQWnF4GETFSFq3IvUcnNcGNWvErFFsL2uEeiBfLM+46
         jMK+ENv9Dld8scKBu4CBOOhHkFs4f+CIhLozKz3Y3D11vmiE3n//aBlKGIlbCK91KQTh
         gjV1KlfcBPczUeWVPgWaRk1vGwxYBAtxZ8FrV/52/JaCaiYO7itpDazKUX+ZuYeSU2m4
         JlBDqdyLOv+JUBdkKvlC7MafQrI1C6df41qg2e4sW4uCtyWnfwIOypFjTUliBIKi0/Rf
         6OvlD768SyMmUmF+2G1hK7isEztqriN4UQPac+EOpFWqYgQgf629jrGxcE2/atBGcis7
         g9nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4D//Pp/TZqR7m0Xv97rNg3iy0ay2HnnYAQiblL0c7eU=;
        b=Mf1PrrXvxfBHqMEgIIgUKoRhqJk7EhDVDfq6MS82FlnjhUF8gx3NGiuQKpp3lQES4z
         KHVmVgJ4iXNJUqKqKthZI6/Gx2nOr+hA4Gazx0M39fR73iWgBSNYICc/BH7WsXn9YWLd
         rtcD7jsPgQU7o8mS5u1VhivlA2TP58SyPwxxl4ZuVVhvw3NyIALLiPrwsoqscTzc0m/m
         4BqptwZD5kUwE5U7dybYh7N0q/2gYDKr5HNn1coys2SDk3QHOkT03kjMuuF1zgLUhQ9t
         w1VDHd2gi3IkTsQ3PsN/LhQj5BOJNWWTWO5QCQoLsl+tXYsBP+3EZZt8TwO55zRs8P4b
         YSOg==
X-Gm-Message-State: APjAAAV4qR2n7amdnQY1t/XPk/ajEAGtcCm3Sstr9I87LMm9xHunIaV9
        Ym1fch8/cX6YrfQVQTwTTyv8J7GD//bl/mz89qqoOw==
X-Google-Smtp-Source: APXvYqzGHLppwWke0pO2++IwiTEdck9wvz9/d4REyeumkNmedLE2t/EbxCRGRK40pri6uiNjWD0D5KVt9eyzMCfdXIo=
X-Received: by 2002:a17:906:5409:: with SMTP id q9mr6256097ejo.209.1565899770715;
 Thu, 15 Aug 2019 13:09:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190801152439.11363-1-pasha.tatashin@soleen.com>
 <CA+CK2bADiBMEx9cJuXT5fQkBYFZAtxUtc7ZzjrNfEjijPZkPtw@mail.gmail.com> <ba8a2519-ed95-2518-d0e8-66e8e0c14ff5@arm.com>
In-Reply-To: <ba8a2519-ed95-2518-d0e8-66e8e0c14ff5@arm.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 15 Aug 2019 16:09:19 -0400
Message-ID: <CA+CK2bAqBi43Cchr=md7EPRuEWH-iuToK0PxN3ysSBQ42Hd0-g@mail.gmail.com>
Subject: Re: [PATCH v1 0/8] arm64: MMU enabled kexec relocation
To:     James Morse <james.morse@arm.com>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

Thank you for your feedback. My replies below:

> > Also, I'd appreciate if anyone could test this series on vhe hardware
> > with vhe kernel, it does not look like QEMU can emulate it yet
>
> This locks up during resume from hibernate on my AMD Seattle, a regular v8.0 machine.

Thanks for reporting a bug I will root cause and fix it.

> Please try and build the series to reduce review time. What you have here is an all-new
> page-table generation API, which you switch hibernate and kexec too. This is effectively a
> new implementation of hibernate and kexec. There are three things here that need review.
>
> You have a regression in your all-new implementation of hibernate. It took six months (and
> lots of review) to get the existing code right, please don't rip it out if there is
> nothing wrong with it.

> Instead, please just move the hibernate copy_page_tables() code, and then wire kexec up.
> You shouldn't need to change anything in the copy_page_tables() code as the linear map is
> the same in both cases.

It is not really an all-new implementation of hibernate (for kexec it
is true though). I used the current implementation of hibernate as
bases, and simply generalized the functions by providing a flexible
interface. So what you are asking is actually exactly what I am doing.
I realize, that I introduced a bug that I will fix.

> It looks like you are creating the page tables just after the kexec:segments have been
> loaded. This will go horribly wrong if anything changes between then and kexec time. (e.g.
> memory you've got mapped gets hot-removed).
> This needs to be done as late as possible, so we don't waste memory, and the world can't
> change around us. Reboot notifiers run before kexec, can't we do the memory-allocation there?

Kexec by design does not allow allocate during kexec time. This is
because we cannot fail during kexec syscall. All allocations must be
done during kexec load time. Kernel memory cannot be hot-removed, as
it is not part of ZONE_MOVABLE, and cannot be migrated.

The current implementation relies on this assumption as well: during
load time the (struct kimage) -> head contains the physical addresses
of sources and destinations. If sources can be moved, this array will
be broken.


> >> Previously:
> >> kernel shutdown 0.022131328s
> >> relocation      0.440510736s
> >> kernel startup  0.294706768s
> >>
> >> Relocation was taking: 58.2% of reboot time
> >>
> >> Now:
> >> kernel shutdown 0.032066576s
> >> relocation      0.022158152s
> >> kernel startup  0.296055880s
> >>
> >> Now: Relocation takes 6.3% of reboot time
> >>
> >> Total reboot is x2.16 times faster.
>
> When I first saw these numbers they were ~'0.29s', which I wrongly assumed was 29 seconds.
> Savings in milliseconds, for _reboot_ is a hard sell. I'm hoping that on the machines that
> take minutes to kexec we'll get numbers that make this change more convincing.

Sure, this userland is very small kernel+userland is only 47M. Here is
another data point: fitImage: 380M, it contains a larger userland.
The numbers for kernel shutdown and startup are the same as this is
the same kernel, but relocation takes: 3.58s

shutdown: 0.02s
relocation: 3.58s
startup:  0.30s

Relocation take 88% of reboot time. And, we must have it under one second.

Thank you,
Pasha
