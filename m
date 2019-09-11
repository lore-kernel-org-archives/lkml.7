Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A16A1C49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 16:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72EC82084F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 16:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729487AbfIKQy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 12:54:26 -0400
Received: from mailoutvs23.siol.net ([185.57.226.214]:40212 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729310AbfIKQy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 12:54:26 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id 44A12522489;
        Wed, 11 Sep 2019 18:54:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id JqGzle1UahVN; Wed, 11 Sep 2019 18:54:19 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id 9203F521CBC;
        Wed, 11 Sep 2019 18:54:19 +0200 (CEST)
Received: from jernej-laptop.localnet (cpe-86-58-59-25.static.triera.net [86.58.59.25])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Zimbra) with ESMTPA id 8399E522314;
        Wed, 11 Sep 2019 18:54:16 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Cheng-Yi Chiang <cychiang@chromium.org>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, airlied@linux.ie,
        daniel@ffwll.ch, kuninori.morimoto.gx@renesas.com,
        sam@ravnborg.org, dianders@chromium.org, dgreid@chromium.org,
        tzungbi@chromium.org, zhengxing@rock-chips.com,
        cain.cai@rock-chips.com, eddie.cai@rock-chips.com,
        jeffy.chen@rock-chips.com, kuankuan.y@gmail.com,
        enric.balletbo@collabora.com, dri-devel@lists.freedesktop.org,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Yakir Yang <ykk@rock-chips.com>
Subject: Re: [PATCH v3] drm: bridge/dw_hdmi: add audio sample channel status setting
Date:   Wed, 11 Sep 2019 18:54:16 +0200
Message-ID: <10668907.r1TyVuJQb1@jernej-laptop>
In-Reply-To: <1e2ec69d-e42d-4e1b-7ce9-d1620cfbb4c9@baylibre.com>
References: <20190911082646.134347-1-cychiang@chromium.org> <1e2ec69d-e42d-4e1b-7ce9-d1620cfbb4c9@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sreda, 11. september 2019 ob 18:23:59 CEST je Neil Armstrong napisal(a):
> On 11/09/2019 10:26, Cheng-Yi Chiang wrote:
> > From: Yakir Yang <ykk@rock-chips.com>
> > 
> > When transmitting IEC60985 linear PCM audio, we configure the
> > Aduio Sample Channel Status information in the IEC60958 frame.
> > The status bit is already available in iec.status of hdmi_codec_params.
> > 
> > This fix the issue that audio does not come out on some monitors
> > (e.g. LG 22CV241)
> > 
> > Note that these registers are only for interfaces:
> > I2S audio interface, General Purpose Audio (GPA), or AHB audio DMA
> > (AHBAUDDMA).
> > For S/PDIF interface this information comes from the stream.
> > 
> > Currently this function dw_hdmi_set_channel_status is only called
> > from dw-hdmi-i2s-audio in I2S setup.
> > 
> > Signed-off-by: Yakir Yang <ykk@rock-chips.com>
> > Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> > ---
> > 
> > Change from v2 to v3:
> > 1. Reuse what is already set in iec.status in hw_param.
> > 2. Remove all useless definition of registers and values.
> > 3. Note that the original sampling frequency is not written to
> > 
> >    the channel status as we reuse create_iec958_consumer in pcm_iec958.c.
> >    Without that it can still play audio fine.
> >  
> >  .../drm/bridge/synopsys/dw-hdmi-i2s-audio.c   |  1 +
> >  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c     | 20 +++++++++++++++++++
> >  drivers/gpu/drm/bridge/synopsys/dw-hdmi.h     |  2 ++
> >  include/drm/bridge/dw_hdmi.h                  |  1 +
> >  4 files changed, 24 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
> > b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c index
> > 34d8e837555f..20f4f92dd866 100644
> > --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
> > +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
> > @@ -102,6 +102,7 @@ static int dw_hdmi_i2s_hw_params(struct device *dev,
> > void *data,> 
> >  	}
> >  	
> >  	dw_hdmi_set_sample_rate(hdmi, hparms->sample_rate);
> > 
> > +	dw_hdmi_set_channel_status(hdmi, hparms->iec.status);
> > 
> >  	dw_hdmi_set_channel_count(hdmi, hparms->channels);
> >  	dw_hdmi_set_channel_allocation(hdmi, hparms-
>cea.channel_allocation);
> > 
> > diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c index
> > bd65d0479683..aa7efd4da1c8 100644
> > --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > @@ -582,6 +582,26 @@ static unsigned int hdmi_compute_n(unsigned int freq,
> > unsigned long pixel_clk)> 
> >  	return n;
> >  
> >  }
> > 
> > +/*
> > + * When transmitting IEC60958 linear PCM audio, these registers allow to
> > + * configure the channel status information of all the channel status
> > + * bits in the IEC60958 frame. For the moment this configuration is only
> > + * used when the I2S audio interface, General Purpose Audio (GPA),
> > + * or AHB audio DMA (AHBAUDDMA) interface is active
> > + * (for S/PDIF interface this information comes from the stream).
> > + */
> > +void dw_hdmi_set_channel_status(struct dw_hdmi *hdmi,
> > +				u8 *channel_status)
> > +{
> > +	/*
> > +	 * Set channel status register for frequency and word length.
> > +	 * Use default values for other registers.
> > +	 */
> > +	hdmi_writeb(hdmi, channel_status[3], HDMI_FC_AUDSCHNLS7);
> > +	hdmi_writeb(hdmi, channel_status[4], HDMI_FC_AUDSCHNLS8);
> > +}
> > +EXPORT_SYMBOL_GPL(dw_hdmi_set_channel_status);
> > +
> > 
> >  static void hdmi_set_clk_regenerator(struct dw_hdmi *hdmi,
> >  
> >  	unsigned long pixel_clk, unsigned int sample_rate)
> >  
> >  {
> > 
> > diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h
> > b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h index
> > 6988f12d89d9..fcff5059db24 100644
> > --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h
> > +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h
> > @@ -158,6 +158,8 @@
> > 
> >  #define HDMI_FC_SPDDEVICEINF                    0x1062
> >  #define HDMI_FC_AUDSCONF                        0x1063
> >  #define HDMI_FC_AUDSSTAT                        0x1064
> > 
> > +#define HDMI_FC_AUDSCHNLS7                      0x106e
> > +#define HDMI_FC_AUDSCHNLS8                      0x106f
> > 
> >  #define HDMI_FC_DATACH0FILL                     0x1070
> >  #define HDMI_FC_DATACH1FILL                     0x1071
> >  #define HDMI_FC_DATACH2FILL                     0x1072
> > 
> > diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
> > index cf528c289857..4b3e863c4f8a 100644
> > --- a/include/drm/bridge/dw_hdmi.h
> > +++ b/include/drm/bridge/dw_hdmi.h
> > @@ -156,6 +156,7 @@ void dw_hdmi_setup_rx_sense(struct dw_hdmi *hdmi, bool
> > hpd, bool rx_sense);> 
> >  void dw_hdmi_set_sample_rate(struct dw_hdmi *hdmi, unsigned int rate);
> >  void dw_hdmi_set_channel_count(struct dw_hdmi *hdmi, unsigned int cnt);
> > 
> > +void dw_hdmi_set_channel_status(struct dw_hdmi *hdmi, u8
> > *channel_status);
> > 
> >  void dw_hdmi_set_channel_allocation(struct dw_hdmi *hdmi, unsigned int
> >  ca);
> >  void dw_hdmi_audio_enable(struct dw_hdmi *hdmi);
> >  void dw_hdmi_audio_disable(struct dw_hdmi *hdmi);
> 
> Looks fine for me:
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
> 
> Jonas ? Jernej ? Russell ?

Patch itself is fine, I'm just wondering if more information should be copied 
from status array to registers. But I think they are not 1:1 mapping so some 
more work would be needed. Anyway, patch is:

Reviewed-by: Jernej Skrabec <jernej.skrabec@siol.net>

Best regards,
Jernej

> 
> If it's ok for you I'll apply it.
> 
> Neil




