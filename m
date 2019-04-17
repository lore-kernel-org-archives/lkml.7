Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5A6C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 18:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 245A220693
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 18:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8IF9zoV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732501AbfDQSf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 14:35:26 -0400
Received: from mail-pf1-f181.google.com ([209.85.210.181]:40144 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfDQSfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 14:35:25 -0400
Received: by mail-pf1-f181.google.com with SMTP id c207so12497600pfc.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 11:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nUEsRDGIX/MnBzMpthI1XaQPhS2DtMo0O3QUz3uE4lE=;
        b=L8IF9zoV9/4r9tJf5kZ1rIbB7qqRZmM3tAMTbVfeAzpgXDU+i+b2wMSNwUrzkqJgyf
         s4U2Y8ODPjKBHbKq8NPy70StqAuP7k0aphRVECU7VGOtLL6NQIFWvyJJkxAmnpvrjKaF
         mc5B3pum0z4WTFSgHe2H/ZgdYt1jyzdyFboODEZYpzUVf/Id0X+9whSWK/dOt6jik8er
         +oyM8bSiSGViIckz6zPagXeTj8EHbBPtdChS5g0lGHXIAYgaK3sNyy1TNZZf/q9O4hIf
         31e3xxBlliL0KHMUcSmoS9ML8KCmIXhoT6K4FqIbX+rR3zhLPXJmY3esAHyjJiZRBCV4
         HpxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nUEsRDGIX/MnBzMpthI1XaQPhS2DtMo0O3QUz3uE4lE=;
        b=OcEZ5lmWHNDlrA4vMnGs75McfWwo/xLsy9juyCnrXHA+a/9BmNDD9NJQhEmFyIoWZk
         9upGJ+DAxb0McLwaasXD6HITZVfxiyj+p9Cz26OZ8CnwopAHvKzhjeK/kuvCUo9N+wgT
         kNUIXYpBQEhdzNflJw+QARlTxSvPU5lOM1qQP1ACyomo4nXArXgogf+cVEGgUJq1N/TS
         Tzy5f9Pw3fIP2ElghJhqJRWYkq67NihV+4zEfhXTgsSn53kkNBwN72gV5URrix2bITxl
         LlahDmHjbrWEl51nmDRBZRaeK3wiKULyrSYYTbzPrhot/f1/rb2BW3ICkYxlHh27rIbA
         1/oQ==
X-Gm-Message-State: APjAAAUqNMl5OWEPF9pVObXvw3rSTQGr6OMfhC81LlW+zGftrMx/hhoC
        RUVTdAki1uiJfLNgDipk/0I=
X-Google-Smtp-Source: APXvYqwoBOIUFT3PPkYHkaJ893V7mgsjdr+l2Tc5sMkTepau78sRjs7Hy5CspJnDT/EAoWZ8/HVD3w==
X-Received: by 2002:a63:2157:: with SMTP id s23mr1241028pgm.436.1555526124703;
        Wed, 17 Apr 2019 11:35:24 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id b16sm75671630pfo.168.2019.04.17.11.35.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 11:35:24 -0700 (PDT)
Date:   Wed, 17 Apr 2019 11:35:19 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Daniel Baluta <daniel.baluta@gmail.com>,
        Cosmin-Gabriel Samoila <gabrielcsmo@gmail.com>
Cc:     Yue Haibing <yuehaibing@huawei.com>, Timur Tabi <timur@kernel.org>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        Linux-ALSA <alsa-devel@alsa-project.org>
Subject: Re: [PATCH -next] ASoC: fsl_micfil: Remove set but not used variable
 'osr'
Message-ID: <20190417183518.GA5073@Asurada-Nvidia.nvidia.com>
References: <20190417150915.37968-1-yuehaibing@huawei.com>
 <CAEnQRZAug2kQoFTN6W47URBKwHcU5Zmmy=04smOtMomuzz6_TA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEnQRZAug2kQoFTN6W47URBKwHcU5Zmmy=04smOtMomuzz6_TA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 06:25:11PM +0300, Daniel Baluta wrote:

> Looks good to me. Just one question for Cosmin:

> > diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
> > index 40c07e7..f7f2d29 100644
> > --- a/sound/soc/fsl/fsl_micfil.c
> > +++ b/sound/soc/fsl/fsl_micfil.c
> > @@ -151,12 +151,9 @@ static inline int get_clk_div(struct fsl_micfil *micfil,
> >  {
> >         u32 ctrl2_reg;
> >         long mclk_rate;
> > -       int osr;
> >         int clk_div;
> >
> >         regmap_read(micfil->regmap, REG_MICFIL_CTRL2, &ctrl2_reg);
> 
> I noticed now that we also read ctrl2_reg without using it. Is this as intended?

For Cosmin,

Same question here.

Btw, I just noticed that the initial patch of adding this driver
did not seemly include most of FSL maintainers/reviewers. Please
run get_maintainer.pl to add all listed reviewers when sending a
change to the maillist.

Thanks
Nicolin
