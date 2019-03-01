Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 571F7C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 15:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1545F2084F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 15:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="IXhew6MT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388735AbfCAP0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 10:26:12 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42337 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbfCAP0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 10:26:12 -0500
Received: by mail-oi1-f195.google.com with SMTP id s16so19748694oih.9;
        Fri, 01 Mar 2019 07:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Eo/srFU45IxuxtBCG8At/eXT5H87tGwGcm2Tw40UFaY=;
        b=IXhew6MTfxtgTGysBeJTR/WH9W3klE/KOn1YHkjIPoo2E4ME5R5v8RYo9YElu++OxL
         qatmKu7r9QhS1wir0vjzeDZP2bvHvJq/Sg66d5LY6n6Gv8GcPUbG4sdSC/TKIEs8vCIi
         1sRpLH9Y+pPEKXALLty9o+JqmeB6qhiMg+uSMECbAJksp0AYWVwBT/C/YWOdpbbLNPgX
         19fwjyBKWwHwLxgcYolwXpHMZy7bJme/vG+wluBwMKv641gf241olLuuULjs/fryaB/A
         xc6pMe/9gMTtyK/LrCRIKkEpjLp6FTl1IXatoZkAtDVjvNaxvS7mwAaAQOlYTYYq5fPc
         veDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Eo/srFU45IxuxtBCG8At/eXT5H87tGwGcm2Tw40UFaY=;
        b=jogVDB4Oo1711p8+ngwwd2IFxRtbIL+FkC/ixXbLlxvfHuW5jMhbfDoZS/2ewfSKOW
         BjyqCqbS3/yYJsB+wheUbJPqgdbiKk4JLj+ZwGkqFQqYmJjIoQQB2tb1swukiK/BMJY5
         phTMNF91GBlEaKJlyDXD1Tu7pZmkL+b0Mt8//l4Zf5HJRCVHTTWU3xCJzl01pac7BEin
         RvJvU+olMIv5FmOurVTiaieptSoTtocOfiETwcK8IYPbpD3M6x6oeBEBgsV9l5RLVDat
         xLWSKscFUUdo1XJtDWuMMPFCnA/yW6LM4XrFMu0GhIqlcGdPS9AqO3YJ6No319nc/8RV
         UdSw==
X-Gm-Message-State: AHQUAubQWjF3ncmky75tpwBp4s9Q/o/fCFNgWJEbajpqbF9qIjZlI8G8
        r0ao7baxis9bOwbzBAi4NNFTtRwoTU1kAtyBaJjtAa+e
X-Google-Smtp-Source: AHgI3Ia/gBXpSXXoWmv5YgxOzWpusVnInHAPZntpMsTmQ2OXzN9wY8kdKtf3VLzihLpVCAjaxauz0Ibiq+R0o16YTEQ=
X-Received: by 2002:aca:4205:: with SMTP id p5mr3716145oia.15.1551453970803;
 Fri, 01 Mar 2019 07:26:10 -0800 (PST)
MIME-Version: 1.0
References: <20190301102140.7181-1-narmstrong@baylibre.com> <20190301102140.7181-2-narmstrong@baylibre.com>
In-Reply-To: <20190301102140.7181-2-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 1 Mar 2019 16:26:00 +0100
Message-ID: <CAFBinCCtmykL-ccWd9cporEOmxeUKC-RgrP3wfuSuYoAEjrGWA@mail.gmail.com>
Subject: Re: [PATCH 1/2] clk: meson-g12a: add cpu clock bindings
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     jbrunet@baylibre.com, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Fri, Mar 1, 2019 at 11:22 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Add Amlogic G12A Family CPU clocks bindings, only export CPU_CLK since
> it should be the only ID used.
is this also true for the CPU post-dividers (APB, ATB, AXI, CPU CLK TRACE)?

> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/clk/meson/g12a.h              | 24 +++++++++++++++++++++++-
>  include/dt-bindings/clock/g12a-clkc.h |  1 +
>  2 files changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clk/meson/g12a.h b/drivers/clk/meson/g12a.h
> index f399dfe1401c..4854750df902 100644
> --- a/drivers/clk/meson/g12a.h
> +++ b/drivers/clk/meson/g12a.h
> @@ -166,8 +166,30 @@
>  #define CLKID_MALI_0_DIV                       170
>  #define CLKID_MALI_1_DIV                       173
>  #define CLKID_MPLL_5OM_DIV                     176
> +#define CLKID_PCIE_PLL_DCO                     178
> +#define CLKID_PCIE_PLL_DCO_DIV2                        179
> +#define CLKID_PCIE_PLL_OD                      180
how are these PCIe clock related to the CPU clocks?

> +#define CLKID_SYS_PLL_DIV16_EN                 181
> +#define CLKID_SYS_PLL_DIV16                    182
> +#define CLKID_CPU_CLK_DYN0_SEL                 183
> +#define CLKID_CPU_CLK_DYN0_DIV                 184
> +#define CLKID_CPU_CLK_DYN0                     185
> +#define CLKID_CPU_CLK_DYN1_SEL                 186
> +#define CLKID_CPU_CLK_DYN1_DIV                 187
> +#define CLKID_CPU_CLK_DYN1                     188
> +#define CLKID_CPU_CLK_DYN                      189
> +#define CLKID_CPU_CLK_DIV16_EN                 191
> +#define CLKID_CPU_CLK_DIV16                    192
> +#define CLKID_CPU_CLK_APB_DIV                  193
> +#define CLKID_CPU_CLK_APB                      194
> +#define CLKID_CPU_CLK_ATB_DIV                  195
> +#define CLKID_CPU_CLK_ATB                      196
> +#define CLKID_CPU_CLK_AXI_DIV                  197
> +#define CLKID_CPU_CLK_AXI                      198
> +#define CLKID_CPU_CLK_TRACE_DIV                        299
> +#define CLKID_CPU_CLK_TRACE                    200
>
> -#define NR_CLKS                                        178
> +#define NR_CLKS                                        201
shouldn't all changes to this file (drivers/clk/meson/g12a.h) be part
of the patch which adds the actual clocks so the dt-bindings patch is
independent of the clock driver patches?
in this case the subject should also be updated to "dt-bindings:
clock: g12a: ..."


Regards
Martin
