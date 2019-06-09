Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5CCC28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 05:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F3FB208E4
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 05:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="j/5W+Sr8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbfFIFuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 01:50:20 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37324 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbfFIFuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 01:50:20 -0400
Received: by mail-pf1-f196.google.com with SMTP id 19so2587893pfa.4
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2019 22:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=g5g0galx8RyvOsGO1iYuup0nP37+YQK2f5/z3KYX1Es=;
        b=j/5W+Sr8ZHhSAf244dwdVTBvj2tr7+iZOWOKMMfzhIdFRqi7/u2TWYwP2epGcXpNlW
         I/pwIxHeXTA7MG4TUk0ufCyZSyIIQCyjiYyrHyWYIDcTZHo1r+jsI0EBt7hr3FN0zF6I
         9aQi/LIdQB7E6GlEfpTnYulqzgptG5UTsd45QMT4YAbNIlHdVNnESvsPdRQyDQdtMXPS
         jPux964RM50+CXs/BZwcQ7pdwuI3t2VFovovnu6vLXDKg5CDrROdsbaULSS6ohRCdHuV
         S0Iv21sLf6xxu5Yv8dwERodWihPDBsIc7gff7PUgGOY1ooe1vEiFAqb/Yrg666boUpoB
         aieA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=g5g0galx8RyvOsGO1iYuup0nP37+YQK2f5/z3KYX1Es=;
        b=OHKIcNmrEIQF+pYOstuCtZt2USVmKEPjRck4sDZXoOnravxWIc5EhhDmS0brrZbxQi
         eUdFyGWqIfQlrO6pT1OKcc2qKywmTRLIvgAdWmM1x+lW8ihLdK6WcN1ClmrMHnhvb+q9
         9yKloM7HmS8RUQ7aDRK3khAdsl0tume/ZeBBWWYnKFxnNVOrAXhycmNTJzVN1siXFAq9
         UO2rQ5xLNQ1XM6mfSJ+zhkFjOMahWuzIc1rWVfAbFS/NWUAzR9Ce9T9OGLgMr5PWopyP
         CTL2BkGfqy33ApQI0jNTu3jhF3LAr1Eko1Hm9TKmIJDxDYYK7ngc3Dpx+F6/kpZlMjKi
         oROg==
X-Gm-Message-State: APjAAAVm2LqU8my/fcA7+RNaewAstIv0z0vD6P5rVCoXBzPiikaiMSgx
        U5rYJlQNAcnh2SjKjppe/dCY3Q==
X-Google-Smtp-Source: APXvYqxz5Y4VKifbCFKug9kpochpBP/0jxW+Ow0eYUlsETgxmERQpqyTgihHK+7isHFvK+mEGd1Mhw==
X-Received: by 2002:a62:15c3:: with SMTP id 186mr3310072pfv.141.1560059419499;
        Sat, 08 Jun 2019 22:50:19 -0700 (PDT)
Received: from localhost ([202.131.137.2])
        by smtp.gmail.com with ESMTPSA id y13sm8257212pfb.143.2019.06.08.22.50.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 08 Jun 2019 22:50:18 -0700 (PDT)
Date:   Sat, 8 Jun 2019 22:50:14 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Palmer Dabbelt <palmer@sifive.com>
cc:     lollivier@baylibre.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, paul@pwsan.com,
        aou@eecs.berkeley.edu
Subject: Re: [PATCH v3 1/5] arch: riscv: add support for building DTB files
 from DT source data
In-Reply-To: <mhng-802d67ce-9f78-4ebc-9981-a27e5e4e40df@palmer-si-x1e>
Message-ID: <alpine.DEB.2.21.9999.1906082245300.720@viisi.sifive.com>
References: <mhng-802d67ce-9f78-4ebc-9981-a27e5e4e40df@palmer-si-x1e>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Jun 2019, Palmer Dabbelt wrote:

> On Thu, 06 Jun 2019 22:12:05 PDT (-0700), Paul Walmsley wrote:
> > On Tue, 4 Jun 2019, Loys Ollivier wrote:
> > 
> > > Always build it ?
> > > Any particular reason to drop ARCH_SIFIVE ?
> > 
> > Palmer had some reservations about it, so I dropped it for now.  But then
> > as I was thinking about it, I remembered that I also had some reservations
> > about it, years ago: that everyone should use CONFIG_SOC_* for this,
> > rather than CONFIG_ARCH.  CONFIG_ARCH_* seems better reserved for
> > CPU architectures.
> 
> The SOC stuff will, of course, be vendor specific.  In this idealized world
> SiFive's SOC support has nothing to do with RISC-V, but of course all of
> SiFive's SOCs are RISC-V based so the separation is a bit of pedantry.  That
> said, in this case I think getting the name right does make it slightly easier
> to espouse this "one kernel can run on all RISC-V systems" philosophy.
> Balancing the SiFive and RISC-V stuff can be a bit tricky, which is why I am
> sometimes a bit pedantic about these sorts of things.

Once there are SoC variants that have different CPU cores, but with the 
remaining chip integration the same, I think it would make sense to move 
the CONFIG_SOC_ stuff out from ARM, RISC-V, etc., into something that's 
not CPU architecture-specific.  But for the time being, that seems 
premature.  Might as well have it be driven by an actual use-case.


- Paul
