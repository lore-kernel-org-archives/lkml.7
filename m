Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291D8C282CE
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 09:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00EA92168B
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 09:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ceHJWOcl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfEYJSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 05:18:50 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:35832 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbfEYJSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 05:18:49 -0400
Received: by mail-it1-f193.google.com with SMTP id u186so17314239ith.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2019 02:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XET7OF75wNiBS0S9YBCqjrCeD8nZnzrXhbrqUvMdrP8=;
        b=ceHJWOclYeyDuJd7Q+aBCyW8OCwNFP8/2cWymfgFMO3AHiV4OddjDn8yfqX+xarEuT
         QDG0HGrexSN7InLbYaWJc2k4H5kadELuPS8oT/40UksxXj9l1VNDDQqVXZ5jR9AaTaqw
         MQvnpIeWvRKTyesCYEN4KeoUdjR2inujPC0435YZvqMqunD5W6k1bDxy+xa6RjdN7n3K
         dmPEMXbwYu/QtRnAnOD9DEmXFcafL68r+OEYi5eqHiEOefJosh1ceV2DTQM6ZmE3nj16
         Iu4C5tFR8tDL/XibRnPlSvqjCOOaG+NCyaWEXHT04A/s1pATYUJPIIrw37Ec+fCtEKCs
         MLrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XET7OF75wNiBS0S9YBCqjrCeD8nZnzrXhbrqUvMdrP8=;
        b=mUNjfOPVtNsWJHOOdtd5VTFMn/5Y9GN5Oqhra9jxtnwLW/FCzBgwGNb7kG4p1mY14r
         PmYlyQXpUEKV5Y79zNPZz6ehLgL5X5sA9fGlGtfNQ4RhxR8NfbE1w3xFGvpWQKo44yHk
         x6J5RPO8swDl/1Va8a5PeGV73Z4heKcMI+geSkwW1qHHdQ/GXXrPNp2ltxrMbWpKc4sx
         FlGmK3kSruR/OwYKhkhkcUUgbU5d1UmatWx+VnpatbTimp1zQS9jYOtHZQcqRNIETLJy
         FyCD5D9/Qk44FRxALdYJHZlG0wZ2JwnoB+QPmjuGDp9DtdQiIYmH3+Yw/W02f10UKrqR
         xUnQ==
X-Gm-Message-State: APjAAAXzUGXODrhoQgCO9j5z07jED2Vt88YmKWb/rmEgfBcMVnHCMimc
        WkkoKCcWjmwupvXfcUlCPwOGkrrK0W+6RXdEUjAFgUCrgE4HxQ==
X-Google-Smtp-Source: APXvYqz59acG8/T/AZt2D2LSZs/6ic5Hm2z3iRvDn8ZZchk6sOZJbigHdn6crFhkOiYJp3hj4oetxEMkqhWgvWAmWTM=
X-Received: by 2002:a24:d00e:: with SMTP id m14mr19817246itg.153.1558775928708;
 Sat, 25 May 2019 02:18:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190517082633.GA3890@zhanggen-UX430UQ> <CAKv+Gu98JNK34Q6MNOe3aq0W5rbv6hUFiuc7cHxHJat5aTk_gg@mail.gmail.com>
 <20190517090628.GA4162@zhanggen-UX430UQ> <CAKv+Gu_mwFpdtNZm9QMFn69+vOMTOpv9gvuhnBL2NBXvwkhXqg@mail.gmail.com>
 <20190523005133.GA14881@zhanggen-UX430UQ> <CAKv+Gu_wRYZdDYXso0B5m_BPJznGQXpCWq4_0u34bConu0V1ow@mail.gmail.com>
 <20190525023608.GA11613@zhanggen-UX430UQ>
In-Reply-To: <20190525023608.GA11613@zhanggen-UX430UQ>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sat, 25 May 2019 11:18:36 +0200
Message-ID: <CAKv+Gu-agMymoGm0G8Yj-siXwtPnqYjAHeu-wQwRT47Jqd27JA@mail.gmail.com>
Subject: Re: [PATCH v2] efi_64: Fix a missing-check bug in arch/x86/platform/efi/efi_64.c
To:     Gen Zhang <blackgod016574@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 May 2019 at 04:36, Gen Zhang <blackgod016574@gmail.com> wrote:
>
> On Fri, May 24, 2019 at 06:07:10PM +0200, Ard Biesheuvel wrote:
> > Apologies for only spotting this now, but I seem to have given some bad advice.
> >
> > efi_call_phys_prolog() in efi_64.c will also return NULL if
> > (!efi_enabled(EFI_OLD_MEMMAP)), but this is not an error condition. So
> > that occurrence has to be updated: please return efi_mm.pgd instead.
> Thanks for your reply, Ard. You mean that we should return efi_mm.pgd
> when allcoation fails? And we should delete return EFI_ABORTED on the
> caller site, right? In that case, how should we handle the NULL pointer
> returned by condition if(!efi_enabled(EFI_OLD_MEMMAP)) on the caller
> site?
>

No, the other way around. I have already updated the patch, so don't
worry about it.

https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/commit/?h=urgent&id=d2dc2bc7b60b936b95da4b04c2912c02974c3e9f
