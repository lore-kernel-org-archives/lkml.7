Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0759BC10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 10:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B99D6218FC
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 10:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555237219;
	bh=sOeMCxEy87xuTnhRSsc+V8KesV5Ng8iOzI34qqJpFvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=R/1ZB4PmnZe8jrG9pVTfHgf22DieEID06OdAuryxPS6aGGULOo6S17kq01QJGpkfZ
	 FL0naDHXui6VGq5VAZgvtLnG+w2h73EKqxHxwNEwWCZ3mPTu58oKbvScpJOksIyWTi
	 pX5dIkbBDp0NDSzY7uOAN6jzWji84iXZyueuz2jY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbfDNKUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 06:20:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:37058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725681AbfDNKUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 06:20:18 -0400
Received: from localhost (unknown [106.199.53.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C90320848;
        Sun, 14 Apr 2019 10:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555237217;
        bh=sOeMCxEy87xuTnhRSsc+V8KesV5Ng8iOzI34qqJpFvE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K8SaJsneigvAFdPFjLIBipp0nukrnmPB2Tjqr3/hV8hb3m+eF/47Ck7IgPrXHL2sd
         rP4R5jrdWsfVnzykmXDM29dEWD270bHVOuE4OWXpNGZ0SvC8FwFR1evr4OV5ZT7y2c
         hqiG7x5m0/7o6cqUS28K9KYvA61082Gzmwzxo5DA=
Date:   Sun, 14 Apr 2019 15:50:07 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, liam.r.girdwood@linux.intel.com,
        jank@cadence.com, joe@perches.com, srinivas.kandagatla@linaro.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [alsa-devel] [PATCH 1/2] regmap: soundwire: fix Kconfig
 select/depend issue
Message-ID: <20190414102007.GK28103@vkoul-mobl>
References: <20190411192814.10663-1-pierre-louis.bossart@linux.intel.com>
 <20190411192814.10663-2-pierre-louis.bossart@linux.intel.com>
 <s5ho95bpqis.wl-tiwai@suse.de>
 <bd9a5c75-8519-b6ac-ca16-7fa93c706ead@linux.intel.com>
 <20190412141841.GA6235@sirena.org.uk>
 <s5hv9zjl2ya.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hv9zjl2ya.wl-tiwai@suse.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-04-19, 16:21, Takashi Iwai wrote:
> On Fri, 12 Apr 2019 16:18:41 +0200,
> Mark Brown wrote:
> > 
> > On Fri, Apr 12, 2019 at 09:07:41AM -0500, Pierre-Louis Bossart wrote:
> > 
> > >  config CODEC_XYX_SDW
> > > 	 tristate "XYZ SDW Codec"
> > >          depends on SOUNDWIRE
> > >          select REGMAP_SOUNDWIRE
> > 
> > That looks good.
> > 
> > >  config REGMAP_SOUNDWIRE
> > >          select SOUNDWIRE_BUS
> > 
> > > it'd follow the typical pattern seen in sound/soc/codecs/Kconfig:
> > 
> > IIRC the select here won't actually do anything.
> 
> I thought it'd do select SOUNDWIRE_BUS.  The depends-on here would be
> ignored instead.

yeah this all is bit complicated and should not be so. As Srini pointed
out, we have two symbols, SOUNDWIRE as a menuconfig item which enables
the subsystem and then SOUNDWIRE_BUS which compiles in the code.

Unfortunately I dont seem to recall the advantages of this approach so
it might be easier to drop SOUNDWIRE_BUS and then let codecs do select
REGMAP_SOUNDWIRE and depends on SOUNDWIRE

Thanks
-- 
~Vinod
