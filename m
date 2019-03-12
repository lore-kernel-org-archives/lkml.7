Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44BAEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 19:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 110AF2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 19:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552418888;
	bh=Bkl93QxxNDbczulPqjkUf0h0Jvb3AJS89aJOBN/aXN8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bsZrSgsGY2+2lu8nVA3um/6v2vBRzqqlXCn2N4BqNNsx3ecUrkePPMNhOXHc4YDtP
	 5KJmyUT3L1LmAEuNtNzgO+zPq31ibO2lnQgcYwvPogFuhGzssOJ7Yq+ZEiaCLN34Cl
	 n4Xl8Efvm/D8Pf7YL3enD0yLMKfp9LWrdS8v9fd0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbfCLT2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 15:28:07 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36951 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbfCLT2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 15:28:06 -0400
Received: by mail-ot1-f67.google.com with SMTP id b3so3590753otp.4;
        Tue, 12 Mar 2019 12:28:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F9V4OMns3P/x6VFCcXVv5gZlRufgHPxnhWpwUoF+RYA=;
        b=HPigVKjB+T0qClY3+Cwhs8bqZBkcoSl5j7G1I8VVX5MPgzkb8aeUpSW0z2LQIRYeLB
         d5x4Kg2/WyOCKD4qK9SqUwDgQ/GpH8eu2SE0bomEBRmVG8RsiJ9DcwEcAsj/FwhAmqdk
         m34AVNE/f+uoGUvQKUZd884cGDuySdh+K+PEXY4hImsTWmuzZDqfN0rlUMcvoMtw4Lcb
         ryjepIGwtAkUon4xjJ/GTeLMxKunEU1pgnKOd9o+vniz72M7B3A632zMb4jpl5i+y2lP
         bezl/r+31WTcLN5vHUFNi5ocuGj/6H2X2wH3mqDTWGx5vQAIDMgvPAps+qD6Vy7tmAiD
         SVuw==
X-Gm-Message-State: APjAAAXpqKRlI9S8MWiGu33F6fZxQ4rKLNMdA081Ybgwo/z4bmilAayH
        KS2ikoU+s+cRX3q9maUZJQ==
X-Google-Smtp-Source: APXvYqzH6Uri43SuIyZUbzXYlN+lRz113WPkbkp/5scL1ASoY1HJHpFDWBw6NXcRf0mE40ZHyDhwBg==
X-Received: by 2002:a9d:3b23:: with SMTP id z32mr26521169otb.138.1552418885252;
        Tue, 12 Mar 2019 12:28:05 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 60sm4006727otw.50.2019.03.12.12.28.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 12:28:04 -0700 (PDT)
Date:   Tue, 12 Mar 2019 14:28:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Christoph Muellner <christoph.muellner@theobroma-systems.com>
Cc:     mark.rutland@arm.com, heiko@sntech.de, shawn.lin@rock-chips.com,
        ulf.hansson@linaro.org, adrian.hunter@intel.com,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Douglas Anderson <dianders@chromium.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Vicente Bergas <vicencb@gmail.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Randy Li <ayaka@soulik.info>,
        Tony Xie <tony.xie@rock-chips.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        Lin Huang <hl@rock-chips.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 2/3] dt-bindings: mmc: Add a new property
 disable-cqe-dcmd.
Message-ID: <20190312192803.GA19594@bogus>
References: <20190307084329.25416-1-christoph.muellner@theobroma-systems.com>
 <20190307084329.25416-2-christoph.muellner@theobroma-systems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307084329.25416-2-christoph.muellner@theobroma-systems.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 09:43:27AM +0100, Christoph Muellner wrote:
> This patch documents the new property disable-cqe-dcmd
> for the Arasan eMMC 5.1 driver.
> 
> Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
> Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
> ---
>  Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> index 1edbb049cccb..ec699bf98b7c 100644
> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> @@ -44,6 +44,10 @@ Optional Properties:
>      properly. Test mode can be used to force the controller to function.
>    - xlnx,int-clock-stable-broken: when present, the controller always reports
>      that the internal clock is stable even when it is not.
> +  - disable-cqe-dcmd: The eMMC 5.1 standard specifies direct commands (DCMDs)
> +    as part of the command queue engine (CQE). On controllers with a CQHCI,
> +    such as the Arasan eMMC 5.1 host controller, the driver has to enable DCMDs.
> +    This is done unless disable-cqe-dcmd is specified.

Should be common either for all controllers or all SDHCI controllers?
