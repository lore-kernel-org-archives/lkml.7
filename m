Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A92C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 16:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 857DF22525
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 16:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LcZXnD3Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729891AbfLEQrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 11:47:13 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35685 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfLEQrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 11:47:13 -0500
Received: by mail-wr1-f67.google.com with SMTP id g17so4487510wro.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 08:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AdQa7zTKef6TuZxKVd+h8OUJjd3AmkT97EW9UuGI8tU=;
        b=LcZXnD3YjMu/Pbxt/Ydw9eKqW8gdmIaRYKADYygtoqvEo6IIXdgpV0JqAsWl3K2/Ca
         EltGH3cV30xoAJLPmAak2GlMoCGbIAoAM51s+z/cdY+rgZECV9zQ50zs59tkB8+1pGRB
         0AlFBnseVf3UdmZ2uDkg15T3tZSFDa/3evXCQONPuTtfRT5AWOMxmmi0XmRTElTxhslO
         pP1UEtPAz3rwW+nNu5pmiN2kJtx2nY0wcaKWhAnp8sX3WlTbfXuL16bo58lqTDhwjy8H
         czTS+P4u0gIOLgoYKLDp2a6GqqQRd3DCS7toqlSjc7EQXgkapMMhgnMgd0RugAy4uAZI
         hDrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AdQa7zTKef6TuZxKVd+h8OUJjd3AmkT97EW9UuGI8tU=;
        b=cNqD/JMYo8qUoh7ZdyofUnkOSNvBB2IDk723vHHazOAt+i/7Bw/a7iamh8O0MVrKFF
         M0R0EowiKUsYTKswbjeeYzCn7IqNKRVVa+KtTjgx/4y8YzJQ8QzIJVY6XRdatC3T6f63
         B7kuuR6uDrX1cased/DgWqZszgFGP9U+4Lb09nTYj3xwmlH7tFIvwRQdx/q38UsgpwnN
         oMPQ623QdZAXdeMQ+pJajqW3aRSbpdaXU9t4wKDCjTfKfiZ4RSQjpeGOfovuN5Nb9G9p
         1e9fWwa2ooDC/VExMqFFaqTVcytyA2MLLHKxgqZWM8zXoZI7Ckl+MnyflVOzYxEy7Bpm
         t+cA==
X-Gm-Message-State: APjAAAWsykoVinwR3yF7MtXqKo1pCJsHqRUMaSQuaMy3hQU1sJ9DkcFY
        JT7jAgdRFUGo4mew3Z5HFS5oPQ==
X-Google-Smtp-Source: APXvYqz4gVCYwOJxOWID1BItB7GKwi7oY6Ha1hp6BkimbdykmDf/yOM6pIVFeamJPsKrrtFWz9c6BA==
X-Received: by 2002:adf:ee88:: with SMTP id b8mr11827870wro.249.1575564429477;
        Thu, 05 Dec 2019 08:47:09 -0800 (PST)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id x132sm2398633wmg.0.2019.12.05.08.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 08:47:08 -0800 (PST)
Date:   Thu, 5 Dec 2019 16:47:06 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Anup Patel <anup@brainfault.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RISC-V: Add debug defconfigs
Message-ID: <20191205164706.svarpjp2kdokl2pg@holly.lan>
References: <20191205005601.1559-1-anup.patel@wdc.com>
 <alpine.DEB.2.21.9999.1912041859070.215427@viisi.sifive.com>
 <CAAhSdy1RQw3MVcVT5y1EHr72LDNADKRL5nO2E8OrzBi+tpuvtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhSdy1RQw3MVcVT5y1EHr72LDNADKRL5nO2E8OrzBi+tpuvtA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2019 at 10:03:34PM +0530, Anup Patel wrote:
> On Thu, Dec 5, 2019 at 8:33 AM Paul Walmsley <paul.walmsley@sifive.com> wrote:
> >
> > On Thu, 5 Dec 2019, Anup Patel wrote:
> >
> > > Various Linux kernel DEBUG options have big performance impact
> > > so these should not be enabled in RISC-V normal defconfigs.
> > >
> > > Instead we should have separate RISC-V debug defconfigs having
> > > these DEBUG options enabled. This way Linux RISC-V can build both
> > > non-debug and debug kernels separately.
> >
> > I respect your point of view, but until the RISC-V kernel port is more
> > mature, I personally am not planning to merge this patch, for reasons
> > discussed in the defconfig patch descriptions and the subsequent pull
> > request threads.
> >
> > I'm sure we'll revisit this in the future to realign with the defconfig
> > debug settings for more mature architecture ports - but my guess is that
> > we'll probably avoid creating debug_defconfigs, since only S390 does that.
> 
> We have a lot of users (Yocto and Buildroot) dependent on the Linux
> defconfig. I understand that you need DEBUG options for SiFive internal
> use but this does not mean all users dependent on Linux defconfig
> should be penalized in-terms of performance.
> 
> This is the right time to introduce debug defconfigs so that you can
> use it for your SiFive internal use and all users dependent on normal
> defconfigs are not penalized in-terms of performance.
> 
> If you still don't want debug defconfigs then I recommend reverting
> your DEBUG options patch and you can find an alternative way to
> enable DEBUG options for SiFive internal use.

None of my business (except that I watch threads with debug in the
subject line) but why propose putting debug options into any kind
of defconfig. If you want standardized set debug options to chase
problems why can't they into a .config file rather than a defconfig
file.

In use it will look like:
  make defconfig extra_debug.config

That way you don't have to maintain two almost identical files that will
inevitably drift apart.


Daniel.
