Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01DEAC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 23:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C11F821855
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 23:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9aT+H8z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728790AbfGXXV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 19:21:26 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45180 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbfGXXV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 19:21:26 -0400
Received: by mail-pl1-f194.google.com with SMTP id y8so22591635plr.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 16:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kcok0LgBsyc/okZx1Ol3rmWhL5MLbD+99FlIboC+ndY=;
        b=B9aT+H8zZb0fNl2vjxmEtT81BPo37zTt5g98LCfuxuy01ddORWh/CB7Q3hnuQ/AX+s
         vowRpzcr6WtyMgKF69p7p/q6KxV83JR231xFia1doXz5wITR+X1KThH8F/31CZ+kYWE7
         H/PfmqrHNBQrYD7eylgT/EsKd/qOanXXwpV+mGeWJdiMWG3eAhPZNNuqg+EP1BZPuqk/
         jRpvuLLnnUf+/O56aqMvbYEjIfEDAOqr/mR56+/imvtR2yMv8sIexbWJd2q9bwB+m9Oa
         HYZ3T5czjU5hRe7Nuw3H73T5+nl9tG6oU29R3sPZm/zfGJZw0xYUb6mVuS2R8nRAG3U7
         8RiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kcok0LgBsyc/okZx1Ol3rmWhL5MLbD+99FlIboC+ndY=;
        b=dQC5H1iioR8nkgRJLz8jFYZCNPSkUWJ0rwzW1QBfy/yH6s/ye5mNydOZliiE/nO/Gc
         3u3NqwUebrV4L/lfT1GxTBjVMazyyOAlgcwGDzQtYqyTp4fsu0GbRx/gr/IV3x8iOeps
         d0rKAD5t83SDZYRIk5gCl3mjyMfPS0yNpPI9Q76D9YiFJMv6GVob1R7DiX+IpmOuwhWl
         zs3/zkvzBUaDeYo4tf3pv1y8HUQy8skq1oME6oPHOz6ttutXVzVJuJTy9FDMdHnOeAHj
         rDsvP4m70nYI0rxdJKilh4sXQ54Y2z/892fAe/XLJbQqqZREHY2A3kRsW2pjtAYsAmrW
         Xllw==
X-Gm-Message-State: APjAAAWyEtOSFW3y5moJmhJ/4ujZdXK14NX/t345KRCRpfHeb9gtw8P+
        tKroN38oz+rGDcnLO5LrHIg=
X-Google-Smtp-Source: APXvYqxwiudUxvu/coz792oUMUsi+3uSVa3zbEp1vcSY5LXXHGd7MfPYmIfYNlhGJTdsJVApfFFF4g==
X-Received: by 2002:a17:902:29c3:: with SMTP id h61mr44698653plb.37.1564010485328;
        Wed, 24 Jul 2019 16:21:25 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id g2sm61762399pfb.95.2019.07.24.16.21.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Jul 2019 16:21:25 -0700 (PDT)
Date:   Wed, 24 Jul 2019 16:22:09 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     broonie@kernel.org, festevam@gmail.com, perex@perex.cz,
        tiwai@suse.com, Xiubo.Lee@gmail.com, timur@kernel.org,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        shengjiu.wang@nxp.com, angus@akkea.ca, kernel@pengutronix.de,
        l.stach@pengutronix.de, viorel.suman@nxp.com
Subject: Re: [PATCH 08/10] ASoC: dt-bindings: Document fcomb_mode property
Message-ID: <20190724232209.GC6859@Asurada-Nvidia.nvidia.com>
References: <20190722124833.28757-1-daniel.baluta@nxp.com>
 <20190722124833.28757-9-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722124833.28757-9-daniel.baluta@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 03:48:31PM +0300, Daniel Baluta wrote:
> This allows combining multiple-data-line FIFOs into a
> single-data-line FIFO.
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  Documentation/devicetree/bindings/sound/fsl-sai.txt | 4 ++++

This should be sent to devicetree mail-list also.

>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl-sai.txt b/Documentation/devicetree/bindings/sound/fsl-sai.txt
> index 59f4d965a5fb..ca27afd840ba 100644
> --- a/Documentation/devicetree/bindings/sound/fsl-sai.txt
> +++ b/Documentation/devicetree/bindings/sound/fsl-sai.txt
> @@ -54,6 +54,10 @@ Optional properties:
>  			  represents first data line, bit 1 represents second
>  			  data line and so on. Data line is enabled if
>  			  corresponding bit is set to 1.
> +  - fsl,fcomb_mode	: list of two integers (first for RX, second for TX)
> +			  representing FIFO combine mode. Possible values for
> +			  combined mode are: 0 - disabled, 1 - Rx/Tx from shift
> +			  registers, 2 - Rx/Tx by software, 3 - both.

Looks like a software configuration to me, instead of a device
property. Is this configurable by user case, or hard-coded by
SoC/hardware design?
