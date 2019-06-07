Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48035C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 20:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 173E1208C0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 20:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559938610;
	bh=t/Vyv0uaKCis1VJG53gh7oHmtQRhMKw5HM16AnV9y1o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=UVPu5Ke5ghiR0w9HWz9jw8HuGU80Q5z+bB/IYMPRGQwVu6lSa1iUNFcmPmmeX/Q2/
	 TAHrhU187QAnx0ur7AN+0LEHDf3hXjLrkyloiJnJMV8g/O3qShlEVb3Mp9aju2BDbJ
	 K57iwHQfu5HKfJQK4BSrgOJahLxioCX2OamWihfQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730436AbfFGUQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 16:16:49 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33736 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729487AbfFGUQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 16:16:48 -0400
Received: by mail-lf1-f66.google.com with SMTP id y17so2549930lfe.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 13:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+IlYOcz6MNUONhjjBYHuT8/QTI8M6rG//OnFFoEPmts=;
        b=JamJvjNSga7wum4UHIzRpQ2ggGqR3TS0Ky3ghoX7KcWNz8Sk+A3tuB7WPgceeqShLW
         nkFVY32F//ZpHLDi01RoWYF0DRnMpUJfvGw13D4xRwu8fxepDRERdpAgOw7kRX4gPwDp
         1UYD90Jfac/Amyi8nekd0EYx6+jSjy9ePtfCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+IlYOcz6MNUONhjjBYHuT8/QTI8M6rG//OnFFoEPmts=;
        b=Kws2IpwwdDUDZP8GeXCSQxMo5OYjD7PnQRjdOSQG41IZ9Z31+heDSztCQUVTCRf5WQ
         92mbCTuePARVceI6n4KhTL44mHG4CwRxVhb8J1Tgi5sZlC0wOUf9ISDdCQ4Zksf7nyhT
         9WtbyesP6p9CkMbXYITjERg6SbQo8hQJfLtiwGOHKKXfHS54+UbfRNTYC2IVmdCQMJNZ
         2hy/qMdJiBqbfNBtc/c3EFAaQBrQ9xvLNvn+FljpWGwoN5DczhbKnyXu6hHWFPayYAsc
         7qN8v4MA+F/Ixc80wKBPPcZ3MzPz3CckqiYCETuobtKrn1QkErJGJWFjNFwD160HkWH3
         6aHg==
X-Gm-Message-State: APjAAAXu2Ose1YT8lPUzeAA2hP0i+7gmipKVucmzDb4Ft/HHV3NXC/Li
        7E0JMXPYi2/a//AVwaixeGJIGFxR2DlIOA==
X-Google-Smtp-Source: APXvYqx+hAAMBo7EN3VknH78kjWdDIN65u699S9BpENsrXqX4fXrxbNYDL4wUgg/bh4CFHDSH0Ixpw==
X-Received: by 2002:a05:6512:64:: with SMTP id i4mr4677157lfo.32.1559938606324;
        Fri, 07 Jun 2019 13:16:46 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id r76sm577053lfr.6.2019.06.07.13.16.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 13:16:46 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id k18so2790154ljc.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 13:16:45 -0700 (PDT)
X-Received: by 2002:a2e:4246:: with SMTP id p67mr29114030lja.44.1559938267141;
 Fri, 07 Jun 2019 13:11:07 -0700 (PDT)
MIME-Version: 1.0
References: <c8311f9b759e254308a8e57d9f6eb17728a686a7.1559649879.git.andreyknvl@google.com>
In-Reply-To: <c8311f9b759e254308a8e57d9f6eb17728a686a7.1559649879.git.andreyknvl@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 7 Jun 2019 13:10:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjKy5503vYoj3ZizGz69iBos69wdrEujojuri67vV=BVQ@mail.gmail.com>
Message-ID: <CAHk-=wjKy5503vYoj3ZizGz69iBos69wdrEujojuri67vV=BVQ@mail.gmail.com>
Subject: Re: [PATCH v2] uaccess: add noop untagged_addr definition
To:     Andrey Konovalov <andreyknvl@google.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        sparclinux@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Khalid Aziz <khalid.aziz@oracle.com>, enh <enh@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Christoph Hellwig <hch@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 4, 2019 at 5:04 AM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> Architectures that support memory tagging have a need to perform untagging
> (stripping the tag) in various parts of the kernel. This patch adds an
> untagged_addr() macro, which is defined as noop for architectures that do
> not support memory tagging.

Ok, applied directly to my tree so that people can use this
independently starting with rc4 (which I might release tomorrow rather
than Sunday because I have some travel).

                  Linus
