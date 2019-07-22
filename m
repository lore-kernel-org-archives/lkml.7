Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59505C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 21:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AD7021E70
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 21:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KT2OjFf4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730626AbfGVVCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 17:02:10 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40893 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730102AbfGVVCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 17:02:10 -0400
Received: by mail-pf1-f193.google.com with SMTP id p184so17946122pfp.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 14:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jw/FU1q0pCTK1VPg2x0ZxM+ApR0mweZ/rozgAV4xcGw=;
        b=KT2OjFf489hhPucfneku58TnKRsVBg+Jt6CDqvPVKCR4NuubivT2BmyRivFWO6rbbb
         Ac8IJLVNnfBmc506gjj/ssCkA4OXd6ZOPTSaarcwu62k8dqEhAPAasxmJJcx9MGQLB85
         QxbVuPV7lmscfJYgXuE4UyTsHwhG6cNqloosk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jw/FU1q0pCTK1VPg2x0ZxM+ApR0mweZ/rozgAV4xcGw=;
        b=LzvXuJ4NfXeUexYisVjOdgfm6GK5D0vQfW3Qi+2acQkh2U1wFc4T8ZEAEtv0P0nBrV
         yCCm4VUZtjSlhwtRDShvVO4uWLViRtO7xhof7DQrcE9t93Zgih2/M2T9CyXDyemU1Am6
         ugVxSmuaujBwu5Yjojr2sy4/y764EfUDuakEa3EKpqMErwkzb7FPjS04z9LJ9doFwE4k
         B8shANatmddW3mky7O3Fczo1lV6kUAxdxmsQ96Py6hyEvBEzFlfwL1+OlPCkDrwwyvuY
         oNVGE0PvkPwKvrJFpiPI08abqxcG+BEnuD6Jn+EGGMuprWj6+PsKLyS6L4S2B/kYK/tw
         IdMQ==
X-Gm-Message-State: APjAAAVnzJ/Y3t2aRCfSzxg4O2Hx4H89/hUYrOkrxGuRVuTLO/GFp5mF
        zgnWh/g5LlSCcRNWyzBw/LtJgA==
X-Google-Smtp-Source: APXvYqy0JMbb9a5jvwtfwKxQgHi6wKafXmWjMEI2PVTyNSoG3byUvxY11OdyC+FTFjRAHNVX00OMaA==
X-Received: by 2002:a62:17d3:: with SMTP id 202mr2111016pfx.198.1563829329650;
        Mon, 22 Jul 2019 14:02:09 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id j12sm31137923pff.4.2019.07.22.14.02.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 14:02:08 -0700 (PDT)
Date:   Mon, 22 Jul 2019 14:02:07 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Sean Paul <sean@poorly.run>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
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
Message-ID: <20190722210207.GZ250418@google.com>
References: <20190722181945.244395-1-mka@chromium.org>
 <20190722202426.GL104440@art_vandelay>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190722202426.GL104440@art_vandelay>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 04:24:26PM -0400, Sean Paul wrote:
> On Mon, Jul 22, 2019 at 11:19:45AM -0700, Matthias Kaehlcke wrote:
> > The DDC/CI protocol involves sending a multi-byte request to the
> > display via I2C, which is typically followed by a multi-byte
> > response. The internal I2C controller only allows single byte
> > reads/writes or reads of 8 sequential bytes, hence DDC/CI is not
> > supported when the internal I2C controller is used. The I2C
> 
> This is very likely a stupid question, but I didn't see an answer for it, so
> I'll just ask :)
> 
> If the controller supports xfers of 8 bytes and 1 bytes, could you just split
> up any of these transactions into len/8+len%8 transactions?

The controller interprets all transfers to be register accesses. It is
not possible to just send the sequence '0x0a 0x0b 0x0c' as three byte
transfers, the controller expects an address for each byte and
(supposedly) sends it over the wire, which typically isn't what you
want.

Also the 8-byte reads only seem to be supported in certain
configurations ("when the DWC_HDMI_TX_20 parameter is enabled").

> > transfers complete without errors, however the data in the response
> > is garbage. Abort transfers to/from slave address 0x37 (DDC) with
> > -EOPNOTSUPP, to make it evident that the communication is failing.
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> > Changes in v2:
> > - changed DDC_I2C_ADDR to DDC_CI_ADDR
> > ---
> >  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > index 045b1b13fd0e..28933629f3c7 100644
> > --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > @@ -35,6 +35,7 @@
> >  
> >  #include <media/cec-notifier.h>
> >  
> > +#define DDC_CI_ADDR		0x37
> >  #define DDC_SEGMENT_ADDR	0x30
> >  
> >  #define HDMI_EDID_LEN		512
> > @@ -322,6 +323,13 @@ static int dw_hdmi_i2c_xfer(struct i2c_adapter *adap,
> >  	u8 addr = msgs[0].addr;
> >  	int i, ret = 0;
> >  
> > +	if (addr == DDC_CI_ADDR)
> > +		/*
> > +		 * The internal I2C controller does not support the multi-byte
> > +		 * read and write operations needed for DDC/CI.
> > +		 */
> > +		return -EOPNOTSUPP;
> > +
> >  	dev_dbg(hdmi->dev, "xfer: num: %d, addr: %#x\n", num, addr);
> >  
> >  	for (i = 0; i < num; i++) {
> 
