Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FBCC606AF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 11:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD0AB20665
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 11:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TWIF5agX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730640AbfGHL4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 07:56:23 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:35095 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730628AbfGHL4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 07:56:21 -0400
Received: by mail-vk1-f196.google.com with SMTP id m17so2390111vkl.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 04:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BlFTfhz/+AEFhJwpYcJkS+wIUzBLziougjZpKo9Piqs=;
        b=TWIF5agXFrPqVLhH+NfmJmiehDiXhJ+xN3aAqZSxwJe6+ljAyd7mUl/ZZ+80TymJ+T
         NLZ7x/XJcjzCV+MoWwckhKOdysduppW6xjdeAjY4ivz7U8cnLwlV/7Kgq0AMvb7x4fLD
         7a7SUDYCyPoGnsPt5xEc9FfW6JReW7DNK21KBKV0QLtEAvigWxFIaXjGydrCWp0nJrWT
         3ZN54DlUDsM4MKb94aOff/maQDZ8AC05oWstdtWh8YR5mnHAQT3ybAYvGvMCVB+0/tx1
         ZGxdKWJtZ025LucQwuf1wSDUj8pVrF7LvUbvhvFoCm/oaAs+RuMvmKEhjC0gRYX100+i
         LEBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BlFTfhz/+AEFhJwpYcJkS+wIUzBLziougjZpKo9Piqs=;
        b=ghWugaLyupdj9hUXpvSp70ZAVk3tX9d1CPKavObQiej6fhMohJyaLgi1JFhgZ/uhvp
         BvBAz/tKl8Jda+OW2mqZQRuPyf38P4/sPBfzAQLWu+/xDnR4ODLyRdMX0rpSHWDwvBVs
         XvtbKjpaUHwwbPdBV4zbAs62t6QIFFylCXwmKqE6S6CSJ5++nIWsZYAurrmjunGaa7jY
         b4ITc7OOHEnIHNFUGTEIY44MOSogVDlfnHTdjqyMKiSXJ7EKYVYKEUUhF6HKiDAgOp+P
         KnoiTsjxDKKihs+N/bz/A8piiSOPmwpk8AC/o3CEYJd8MWhitRn9equQG+NqJcMciITH
         Nt+w==
X-Gm-Message-State: APjAAAXaILFc9Fq2SWNO7yhSqgRreJj2/e8ccGQYz1omxxQjM4o/LgqD
        RF4nj2GDcT/9aPXJ3mQMQIdRmHtXTCNOhN5sIvlC5A==
X-Google-Smtp-Source: APXvYqyW0ACrsmKwbRbIibahJxBuTjC2FXPE7anQ5O/bL4R0LL9Pn404YIp6kRpgzcc29K7udmDloODNZ4gsXmlTiko=
X-Received: by 2002:a1f:ab04:: with SMTP id u4mr4972793vke.40.1562586980668;
 Mon, 08 Jul 2019 04:56:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190624070345.20373-1-yamada.masahiro@socionext.com>
In-Reply-To: <20190624070345.20373-1-yamada.masahiro@socionext.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 8 Jul 2019 13:55:44 +0200
Message-ID: <CAPDyKFoBaYH+Rqn1heyUEJL-V=dm4dvx4JD31SK+uSS4vXiLXw@mail.gmail.com>
Subject: Re: [PATCH v2] dt-binding: mmc: rename tmio_mmc.txt to renesas,sdhi.txt
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Simon Horman <simon.horman@netronome.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jun 2019 at 09:04, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> As commit b6147490e6aa ("mmc: tmio: split core functionality, DMA and
> MFD glue") said, these MMC controllers use the IP from Panasonic.
>
> TMIO (Toshiba Mobile IO) MMC was the first upstreamed user of this IP.
> The common driver code was split and expanded as 'tmio-mmc-core', then
> it became historical misnomer since 'tmio' is not the name of this IP.
>
> In the discussion [1], we decide to keep this name as-is at least in
> Linux driver level because renaming everything is a big churn.
>
> However, DT should not be oriented to a particular project even though
> it is mainly developed in Linux communities.
>
> This is the misfortune only in Linux. Let's stop exporting it to other
> projects, where there is no good reason to call this hardware "TMIO".
> Rename the file to renesas,sdhi.txt. In fact, all the information in
> this file is specific to the Renesas platform.
>
> This commit also removes the first paragraph entirely. The DT-binding
> should describe the hardware. It is strange to talk about Linux driver
> internals such as how the drivers are probed, how platform data are
> handed off, etc.
>
> [1] https://www.spinics.net/lists/linux-mmc/msg46952.html
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
> Changes in v2:
>  - Rename to renesas,sdhi.txt instead of renesas_sdhi.txt
>
>  .../bindings/mmc/{tmio_mmc.txt => renesas,sdhi.txt}   | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
>  rename Documentation/devicetree/bindings/mmc/{tmio_mmc.txt => renesas,sdhi.txt} (87%)
>
> diff --git a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt b/Documentation/devicetree/bindings/mmc/renesas,sdhi.txt
> similarity index 87%
> rename from Documentation/devicetree/bindings/mmc/tmio_mmc.txt
> rename to Documentation/devicetree/bindings/mmc/renesas,sdhi.txt
> index 2b4f17ca9087..dd08d038a65c 100644
> --- a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/renesas,sdhi.txt
> @@ -1,13 +1,4 @@
> -* Toshiba Mobile IO SD/MMC controller
> -
> -The tmio-mmc driver doesn't probe its devices actively, instead its binding to
> -devices is managed by either MFD drivers or by the sh_mobile_sdhi platform
> -driver. Those drivers supply the tmio-mmc driver with platform data, that either
> -describe hardware capabilities, known to them, or are obtained by them from
> -their own platform data or from their DT information. In the latter case all
> -compulsory and any optional properties, common to all SD/MMC drivers, as
> -described in mmc.txt, can be used. Additionally the following tmio_mmc-specific
> -optional bindings can be used.
> +* Renesas SDHI SD/MMC controller
>
>  Required properties:
>  - compatible: should contain one or more of the following:
> --
> 2.17.1
>
