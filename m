Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 852D7C4CECD
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 18:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 531AF20650
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 18:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568656943;
	bh=jw9WxCmFRLg9kFz2L7R8cTZs0S4CVzr5+ZqT8UTf1jI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Un+WdsXO3nFrfskoQQTG93+9zfn0yBzX5s8/1JMOy0rHPV+0G9A7yDUopGort5sHK
	 t5aAXWLq6G9Ju6W0bb0v537DBJy8BM/NzDMDnFvpmxzA1VcDER49/XQ24RKjXch5GC
	 VGPIGicEAwDirRv4UKLd0lOl6AOZyk9SlYVrn8Zc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389471AbfIPSCW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 14:02:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:35166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727039AbfIPSCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 14:02:22 -0400
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C746021670;
        Mon, 16 Sep 2019 18:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568656941;
        bh=jw9WxCmFRLg9kFz2L7R8cTZs0S4CVzr5+ZqT8UTf1jI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=V23dSxE2kGCR3BVUjTONF1FRXfP1gZhfaFk4gApW297O01495XrpSj2MLtlSUoInV
         kqTTrnnezGyP8I98AdDkAnb04MUJWvUN7Cd1X/u2fHZTGU1pOyUzYkIt1evdGPO1jg
         FVWdR6xHqLvbwo/FUj+S/ARtAPoCTzccCeEmuDRQ=
Received: by mail-qk1-f170.google.com with SMTP id h126so872235qke.10;
        Mon, 16 Sep 2019 11:02:21 -0700 (PDT)
X-Gm-Message-State: APjAAAU9icw0Tv1E+YWnUlt1lu65jHXuvQQjcBaCIeuZJvoTyVYDYFe9
        5BlaHDkrbW1M6+wfzPdyHQoV9QzjOhEYAqnlrQ==
X-Google-Smtp-Source: APXvYqwIiBMlyhrPnYeXlslX3QQeHDB1E7HsL8JSZyGmHrkr6hB5Cyuj+9oFg0wnVhS/VTV38+HO6mnIuvsId6+pqz8=
X-Received: by 2002:a37:8905:: with SMTP id l5mr1331558qkd.152.1568656940987;
 Mon, 16 Sep 2019 11:02:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190916161447.32715-1-manivannan.sadhasivam@linaro.org> <20190916161447.32715-5-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20190916161447.32715-5-manivannan.sadhasivam@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 16 Sep 2019 13:02:09 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKDp4kY=PxDNnr2NARZ0HSPrtvLCuTh_9mvaWY8-5Sqbg@mail.gmail.com>
Message-ID: <CAL_JsqKDp4kY=PxDNnr2NARZ0HSPrtvLCuTh_9mvaWY8-5Sqbg@mail.gmail.com>
Subject: Re: [PATCH v5 4/8] dt-bindings: clock: Add devicetree binding for
 BM1880 SoC
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, haitao.suo@bitmain.com,
        darren.tsao@bitmain.com, fisher.cheng@bitmain.com,
        alec.lin@bitmain.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 11:15 AM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> Add YAML devicetree binding for Bitmain BM1880 SoC.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../bindings/clock/bitmain,bm1880-clk.yaml    | 76 +++++++++++++++++
>  include/dt-bindings/clock/bm1880-clock.h      | 82 +++++++++++++++++++
>  2 files changed, 158 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/bitmain,bm1880-clk.yaml
>  create mode 100644 include/dt-bindings/clock/bm1880-clock.h

Reviewed-by: Rob Herring <robh@kernel.org>
