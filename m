Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F37C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 23:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2114620850
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 23:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d/mq2Rkw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfDJX1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 19:27:44 -0400
Received: from mail-vk1-f171.google.com ([209.85.221.171]:40102 "EHLO
        mail-vk1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfDJX1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 19:27:43 -0400
Received: by mail-vk1-f171.google.com with SMTP id l17so965748vke.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 16:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gNlKPyKG8+QtNce73/Iv5lOFma4r0K9qU8E9XvP2Jc0=;
        b=d/mq2RkwjH/zieHh3yaXl4fAgXqLQzmIqXqRsSzThUGDzWSawNIzYLSWf+yMcriAuF
         jQocb31jPcSY+7iOFq4j6sJK1CG4f2z1a35AnhDdew0cXY08ZjccG9HAzJelvXlmZ+zy
         KZnKq/5SR1OK4jq/kK0g4UBSbqqx2mG6Dl7XA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gNlKPyKG8+QtNce73/Iv5lOFma4r0K9qU8E9XvP2Jc0=;
        b=FzN5gBcsMu6qG2xDNVEfWY9uIWjkJ9a3skURPe/NUFHvWkw2KI5B6CIBxfMHP5tgjM
         lzUq651YTWvXcycCbAGA8tKUK77wtI/p3q34ELCpwZUv/N/SMjs9ujUBo6XFOFYFoC1/
         45YGYwxOb4WbhqWiQERa4AbtYNODntBu2txCzBk4VP52ipBU0iRj8EejuK0HWokEQS1Q
         ChJlkCqbau1m9qw5i5MMCVB117UQuut0bUI1paL/yJtkRQLohha5y4Kqt+hbmJ/dWd7x
         H0/pKDjxJfZS6VRXXUHQ/MR5KO4QIzM4pY/X0rNYJ9gzFiYWZLjQhsYpaLtjDwdDwyrJ
         yoZg==
X-Gm-Message-State: APjAAAVIz06NxSrYDkE4bLiyJvMP/y0onMDpfOgwakRJrLdBAQO15OR+
        P2qPgdO6jeT0b0KdFPoGAcbTPXvz+cU=
X-Google-Smtp-Source: APXvYqyu91hVNmZTefE7tLbe07wlREcUAC1/mHqMv3MybcJBF5iaYcjPPMyC3yjwA+UazAkXXlLYvQ==
X-Received: by 2002:a1f:860c:: with SMTP id i12mr26638522vkd.46.1554938861445;
        Wed, 10 Apr 2019 16:27:41 -0700 (PDT)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id u10sm17578457vku.34.2019.04.10.16.27.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 16:27:40 -0700 (PDT)
Received: by mail-vs1-f49.google.com with SMTP id g187so2394149vsc.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 16:27:40 -0700 (PDT)
X-Received: by 2002:a67:76c7:: with SMTP id r190mr27002454vsc.196.1554938859577;
 Wed, 10 Apr 2019 16:27:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAMuHMdWhx0-kspDyLOgTp+9udiBpkMHULSGyMg9uPPV16=FWQg@mail.gmail.com>
 <20190319170911.GB202956@gmail.com> <20190320185719.GB180195@gmail.com>
 <CAGXu5jL-5C1ZGZ1JgaNFqK-z1Pp1N1X8gD3_ysKTCa=omD+_VQ@mail.gmail.com>
 <20190321175122.GA1587@sol.localdomain> <20190410031734.GB7140@sol.localdomain>
 <CAGXu5j+SZ2+Zkc=Vp5CXQUHhiR9f_OOnca684JTRW3T0yXdaNQ@mail.gmail.com>
 <20190410190729.GA120258@gmail.com> <CAGXu5j+Gfvj9G6s_UQTw6hE11gJb1edt3BXzpbDQdc_dpcHgag@mail.gmail.com>
 <20190410231156.GB120258@gmail.com>
In-Reply-To: <20190410231156.GB120258@gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 10 Apr 2019 16:27:28 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKg+oN7yUY=N69U93afOVHBPgwz6Osf=eMDPfiwbzEqmw@mail.gmail.com>
Message-ID: <CAGXu5jKg+oN7yUY=N69U93afOVHBPgwz6Osf=eMDPfiwbzEqmw@mail.gmail.com>
Subject: Re: crypto: Kernel memory overwrite attempt detected to spans
 multiple pages
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Rik van Riel <riel@surriel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 4:12 PM Eric Biggers <ebiggers@kernel.org> wrote:
> You've explained *what* it does again, but not *why*.  *Why* do you want
> hardened usercopy to detect copies across page boundaries, when there is no
> actual buffer overflow?

But that *is* how it determines it was a buffer overflow: "if you
cross page boundaries (of a non-compound allocation), it *is* a buffer
overflow". This assertion, however, is flawed because many contiguous
allocations are not marked as being grouped together when it reality
they were. It was an attempt to get allocation size information out of
the page allocator, similar to how slab can be queries about
allocation size. I'm open to improvements here, since it's obviously
broken in its current state. :)

-- 
Kees Cook
