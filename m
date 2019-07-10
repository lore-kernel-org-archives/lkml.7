Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9180BC74A21
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5977A20645
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="MPgH/N4l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbfGJP10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 11:27:26 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46880 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbfGJP1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 11:27:25 -0400
Received: by mail-ed1-f65.google.com with SMTP id d4so2550968edr.13
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 08:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=SgkufzQSTv6apsZUdNJaHjQjszSiq6lRFJLPOSo/AdU=;
        b=MPgH/N4l+levG/VhKT8jjXObPZPdcPsPGW9l4OkxWmh5Mga2fY36xiK9/aWYGSDWoA
         bZRJFhK/XNZzPxm2cB6rV9EN2rfyFht230HqwAoiyw113/16g8xpwbQ4NmZqP/eQrGRT
         eHf2BSBk83dh088+VhXnml/jxzrTjM1zMyJMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=SgkufzQSTv6apsZUdNJaHjQjszSiq6lRFJLPOSo/AdU=;
        b=Ac/L9PBMkB4ix+4udOauH9JjwjnCtNs3zMj1g+GK7t04n87QYxDIKK6t8NS2Dn7XRx
         WgirPr+5ezIK95D1k14HGlndUeCcVwan4yCYzYbeXGPLFotm8TnJy1GhSKBSY9N8Q0rF
         7LjVtpABe50Y52GYc9e4oTi0blPkybEyWmtgsBzo3etfs9iF2MCI2nrpDHwtRQ01uy2p
         mq9yH6MIXGPnNu+7jl0XqJqJR84E8Ru0xJokhQlgeJ2agWXrT1pQ9xmrV8tN3EIWJktT
         xKO1pwr9PP93BVua3Arj2DDNO53eK7ZAZG66fD78BqCW/artxQGhkRUvZX5BycYxwX4U
         ea+A==
X-Gm-Message-State: APjAAAX/2ZVkAh2pahWDRZVwWIj37+ErJCw08eoP3tlyTpVzqtOmJzXV
        IrS3EA3CkAKYshz9X8gjibSPOA==
X-Google-Smtp-Source: APXvYqxigJ129/HrafCJTtiUL+NQg3j1KH4mPx69jB2LtBZDhrvgMPNuqQpiv9e5nrCEaY/ZCC3gxA==
X-Received: by 2002:a17:906:12d7:: with SMTP id l23mr26929442ejb.282.1562772443347;
        Wed, 10 Jul 2019 08:27:23 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id q50sm811398edd.91.2019.07.10.08.27.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 10 Jul 2019 08:27:22 -0700 (PDT)
Date:   Wed, 10 Jul 2019 17:27:20 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Philippe CORNU <philippe.cornu@st.com>
Cc:     Olivier MOYSAN <olivier.moysan@st.com>,
        "a.hajda@samsung.com" <a.hajda@samsung.com>,
        "narmstrong@baylibre.com" <narmstrong@baylibre.com>,
        "Laurent.pinchart@ideasonboard.com" 
        <Laurent.pinchart@ideasonboard.com>,
        "jonas@kwiboo.se" <jonas@kwiboo.se>,
        "jernej.skrabec@siol.net" <jernej.skrabec@siol.net>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "jsarha@ti.com" <jsarha@ti.com>
Subject: Re: [PATCH] drm/bridge: sii902x: add audio graph card support
Message-ID: <20190710152720.GR15868@phenom.ffwll.local>
Mail-Followup-To: Philippe CORNU <philippe.cornu@st.com>,
        Olivier MOYSAN <olivier.moysan@st.com>,
        "a.hajda@samsung.com" <a.hajda@samsung.com>,
        "narmstrong@baylibre.com" <narmstrong@baylibre.com>,
        "Laurent.pinchart@ideasonboard.com" <Laurent.pinchart@ideasonboard.com>,
        "jonas@kwiboo.se" <jonas@kwiboo.se>,
        "jernej.skrabec@siol.net" <jernej.skrabec@siol.net>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
        "linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>,
        "jsarha@ti.com" <jsarha@ti.com>
References: <1562141052-26221-1-git-send-email-olivier.moysan@st.com>
 <7c17b3f2-afee-7548-7620-b67d11d09b24@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c17b3f2-afee-7548-7620-b67d11d09b24@st.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 05, 2019 at 12:41:03PM +0000, Philippe CORNU wrote:
> Hi Olivier,
> and many thanks for your patch.
> Good to have the audio graph card support, looks ok.
> Reviewed-by: Philippe Cornu <philippe.cornu@st.com>

Since you have drm-misc commit rights I'm assuming you're going to push
this too. Correct?
-Daniel

> Philippe :-)
> 
> On 7/3/19 10:04 AM, Olivier Moysan wrote:
> > Implement get_dai_id callback of audio HDMI codec
> > to support ASoC audio graph card.
> > HDMI audio output has to be connected to sii902x port 3.
> > get_dai_id callback maps this port to ASoC DAI index 0.
> > 
> > Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
> > ---
> >   drivers/gpu/drm/bridge/sii902x.c | 23 +++++++++++++++++++++++
> >   1 file changed, 23 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
> > index dd7aa466b280..daf9ef3cd817 100644
> > --- a/drivers/gpu/drm/bridge/sii902x.c
> > +++ b/drivers/gpu/drm/bridge/sii902x.c
> > @@ -158,6 +158,8 @@
> >   
> >   #define SII902X_I2C_BUS_ACQUISITION_TIMEOUT_MS	500
> >   
> > +#define SII902X_AUDIO_PORT_INDEX		3
> > +
> >   struct sii902x {
> >   	struct i2c_client *i2c;
> >   	struct regmap *regmap;
> > @@ -690,11 +692,32 @@ static int sii902x_audio_get_eld(struct device *dev, void *data,
> >   	return 0;
> >   }
> >   
> > +static int sii902x_audio_get_dai_id(struct snd_soc_component *component,
> > +				    struct device_node *endpoint)
> > +{
> > +	struct of_endpoint of_ep;
> > +	int ret;
> > +
> > +	ret = of_graph_parse_endpoint(endpoint, &of_ep);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	/*
> > +	 * HDMI sound should be located at reg = <3>
> > +	 * Return expected DAI index 0.
> > +	 */
> > +	if (of_ep.port == SII902X_AUDIO_PORT_INDEX)
> > +		return 0;
> > +
> > +	return -EINVAL;
> > +}
> > +
> >   static const struct hdmi_codec_ops sii902x_audio_codec_ops = {
> >   	.hw_params = sii902x_audio_hw_params,
> >   	.audio_shutdown = sii902x_audio_shutdown,
> >   	.digital_mute = sii902x_audio_digital_mute,
> >   	.get_eld = sii902x_audio_get_eld,
> > +	.get_dai_id = sii902x_audio_get_dai_id,
> >   };
> >   
> >   static int sii902x_audio_codec_init(struct sii902x *sii902x,
> > 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
