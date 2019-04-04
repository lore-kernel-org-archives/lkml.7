Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0506C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 01:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DAC42133D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 01:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554341389;
	bh=tATE0kDtaFam0x8VXorFbEs49htN2DYkNbXBemkJufg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=hiC2qGMn/CMCDNx9iiIvuJeSsoyWyEsg/0ZGz6CMlszPZFXgUUzJu7XwtBXhlIrj2
	 OTvSsZRThZJPNPxlVJVcY9FX4WiGC5iV3pVii08T5vWUEgI8ujJz0sU89CEiebPJFd
	 T7kwCsPArd5sP98JBJyumc9HoE2CzkH+eaW5oYkw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbfDDB3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 21:29:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:33936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbfDDB3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 21:29:47 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16A972171F;
        Thu,  4 Apr 2019 01:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554341386;
        bh=tATE0kDtaFam0x8VXorFbEs49htN2DYkNbXBemkJufg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ksSHTVo+3QVX53KrKqY64A7WC9lfXy1ROzXdxcpXEp3XZcCdjV8Sg9cOn8AXO0uj6
         0wu1S1gz6IvupzPwfzXOQa0GAUDKqgpThZdq8ZZV3FOblt1JT7WWiwyK0ofUO3zZAu
         boytoIyW8ozy3rBLIXvvNr4tBxwBegxqJ4S1ALco=
Received: by mail-qt1-f179.google.com with SMTP id x12so1392829qts.7;
        Wed, 03 Apr 2019 18:29:46 -0700 (PDT)
X-Gm-Message-State: APjAAAWngYSYDw4wzKSrwL9q8IjqU+k9nUCTX3hFs7vl2vF6UGI1jcck
        YTyaDsjeXX4ctXtBBkDl7spi6iT97Pj3eJRBhg==
X-Google-Smtp-Source: APXvYqxSCk4yUzBgYqvMLNE6TX/UlNNhnuLPBCA4KRwlijnMy/bey7uXC5SgGmQkF0J0f3JfhzqpGM+HcCGmirI8Eos=
X-Received: by 2002:ac8:3f6f:: with SMTP id w44mr2839942qtk.59.1554341385136;
 Wed, 03 Apr 2019 18:29:45 -0700 (PDT)
MIME-Version: 1.0
References: <1551795849-13672-1-git-send-email-fabien.dessenne@st.com>
 <1551795849-13672-2-git-send-email-fabien.dessenne@st.com>
 <20190327230722.GA13708@bogus> <41b7bd91-7c14-9227-381e-f0e751ae4079@st.com>
In-Reply-To: <41b7bd91-7c14-9227-381e-f0e751ae4079@st.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 3 Apr 2019 20:29:33 -0500
X-Gmail-Original-Message-ID: <CAL_JsqK3BboUTW5TObyAjZCb5T0M-uVYt8pLYjPX598OgcuxkA@mail.gmail.com>
Message-ID: <CAL_JsqK3BboUTW5TObyAjZCb5T0M-uVYt8pLYjPX598OgcuxkA@mail.gmail.com>
Subject: Re: [PATCH 1/8] dt-bindings: stm32: add bindings for ML-AHB interconnect
To:     Fabien DESSENNE <fabien.dessenne@st.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        Loic PALLARDY <loic.pallardy@st.com>,
        Arnaud POULIQUEN <arnaud.pouliquen@st.com>,
        Ludovic BARRE <ludovic.barre@st.com>,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 On Fri, Mar 29, 2019 at 10:59 AM Fabien DESSENNE
<fabien.dessenne@st.com> wrote:
>
> Hi Rob,
>
> Let me clarify the context and the reason of the proposed approach.
>
> The remoteproc framework deals with 'carveout' memory regions.
>  From the remoteproc_core.c:
>
>   * Some remote processors will ask us to allocate them physically contiguous
>   * memory regions (which we call "carveouts"), and map them to specific
>   * device addresses (which are hardcoded in the firmware). They may also have
>   * dedicated memory regions internal to the processors, and use them either
>   * exclusively or alongside carveouts.
>   *
>   * They may then ask us to copy objects into specific device addresses (e.g.
>   * code/data sections) or expose us certain symbols in other device address
>   * (e.g. their trace buffer).
>
> For this, the remoteproc drivers have to register these memory regions
> providing their memory mapping remote processor view / local processor
> view. See rproc_mem_entry_init() and rproc_add_carveout().
>
> An implementation solution consists in declaring the memory mapping inside
> the remoteproc driver. (Ex: imx_rproc_att_imx7d[] from imx_rproc.c)
>
> For the stm32 rproc driver that we are introducing, we would like to have
> something more flexible than hardcoded values.

I need an explanation that is not in terms of remoteproc. That's a Linux thing.

> One reason for this, is that some memory parts can be accessed through
> different 2 bus port, with different addresses and access speed, and we
> would like to let the user customize this.
>
> Using DeviceTree "ranges" seems to fit with these requirements.

'ranges' is strictly about the cpu's (running Linux) view of the
system. 'dma-ranges' is for the device's (the remoteproc) view of
memory. You simply cannot redefine them for your own custom use.

If the cpu has 2 views of the same memory, then you can use ranges to
describe that.

> If you think that this is not the right approach, please let me know if you
> think about something better.
>
> See also below my answer to your specific remarks
>
> BR
>
> On 28/03/2019 12:07 AM, Rob Herring wrote:
>
> > On Tue, Mar 05, 2019 at 03:24:02PM +0100, Fabien Dessenne wrote:
> >> Document the ML-AHB interconnect for stm32 SoCs.
> >>
> >> Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
> >> ---
> >>   .../devicetree/bindings/arm/stm32/mlahb.txt        | 30 ++++++++++++++++++++++
> >>   1 file changed, 30 insertions(+)
> >>   create mode 100644 Documentation/devicetree/bindings/arm/stm32/mlahb.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/arm/stm32/mlahb.txt b/Documentation/devicetree/bindings/arm/stm32/mlahb.txt
> >> new file mode 100644
> >> index 0000000..880cb38
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/arm/stm32/mlahb.txt
> >> @@ -0,0 +1,30 @@
> >> +ML-AHB interconnect bindings
> >> +
> >> +These bindings describe the STM32 SoCs ML-AHB interconnect bus which connects
> >> +a Cortex-M subsystem with dedicated memories.
> >> +
> >> +Required properties:
> >> +- compatible: should be "simple-bus"
> > A binding for simple-bus was the first thing that looked odd.
>
> Since we want to use "ranges" (or "dma-ranges"), we need to define a parent-bus.
> This bus has nothing specific, so it is a "simple-bus"

Okay, fair enough.

> >> +- ranges: describes memory addresses translation between the local CPU and the
> >> +       remote Cortex-M processor. Each memory region, is declared with 3
> >> +       parameters:
> >> +             - param 1: device base address (Cortex-M processor address)
> >> +             - param 2: physical base address (local CPU address)
> >> +             - param 3: size of the memory region.
> > Given that the driver is parsing ranges itself, this looks like abuse of
> > ranges.
>
> That's correct. As explained above, we need to provide the remoteproc framework
> with carveout mappings.
>
> >
> > What exactly is address 0 supposed to be here? If it is the M4's view of
> > memory, then dma-ranges is what you want to use here.
>
> "dma-ranges" is probably more appropriated here. But the driver still needs to
> parse this property.

That is more acceptable assuming what's in dma-ranges matches the
standard definition.

Rob
