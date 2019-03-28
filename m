Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D16C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9741020823
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfeksYdK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbfC1PSR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 11:18:17 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34287 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfC1PSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 11:18:16 -0400
Received: by mail-ed1-f66.google.com with SMTP id x14so14902473eds.1;
        Thu, 28 Mar 2019 08:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s5+k+JQM7cmlRGleHQLURHR6+zvpzSM9w1Zv9Wb0t3A=;
        b=kfeksYdK4LdONUAQi28t2vxTW97iuuWa7SMtBD2kG89I0Ld/1feoa3uT4uRp441caY
         aIMbwrVS/54ugMGd1OPneORz4TTcIsJjDjZv1VLMINClIrE59IKw+K+N5eaN9RMEGTRr
         ZWwA5bbYs8SZN0ieIJ2L811+3VitEqVs22pNxLMkecx39t6Je59lWZsdgPckVU7m8v81
         tJIaZAa6G2iofLOf7lROe4x+1bQMWb568MWmLmyrF33qWZYB50PnOvf42FZGEeUA7hJi
         F+mmm9rn3bd98dMPo+ITOnjrGSs+cgk5i/3AgN8vFtLft0S8Q896ttSYwLXbGTBRMZ+e
         IyHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s5+k+JQM7cmlRGleHQLURHR6+zvpzSM9w1Zv9Wb0t3A=;
        b=kSc83OQgTD4dA0mwLqcXVan1GqMwKiIJ5W5giqb8QnOo3VHIJL85sRmKEEo0g6fbPJ
         xKGPkvzt0Kvi1LzgYK6jNZxtJG3t1QVc+FqxvRHA9VDM8Lrx/y2WCgxbP7YpzmRPYkob
         Y6FeKJb+ehIbkPKeBrOybYrff9YxqGzSfLiLkJXwRBbrr5Nk+091F5zYeHqy9Z605UYG
         HaMJLr6Hs7pxQ8SWDUJFjt+inMxbC0n2hcCTERq1kVXiGQyGfweehzhf668u7+BLgc4v
         cZvsgkeKBCZRyqp5ncVknQ0PmyloIoNyG+fXD8jL9pZ/8Zbozdij5aiIeKI2jSsVtS7Y
         8VQQ==
X-Gm-Message-State: APjAAAUuzkE6LszcgoUaxgPy5dK0Gq87h0hSrAiVyo3nItQfGP58j2Ur
        3l7SFEqfo7ZbHyHbQHKtdl8RdnZ6DIzaRqUC74E=
X-Google-Smtp-Source: APXvYqyA5gC/rHDenDGzFKkz/xhlc2ugR0PVGu5GFb0UXRx6w1yEqxwLpz+Yxc22APR9oQbWNACTZE6q2TroeLRnuhs=
X-Received: by 2002:a17:906:3e48:: with SMTP id t8mr12859886eji.145.1553786294705;
 Thu, 28 Mar 2019 08:18:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190328133828.20999-1-angus@akkea.ca> <20190328133828.20999-4-angus@akkea.ca>
In-Reply-To: <20190328133828.20999-4-angus@akkea.ca>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Thu, 28 Mar 2019 17:18:03 +0200
Message-ID: <CAEnQRZDegwSih4BDsPiYHmoSCjtxCvO3-U+g1X27C6c_KE8fgw@mail.gmail.com>
Subject: Re: [PATCH 3/4] dt-bindings: Document the new imx8mq-sdma compatible string
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Carlo Caione <ccaione@baylibre.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 3:41 PM Angus Ainslie (Purism) <angus@akkea.ca> wrote:
>
> The imx8mq needs to be specified to check the clk ratio.
>
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
> ---
>  Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt b/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
> index 3c9a57a8443b..9d8bbac27d8b 100644
> --- a/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
> +++ b/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
> @@ -9,6 +9,7 @@ Required properties:
>        "fsl,imx53-sdma"
>        "fsl,imx6q-sdma"
>        "fsl,imx7d-sdma"
> +      "fsl,imx8mq-sdma"

You can drop this patch. It is already in Shwan's for-next branch.

The joy of working in parallel on similar things.

thanks,
Daniel.
