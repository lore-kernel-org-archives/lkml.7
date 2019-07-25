Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5042C76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABDCC206DD
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lOQLyh4Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403750AbfGYRoq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 13:44:46 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37350 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388291AbfGYRop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 13:44:45 -0400
Received: by mail-oi1-f195.google.com with SMTP id t76so38299296oih.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 10:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YcakAwhbTJoGYOpuC9oEF2WLvqGmsUfwK1z2nnLHMx8=;
        b=lOQLyh4ZNknNXbKWG97od/UX1813pei3SQYOlzqfOBssMSPnPm/s9PBy7maBCSRQR+
         6K6LuD8sKfW7wZdMb04oWNrprN/bwJU8opJUc/hN6RVCS3BW5KS+df7hEe4j5phFRaVN
         5xan32Z6xKmFJh4YvSrz+IewIJvJIywhpqXNvxm/g8UixovFxlF9XcS74wn/iNu5vDTN
         jcV59QX4f940eW515Aa+C5zzgAmgb/9KZ8wM7r6Bykq2UrPIOebXD5uUAOf3nZEITFr+
         pUKgyZ/lXzgKGxxqtAGOOqBOpVIGWe1OKpuQIC7HbaWSj1rH1Hcd2+0fPCBLbrtDmd9J
         +ufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YcakAwhbTJoGYOpuC9oEF2WLvqGmsUfwK1z2nnLHMx8=;
        b=O0T5Td/vQLKhVYoke7g3oYjo5jEtQJYHrKIUPfKEA1DCgTq/k1elQteqFA1j9PXCQA
         h1S2dWW2Rek5Y4fkQ9RnBD82z+ggaS9rwuhrGdVCkN6EXg2GV9k0W1xBRWbbBMTcCCww
         wsnmkAtG8r1spk6OF39tiS8PYn8Wi06pQtsVMVd00JRuykQO1gQvXcAV12Q+hAia08ii
         cwAzorjdFL2JrZrpyjjW6PQGdM9UYqR8DZQYpO5FBEVKiQbAzZ08d04opclBQD+PPNyr
         3emRt5ny7nsB8X7gxlhxU9/RLywwkCLSsz5SqMprgHVtaBG0dTHRz7tFhZUTa6KO8ZgM
         84xQ==
X-Gm-Message-State: APjAAAWYmGvEwDfN/fQbe8UE4HV45qle3psUvchqNMonzYp8tLDuIeF+
        N4EZXlIa9e3C6D3PW3vbjgAtFZvW5h0=
X-Google-Smtp-Source: APXvYqzB6wcKueZqL/f5Yl4DSRC0xnwviVPYuE27V4XggjeaSOX7/Y1xUexB+LH0hHqnf6Kelh3OAQ==
X-Received: by 2002:a65:6415:: with SMTP id a21mr74594225pgv.98.1564076314666;
        Thu, 25 Jul 2019 10:38:34 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id e10sm51619090pfi.173.2019.07.25.10.38.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Jul 2019 10:38:34 -0700 (PDT)
Date:   Thu, 25 Jul 2019 10:39:19 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Daniel Baluta <daniel.baluta@gmail.com>
Cc:     Daniel Baluta <daniel.baluta@nxp.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Viorel Suman <viorel.suman@nxp.com>,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, "S.j. Wang" <shengjiu.wang@nxp.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [alsa-devel] [PATCH 08/10] ASoC: dt-bindings: Document
 fcomb_mode property
Message-ID: <20190725173918.GD31961@Asurada-Nvidia.nvidia.com>
References: <20190722124833.28757-1-daniel.baluta@nxp.com>
 <20190722124833.28757-9-daniel.baluta@nxp.com>
 <20190724232209.GC6859@Asurada-Nvidia.nvidia.com>
 <CAEnQRZBW7LNZ7=c_h_ef4ZDcbFzEt61h4VAJSLo2Fb80kBqtpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEnQRZBW7LNZ7=c_h_ef4ZDcbFzEt61h4VAJSLo2Fb80kBqtpw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 09:02:22AM +0300, Daniel Baluta wrote:
> On Thu, Jul 25, 2019 at 2:22 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> >
> > On Mon, Jul 22, 2019 at 03:48:31PM +0300, Daniel Baluta wrote:
> > > This allows combining multiple-data-line FIFOs into a
> > > single-data-line FIFO.
> > >
> > > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> > > ---
> > >  Documentation/devicetree/bindings/sound/fsl-sai.txt | 4 ++++
> >
> > This should be sent to devicetree mail-list also.
> >
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/sound/fsl-sai.txt b/Documentation/devicetree/bindings/sound/fsl-sai.txt
> > > index 59f4d965a5fb..ca27afd840ba 100644
> > > --- a/Documentation/devicetree/bindings/sound/fsl-sai.txt
> > > +++ b/Documentation/devicetree/bindings/sound/fsl-sai.txt
> > > @@ -54,6 +54,10 @@ Optional properties:
> > >                         represents first data line, bit 1 represents second
> > >                         data line and so on. Data line is enabled if
> > >                         corresponding bit is set to 1.
> > > +  - fsl,fcomb_mode   : list of two integers (first for RX, second for TX)
> > > +                       representing FIFO combine mode. Possible values for
> > > +                       combined mode are: 0 - disabled, 1 - Rx/Tx from shift
> > > +                       registers, 2 - Rx/Tx by software, 3 - both.
> >
> > Looks like a software configuration to me, instead of a device
> > property. Is this configurable by user case, or hard-coded by
> > SoC/hardware design?
> 
> Indeed this is a software configuration and configurable by user case.
> Will think of a another way to specify it.

Yea, it needs to be put somewhere else other than devicetree.

Not sure sysfs is a good approach for ASoC components or can
be done via amixer control.
