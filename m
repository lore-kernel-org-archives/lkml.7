Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BD5C4CEC8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 23:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A5AA20856
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 23:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mVclnYpU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbfILXWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 19:22:00 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33400 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbfILXV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 19:21:59 -0400
Received: by mail-pg1-f193.google.com with SMTP id n190so14275999pgn.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 16:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YmpY77tOjMlIBM+QNhtMQBjrqYVfrKFcyr6SgoPVdxU=;
        b=mVclnYpUotNVMVlsDFEnMjm9huupDI5osneDwNjpz3DEn7odTq1c2j3DWotgaHFfiP
         RrjHJyXSDm+jOs+8PAS76MemG0ZSxEVKxiDuzMSVkqgGaPZ+rBRIRjAdsDKGdsqmDTtV
         8Mt5Z3cBPNwe+5kJ6n1RslkClAwV6Wvjtx61BNTXpB7H7V+dtKgX9hc5up8a01GcBRgR
         1aygXyMNnQwQU56EcGzPJFVX4neoPPoyr92ld2d0Hs2kf0jf9Y5L3RTNqCXiFkcC2qFv
         z/cuxBvO5uT+Jm8RnPJQe231C5TPgiAibBCNfbVu/wM4UTIERhf0rLgrHxYfKtOwmB2t
         61+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YmpY77tOjMlIBM+QNhtMQBjrqYVfrKFcyr6SgoPVdxU=;
        b=lwhpNUvDo2vMi2KmQm7ugQUdGx96nYLWikm34LWu2WuiGsA8i9CtmRjUb28Tn1bqah
         E9cXbMywYwlsDtMjLkBeLAJzkzEb+1pRUIiFvfs7yNQxwfbq8lhaDYzo9bed4qc7d0WJ
         t4sb9qkLFGz0aYikZbGarae9tnSySovd0GVw2HmwfUMzJCvLKPnCm5SXvIrDfYEjAoPn
         baP6CcqpsbJRDnJyZAI6JgtStj94s40iCgUFnqnogSHSa1EcE69iPWIz8CQARibfvwq+
         hulOIzqxvJyyqz0mTsymoQX9H85A2QY8JonespGb/g17fTegP4dF321Bmsm1zD6iis2b
         LTiQ==
X-Gm-Message-State: APjAAAWQiVFuuSSDIP2J76aveVMoiTdDOe0TBp6H8yLmYyV3hfxEqG+M
        7UMwLDPLptwcYlK9RvI1w8o=
X-Google-Smtp-Source: APXvYqzjkWQvAVi05TsLPjjsDKWOcCu5aiWUyBmF1hRLmeD9T7T6K9HbN6XFLr4Amm9oqjG/SQ3UEQ==
X-Received: by 2002:a17:90a:e98e:: with SMTP id v14mr1337906pjy.101.1568330519125;
        Thu, 12 Sep 2019 16:21:59 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id q204sm33758013pfc.11.2019.09.12.16.21.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Sep 2019 16:21:58 -0700 (PDT)
Date:   Thu, 12 Sep 2019 16:21:37 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     "S.j. Wang" <shengjiu.wang@nxp.com>
Cc:     "timur@kernel.org" <timur@kernel.org>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXT] Re: [PATCH 1/3] ASoC: fsl_asrc: Use in(out)put_format
 instead of in(out)put_word_width
Message-ID: <20190912232136.GC24937@Asurada-Nvidia.nvidia.com>
References: <cover.1568025083.git.shengjiu.wang@nxp.com>
 <65e96ca15afd4a282b122f3ea8b13642cf4614c7.1568025083.git.shengjiu.wang@nxp.com>
 <20190909200156.GB10344@Asurada-Nvidia.nvidia.com>
 <VE1PR04MB6479D271F4271ECF404473E7E3B60@VE1PR04MB6479.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VE1PR04MB6479D271F4271ECF404473E7E3B60@VE1PR04MB6479.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 02:22:06AM +0000, S.j. Wang wrote:
> Hi
> 
> > 
> > On Mon, Sep 09, 2019 at 06:33:19PM -0400, Shengjiu Wang wrote:
> > > snd_pcm_format_t is more formal than enum asrc_word_width, which
> > has
> > > two property, width and physical width, which is more accurate than
> > > enum asrc_word_width. So it is better to use in(out)put_format instead
> > > of in(out)put_word_width.
> > 
> > Hmm...I don't really see the benefit of using snd_pcm_format_t here...I
> > mean, I know it's a generic one, and would understand if we use it as a
> > param for a common API. But this patch merely packs the "width" by
> > intentionally using this snd_pcm_format_t and then adds another
> > translation to unpack it.. I feel it's a bit overcomplicated. Or am I missing
> > something?
> > 
> > And I feel it's not necessary to use ALSA common format in our own "struct
> > asrc_config" since it is more IP/register specific.
> > 
> > Thanks
> > Nicolin
> > 
> 
> As you know, we have another M2M function internally, when user want to
> Set the format through M2M API, it is better to use snd_pcm_format_t instead the
> Width, for snd_pcm_format_t include two property, data with and physical width
> In driver some place need data width, some place need physical width.
> For example how to distinguish S24_LE and S24_3LE in driver,  DMA setting needs
> The physical width,  but ASRC need data width. 
> 
> Another purpose is that we have another new designed ASRC, which support more
> Formats, I would like it can share same API with this ASRC, using snd_pcm_format_t
> That we can use the common API, like snd_pcm_format_linear,
> snd_pcm_format_big_endian to get the property of the format, which is needed by
> driver.

I see. Just acked the patch.
