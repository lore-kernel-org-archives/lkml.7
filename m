Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F93C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 19:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3B4821655
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 19:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech-se.20150623.gappssmtp.com header.i=@ragnatech-se.20150623.gappssmtp.com header.b="ubZB15BK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbfI0TE6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 15:04:58 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38860 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfI0TE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 15:04:57 -0400
Received: by mail-lj1-f193.google.com with SMTP id b20so3528493ljj.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 12:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=4wbDflaWLhDcXWdkn217zW2gOLTlGF2zJ1ifl74VgLQ=;
        b=ubZB15BKquliImyXNHwo9tar2iWTGSsP40wD2TLXhbFGlPHtFD+lolFe6jSaUlp4Rw
         kcGqm1PWE4jdCeEN0YpdOPGiXLii3+d84FB+txjWNoBML7IeUWG3Sw3b9vvOVsXgzVTS
         g+TbkAL/i/E4awGMq55436a/KZwuSw1uoEq3/esIWrTAjLWH7shy0hEuaVhbcqqcvydb
         pYGoo/jK/5a8Ew17A9FxvOq3GweFNeo+mAtPCHHK3aQou5+55gVYovaIA5oY/f6L1jAD
         iUXaigvLe6XCXqOcBpNIn9RFJyctE/pY8S1c9Vl+y6r8rtHy8ndiKi2X6CJERT7xGq7V
         sx8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=4wbDflaWLhDcXWdkn217zW2gOLTlGF2zJ1ifl74VgLQ=;
        b=fhwUAJUG5UyanVhXZxCiqtpWHbex5FgTYRRnnfeRThkzKkiq0cR1Er8pkBm2X71gtH
         BACj/HO0fyVO730tF6eqXR0SWDEYrrbIYTsiEaz43HfUtre7xfv3eXPFsoQNJwpV9wsI
         OiixEdr4nfhNOKUYOYp/eyNyMQ1n+ADJJxqW1MPOZSAj92o3W/V8UrtN50SrHeyCIV6P
         M2f/kvNVupteTQzRtqmlYQcas96vDQac/fDXyV9y1nM5hQDosaT+Ky6en1nB6U5Dkcg5
         PC1fQdaHgzDRgv/MemfPMQqzrWZT9aKzWU4WEgK3fxCalCLG/lZZwHrbAEkUpreukZUT
         NKag==
X-Gm-Message-State: APjAAAUp+sageKXbKkKXcQvQWcvF+woxol+xDakcnzFGkchgQC3AbKtM
        2OdEkSUQ9ktIc0O73yKLtKZ60Q==
X-Google-Smtp-Source: APXvYqxX48CO66OpHtjCOmhPRC7/3r1MK4chmqYkk7WZKO3KsmdpcrZ33wvfHw4JKb/+UmHXmcLAKQ==
X-Received: by 2002:a2e:504f:: with SMTP id v15mr4102041ljd.67.1569611095285;
        Fri, 27 Sep 2019 12:04:55 -0700 (PDT)
Received: from localhost (h-93-159.A463.priv.bahnhof.se. [46.59.93.159])
        by smtp.gmail.com with ESMTPSA id w16sm614372lji.42.2019.09.27.12.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 12:04:54 -0700 (PDT)
Date:   Fri, 27 Sep 2019 21:04:54 +0200
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Matthew Michilot <matthew.michilot@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] media: i2c: adv7180: fix adv7280 BT.656-4 compatibility
Message-ID: <20190927190454.GA7409@bigcity.dyn.berto.se>
References: <20190827215539.1286-1-mmichilot@gateworks.com>
 <cb3e9be4-9ce6-354f-bb7c-a4710edc1c1b@xs4all.nl>
 <20190829142931.GZ28351@bigcity.dyn.berto.se>
 <CAJ+vNU11HTcP8L5J2Xg+Rmhvb8JDYemhJxt-GaGG5Myk3n38Tw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+vNU11HTcP8L5J2Xg+Rmhvb8JDYemhJxt-GaGG5Myk3n38Tw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tim,

Sorry for taking to so long to look at this.

On 2019-09-23 15:04:47 -0700, Tim Harvey wrote:
> On Thu, Aug 29, 2019 at 7:29 AM Niklas Söderlund
> <niklas.soderlund@ragnatech.se> wrote:
> >
> > Hi,
> >
> > On 2019-08-29 13:43:49 +0200, Hans Verkuil wrote:
> > > Adding Niklas.
> > >
> > > Niklas, can you take a look at this?
> >
> > I'm happy to have a look at this. I'm currently moving so all my boards
> > are in a box somewhere. I hope to have my lab up and running next week,
> > so if this is not urgent I will look at it then.
> >
> 
> Niklas,
> 
> Have you looked at this yet? Without this patch the ADV7280A does not
> output proper BT.656. We tested this on a Gateworks Ventana GW5404-G
> which uses the ADV7280A connected to the IMX6 CSI parallel bus. I'm
> hoping to see this get merged and perhaps backported to older kernels.

I only have access to an adv7180 so I was unable to test this patch.  
After reviewing the documentation I think the patch is OK if what you 
want is to unconditionally switch the driver from outputting BT.656-3 to 
outputting BT.656-4.

As this change would effect a large number of compat strings (adv7280, 
adv7280-m, adv7281, adv7281-m, adv7281-ma, adv7282, adv7282-m) and the 
goal is to back port it I'm a bit reluctant to adding my tag to this 
patch as I'm not sure if this will break other setups.

From the documentation about the BT.656-4 register (address 0x04 bit 7):

    Between Revision 3 and Revision 4 of the ITU-R BT.656 standards,
    the ITU has changed the toggling position for the V bit within
    the SAV EAV codes for NTSC. The ITU-R BT.656-4 standard
    bit allows the user to select an output mode that is compliant
    with either the previous or new standard. For further information,
    visit the International Telecommunication Union website.

    Note that the standard change only affects NTSC and has no
    bearing on PAL.

    When ITU-R BT.656-4 is 0 (default), the ITU-R BT.656-3
    specification is used. The V bit goes low at EAV of Line 10
    and Line 273.

    When ITU-R BT.656-4 is 1, the ITU-R BT.656-4 specification is
    used. The V bit goes low at EAV of Line 20 and Line 283.

Do you know what effects such a change would bring? Looking at the 
driver BT.656-4 seems to be set unconditionally for some adv7180 chips.

> 
> Regards,
> 
> Tim
> 
> > >
> > > Regards,
> > >
> > >       Hans
> > >
> > > On 8/27/19 11:55 PM, Matthew Michilot wrote:
> > > > From: Matthew Michilot <matthew.michilot@gmail.com>
> > > >
> > > > Captured video would be out of sync when using the adv7280 with
> > > > the BT.656-4 protocol. Certain registers (0x04, 0x31, 0xE6) had to
> > > > be configured properly to ensure BT.656-4 compatibility.
> > > >
> > > > An error in the adv7280 reference manual suggested that EAV/SAV mode
> > > > was enabled by default, however upon inspecting register 0x31, it was
> > > > determined to be disabled by default.

The manual I have [1] states that NEWAVMODE is switched off by default.  
I'm only asking as I would like to know if there is an error in that 
datasheet or not.

1. https://www.analog.com/media/en/technical-documentation/user-guides/ADV7280_7281_7282_7283_UG-637.pdf

> > > >
> > > > Signed-off-by: Matthew Michilot <matthew.michilot@gmail.com>
> > > > Reviewed-by: Tim Harvey <tharvey@gateworks.com>
> > > > ---
> > > >  drivers/media/i2c/adv7180.c | 15 +++++++++++++--
> > > >  1 file changed, 13 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/media/i2c/adv7180.c b/drivers/media/i2c/adv7180.c
> > > > index 99697baad2ea..27da424dce76 100644
> > > > --- a/drivers/media/i2c/adv7180.c
> > > > +++ b/drivers/media/i2c/adv7180.c
> > > > @@ -94,6 +94,7 @@
> > > >  #define ADV7180_REG_SHAP_FILTER_CTL_1      0x0017
> > > >  #define ADV7180_REG_CTRL_2         0x001d
> > > >  #define ADV7180_REG_VSYNC_FIELD_CTL_1      0x0031
> > > > +#define ADV7180_VSYNC_FIELD_CTL_1_NEWAV 0x12
> > > >  #define ADV7180_REG_MANUAL_WIN_CTL_1       0x003d
> > > >  #define ADV7180_REG_MANUAL_WIN_CTL_2       0x003e
> > > >  #define ADV7180_REG_MANUAL_WIN_CTL_3       0x003f
> > > > @@ -935,10 +936,20 @@ static int adv7182_init(struct adv7180_state *state)
> > > >             adv7180_write(state, ADV7180_REG_EXTENDED_OUTPUT_CONTROL, 0x57);
> > > >             adv7180_write(state, ADV7180_REG_CTRL_2, 0xc0);
> > > >     } else {
> > > > -           if (state->chip_info->flags & ADV7180_FLAG_V2)
> > > > +           if (state->chip_info->flags & ADV7180_FLAG_V2) {
> > > > +                   /* ITU-R BT.656-4 compatible */
> > > >                     adv7180_write(state,
> > > >                                   ADV7180_REG_EXTENDED_OUTPUT_CONTROL,
> > > > -                                 0x17);
> > > > +                                 ADV7180_EXTENDED_OUTPUT_CONTROL_NTSCDIS);
> > > > +                   /* Manually set NEWAVMODE */
> > > > +                   adv7180_write(state,
> > > > +                                 ADV7180_REG_VSYNC_FIELD_CTL_1,
> > > > +                                 ADV7180_VSYNC_FIELD_CTL_1_NEWAV);
> > > > +                   /* Manually set V bit end position in NTSC mode */
> > > > +                   adv7180_write(state,
> > > > +                                 ADV7180_REG_NTSC_V_BIT_END,
> > > > +                                 ADV7180_NTSC_V_BIT_END_MANUAL_NVEND);
> > > > +           }
> > > >             else
> > > >                     adv7180_write(state,
> > > >                                   ADV7180_REG_EXTENDED_OUTPUT_CONTROL,
> > > >
> > >
> >
> > --
> > Regards,
> > Niklas Söderlund

-- 
Regards,
Niklas Söderlund
