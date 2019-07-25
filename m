Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818E4C76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54C872084C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="PONBzy9m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729943AbfGYRt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 13:49:29 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:40848 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbfGYRt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 13:49:28 -0400
Received: by mail-yw1-f68.google.com with SMTP id b143so19508586ywb.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 10:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OoM8RtRnrNUtmStwHC0+KsBVS4r5eOo6VxB/ZvbIcwo=;
        b=PONBzy9mx1DDK1v+PDvnFEOMsIP29+0jf0+9Dje+TouNHnF2UwKEqX8OOyaxBJTGnt
         OV1bfLoOuHYjXDoU1BlfXjNKFe7sEOIcGb+ox+V0IEmBiaF1/HnpmsGUxsy/A6Xigvab
         kdsVP8dDJdZssywclnmsA3ZUWVyamTEQmaG65pED40ts05lpsanvnqa/eOimkuHhGa8Q
         N3eYdh6fDyAMvUKnz++34Ux316nwQeeHe/IgOmUIfDFUTL3VNAit82ry0LJO2taTti33
         gcwZ38qJU33CNcpWNk7X7ujmL+v7j+g5FEb9c2vzDoq4VFSJHVMzmnUqwrOea8prtzZH
         pU7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OoM8RtRnrNUtmStwHC0+KsBVS4r5eOo6VxB/ZvbIcwo=;
        b=MWBuNPL6VUyMGhm8zLDAMSOEg1edyCS4qdsfjTuJPQpVLyxe2uyNisStR18EOs2c7b
         zi8ssHohzVMmLn5L5+8ueBDYzcTvBssOLUs0M5lXIixV06gBs7sD3hFVM+hPtlvr5RfO
         lAn47SGQodQu/vFp51TzFNccLA2+mK/iougABQvFE99q5q+EUvTBrejnCpWJ74ONL3g7
         9b+jdZOrimojIk6BSA96hxPjrOKIOF5bLizTKdoSgWrsrDpI68qPPF1706dj5O6gBrpo
         QUnTVKIgFEd4XIA5BxrX1ZEDn3+c+o9YPbVrrO64gam0ARh+fDECaYHCJY3giIUcmbbV
         a5nA==
X-Gm-Message-State: APjAAAWzmaCiFcOEFJ3lU6gbJJ0sq7c8ILnBQDAMSOQCVyTHh08V4Isr
        b4M586u6FVou8Z1xbP9gOvauZg==
X-Google-Smtp-Source: APXvYqxAHNazdJ/L/5l/x5/K71LHWoAyCkyD4hcgJI1CalnKgpmUThw46IPfZZiomqYwo37622E3Ig==
X-Received: by 2002:a81:a705:: with SMTP id e5mr52681935ywh.445.1564076967880;
        Thu, 25 Jul 2019 10:49:27 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id 131sm11662257ywq.21.2019.07.25.10.49.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 10:49:27 -0700 (PDT)
Date:   Thu, 25 Jul 2019 13:49:27 -0400
From:   Sean Paul <sean@poorly.run>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Sean Paul <sean@poorly.run>, Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Douglas Anderson <dianders@chromium.org>,
        Adam Jackson <ajax@redhat.com>
Subject: Re: [PATCH v2] drm/bridge: dw-hdmi: Refuse DDC/CI transfers on the
 internal I2C controller
Message-ID: <20190725174927.GN104440@art_vandelay>
References: <20190722181945.244395-1-mka@chromium.org>
 <20190722202426.GL104440@art_vandelay>
 <20190722210207.GZ250418@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722210207.GZ250418@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 02:02:07PM -0700, Matthias Kaehlcke wrote:
> On Mon, Jul 22, 2019 at 04:24:26PM -0400, Sean Paul wrote:
> > On Mon, Jul 22, 2019 at 11:19:45AM -0700, Matthias Kaehlcke wrote:
> > > The DDC/CI protocol involves sending a multi-byte request to the
> > > display via I2C, which is typically followed by a multi-byte
> > > response. The internal I2C controller only allows single byte
> > > reads/writes or reads of 8 sequential bytes, hence DDC/CI is not
> > > supported when the internal I2C controller is used. The I2C
> > 
> > This is very likely a stupid question, but I didn't see an answer for it, so
> > I'll just ask :)
> > 
> > If the controller supports xfers of 8 bytes and 1 bytes, could you just split
> > up any of these transactions into len/8+len%8 transactions?
> 
> The controller interprets all transfers to be register accesses. It is
> not possible to just send the sequence '0x0a 0x0b 0x0c' as three byte
> transfers, the controller expects an address for each byte and
> (supposedly) sends it over the wire, which typically isn't what you
> want.
> 
> Also the 8-byte reads only seem to be supported in certain
> configurations ("when the DWC_HDMI_TX_20 parameter is enabled").

Thanks for the detailed answers (both you and Doug)!

This change looks good to me, but I'll leave it to a dw-hdmi expert to apply. So
fwiw,

Reviewed-by: Sean Paul <sean@poorly.run>


> 
> > > transfers complete without errors, however the data in the response
> > > is garbage. Abort transfers to/from slave address 0x37 (DDC) with
> > > -EOPNOTSUPP, to make it evident that the communication is failing.
> > > 
> > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > ---
> > > Changes in v2:
> > > - changed DDC_I2C_ADDR to DDC_CI_ADDR
> > > ---
> > >  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > > 
> > > diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > > index 045b1b13fd0e..28933629f3c7 100644
> > > --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > > +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > > @@ -35,6 +35,7 @@
> > >  
> > >  #include <media/cec-notifier.h>
> > >  
> > > +#define DDC_CI_ADDR		0x37
> > >  #define DDC_SEGMENT_ADDR	0x30
> > >  
> > >  #define HDMI_EDID_LEN		512
> > > @@ -322,6 +323,13 @@ static int dw_hdmi_i2c_xfer(struct i2c_adapter *adap,
> > >  	u8 addr = msgs[0].addr;
> > >  	int i, ret = 0;
> > >  
> > > +	if (addr == DDC_CI_ADDR)
> > > +		/*
> > > +		 * The internal I2C controller does not support the multi-byte
> > > +		 * read and write operations needed for DDC/CI.
> > > +		 */
> > > +		return -EOPNOTSUPP;
> > > +
> > >  	dev_dbg(hdmi->dev, "xfer: num: %d, addr: %#x\n", num, addr);
> > >  
> > >  	for (i = 0; i < num; i++) {
> > 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
