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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80291C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 23:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A7ED21855
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 23:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sa4QuXYT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729683AbfGXXNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 19:13:00 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33138 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbfGXXM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 19:12:59 -0400
Received: by mail-pg1-f195.google.com with SMTP id f20so12725184pgj.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 16:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d+t+952qOGIU1AddOHVH/nDFUA90m4SMJ1NCUq2nKKI=;
        b=Sa4QuXYTDpG4z9VPVpCPn4be1hY1xZdVOzdRfkm5eeTmruwirxYioQZkmJndvCu/OF
         bzrzowYqU0xUjsFcb/9Gak318sfFLVIUWd1bEtZKQSov5e25ZaPricXKIHgcMDs0D9GX
         zM4mJcESv6Ad3QBx4ZTbbA70n96sGRf8fa97U7fgYq1Q7ckfFSCLwjZDEYTKFL4RE9Ft
         /noDhPKAvG871BL+wzXVGZMFh6VtQgbUW2K1P1E0a5GOgU3n9cNJKc903vD2QtySQcGn
         N/X+a3Lt7zuy7QItV4ewrlRjb576kj58NUH5FtirVnBLqvk8l5R+TPgYJ1PrxyBsAdIW
         EekA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d+t+952qOGIU1AddOHVH/nDFUA90m4SMJ1NCUq2nKKI=;
        b=S0dlMm5F6OJg6TwNmCNsKfZpIRtVIKTb0EGb5k56hNc+B2PVuXlU9ftmlhoWX1Lvgw
         BuM/LszkcEWjjNutsuHBhldRsMO7F45QeZGid46MKvFnWafmrdLuaKg03sSPFSDQiZrr
         ZtEFVJVvbFVxINAyKOgOmpMRjRxrX4uSy0a8Qmv198y0KQDEVO15vFq0n5z6ILkn0KVb
         Em8qdyyqRg1EOGZ5V6NG20YxOoQMaNIPUwT5UC/6Q9L0s5v6vJiCJPQh1TwV8tdEWpIA
         XQRBlekzfDAt3tfvHZgYZKgZaji5muaB/vDSJ2nDTIQgiPz/jtntxaRQm/WdgfWLSwOG
         fHKw==
X-Gm-Message-State: APjAAAUb09TZAdX8p4MJTTCNTI4AM2MeLVu1ZXTfbhnpUGfXvHOGFSgN
        0AwYZ3Sq1CnbaQDbta9dhto=
X-Google-Smtp-Source: APXvYqze9AAhyT3DRIx1dZFNDLjo8o8XIOYbw6gQScrKQK72ISZdadufL/dJOqjjN+UT+iUZgOd2WA==
X-Received: by 2002:a62:f20b:: with SMTP id m11mr13713991pfh.125.1564009979132;
        Wed, 24 Jul 2019 16:12:59 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id t9sm20439665pgj.89.2019.07.24.16.12.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Jul 2019 16:12:58 -0700 (PDT)
Date:   Wed, 24 Jul 2019 16:13:43 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     broonie@kernel.org, festevam@gmail.com, perex@perex.cz,
        tiwai@suse.com, Xiubo.Lee@gmail.com, timur@kernel.org,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        shengjiu.wang@nxp.com, angus@akkea.ca, kernel@pengutronix.de,
        l.stach@pengutronix.de, viorel.suman@nxp.com
Subject: Re: [PATCH 06/10] ASoC: dt-bindings: Document dl_mask property
Message-ID: <20190724231342.GB6859@Asurada-Nvidia.nvidia.com>
References: <20190722124833.28757-1-daniel.baluta@nxp.com>
 <20190722124833.28757-7-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722124833.28757-7-daniel.baluta@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 03:48:29PM +0300, Daniel Baluta wrote:
> SAI supports up to 8 data lines. This property let the user
> configure how many data lines should be used per transfer
> direction (Tx/Rx).
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  Documentation/devicetree/bindings/sound/fsl-sai.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl-sai.txt b/Documentation/devicetree/bindings/sound/fsl-sai.txt
> index 2e726b983845..59f4d965a5fb 100644
> --- a/Documentation/devicetree/bindings/sound/fsl-sai.txt
> +++ b/Documentation/devicetree/bindings/sound/fsl-sai.txt
> @@ -49,6 +49,11 @@ Optional properties:

> +  - fsl,dl_mask		: list of two integers (bitmask, first for RX, second

Not quite in favor of the naming here; And this patch should
be sent to the devicetree maillist and add DT maintainers --
they would give some good naming advice.

From my point of view, I feel, since data lines are enabled
consecutively, probably it'd be clear just to have something
like "fsl,num-datalines = <2 2>", corresponding to "dl_mask
= <0x3 0x3>". I believe there're examples in the existing DT
bindings, so let's see how others suggest.

> +			  for TX) representing enabled datalines. Bit 0
> +			  represents first data line, bit 1 represents second
> +			  data line and so on. Data line is enabled if
> +			  corresponding bit is set to 1.

Would be better to mention: "as a default use case, if this
property is absent, only the first data line will be enabled
for both TX and RX", since it's an optional property.

And one more extension(?) of it could be what if there's no
data line being physically connected for one direction, for
example "dl_mask = <0x0 0x1>", indicating that SAI enables
one single TX line only, so driver would disable RX feature.
What do you think?
