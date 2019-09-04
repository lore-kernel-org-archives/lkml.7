Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30845C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE57B21883
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567616194;
	bh=/PClAjiL1I36PVpeMuFaSLb4sjjsS6Cd5FfGsDw5IzU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Svl47eEwE9F96niUFBg/G8pqf8I/vvLTOKJmz5sxFi40PC+gL13OdwZKU71WEiMsx
	 l9f3oi1oJiMhgx5NjFD+m6cOAJU4oMRGGLqy2XZrBpVFMOrQFi6jOT+eYaluraka6m
	 hNT8a5VWQQRfxhtqbw8qm+JwTktqa9Xr+4YsJE9E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732242AbfIDQ4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 12:56:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:39944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbfIDQ4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 12:56:32 -0400
Received: from localhost (unknown [122.182.201.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B16A21670;
        Wed,  4 Sep 2019 16:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567616191;
        bh=/PClAjiL1I36PVpeMuFaSLb4sjjsS6Cd5FfGsDw5IzU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JdmbD9LVQPoKI53zMWAA3IwYish6qxu2qRdAaqk8p8XEvQFLoTyYLgPdIJgHn0NyX
         ttE6Up4kR0Sikt83zDFqOWaidpp9aRf/hCT+zGqTw6iMq4djQhr/fTyuARnGgDGRr6
         wZbQ2hwwuBLdi6tSHnepGrkr31MSRE8m80GYyzAY=
Date:   Wed, 4 Sep 2019 22:25:22 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Zhu Yingjiang <yingjiang.zhu@linux.intel.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [alsa-devel] [RFC PATCH 4/5] ASoC: SOF: Intel: hda: add
 SoundWire stream config/free callbacks
Message-ID: <20190904165522.GC2672@vkoul-mobl>
References: <20190821201720.17768-1-pierre-louis.bossart@linux.intel.com>
 <20190821201720.17768-5-pierre-louis.bossart@linux.intel.com>
 <20190822071835.GA30262@ubuntu>
 <f73796d6-fcfa-97c8-69ae-0a183edbbd97@linux.intel.com>
 <20190904073549.GL2672@vkoul-mobl>
 <4de9613c-2da4-8d39-6f99-3039811673b8@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4de9613c-2da4-8d39-6f99-3039811673b8@linux.intel.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-09-19, 08:31, Pierre-Louis Bossart wrote:
> On 9/4/19 2:35 AM, Vinod Koul wrote:
> > On 22-08-19, 08:53, Pierre-Louis Bossart wrote:
> > > Thanks for the review Guennadi
> > > 
> > > > > +static int sdw_config_stream(void *arg, void *s, void *dai,
> > > > > +			     void *params, int link_id, int alh_stream_id)
> > > > 
> > > > I realise, that these function prototypes aren't being introduced by these
> > > > patches, but just wondering whether such overly generic prototype is really
> > > > a good idea here, whether some of those "void *" pointers could be given
> > > > real types. The first one could be "struct device *" etc.
> > > 
> > > In this case the 'arg' parameter is actually a private 'struct snd_sof_dev',
> > > as shown below [1]. We probably want to keep this relatively opaque, this is
> > > a context that doesn't need to be exposed to the SoundWire code.
> > 
> > This does look bit ugly.
> > 
> > > The dai and params are indeed cases where we could use stronger types, they
> > > are snd_soc_dai and hw_params respectively. I don't recall why the existing
> > > code is this way, Vinod and Sanyog may have the history of this.
> > 
> > Yes we wanted to decouple the sdw and audio bits that is the reason why
> > none of the audio types are used here, but I think it should be revisited
> > and perhaps made as:
> > 
> > sdw_config_stream(struct device *sdw, struct sdw_callback_ctx *ctx)
> > 
> > where the callback context contains all the other args. That would make
> > it look lot neater too and of course use real structs if possible
> 
> the suggested sdw_callbback_ctx is really intel-specific at the moment, e.g.
> the notion of link_id and alh_stream_id are due to the hardware, it's not
> generic at all. And in the latest code we also pass the dai->id.

s/sdw_callback_ctx/intel_sdw_callback_ctx

Yes this code is intel specific and this would be intel specific too

-- 
~Vinod
