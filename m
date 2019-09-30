Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C57E3C35280
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 22:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99C2C21920
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 22:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569883723;
	bh=JcEw7uCIyE5jztsOeNcXfKUFexFxQswUUcMaCxIQGmE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1Lu1TYIKwaG58CB9HRfw3MC/212LikfEOncLee+gS1UipdqdGbDGPPT0pzgKlxzRF
	 Iu6+M03sF+O7J+e+NNTzgyDY2eOwF/t9YZ+UQyDjqPrgF9dYJRECTrentafxqA5leW
	 uhMijDGDuOd5U5z2wL1vR2mzj+kkSojGC2/Ac910=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731515AbfI3Wsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 18:48:43 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:40683 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbfI3Wsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 18:48:42 -0400
Received: by mail-ot1-f49.google.com with SMTP id y39so9847196ota.7;
        Mon, 30 Sep 2019 15:48:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D/dD00QphSzV/Ka38bzb5/CeWrEMk8mWwTGoFJZHq3k=;
        b=bkNxNnuFLSPNJX678qt7qerpWWx0VuFjY3XX6TmDjbNrEPPmzmg13KNb/q8puamy/v
         tVc96qWyq1utiiZhIlAGnI5U1Lx3cqFfrL7PgXgBwwvUOzR626nIgiaVouZQ59FgOQlT
         naLYi2N2K0fSbBA7pDeqw9XfCV4IOwxF7LkYtDwliP7j2BpVgpADQM2Sdpsu33wkpgEU
         27w/AwT1asykLVTr9I64bAlRBaZ/Z1y1wb43UoCxK9GeUUzbHrdk5ATJpgniXn+syytd
         Rtr0M0BMZuuopWcsAkF/xYWWqvPbMv5xtfuR63NN9q9D2cYLq7iyMG+G1zH3Lukwb/BK
         tXaw==
X-Gm-Message-State: APjAAAVWotVatJF3CA8aY+AYwXqyzdgfPOU9YHkXTC4lgnPPeXxhebV5
        wP9d8BPo0dlys8i/lN+sNQ==
X-Google-Smtp-Source: APXvYqy8N455WPCAznPZGY3kveDRglG9NszpcGNYi7iZk5py/XeRlVJI8/bg0hebWXyLQwk62+B+0w==
X-Received: by 2002:a9d:2f09:: with SMTP id h9mr5102050otb.21.1569883720195;
        Mon, 30 Sep 2019 15:48:40 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x140sm4772717oix.42.2019.09.30.15.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 15:48:39 -0700 (PDT)
Date:   Mon, 30 Sep 2019 17:48:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     Biwen Li <biwen.li@nxp.com>
Cc:     'Geert Uytterhoeven' <geert@linux-m68k.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [EXT] Re: [PATCH] devicetree: property-units: Add kohms unit
Message-ID: <20190930224838.GA27522@bogus>
References: <20190917075850.40039-1-biwen.li@nxp.com>
 <CAMuHMdUWue6-51Za7vejk=QkhV80iBXdc1E+6aTmQsvpB5AP-A@mail.gmail.com>
 <DB7PR04MB4490DD5F5A87EB796DE2A7A28F8F0@DB7PR04MB4490.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB7PR04MB4490DD5F5A87EB796DE2A7A28F8F0@DB7PR04MB4490.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 08:25:55AM +0000, Biwen Li wrote:
> > 
> > Caution: EXT Email
> > 
> > Hi Biwen,
> > 
> > On Tue, Sep 17, 2019 at 10:09 AM Biwen Li <biwen.li@nxp.com> wrote:
> > > The patch adds kohms unit
> > >
> > > Signed-off-by: Biwen Li <biwen.li@nxp.com>
> > 
> > Thanks for your patch!
> > 
> > > --- a/Documentation/devicetree/bindings/property-units.txt
> > > +++ b/Documentation/devicetree/bindings/property-units.txt
> > > @@ -27,6 +27,7 @@ Electricity
> > >  -microamp      : microampere
> > >  -microamp-hours : microampere hour
> > >  -ohms          : ohm
> > > +-kohms         : kiloohm
> > >  -micro-ohms    : microohm
> > >  -microwatt-hours: microwatt hour
> > >  -microvolt     : microvolt
> > 
> > What's your rationale for adding "kohms"?
> > Do you need to specify resistance values that do not fit in 32-bit, and thus
> 32-bit is enough, I have three values, 60 kohm, 100 kohm and 500 kohm
> > cannot be specified using "ohms"?
> If replace with ohms, the value is as follows:
> 60000 ohm, 100000 ohm, 500000 ohm.
> It's so long for everyone.

It's not any longer, it's still 32-bits.

Please stick with '-ohms'.

Rob
