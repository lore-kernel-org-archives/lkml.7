Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 750DAC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 15:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45D3920657
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 15:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558019891;
	bh=ZM7ppt/S5KJwv0acQCOQ76OkA49Aolc34/4ZQeZCdco=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=kM3SpBUAcv7LiVYJXB2BJYDTXvMwIqmfwgc1kzH5tIplMClUKyQWeJMauCNGFgyTR
	 s9O97By24nd2Iwz4DEF8tyTpH6UK4BF4Os3dO6qqdmHpPrCvWqKk8Ry2HDsMhfKshW
	 GOx/Cq+7M01HtfwH/3pdF8rZJRm19B6RYb4ULcQk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbfEPPSK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 11:18:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:53290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726687AbfEPPSK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 11:18:10 -0400
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 900CB20833;
        Thu, 16 May 2019 15:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558019888;
        bh=ZM7ppt/S5KJwv0acQCOQ76OkA49Aolc34/4ZQeZCdco=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1O52VzdmaWpclF2Vq5eVFl+XFTl+jyTJm2sXqSL/6DNVKTb2AN2wggy1ABR4GT+Ol
         zeVFkidsdioXrsnfl0X/+MB44YQbSff6eIy59n/HGd+Ejo+ct3oG7wRujt7w+n9Yo/
         I9DS4ya12Up8RU8Y2TZULqMiiYMAP1f0k2jCyYxs=
Received: by mail-qt1-f176.google.com with SMTP id y42so4333841qtk.6;
        Thu, 16 May 2019 08:18:08 -0700 (PDT)
X-Gm-Message-State: APjAAAX/RnUhhRPrF0nN8q6buOaTyx4Vz5Jend58MUn3cR9B6qtvEAaF
        ecX+PywwAl6vmHKEZcLq8T76p5TUWz5/qlCcXA==
X-Google-Smtp-Source: APXvYqxt++jGtZr/pMp/Bw9IfigV/iGoq2iy4QQBdyF695i72d1q8vmOqdxvkY39gqqmm4cqUNbklT6HdE7Zolbcags=
X-Received: by 2002:ac8:3862:: with SMTP id r31mr42313002qtb.26.1558019887828;
 Thu, 16 May 2019 08:18:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190516102817.188519-1-hsinyi@chromium.org> <20190516102817.188519-2-hsinyi@chromium.org>
 <CAL_JsqLx1UdjCnZ69aQm0GU_uOdd7tTdD_oM=D7yhDANoQ0fEA@mail.gmail.com> <20190516144303.GF43059@lakrids.cambridge.arm.com>
In-Reply-To: <20190516144303.GF43059@lakrids.cambridge.arm.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 16 May 2019 10:17:56 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+Tmht+oxdmjtyhzwrYw4NNAkVnimAuEGODC_2fAprSjg@mail.gmail.com>
Message-ID: <CAL_Jsq+Tmht+oxdmjtyhzwrYw4NNAkVnimAuEGODC_2fAprSjg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] arm64: implement update_fdt_pgprot()
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Miles Chen <miles.chen@mediatek.com>,
        James Morse <james.morse@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Jun Yao <yaojun8558363@gmail.com>, Yu Zhao <yuzhao@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 9:43 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Thu, May 16, 2019 at 09:37:05AM -0500, Rob Herring wrote:
> > On Thu, May 16, 2019 at 5:28 AM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> > >
> > > Basically does similar things like __fixmap_remap_fdt(). It's supposed
> > > to be called after fixmap_remap_fdt() is called at least once, so region
> > > checking can be skipped. Since it needs to know dt physical address, make
> > > a copy of the value of __fdt_pointer.
> > >
> > > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > > ---
> > >  arch/arm64/kernel/setup.c |  2 ++
> > >  arch/arm64/mm/mmu.c       | 17 +++++++++++++++++
> > >  2 files changed, 19 insertions(+)
> >
> > Why not just map the FDT R/W at the start and change it to RO just
> > before calling unflatten_device_tree? Then all the FDT scanning
> > functions or any future fixups we need can just assume R/W. That is
> > essentially what Stephen suggested. However, there's no need for a
> > weak function as it can all be done within the arch code.
> >
> > However, I'm still wondering why the FDT needs to be RO in the first place.
>
> We want to preserve the original FDT in a pristine form for kexec (and
> when exposed to userspace), and mapping it RO was the easiest way to
> catch it being randomly modified (e.g. without fixups applied).

The CRC check already existed for this purpose and that works for
every arch including ones where the FDT is copied.

BTW, This version of the patchset disables the export to userspace
since the CRC will be wrong.

> I'd prefer to keep it RO once we've removed/cleared certain properties
> from the chosen node that don't make sense to pass on for kexec

I want clear rules about when the FDT can be modified or not which are
not arch specific.

It's really only a question of with what granularity it's made R/W.
Wrapping every modification seems like overkill to me.

Rob
