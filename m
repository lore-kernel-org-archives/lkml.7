Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11175C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 06:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEDA920693
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 06:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="igi9FKoy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729752AbfCYG2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 02:28:36 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:47058 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729608AbfCYG2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 02:28:35 -0400
Received: by mail-wr1-f67.google.com with SMTP id o1so8611160wrs.13
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 23:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=KnVyvfjUoGocd1C3YV2lm4OHoU9M451JCr37CgiusKA=;
        b=igi9FKoyjDFRI1jtmz7vwXLKxaMlFAWl0SvSTC3xZFsLQmXXa03BDnn/KVGV5cxDjx
         o/jL1yzCCKaEz3CjrS4LJkg5jZollwegBaWALEsaP88lA7ReLxjmROurDHZPW+r5zGTW
         Tn6OlRFsk3GFlq+rBF1PqzWt19RqNDsfpAK9S0KVJRpJpGhPJvJ1dGLBeVEsm57Vk1rU
         uxouGIpLellvCnwVUKZ8Dy2fnDE/KMkjpA3XHUrsICuPTR+jm0O/BxroVko1MfbwNnAi
         eeMax5WOSyuWN77ljq19+cUM/qskn7y9s0P6B567MR5c0h5kssIlLKsI9G0MNNlAPKUR
         lhXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=KnVyvfjUoGocd1C3YV2lm4OHoU9M451JCr37CgiusKA=;
        b=lofbPqr9zn8vgUjmuvgG1zWzXOSDUvucFyPYCIM+US6h8aVWG/KI+8bFPPhvcgpOAy
         V8w+Y4lOL4z/dMDU8JVdrm07U8Z0/Bykotg6GFpy79iHCP/ddx4FCEI8nm6CWkMIcdJR
         RfJC4NonRdxVNi7yOTdsf7BiabVyO8Vrh+3vNx93Rcg9Pnv1SGrAMWrN+qVxURz7PMg9
         EsLsqAQJ66ZeYYajNryLEBNxjv2kHJ6clJz4Mr+Y7mjFL9patS3NANSyniA73BUiIpjP
         oookAzsOIvJeBwzu59K5MRmi7N22Zg2XSkA5a07sABZUhqfb0A3Dk/d0CqZILp97Ghvt
         JuVw==
X-Gm-Message-State: APjAAAWZP6YGEERmDr3nni+DXxR15vziENRz5BbO4YPpT2s4CwTS9hQ1
        ltIuzVcHEISgxRluRn+4aZ9pIg==
X-Google-Smtp-Source: APXvYqxrEu8V0gGf5E4goW1/chD9i3yJOcItDDwjZ7M0fOd66vWcUOCsd9el2SnQdF5u/za8AHA83g==
X-Received: by 2002:adf:fb05:: with SMTP id c5mr13908207wrr.297.1553495313707;
        Sun, 24 Mar 2019 23:28:33 -0700 (PDT)
Received: from dell ([2.27.167.37])
        by smtp.gmail.com with ESMTPSA id f20sm36722597wrg.91.2019.03.24.23.28.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Mar 2019 23:28:32 -0700 (PDT)
Date:   Mon, 25 Mar 2019 06:28:30 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "elven.wang@nxp.com" <elven.wang@nxp.com>,
        "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "angus.ainslie@puri.sm" <angus.ainslie@puri.sm>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "anson.huang@nxp.com" <anson.huang@nxp.com>,
        "matt.vaittinen@fi.rohmeurope.com" <matt.vaittinen@fi.rohmeurope.com>,
        "yibin.gong@nxp.com" <yibin.gong@nxp.com>,
        "Haikola, Heikki" <Heikki.Haikola@fi.rohmeurope.com>
Subject: Re: [PATCH v3 1/3] devicetree: bindings: bd718x7: document HW state
 related ROHM specific properties
Message-ID: <20190325062830.GV4731@dell>
References: <cover.1550135853.git.matti.vaittinen@fi.rohmeurope.com>
 <6ed4238fb083f52de0f5f013647b2334bad8ebe4.1550135853.git.matti.vaittinen@fi.rohmeurope.com>
 <20190320130259.GN4731@dell>
 <20190320141701.GA6208@localhost.localdomain>
 <20190321082338.GT4731@dell>
 <74b5d125c5cac75b3ab37ff2202966fb3f3395a1.camel@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <74b5d125c5cac75b3ab37ff2202966fb3f3395a1.camel@fi.rohmeurope.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Mar 2019, Vaittinen, Matti wrote:

> On Thu, 2019-03-21 at 08:23 +0000, Lee Jones wrote:
> > On Wed, 20 Mar 2019, Matti Vaittinen wrote:
> > 
> > > Hello Lee, All
> > > 
> > > On Wed, Mar 20, 2019 at 01:02:59PM +0000, Lee Jones wrote:
> > > > On Thu, 14 Feb 2019, Matti Vaittinen wrote:
> > > > 
> > > > > Add ROHM BD71837 / BD71847 specific device tree bindings for
> > > > > controlling the PMIC shutdown/reset states and voltages for
> > > > > different HW states. The PMIC was designed to be used with NXP
> > > > > i.MX8 SoC and it supports SNVS low power state which seems to
> > > > > be typical for NXP i.MX SoCs. However, when SNVS is used we
> > > > > must
> > > > > not allow SW to control enabling/disabling those regulators
> > > > > which
> > > > > are crucial for system to boot as there is a HW limitation
> > > > > which
> > > > > causes SW controlled regulators to be kept shut down after SNVS
> > > > > reset.
> > > > > 
> > > > > Allow setting the SNVS to be used as reset target state and
> > > > > allow
> > > > > marking those regulators which are critical for boot.
> > > > > 
> > > > > Signed-off-by: Matti Vaittinen <
> > > > > matti.vaittinen@fi.rohmeurope.com>
> > > > > ---
> > > > >  .../devicetree/bindings/mfd/rohm,bd71837-pmic.txt  | 17
> > > > > ++++++++++
> > > > >  .../bindings/regulator/rohm,bd71837-regulator.txt  | 38
> > > > > ++++++++++++++++++++++
> > > > >  2 files changed, 55 insertions(+)
> > > > 
> > > > Needs a DT Ack.
> > > 
> > > I think this was already applied to regulator tree by Mark:
> > > 
> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git/commit/?h=for-next&id=f43d1b388f9be4aa47ed42c33659243a675c5c76
> > > Does it go in via his tree or do we need to apply it in Lee's tree
> > > too?
> > 
> > Why don't I see an email from Mark?
> 
> https://lore.kernel.org/lkml/20190214160025.65B8E1126F78@debutante.sirena.org.uk/
> 
> Maybe that's what you're looking for?

It is, but I need this in my inbox.

Mark, could you please take the time to fix your scripts please?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
