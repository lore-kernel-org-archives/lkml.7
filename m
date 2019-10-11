Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F467C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 14:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09692206A1
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 14:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570804172;
	bh=1rf60D2w72rJvD2HR4NKDbi7Bsej0Rkvv/rHYisE7vY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GAX3aUue6z+wjHD7lDLhjxJ/L/9o6dP3d9QJQA54xShj+nCpEfvuBoPoLLLUyW8QE
	 QHyl9lfG3N6Mop2gk5MHrY/txGYYWc5yFcbHJpUZP4DFsLSut6VmA44hYcHBgqNxUm
	 bIVEHdYAun4RBTZD+PeE0rexCAURX+G0wURRuxlE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbfJKO3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 10:29:30 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33032 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728123AbfJKO3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 10:29:30 -0400
Received: by mail-oi1-f196.google.com with SMTP id a15so8175133oic.0;
        Fri, 11 Oct 2019 07:29:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0X1hghAJ29XYm0tUmf8FNz9k1l80AJy3GjZpN1F0pmk=;
        b=OEMbkFELfvtuRGgRxO6eeL96TWbwmNCgZbCJdwCSc0kjIfiodGia26Oc+mE7TSih+o
         nLqPcsnfsDhOY15z210OPQ4Za3l4SUcC6w5hTWCkfPz1WhFiYNG1ce1/o8FDD0fDH5VR
         9YjUMDoMLTyqAA9vYV9b9WvqhAZxjO7fsEkkxfemDRWBNb34Ayn/ozqYd977L4fkl3/5
         ufM2hcSn0JkdErS1YYrS0HSfAfY282nhVKKKSMhXHYNW0rInG/qg3+prQyaosBNt5r5a
         5dLzVs5/DyEgy77Qo3FlKQBd9s+rQgnWLOs3SK2CQ4rXLeIgN7GBbnBR06Eyl25Zy3Ff
         WJSA==
X-Gm-Message-State: APjAAAVu3u0bDvIe/imacLndzHf6Pbh8+xptNAoiVFelu4CKKx/JRSR4
        gXkkIF+tsuhTsUqfaz010IB2O/U=
X-Google-Smtp-Source: APXvYqwui5azj5/LBQ8YN/5iqD8CTtMpoje9cQuqiYX5Z73OvIq4kjOYrUchjSr9TmslZtEYKMScBw==
X-Received: by 2002:aca:36d5:: with SMTP id d204mr11992336oia.51.1570804168556;
        Fri, 11 Oct 2019 07:29:28 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m14sm2629238otl.26.2019.10.11.07.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 07:29:27 -0700 (PDT)
Date:   Fri, 11 Oct 2019 09:29:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     Marco Felsch <m.felsch@pengutronix.de>, mark.rutland@arm.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        manivannan.sadhasivam@linaro.org, andrew.smirnov@gmail.com,
        marex@denx.de, angus@akkea.ca, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        j.neuschaefer@gmx.net,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Subject: Re: [PATCH v3 2/3] ARM: dts: add Netronix E60K02 board common file
Message-ID: <20191011142927.GA11490@bogus>
References: <20191010192357.27884-1-andreas@kemnade.info>
 <20191010192357.27884-3-andreas@kemnade.info>
 <20191011065609.6irap7elicatmsgg@pengutronix.de>
 <20191011094148.1376430e@aktux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011094148.1376430e@aktux>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 09:41:48AM +0200, Andreas Kemnade wrote:
> On Fri, 11 Oct 2019 08:56:09 +0200
> Marco Felsch <m.felsch@pengutronix.de> wrote:
> 
> > Hi Andreas,
> > 
> > On 19-10-10 21:23, Andreas Kemnade wrote:
> > > The Netronix board E60K02 can be found some several Ebook-Readers,
> > > at least the Kobo Clara HD and the Tolino Shine 3. The board
> > > is equipped with different SoCs requiring different pinmuxes.
> > > 
> > > For now the following peripherals are included:
> > > - LED
> > > - Power Key
> > > - Cover (gpio via hall sensor)
> > > - RC5T619 PMIC (the kernel misses support for rtc and charger
> > >   subdevices).
> > > - Backlight via lm3630a
> > > - Wifi sdio chip detection (mmc-powerseq and stuff)
> > > 
> > > It is based on vendor kernel but heavily reworked due to many
> > > changed bindings.
> > > 
> > > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > > ---
> > > Changes in v3:
> > > - better led name
> > > - correct memory size
> > > - comments about missing devices
> > > 
> > > Changes in v2:
> > > - reordered, was 1/3
> > > - moved pinmuxes to their actual users, not the parents
> > >   of them
> > > - removed some already-disabled stuff
> > > - minor cleanups  
> > 
> > You won't change the muxing, so a this dtsi can be self contained?
> > 
> So you want me to put a big 
> #if defined(MX6SLL) 

Not sure what the comment meant, but no, don't do this. C defines in dts 
files are for symbolic names for numbers and assembling bitfields and 
that's it.

> [...]
>              pinctrl_i2c1: i2c1grp {
>                         fsl,pins = <
>                                 MX6SLL_PAD_I2C1_SCL__I2C1_SCL    0x4001f8b1
>                                 MX6SLL_PAD_I2C1_SDA__I2C1_SDA    0x4001f8b1
>                         >;
>                 };
> 
> #elif (MX6SL)
> [...]
>                pinctrl_i2c1: i2c1grp {
>                         fsl,pins = <
>                                 MX6SL_PAD_I2C1_SCL__I2C1_SCL     0x4001f8b1
>                                 MX6SL_PAD_I2C1_SDA__I2C1_SDA     0x4001f8b1
>                         >;
>                 };
> 
> #endif
> in the dtsi?
> 
> Regards,
> Andreas
