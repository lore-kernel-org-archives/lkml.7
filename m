Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2F9CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 14:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B97A62087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 14:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g0iggF+J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfJ3O6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 10:58:07 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:42437 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbfJ3O6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 10:58:07 -0400
Received: by mail-ua1-f67.google.com with SMTP id v2so773326uam.9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 07:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hNZcxEruvf8VcEgV12QG1AuNsmpJsv+vCmtArpIWJMY=;
        b=g0iggF+JgdTMYAr4mMgTLxZq7FZRkSb9aix7YOJppOGXwFuU39AeIlzKfye3jEC+Nf
         E5WhW0ayBApGA3e6LQAmfNOehFs4XaZLnjzC7ylbmSjiSkkzxa18yngDgVAy+YPdf8YF
         xzh4k4+vYJeNRay2Ay7FbZtxHpdDy9kXgIqZ559GP/rkZsw7YZC2nCN1T+d6UFyqsohT
         mV0Yy+ut1dtfibK++DcGkXDlgi70hfa8+iO/DVyt7lOw3AwJKDbcj0I3v6f5sNIdnQZ0
         DMRds/mSHEGNJOcd+6X5gfZlsom9I6uJ2Ww9uxmaFKR2KXDWn8SKCIRg7ZG/yv2Ldf++
         lVbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hNZcxEruvf8VcEgV12QG1AuNsmpJsv+vCmtArpIWJMY=;
        b=II3clAKDWpNp6aJcobhWuX2y4ZdNAsM00ULC4px9S7dw2An3P9fnfNZwCUn+odRp4o
         08S7YfWDn0GQD+mbU1VQ36iAlRHQuxRy8uxcssBpWbZ+3uuGwGjuyFLsKsQkntTSB9OI
         wCJazvw18x+sEDULNewFzauwC5zXdYthPymScOvo9uXdceBUrOew/jWwUl70k3P9vIxv
         JMoZVaiPeagcDjBVgafI54YyyIfv/Y9LMX899btAXMEKkh8WOseiyLkpQ/ksNwaenzKq
         Xmd8fklzPHvqZUAMDekhImBnZy1i+0RhnO0B64N49oAzQEuaqxhYK3gFOapi+xm/VSAK
         QzEQ==
X-Gm-Message-State: APjAAAXambNOSpt0ubO3e78bj31nqYepY3VKhqY+pDPOV3EpK4zRpDqm
        uZ47hMJhu4UtwZLF1LSFShxotZBckxbBaExckD2evQ==
X-Google-Smtp-Source: APXvYqxwRGxtAP844tj/7wkb9yqnOyn/FSj46ZD8hZRQHKMQoF9toDZna5qDMU5k6nneyPMsHKvQq6HgHENy9Dudpy8=
X-Received: by 2002:ab0:7095:: with SMTP id m21mr23352ual.15.1572447485669;
 Wed, 30 Oct 2019 07:58:05 -0700 (PDT)
MIME-Version: 1.0
References: <1572345042-101207-1-git-send-email-manish.narani@xilinx.com> <1572345042-101207-4-git-send-email-manish.narani@xilinx.com>
In-Reply-To: <1572345042-101207-4-git-send-email-manish.narani@xilinx.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 30 Oct 2019 15:57:29 +0100
Message-ID: <CAPDyKFqRmFPaiM=AoiWvy5xhYj=fHTt+S1wu8o0W67Nc5ZZ1kA@mail.gmail.com>
Subject: Re: [PATCH v4 4/8] dt-bindings: mmc: arasan: Add optional properties
 for Arasan SDHCI
To:     Manish Narani <manish.narani@xilinx.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michal Simek <michal.simek@xilinx.com>, jolly.shah@xilinx.com,
        nava.manne@xilinx.com, rajan.vaja@xilinx.com,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        git@xilinx.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Oct 2019 at 11:30, Manish Narani <manish.narani@xilinx.com> wrote:
>
> Add optional properties for Arasan SDHCI which are used to set clk delays
> for different speed modes in the controller.
>
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  .../devicetree/bindings/mmc/arasan,sdhci.txt     | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> index b51e40b2e0c5..c0f505b6cab5 100644
> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> @@ -46,6 +46,22 @@ Optional Properties:
>      properly. Test mode can be used to force the controller to function.
>    - xlnx,int-clock-stable-broken: when present, the controller always reports
>      that the internal clock is stable even when it is not.
> +  - arasan-clk-phase-legacy: Input/Output Clock Delay pair in degrees for Legacy Mode.
> +  - arasan-clk-phase-mmc-hs: Input/Output Clock Delay pair degrees for MMC HS.
> +  - arasan-clk-phase-sd-hs: Input/Output Clock Delay pair in degrees for SD HS.
> +  - arasan-clk-phase-uhs-sdr12: Input/Output Clock Delay pair in degrees for SDR12.
> +  - arasan-clk-phase-uhs-sdr25: Input/Output Clock Delay pair in degrees for SDR25.
> +  - arasan-clk-phase-uhs-sdr50: Input/Output Clock Delay pair in degrees for SDR50.
> +  - arasan-clk-phase-uhs-sdr104: Input/Output Clock Delay pair in degrees for SDR104.
> +  - arasan-clk-phase-uhs-ddr50: Input/Output Clock Delay pair in degrees for SD DDR50.
> +  - arasan-clk-phase-mmc-ddr52: Input/Output Clock Delay pair in degrees for MMC DDR52.
> +  - arasan-clk-phase-mmc-hs200: Input/Output Clock Delay pair in degrees for MMC HS200.
> +  - arasan-clk-phase-mmc-hs400: Input/Output Clock Delay pair in degrees for MMC HS400.

I don't mind if you convert these to common mmc bindings.

I think other controllers/platforms may find them useful, at least at
some point, if not already.

> +
> +  Above mentioned are the clock (phase) delays which are to be configured in the
> +  controller while switching to particular speed mode. The range of values are
> +  0 to 359 degrees. If not specified, driver will configure the default value
> +  defined for particular mode in it.
>
>  Example:
>         sdhci@e0100000 {
> --
> 2.17.1
>

Kind regards
Uffe
