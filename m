Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F82EC2D0D2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 22:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E44CD218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 22:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="X/akbPBW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbfLTW3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 17:29:32 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:33091 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbfLTW3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 17:29:32 -0500
Received: by mail-il1-f195.google.com with SMTP id v15so9282819iln.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 14:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SxT9S/D7O//cYzKYLsrhvKwwVG4SCgEZz+NAdL3+U5Q=;
        b=X/akbPBWsfdZSp5G+j8P28Aelh08kzfqaYSSeV7+y19Zi1sV/RL/eCdWnV27FHLG2P
         EQRJdTjbSHdcV/ApCLjSWGWjqZvmzYs6dScyi4K4xpQybh/mlAzaWbvhTtb8Ju8a3M++
         qYFouGgxLMhvdLNAM1zSqJpeoY5qcxHAhZuuafFitcFS1pcYJxLy3yfoBN7+IVIjnPAU
         Lo42qgzVk6MKHeoMx/ow0YHO2B+UYq1bf2JWUI9jdIG7IOfnSjZBLEQwE1GpNs8s8IJk
         M+Qn8NlFKu4U+W5/r3EWTzUCZfMmc7HksPCXtYOQWQhp7Ql5z7ZD6Gw/dZBmhwIyPQAm
         L7qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SxT9S/D7O//cYzKYLsrhvKwwVG4SCgEZz+NAdL3+U5Q=;
        b=Iqj8uMPOlZRFEFr7VxdRYARYItfgFNytygVAp6LYLpyrqHq0POaU8fn88TSdHzc1hT
         Y8B17PJs1ZYclwpBd634lCezvYzLhkc6yrdqNEFSIXLhRuIDHzApODeSXb3bz++3K8DR
         71SGPiy+9WJMbB5EUCdxcjz6S3BLLoEnrlX5LbT4XTolN3aSeEjTcVneg4gBXLKTMN+8
         HRjASP4F92HXkv+SFZQY9VkAPR6VpkV/1cT2fjmJA0+bCP4JvjbOrqEvWgwTS1mjAXD9
         MV2raBHR1CxZrDkf1EutRhhJ9/uXxLvjRAzdhYapDWrcgK8A+PwggNBlmUVh9yCRyoTs
         IaUA==
X-Gm-Message-State: APjAAAXHcORT5hjGCt3SDoFuY8E7omAwj9Iaub3LH5QxfxYfDZ3WPoRy
        sHKgILF3t9JxTzuVD2cNF07PD6v0YxLa6P4jEaQxqA==
X-Google-Smtp-Source: APXvYqxLXJqkYvqWBb61uln9iVY4bKA8u4x7YyqWnVhlvxP53ixXA+H6Dubqv63T2mi3IMTN0gxD97MeT3MAXwMVGes=
X-Received: by 2002:a92:afc5:: with SMTP id v66mr13507241ill.123.1576880971835;
 Fri, 20 Dec 2019 14:29:31 -0800 (PST)
MIME-Version: 1.0
References: <20191217040704.91995-1-olof@lixom.net> <alpine.DEB.2.21.9999.1912200302290.3767@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1912200302290.3767@viisi.sifive.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Fri, 20 Dec 2019 14:29:20 -0800
Message-ID: <CAOesGMg_VySkckuTfeMWkfcQ6fUBokAQbCGXP9emz9WvtX4fKQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: export flush_icache_all to modules
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2019 at 3:05 AM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>
> On Mon, 16 Dec 2019, Olof Johansson wrote:
>
> > This is needed by LKDTM (crash dump test module), it calls
> > flush_icache_range(), which on RISC-V turns into flush_icache_all(). On
> > other architectures, the actual implementation is exported, so follow
> > that precedence and export it here too.
> >
> > Fixes build of CONFIG_LKDTM that fails with:
> > ERROR: "flush_icache_all" [drivers/misc/lkdtm/lkdtm.ko] undefined!
>
> In the past we've resisted doing this; see
>
> https://lore.kernel.org/linux-riscv/20190611134945.GA28532@lst.de/
>
> under the principle that we don't want modules to be able to flush the I$
> directly via this interface.  But maybe, like moving the L2 related code
> out of arch/riscv, we should just do it.

So you are aware that all other architectures that don't have coherent
icache already exports this, right?

Being more puritan on RISC-V buys nothing w.r.t. keeping modules from
doing anything, you'll just end up having to mark a bunch of them
broken on your architecture. :(


-Olof
