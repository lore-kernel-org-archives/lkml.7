Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB05C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 14:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C59A20675
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 14:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XewtSERX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbfEPOjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 10:39:47 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42788 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbfEPOjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 10:39:46 -0400
Received: by mail-ed1-f67.google.com with SMTP id l25so5594529eda.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 07:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3CyBDin8DCVhqMsm5Y31nNq5E0wYgKjhJ5os3L5pACs=;
        b=XewtSERXwuRq/hMVzfTTvLn3bup7RL3HYHHiSaecYOcuXF0IYqV7+eahP0uoc2sntm
         all0N0vBT2cEdbkpmEsZSMOHRpXo6iW0x4s9X85jbF/Gs3irW/ih2LB9XWftHVqFvoxL
         zLCWkLS84U94nRd2oDZuAQn3I+MZk66knbYg515af60MhANSCel3a9ThgmTA0MVapTqI
         5zV2XK01YaT/iulH3tvZbCE7lRjnY+IhIzPwTcHf6do6SiNoFYitBpKumOTkoznvSoYZ
         6KDcV0oC5T1hfz1q7tbHZMWpCM0WYLl0ytkNaqiRTMcFgZuF3edRp1KtFoFaMc9E57Z3
         le5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3CyBDin8DCVhqMsm5Y31nNq5E0wYgKjhJ5os3L5pACs=;
        b=EYDfsGCIVlDCZFCNMzG/xJUGZejY9TA3ul+zjXQFMhk+Z9PLIak6/Im21PxUXb+h8L
         SE9T2bmqoLZ3LkmxQJx+TKBehurCgACCSYknvKMeqaq2kw17eL6eTj71YyOdIW71NO+X
         Dmnit/AshUdd0A7mhAh9Gqz/ruwWxjeOz9UaQ28Xx2JdiELpenCITSArOt2rXFCrswnB
         S3BJYu8I5ehIPztogkkmqXaAwjVn36dSNR+SkxmnVOckXGitycNnRsW6LoDInGHhnQro
         D6jSCbtc+dzYqXMWarMkLWcqKxLBikel+GjuBjj7LPukwKX0usYc5Bh9oW3nEG9xFqlG
         ha5Q==
X-Gm-Message-State: APjAAAXX5EiKTCam3TWxFEWk5vW3RrFvemnZLvFxkB5rRv9EpsSWOOdW
        ojHic4Zzh9IdxuSBAjLJ4EG/d2V8hA2e7bUby4aOlA==
X-Google-Smtp-Source: APXvYqzVw4+DR7PKEpSfxZo2Bdbylhw3TaXpzTsHymAwtO3mmxyKdPyPNxfkAFlXWKqIm8B6CbcVq2T1cTiJkrYtHQs=
X-Received: by 2002:a17:906:b6c8:: with SMTP id ec8mr39217179ejb.89.1558017584937;
 Thu, 16 May 2019 07:39:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190516102817.188519-1-hsinyi@chromium.org> <20190516102817.188519-2-hsinyi@chromium.org>
 <CAL_JsqLx1UdjCnZ69aQm0GU_uOdd7tTdD_oM=D7yhDANoQ0fEA@mail.gmail.com>
In-Reply-To: <CAL_JsqLx1UdjCnZ69aQm0GU_uOdd7tTdD_oM=D7yhDANoQ0fEA@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 16 May 2019 16:39:32 +0200
Message-ID: <CAKv+Gu_kgHEhk-p8KoGVgpifdjA67Li-D19_KSLo+1h4ZvL=3g@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] arm64: implement update_fdt_pgprot()
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Miles Chen <miles.chen@mediatek.com>,
        James Morse <james.morse@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
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

On Thu, 16 May 2019 at 16:37, Rob Herring <robh+dt@kernel.org> wrote:
>
> On Thu, May 16, 2019 at 5:28 AM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> >
> > Basically does similar things like __fixmap_remap_fdt(). It's supposed
> > to be called after fixmap_remap_fdt() is called at least once, so region
> > checking can be skipped. Since it needs to know dt physical address, make
> > a copy of the value of __fdt_pointer.
> >
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > ---
> >  arch/arm64/kernel/setup.c |  2 ++
> >  arch/arm64/mm/mmu.c       | 17 +++++++++++++++++
> >  2 files changed, 19 insertions(+)
>
> Why not just map the FDT R/W at the start and change it to RO just
> before calling unflatten_device_tree? Then all the FDT scanning
> functions or any future fixups we need can just assume R/W. That is
> essentially what Stephen suggested. However, there's no need for a
> weak function as it can all be done within the arch code.
>
> However, I'm still wondering why the FDT needs to be RO in the first place.
>

It was RO because it could be RO, and we wanted to ensure that it
didn't get modified inadvertently (hence the CRC check we added as
well)

If there is a need for the FDT to be RW, let's make it RW.
