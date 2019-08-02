Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A20C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 17:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BD1C2183F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 17:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564767527;
	bh=JFlo0hd8b2cvmNPi8HS4NNA9dAnHWTxHjhwDFVTzlpI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=q8+NH+7pyey3lZTPPbfekGvQdNWj7miPXqTZ740paRVFfS/KMRxiqLhuVTiMqTy7Z
	 zyDAofyU7TUIQLK52mG6o67z9xLx4fthGAovmV3meuMtGuvpF9dd0X1e7Fvps6Pr7n
	 GsLUpMJVgRiAwskYQx2ynCS/47xt3r743EifMTQs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405685AbfHBRiq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 13:38:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:47726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729364AbfHBRiq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 13:38:46 -0400
Received: from localhost (unknown [106.51.106.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A8B32171F;
        Fri,  2 Aug 2019 17:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564767525;
        bh=JFlo0hd8b2cvmNPi8HS4NNA9dAnHWTxHjhwDFVTzlpI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1YRuXRZ2R+4pLMF8Lug3V25dSOvWufl7EejpqZTLSoid4tLvge3J8qYdX8iKCFuL/
         OONHBsH0512YwnLTxQ6/VvfV56HGnj3Wbxu72/DHGfh59gBnWWPvczkkikZoeuDwrl
         SzT80OHXJACPyOufg374ip7DeDf8YIMtij8kglz0=
Date:   Fri, 2 Aug 2019 23:07:32 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        jank@cadence.com, slawomir.blauciak@intel.com,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 06/40] soundwire: intel: prevent
 possible dereference in hw_params
Message-ID: <20190802173732.GF12733@vkoul-mobl.Dlink>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-7-pierre-louis.bossart@linux.intel.com>
 <20190802115537.GI12733@vkoul-mobl.Dlink>
 <6da5aeef-40bf-c9bb-fc18-4ac0b3961857@linux.intel.com>
 <20190802155738.GR12733@vkoul-mobl.Dlink>
 <884a13fc-08eb-10c9-de9c-50cf38ff533d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <884a13fc-08eb-10c9-de9c-50cf38ff533d@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-08-19, 11:52, Pierre-Louis Bossart wrote:
> 
> 
> On 8/2/19 10:57 AM, Vinod Koul wrote:
> > On 02-08-19, 10:16, Pierre-Louis Bossart wrote:
> > > 
> > > 
> > > On 8/2/19 6:55 AM, Vinod Koul wrote:
> > > > On 25-07-19, 18:39, Pierre-Louis Bossart wrote:
> > > > > This should not happen in production systems but we should test for
> > > > > all callback arguments before invoking the config_stream callback.
> > > > 
> > > > so you are saying callback arg is mandatory, if so please document that
> > > > assumption
> > > 
> > > no, what this says is that if a config_stream is provided then it needs to
> > > have a valid argument.
> > 
> > well typically args are not mandatory..
> > 
> > > I am not sure what you mean by "document that assumption", comment in the
> > > code (where?) or SoundWire documentation?
> > 
> > The callback documentation which in this is in include/linux/soundwire/sdw_intel.h
> > 
> 
> /**
>  * struct sdw_intel_ops: Intel audio driver callback ops
>  *
>  * @config_stream: configure the stream with the hw_params
>  */
> struct sdw_intel_ops {
> 	int (*config_stream)(void *arg, void *substream,
> 			     void *dai, void *hw_params, int stream_num);
> };
> 
> all parameters are mandatory really, not sure what you are trying to get at.

It would be good to make a note that argument is mandatory!

Thanks
-- 
~Vinod
