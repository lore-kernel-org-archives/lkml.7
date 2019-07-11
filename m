Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D100C74A4B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 10:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B691820872
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 10:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="WheCH8ID"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbfGKKZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 06:25:32 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40854 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727680AbfGKKZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 06:25:31 -0400
Received: by mail-ed1-f68.google.com with SMTP id k8so5249417eds.7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 03:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=7U2G4EIDTohj4GLJBc1CsAdYb3Srm8+cHCV4KhEDuP0=;
        b=WheCH8IDb1xLjYRkQ1wHhqBOQvwu9yadLjHXO+2GvTWatmnx3ohVHucMEFlWsb327e
         8oBL/JN3VnzQDpfznayYp5BYRXFtNz+qzfi7kDxf+viYPUc2s5/GMiZFA6C2e95tFaaH
         5eYJT5wwV5q1SpRg5tWMqZl9lM/DrKXjd8GJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=7U2G4EIDTohj4GLJBc1CsAdYb3Srm8+cHCV4KhEDuP0=;
        b=UsLYbGFHTDD32yglkfj5Z7EdAbohQ5ImDlL0omjmVMiGridPFuBkTZiNkyz5MsFNRF
         D94dIAQxj0lpPvBtqvls6qukYieD1HPk3WT/BAHLjU0WXjzpGXzVu63FTUzbFeaq31GS
         wccCvpkfg4YaywwUDYrggjbe5ansRBHDPQMp+EGQiULBpMifIDUQhuFTdPpn3JbHzkq1
         gBWa6ngcBwAnvmYf48ZA2vv0+R2rFpIn7lnRsJzOu3SyUoK9RPSoyNqU0Jh2vgLCi/oZ
         cnu8xpWhlD8WUXIM8LwaJEPY4HHNVTaZgw5jAq0wV+81OTJRqLWeITOMSDCH4d4VfP8+
         ipLA==
X-Gm-Message-State: APjAAAXmbdANpEuM/YZ77UX9T2ZnBWwq5S1PAVuYORZhn0/tODLeNfvt
        cVqWznXGtAuTMsDLFWAHoD4=
X-Google-Smtp-Source: APXvYqzOdFxx7QODvOuCnqI1mfdfr7m02Yx0mnJ15UPVOkEHhP7boRm7tJmqJjhEcUWKcHsDYq9N6A==
X-Received: by 2002:aa7:cd17:: with SMTP id b23mr2648368edw.278.1562840729665;
        Thu, 11 Jul 2019 03:25:29 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id y3sm1436461edr.27.2019.07.11.03.25.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 03:25:28 -0700 (PDT)
Date:   Thu, 11 Jul 2019 12:25:26 +0200
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
Message-ID: <20190711102526.GK15868@phenom.ffwll.local>
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
 <20190710152720.GR15868@phenom.ffwll.local>
 <e29c1671-99fb-581d-bfb7-61ca2cfa8622@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e29c1671-99fb-581d-bfb7-61ca2cfa8622@st.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2019 at 09:27:30AM +0000, Philippe CORNU wrote:
> Hi Daniel,
> 
> 
> On 7/10/19 5:27 PM, Daniel Vetter wrote:
> > On Fri, Jul 05, 2019 at 12:41:03PM +0000, Philippe CORNU wrote:
> >> Hi Olivier,
> >> and many thanks for your patch.
> >> Good to have the audio graph card support, looks ok.
> >> Reviewed-by: Philippe Cornu <philippe.cornu@st.com>
> > 
> > Since you have drm-misc commit rights I'm assuming you're going to push
> > this too. Correct?
> 
> Regarding this patch in particular, there is still missing an acked-by 
> from a "bridge" maintainer. Also it could be nice to wait for the 
> reviewed-by from Jiry as it knows well this sii driver and sent recently 
> good patches on it (already merged).

The bridge maintainer is looking for new bridge maintainers (atm we have
only one, defacto), so for bridge driver patches I really don't think it's
a good idea to gate on that single bottle-neck. Infrastructure is a bit a
different thing.

> With that, Benjamin or I (or a bridge maintainer) can push this patch + 
> the serie named "drm/bridge: sii902x: fix audio mclk management" as I 
> think it is better to push this serie *before* this patch.

Wahtever you feel like, just wanted to make sure you're not stuck
twiddling thumbs. The entire point of drm-misc is to facility mesh review
and maintainership, because the strict hierarchy just doesn't work for
smaller things. Exactly because you're always blocked on a bottleneck
somewhere.
-Daniel

> 
> Thanks,
> Philippe :-)
> 
> 
> >> Philippe :-)
> >>
> >> On 7/3/19 10:04 AM, Olivier Moysan wrote:
> >>> Implement get_dai_id callback of audio HDMI codec
> >>> to support ASoC audio graph card.
> >>> HDMI audio output has to be connected to sii902x port 3.
> >>> get_dai_id callback maps this port to ASoC DAI index 0.
> >>>
> >>> Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
> >>> ---
> >>>    drivers/gpu/drm/bridge/sii902x.c | 23 +++++++++++++++++++++++
> >>>    1 file changed, 23 insertions(+)
> >>>
> >>> diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
> >>> index dd7aa466b280..daf9ef3cd817 100644
> >>> --- a/drivers/gpu/drm/bridge/sii902x.c
> >>> +++ b/drivers/gpu/drm/bridge/sii902x.c
> >>> @@ -158,6 +158,8 @@
> >>>    
> >>>    #define SII902X_I2C_BUS_ACQUISITION_TIMEOUT_MS	500
> >>>    
> >>> +#define SII902X_AUDIO_PORT_INDEX		3
> >>> +
> >>>    struct sii902x {
> >>>    	struct i2c_client *i2c;
> >>>    	struct regmap *regmap;
> >>> @@ -690,11 +692,32 @@ static int sii902x_audio_get_eld(struct device *dev, void *data,
> >>>    	return 0;
> >>>    }
> >>>    
> >>> +static int sii902x_audio_get_dai_id(struct snd_soc_component *component,
> >>> +				    struct device_node *endpoint)
> >>> +{
> >>> +	struct of_endpoint of_ep;
> >>> +	int ret;
> >>> +
> >>> +	ret = of_graph_parse_endpoint(endpoint, &of_ep);
> >>> +	if (ret < 0)
> >>> +		return ret;
> >>> +
> >>> +	/*
> >>> +	 * HDMI sound should be located at reg = <3>
> >>> +	 * Return expected DAI index 0.
> >>> +	 */
> >>> +	if (of_ep.port == SII902X_AUDIO_PORT_INDEX)
> >>> +		return 0;
> >>> +
> >>> +	return -EINVAL;
> >>> +}
> >>> +
> >>>    static const struct hdmi_codec_ops sii902x_audio_codec_ops = {
> >>>    	.hw_params = sii902x_audio_hw_params,
> >>>    	.audio_shutdown = sii902x_audio_shutdown,
> >>>    	.digital_mute = sii902x_audio_digital_mute,
> >>>    	.get_eld = sii902x_audio_get_eld,
> >>> +	.get_dai_id = sii902x_audio_get_dai_id,
> >>>    };
> >>>    
> >>>    static int sii902x_audio_codec_init(struct sii902x *sii902x,
> >>>
> > 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
