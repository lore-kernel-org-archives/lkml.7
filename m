Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7667C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 09:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B40BD2073F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 09:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555493632;
	bh=DfEe7fLNfD4Q71vuBepn21ewEjW51QHbT/yIHtV5LvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=E/Ujynm6q+USY83FwBmLFwAKWUEnGDKCCBJTCmV02+xkHllWt/vxqRtMEOYCfIhja
	 KNmVl7aqdVVi79jhHs6uNAWyMQJkqcRF7e7KmbMEx6s7xm1ipZc8fx4AIPbl/F7sLy
	 reVg9mvQ6HhePWKsVRplZmlBsa88dBNhk/KsLaiU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731551AbfDQJdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 05:33:51 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41262 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728108AbfDQJdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 05:33:51 -0400
Received: by mail-lf1-f68.google.com with SMTP id t30so18337220lfd.8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 02:33:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qMhOWjAqUYxMHI4yOJN1M8HhtwuOvWWfxeDmxOhxppM=;
        b=gUUdzU+0x/6HrO7RDq+7FSzRtue6XSGDcm4Nev0azEK2xTcnc7PDM0RBZfia/5CTeb
         gcxozo5/6mU0KshsU2gTGXRZPNReXkNQTKFneNzXVRKWVFhTA83m23pMNDm5KBUZsRIO
         2M8rabw5YT/l61WIQXjsUsMq2qSBT6dkOoIVHerJgsTDC1z5bIbOxXLT55I5rDl1ZEBQ
         /LwEQ1nFPHY5YQqzOE3ngfHNd1cucOS3CuCu74RJv8Kv8Edocldw2wWg+SQGPqtJccT2
         va+m+3wpwe2WKobkWaClW8yFB9602KpdZ/xUt5tl2CHyUvbOI9oo1rBF5pSjPvstqm46
         YRhA==
X-Gm-Message-State: APjAAAXULR2BhVT9lt8VKUpH2rncDLKK5YufMmp0fC4K/PlWk7AfZSy1
        aWhp8pVRVQdCiDR/jS9Z7zM=
X-Google-Smtp-Source: APXvYqyzBOwz0mAtIEBZtehuYDCTiJXj0ztCCKF32xDYyh1omcKIPyXk2cd9z0AFDe5UcmNAa1M/Mw==
X-Received: by 2002:a19:4b84:: with SMTP id y126mr5911954lfa.15.1555493629067;
        Wed, 17 Apr 2019 02:33:49 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id u11sm10858510ljh.80.2019.04.17.02.33.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 02:33:47 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1hGgx0-0004D9-6l; Wed, 17 Apr 2019 11:33:54 +0200
Date:   Wed, 17 Apr 2019 11:33:54 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Vinod Koul <vkoul@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        gregkh@linuxfoundation.org, liam.r.girdwood@linux.intel.com,
        jank@cadence.com, joe@perches.com, srinivas.kandagatla@linaro.org,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [alsa-devel] [PATCH v3 2/5] soundwire: fix style issues
Message-ID: <20190417093354.GL775@localhost>
References: <20190411031701.5926-1-pierre-louis.bossart@linux.intel.com>
 <20190411031701.5926-3-pierre-louis.bossart@linux.intel.com>
 <20190414095839.GG28103@vkoul-mobl>
 <08ea1442-361a-ecfc-ca26-d3bd8a0ec37b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08ea1442-361a-ecfc-ca26-d3bd8a0ec37b@linux.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 08:09:59AM -0500, Pierre-Louis Bossart wrote:
> 
> >>
> >> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> >> ---
> >>   drivers/soundwire/Kconfig          |   2 +-
> >>   drivers/soundwire/bus.c            |  87 ++++++++--------
> >>   drivers/soundwire/bus.h            |  16 +--
> >>   drivers/soundwire/bus_type.c       |   4 +-
> >>   drivers/soundwire/cadence_master.c |  87 ++++++++--------
> >>   drivers/soundwire/cadence_master.h |  22 ++--
> >>   drivers/soundwire/intel.c          |  87 ++++++++--------
> >>   drivers/soundwire/intel.h          |   4 +-
> >>   drivers/soundwire/intel_init.c     |  12 +--
> >>   drivers/soundwire/mipi_disco.c     | 116 +++++++++++----------
> >>   drivers/soundwire/slave.c          |  10 +-
> >>   drivers/soundwire/stream.c         | 161 +++++++++++++++--------------
> > 
> > I would prefer this to be a patch per module. It doesnt help to have a
> > single patch for all the files!
> > 
> > It would be great to have cleanup done per logical group, for example
> > typos in a patch, aligns in another etc...
> 
> You've got to be kidding. I've never seen people ask for this sort of 
> detail.
> 
> > 
> >>   12 files changed, 313 insertions(+), 295 deletions(-)
> >>
> >> diff --git a/drivers/soundwire/Kconfig b/drivers/soundwire/Kconfig
> >> index 19c8efb9a5ee..84876a74874f 100644
> >> --- a/drivers/soundwire/Kconfig
> >> +++ b/drivers/soundwire/Kconfig
> >> @@ -4,7 +4,7 @@
> >>   
> >>   menuconfig SOUNDWIRE
> >>   	bool "SoundWire support"
> >> -	---help---
> >> +	help
> > 
> > Not sure if this is a style issue, kernel seems to have 2990 instances
> > of this!
> 
> this is reported by checkpatch.pl --strict.

Please don't run checkpatch on code that's already in the kernel, and
especially not with the --strict (a.k.a. --subjective) option enabled.

Don't try to fix what isn't broken.

Thanks,
Johan
