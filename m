Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EEDDC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 08:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D72821473
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 08:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jX13nGRP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbfE1Ixt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 04:53:49 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:39842 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbfE1Ixr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 04:53:47 -0400
Received: by mail-vs1-f66.google.com with SMTP id m1so12279912vsr.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 01:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OvPyYljb7JCOrJ33Ko5bumzGJo9yaiTXxiuXC/YYxTg=;
        b=jX13nGRPAPQI1hudE0X4kQErmhGYYfoL3HEp017zRgTTQqSLqgi4ZQek3ZoSFMxBdU
         /yRFxKtEShA+2g/SGMrieED29wDcQdd5BGbasxRNkqmWV2wIz0TZjWrcjM7Heh2wMW+W
         c3MKVnGHejU3lxN+pyIMTgv8eooombwckW0jjXenNUvhhB+yjrB+lCC6pS8zZWZk72JR
         Pw77jREudMFS/UiJoYxJWClw3K5NX+ITUS4mvilMNIbIlySv9oEL1B2rkoUjaYJdxRS2
         sfpXJ9cOPN61iuyASFipfhH5HVnpqd87PoQrboLqB8p++c//5p0Vzt3LgQsXLF6Sxpv8
         2YhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OvPyYljb7JCOrJ33Ko5bumzGJo9yaiTXxiuXC/YYxTg=;
        b=Vb5Iz2UcFKPmbSq9Krh9jBoNOIMvTWx2J2Mtjsyb2NTPPeDp5sX5l/SvipK016sC8j
         lvoVJGR5d2Mu7nX5jDW3GvqQqf7norK8o7hoX3yMwFCMeQVRuCTmA/h7XLWQSGBOb9DQ
         bH+VTDmmhseimzKyjTakO7LoEHxZ2BxUcyL5nWThuZBgaSWjaK6OQ6udTXxTO6IKbZ59
         SYvMnHobKy/3NTR6TOoolDS4/15T4+5gDampu5LRT/0dhsbQOc1TlAfLP8fF8QnMSfrr
         EKYPsnwNeJPkYKfL8suZAwiEpDnk2DcQJym5QwgvjppzsypVn5Kab946f2IseYboeF8+
         DjCw==
X-Gm-Message-State: APjAAAXYpr3dkDtPsXoqP+siAJBqRMViWw0pNcMwIBNhYHdQ5oXoMBI1
        ekHnB0yoiqpjhysKkqxnuJ20ZZE9cAn48idPfR5fRqng
X-Google-Smtp-Source: APXvYqxxu7B75fGza2d3hxaqgN1ayByiKBL1TJG814+ezkFuh/mzNJ5XOp9JlYbecqc4TcFNqA/1BrHCMWkm2vwSEVk=
X-Received: by 2002:a67:7c58:: with SMTP id x85mr37940337vsc.191.1559033626532;
 Tue, 28 May 2019 01:53:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190527124307.32075-1-narmstrong@baylibre.com> <20190527124307.32075-2-narmstrong@baylibre.com>
In-Reply-To: <20190527124307.32075-2-narmstrong@baylibre.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 28 May 2019 10:53:10 +0200
Message-ID: <CAPDyKFrDKkDO383buUzkWw_4wX15pNvexbHSvJAxHc-na4PSKw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: mmc: meson-gx: add dram-access-quirk property
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 May 2019 at 14:43, Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> On the Amlogic G12A SoC family, (only) the SDIO controller has a bug which
> makes any DRAM access from the MMC controller fail.
>
> Add the amlogic,dram-access-quirk property so signal this particular
> controller has this bug and needs a quirk to work properly.
>
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt
> index 13e70409e8ac..ccc5358db131 100644
> --- a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt
> +++ b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt
> @@ -22,6 +22,10 @@ Required properties:
>    clock rate requested by the MMC core.
>  - resets     : phandle of the internal reset line
>
> +Optional properties:
> +- amlogic,dram-access-quirk: set when controller's internal DMA engine cannot access the
> +  DRAM memory, like on the G12A dedicated SDIO controller.
> +
>  Example:
>
>         sd_emmc_a: mmc@70000 {
> --
> 2.21.0
>
