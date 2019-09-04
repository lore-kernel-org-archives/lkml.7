Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DB8C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B91D122CEA
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567615964;
	bh=9Zah+m6g12D31+MzrxQoEJQmTT36fHIV8yCjlTJUYRo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mFtd5bSpQ9lLXP87qdCux9aFV5UqbdzDpwoJC3YSKZ99BYRg2U9+7O2UPB/4kqZQm
	 M+EYLQDgv1CJWJE/xX4DceLhpM0g0zN/43jFvRb1wKmit2ik7tigLHhvRv2xT1Lj1M
	 FTXztUh1qFvuwzNWtIXZjPe2fdB4N0kPaDKh8mTU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732389AbfIDQwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 12:52:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:38950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731599AbfIDQwn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 12:52:43 -0400
Received: from localhost (unknown [122.182.201.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 716E5208E4;
        Wed,  4 Sep 2019 16:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567615962;
        bh=9Zah+m6g12D31+MzrxQoEJQmTT36fHIV8yCjlTJUYRo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tJaMPrEvqYdcFCsj9zN3yGuNDA1WKW9qulsgPM92qSQ7297jZ3IMkP2oHx2bW1KYu
         yz/UOTF6a68RmkfsyScEyejzz/A2k08WwRRT0PncYqsp1R/wFyw1cTruHXyo6YiW8/
         uPby00yqAgComZOg2HG/QCkkXaPC9Qtc2p0yaqio=
Date:   Wed, 4 Sep 2019 22:21:29 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Zhu Yingjiang <yingjiang.zhu@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Keyon Jie <yang.jie@linux.intel.com>,
        Pan Xiuli <xiuli.pan@linux.intel.com>,
        Fred Oh <fred.oh@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [alsa-devel] [RFC PATCH 3/5] ASoC: SOF: Intel: hda: add
 SoundWire IP support
Message-ID: <20190904165129.GB2672@vkoul-mobl>
References: <20190821201720.17768-1-pierre-louis.bossart@linux.intel.com>
 <20190821201720.17768-4-pierre-louis.bossart@linux.intel.com>
 <20190904072131.GK2672@vkoul-mobl>
 <1897e21f-b086-8233-e96e-6024e75a2153@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1897e21f-b086-8233-e96e-6024e75a2153@linux.intel.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-09-19, 08:25, Pierre-Louis Bossart wrote:
> On 9/4/19 2:21 AM, Vinod Koul wrote:
> > On 21-08-19, 15:17, Pierre-Louis Bossart wrote:
> > > The Core0 needs to be powered before the SoundWire IP is initialized.
> > > 
> > > Call sdw_intel_init/exit and store the context. We only have one
> > > context, but depending on the hardware capabilities and BIOS settings
> > > may enable multiple SoundWire links.
> > > 
> > > Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > > ---
> > >   sound/soc/sof/intel/hda.c | 40 +++++++++++++++++++++++++++++++++------
> > >   sound/soc/sof/intel/hda.h |  5 +++++
> > >   2 files changed, 39 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
> > > index a968890d0754..e754058e3679 100644
> > > --- a/sound/soc/sof/intel/hda.c
> > > +++ b/sound/soc/sof/intel/hda.c
> > > @@ -57,6 +57,8 @@ static int hda_sdw_init(struct snd_sof_dev *sdev)
> > >   {
> > >   	acpi_handle handle;
> > >   	struct sdw_intel_res res;
> > > +	struct sof_intel_hda_dev *hdev;
> > > +	void *sdw;
> > >   	handle = ACPI_HANDLE(sdev->dev);
> > > @@ -66,23 +68,32 @@ static int hda_sdw_init(struct snd_sof_dev *sdev)
> > >   	res.irq = sdev->ipc_irq;
> > >   	res.parent = sdev->dev;
> > > -	hda_sdw_int_enable(sdev, true);
> > > -
> > > -	sdev->sdw = sdw_intel_init(handle, &res);
> > > -	if (!sdev->sdw) {
> > > +	sdw = sdw_intel_init(handle, &res);
> > 
> > should this be called for platforms without sdw, I was hoping that some
> > checks would be performed.. For example how would skl deal with this?
> 
> Good point. For now we rely on CONFIG_SOUNDWIRE_INTEL to use a fallback, but
> if the kernel defines this config and we run on an older platform the only
> safety would be the hardware capabilities and BIOS dependencies, I need to
> test if it works.

Yes I am not sure given the experience with BIOS relying on that is a
great idea ! But if that works, that would be better.


> > > diff --git a/sound/soc/sof/intel/hda.h b/sound/soc/sof/intel/hda.h
> > > index c8f93317aeb4..48e09b7daf0a 100644
> > > --- a/sound/soc/sof/intel/hda.h
> > > +++ b/sound/soc/sof/intel/hda.h
> > > @@ -399,6 +399,11 @@ struct sof_intel_hda_dev {
> > >   	/* DMIC device */
> > >   	struct platform_device *dmic_dev;
> > > +
> > > +#if IS_ENABLED(CONFIG_SOUNDWIRE_INTEL)
> > 
> > is this really required, context is a void pointer

??

> > > +	/* sdw context */
> > > +	void *sdw;
> > 
> > > +#endif

-- 
~Vinod
