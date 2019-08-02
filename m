Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E6B8C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 17:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 750D1217F5
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 17:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564766999;
	bh=f4LLTVVR2NozHp4xg1GijBVQN0SOO8S+/65J8PEHkms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0zgsdHsV1KVU3fIKVsMAofCN5TxnI7f4t18vEvLw9ICqFVANGCk2nwxgZMqr8/1+M
	 X7cink5WjaDb3582tGkBjet06ziNcRAhlpT2DN5ssHAWGEEFhM9m05rnznaRWaC9Y2
	 GNjbJdOlCdUgv65BIrxpYzVcNn4l423pnDdpocDI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405257AbfHBR36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 13:29:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:46244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405217AbfHBR35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 13:29:57 -0400
Received: from localhost (unknown [106.51.106.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A42721726;
        Fri,  2 Aug 2019 17:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564766996;
        bh=f4LLTVVR2NozHp4xg1GijBVQN0SOO8S+/65J8PEHkms=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rAYrta9UyUCnFLkGPm0U/0x47AQ6HjSbus4/MDTo6aiSU6omJVWh0qxXxdLqeN4Yy
         GKEYNCS/qZ9mB2ndF4JsSPthqUg3CluZNG7+msjDFNDt/c2sLUbga/lqdw+IpbIuvM
         35kWXfEIgfa9b+yg4qNTkESGyo5S4zA2wMlvR3j0=
Date:   Fri, 2 Aug 2019 22:58:43 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 31/40] soundwire: intel: move shutdown()
 callback and don't export symbol
Message-ID: <20190802172843.GC12733@vkoul-mobl.Dlink>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-32-pierre-louis.bossart@linux.intel.com>
 <39318aab-b1b4-2cce-c408-792a5cc343dd@intel.com>
 <ee87d4bb-3f35-eb27-0112-e6e64a09a279@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ee87d4bb-3f35-eb27-0112-e6e64a09a279@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-07-19, 09:46, Pierre-Louis Bossart wrote:
> 
> 
> On 7/26/19 5:38 AM, Cezary Rojewski wrote:
> > On 2019-07-26 01:40, Pierre-Louis Bossart wrote:
> > > +void intel_shutdown(struct snd_pcm_substream *substream,
> > > +            struct snd_soc_dai *dai)
> > > +{
> > > +    struct sdw_cdns_dma_data *dma;
> > > +
> > > +    dma = snd_soc_dai_get_dma_data(dai, substream);
> > > +    if (!dma)
> > > +        return;
> > > +
> > > +    snd_soc_dai_set_dma_data(dai, substream, NULL);
> > > +    kfree(dma);
> > > +}
> > 
> > Correct me if I'm wrong, but do we really need to _get_dma_ here?
> > _set_dma_ seems bulletproof, same for kfree.
> 
> I must admit I have no idea why we have a reference to DMAs here, this looks
> like an abuse to store a dai-specific context, and the initial test looks
> like copy-paste to detect invalid configs, as done in other callbacks. Vinod
> and Sanyog might have more history than me here.

I dont see snd_soc_dai_set_dma_data() call for
sdw_cdns_dma_data so somthing is missing (at least in upstream code)

IIRC we should have a snd_soc_dai_set_dma_data() in alloc or some
initialization routine and we free it here.. Sanyog?

-- 
~Vinod
