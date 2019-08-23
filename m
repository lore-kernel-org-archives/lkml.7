Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C331C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 07:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D50A23427
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 07:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566545723;
	bh=bbLkXAsHEX8Wn+grOk4i/1hsz2fjmgUr2Kj6i2J/rPM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vwamXLzaXs++hF5HgcDyyvvhtF5dUV9C2CpWyLBLy/aLe15OrOeN7QHfYlu/69sC+
	 AEOc2JgMgRJ+dbjRnglCDeo7fyQj/RlbRKS0XV4E+Nqt2wgjCKxFFcUFbr6KVPGcLg
	 cSLCu+g2+++FVXQg1oFADuGWFyaaM0YSvzD7qwog=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390596AbfHWHfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 03:35:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:35458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732641AbfHWHfV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 03:35:21 -0400
Received: from localhost (unknown [106.200.210.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D3D92341F;
        Fri, 23 Aug 2019 07:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566545720;
        bh=bbLkXAsHEX8Wn+grOk4i/1hsz2fjmgUr2Kj6i2J/rPM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fjW9/aM3xPahmihoNOYFcTCads+Zl94leJ6QpWXcOUVLFa10S1tQGTkED3P7dIkqj
         rQhddxY2T9+i6BH9sLI8PEn2wzdOEaie39zoZv3vluGoa6T+360J40QRavFv/Ev9c9
         AxvI7Vu9rG+fQYl3xADrlgvqGBx+bQX3GhKzqmrs=
Date:   Fri, 23 Aug 2019 13:04:07 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>, tiwai@suse.de,
        gregkh@linuxfoundation.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 31/40] soundwire: intel: move shutdown()
 callback and don't export symbol
Message-ID: <20190823073407.GF2672@vkoul-mobl>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-32-pierre-louis.bossart@linux.intel.com>
 <39318aab-b1b4-2cce-c408-792a5cc343dd@intel.com>
 <ee87d4bb-3f35-eb27-0112-e6e64a09a279@linux.intel.com>
 <20190802172843.GC12733@vkoul-mobl.Dlink>
 <7abdb0e8-b9c4-28c7-d9ed-a7db1574e0b2@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7abdb0e8-b9c4-28c7-d9ed-a7db1574e0b2@linux.intel.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-08-19, 14:31, Pierre-Louis Bossart wrote:
> 
> 
> > > > > +void intel_shutdown(struct snd_pcm_substream *substream,
> > > > > +            struct snd_soc_dai *dai)
> > > > > +{
> > > > > +    struct sdw_cdns_dma_data *dma;
> > > > > +
> > > > > +    dma = snd_soc_dai_get_dma_data(dai, substream);
> > > > > +    if (!dma)
> > > > > +        return;
> > > > > +
> > > > > +    snd_soc_dai_set_dma_data(dai, substream, NULL);
> > > > > +    kfree(dma);
> > > > > +}
> > > > 
> > > > Correct me if I'm wrong, but do we really need to _get_dma_ here?
> > > > _set_dma_ seems bulletproof, same for kfree.
> > > 
> > > I must admit I have no idea why we have a reference to DMAs here, this looks
> > > like an abuse to store a dai-specific context, and the initial test looks
> > > like copy-paste to detect invalid configs, as done in other callbacks. Vinod
> > > and Sanyog might have more history than me here.
> > 
> > I dont see snd_soc_dai_set_dma_data() call for
> > sdw_cdns_dma_data so somthing is missing (at least in upstream code)
> > 
> > IIRC we should have a snd_soc_dai_set_dma_data() in alloc or some
> > initialization routine and we free it here.. Sanyog?
> 
> Vinod, I double-checked that we do not indeed have a call to
> snd_soc_dai_dma_data(), but there is code in cdns_set_stream() that sets the
> relevant dai->playback/capture_dma_data, see below
> 
> I am not a big fan of this code, touching the ASoC core internal fields
> isn't a good idea in general.

IIRC as long as you stick to single link I do not see this required. The
question comes into picture when we have multi links as you would need
to allocate a soundwire stream and set that for all the sdw DAIs

So, what is the current model of soundwire stream, which entity allocates
that and do you still care about multi-link? is there any machine driver
with soundwire upstream yet?

> Also not sure why for a DAI we need both _drvdata and _dma_data (especially

_drvdata is global for driver whereas _dma_data is typically used per
DAI

> for this case where the information stored has absolutely nothing to do with
> DMAs).
> 
> If the idea was to keep a context that is direction-dependent, that's likely
> unnecessary. For the Intel/Cadence case the interfaces can be configured as
> playback OR capture, not both concurrently, so the "dma" information could
> have been stored in the generic DAI _drvdata.
> 
> I have other things to look into for now but this code will likely need to
> be cleaned-up at some point to remove unnecessary parts.

Sure please go ahead and do the cleanup.
> 
> int cdns_set_sdw_stream(struct snd_soc_dai *dai,
> 			void *stream, bool pcm, int direction)
> {
> 	struct sdw_cdns *cdns = snd_soc_dai_get_drvdata(dai);
> 	struct sdw_cdns_dma_data *dma;
> 
> 	dma = kzalloc(sizeof(*dma), GFP_KERNEL);
> 	if (!dma)
> 		return -ENOMEM;
> 
> 	if (pcm)
> 		dma->stream_type = SDW_STREAM_PCM;
> 	else
> 		dma->stream_type = SDW_STREAM_PDM;
> 
> 	dma->bus = &cdns->bus;
> 	dma->link_id = cdns->instance;
> 
> 	dma->stream = stream;
> 
> >>> this is equivalent to snd_soc_dai_dma_data()
> 
> 	if (direction == SNDRV_PCM_STREAM_PLAYBACK)
> 		dai->playback_dma_data = dma;
> 	else
> 		dai->capture_dma_data = dma;
> <<<<
> 	return 0;
> }
> EXPORT_SYMBOL(cdns_set_sdw_stream);

-- 
~Vinod
