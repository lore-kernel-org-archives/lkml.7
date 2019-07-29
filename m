Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4BEC76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CDEA217D4
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oAW3tFK8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730582AbfG2UOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 16:14:24 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41282 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730525AbfG2UOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 16:14:22 -0400
Received: by mail-pg1-f194.google.com with SMTP id x15so18452937pgg.8;
        Mon, 29 Jul 2019 13:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a80YhmstvkFSvpLxuuKLo03NoSn39TaxaZX6joqs8MA=;
        b=oAW3tFK8X61jpoyXLcaKMiOnJ9TYUngRguXPgieCBQvf7vbjz8n4B8AGc7Yhk1Spov
         jfeQDaW7HSUgWSQJmGbemqCvojoYvAv060EXEN4coAflTTTFW0sx6k1g9dG+HbyQ+kqe
         qUQU0/i18Ci/UKnzWdJlUXx8+Ut03VJliGO3Ol7bvYUETBeW1y1xDi04lBy/SZvgDpl6
         zl+NaAyW5bW5WdKekXOjlSfdQ9oDmyL0jqEAmq32QjWeml/Tl0I1Yc31Je+9sTMrqGj4
         rjTSOmm/45LqyYqzmWonKjfTI0DCeWT4+80sPZ5FHFaQmYxVJ+gyW3Xw3n7TxC2z+RHd
         TgfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a80YhmstvkFSvpLxuuKLo03NoSn39TaxaZX6joqs8MA=;
        b=KI8aa0jgjSkK3Z5dBBMRdyHeYGw3E8+qhepVFpQud6JNPH9PGSdRWT9/DzbhZXvR1K
         CsGnIEjjEXllFPvk4HusQLsx9aQgl8qx0vaXYUwvVp3Nk5P7Nq+jybRTBFpuBOxXpsOW
         ai+2A7bBJ53wH097BNaRPAT8WJJEwPii54nWe9ky8WEodndIh+TZOaIbYUb4GyHC5agt
         x60UBCUf/cxA3r9NVfDgTG+YVq4ddZ5OZ2xO4klIuWOGAG1a8m/drYcK5T252HvlzeSf
         h6C0wo19A+Nx+YXV2XDgozOk+wYbM1lhmfiSG6/C785G3C5AgF8Bm+ov5kru4+sy0zFH
         Wi0w==
X-Gm-Message-State: APjAAAUsIxOxKSWUu52mJp9TYqmHs9yT0msxZWODMLJJwxd46wR6NQ4W
        dZpd16329kwbsAT2ReyJHhA=
X-Google-Smtp-Source: APXvYqzHimbts6Pzs9sE75ZW5J3eKE7GTyz7Rq8GUSY5Q6dToWV+ZKL5WQAvZY7dibUphM2oY0krmA==
X-Received: by 2002:a17:90a:9a83:: with SMTP id e3mr111562668pjp.105.1564431261030;
        Mon, 29 Jul 2019 13:14:21 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id i74sm122243034pje.16.2019.07.29.13.14.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jul 2019 13:14:20 -0700 (PDT)
Date:   Mon, 29 Jul 2019 13:15:09 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     broonie@kernel.org, l.stach@pengutronix.de, mihai.serban@gmail.com,
        alsa-devel@alsa-project.org, viorel.suman@nxp.com,
        timur@kernel.org, shengjiu.wang@nxp.com, angus@akkea.ca,
        tiwai@suse.com, linux-imx@nxp.com, kernel@pengutronix.de,
        festevam@gmail.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org
Subject: Re: [PATCH v2 4/7] ASoC: dt-bindings: Document dl-mask property
Message-ID: <20190729201508.GB20594@Asurada-Nvidia.nvidia.com>
References: <20190728192429.1514-1-daniel.baluta@nxp.com>
 <20190728192429.1514-5-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190728192429.1514-5-daniel.baluta@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2019 at 10:24:26PM +0300, Daniel Baluta wrote:
> SAI supports up to 8 data lines. This property let the user
> configure how many data lines should be used per transfer
> direction (Tx/Rx).

This sounds a bit less persuasive to me as we are adding a
DT property that's used to describe a hardware connections
and it would be probably better to mention that the mapping
between the mask and the data lines could be more flexible
than consecutive active data lines as you said previously.

> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  Documentation/devicetree/bindings/sound/fsl-sai.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl-sai.txt b/Documentation/devicetree/bindings/sound/fsl-sai.txt
> index 2e726b983845..2b38036a4883 100644
> --- a/Documentation/devicetree/bindings/sound/fsl-sai.txt
> +++ b/Documentation/devicetree/bindings/sound/fsl-sai.txt
> @@ -49,6 +49,13 @@ Optional properties:
>  
>    - big-endian		: Boolean property, required if all the SAI
>  			  registers are big-endian rather than little-endian.
> +  - fsl,dl-mask		: list of two integers (bitmask, first for RX, second

I am leaving this naming to DT maintainer.

> +			  for TX) representing enabled datalines. Bit 0
> +			  represents first data line, bit 1 represents second
> +			  data line and so on. Data line is enabled if
> +			  corresponding bit is set to 1. By default, if property
> +			  not present, only dataline 0 is enabled for both
> +			  directions.

To make this patch more convincing, could we add an example
as well in the Example section of this binding file? Like:
	/* RX data lines 0/1 and TX data lines 0/2 are connected */
	fsl,dl-mask = <0x3 0x5>;
