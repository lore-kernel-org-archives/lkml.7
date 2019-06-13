Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E9EC31E4A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B39FD21721
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VY1ARRR2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730172AbfFMQuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:50:50 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38711 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730175AbfFMDyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 23:54:49 -0400
Received: by mail-pg1-f196.google.com with SMTP id v11so10102894pgl.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 20:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mKy9mX5Pp1ioIzP2A8hzp0vntRtGgDnY3IkJQGZ2PBw=;
        b=VY1ARRR2PzJXX/T0X0dikiSYlvBOEZzpixIOxb3/mvvoEJvO1W+6VTiUN6qa+hwMMo
         jsl2ys0dkXq4g+DWURE4vjrOA2narBcN4B7lhf7YxeZhy+Z0fu5wAAQFHrloFTYa9bAY
         McCy2tdVTjXdUZYioxoPhBdfF9xPSgXf05UMISQO85e9KsMEvjDb2BwLLkPYMcRNEssg
         h7H455qyD1uCW4Zr8pD6qbBPtHYMzyMsJRpcuPVSkar+w665vxzgBZhRWnurIda6PDgu
         5Rof3ELHIuGjr0Fe4ShBzdXI70oyHYUPHypZZDzQB9bOCqzydNXdWbkpM5J+7NxaoAQ2
         xrow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mKy9mX5Pp1ioIzP2A8hzp0vntRtGgDnY3IkJQGZ2PBw=;
        b=OphGZrj4RmFKssPeuodoUJlw/Fg8Sg5YUGC8PX8KoGUsJ7o//dTIRM6hJ2UtnmG27L
         GMvh9NlMBi3ILDrx17xX82IVSkk2Uj72gUtGXnROHvPxqCNPcovrgjRnoZQEZCXUl0IA
         ZYCriZFjhSWlhXP/f43KHfFvPqZIzbn5aaDb4GM0GxH03VoOT6wjmo4sLSi0im9qS6Rk
         zzqul9l5VD3uQedqRL6yjmrBjlbBeJRkXCYmI5el4p8YN+UClTxQMqd4b4xX097KBFN1
         aSsTHFkUrahoohd0UyhsfOQJkyigHx5R1RomXvilVuKoKgtfLRNV/U62t4UrxO13FwhB
         VCUg==
X-Gm-Message-State: APjAAAV8eEirR54z+eWOgFd9EUk9L8gA0utOsF84f6WNu91jJL5XCJar
        CVQCJ0GAaaUwP/tuFdDMpHo=
X-Google-Smtp-Source: APXvYqzRZrUpdn80GYYwHJcJVav31KYzUN1LPr7q/EkOEPciQgLl7crthZ3eONR3VME76glRiBDUmQ==
X-Received: by 2002:a65:5304:: with SMTP id m4mr27956862pgq.126.1560398089063;
        Wed, 12 Jun 2019 20:54:49 -0700 (PDT)
Received: from Asurada (c-98-248-47-108.hsd1.ca.comcast.net. [98.248.47.108])
        by smtp.gmail.com with ESMTPSA id y22sm994911pgj.38.2019.06.12.20.54.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 20:54:48 -0700 (PDT)
Date:   Wed, 12 Jun 2019 20:54:35 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     "S.j. Wang" <shengjiu.wang@nxp.com>
Cc:     "broonie@kernel.org" <broonie@kernel.org>,
        "timur@kernel.org" <timur@kernel.org>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC/RFT PATCH v2] ASoC: fsl_esai: Revert "ETDR and TX0~5
 registers are non volatile"
Message-ID: <20190613035434.GA7692@Asurada>
References: <VE1PR04MB6479D4B1D5F00B07C5CECC5BE3EF0@VE1PR04MB6479.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VE1PR04MB6479D4B1D5F00B07C5CECC5BE3EF0@VE1PR04MB6479.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shengjiu,

On Thu, Jun 13, 2019 at 03:00:58AM +0000, S.j. Wang wrote:
> > Commit 8973112aa41b ("ASoC: fsl_esai: ETDR and TX0~5 registers are non
> > volatile") removed TX data registers from the volatile_reg list and appended
> > default values for them. However, being data registers of TX, they should
> > not have been removed from the list because they should not be cached --
> > see the following reason.
> > 
> > When doing regcache_sync(), this operation might accidentally write some
> > dirty data to these registers, in case that cached data happen to be
> > different from the default ones, which might also result in a channel shift or
> > swap situation, since the number of write-via-sync operations at ETDR
> > would very unlikely match the channel number.
> > 
> > So this patch reverts the original commit to keep TX data registers in
> > volatile_reg list in order to prevent them from being written by
> > regcache_sync().
> > 
> > Note: this revert is not a complete revert as it keeps those macros of
> > registers remaining in the default value list while the original commit also
> > changed other entries in the list. And this patch isn't very necessary to Cc
> > stable tree since there has been always a FIFO reset operation around the
> > regcache_sync() call, even prior to this reverted commit.
> > 
> > Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> > Cc: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> > Hi Mark,
> > In case there's no objection against the patch, I'd still like to wait for a
> > Tested-by from NXP folks before submitting it. Thanks!
> 
> bool regmap_volatile(struct regmap *map, unsigned int reg)
> {
>         if (!map->format.format_write && !regmap_readable(map, reg))
>                 return false;
> 
> 
> Actually with this patch, the regcache_sync will write the 0 to ETDR, even
> It is declared volatile, the reason is that in regmap_volatile(), the first
> condition
> 
> (!map->format.format_write && !regmap_readable(map, reg))  is true.
> 
> So the regmap_volatile will return false.

Interesting finding.....so a write-only register will not be treated
as a volatile register (to avoid regcache_sync) at all....

> And in regcache_reg_needs_sync(), because there is no default value
> It will return true, then the ETDR need be synced, and be written 0.

Looks like either way of keeping them in or out of volatile_reg list
might have the same result of having a data being written, while our
current code at least would not force to write 0.

So I think having a FIFO reset won't be a bad idea at all. And since
our suspend/resume() functions are already doing regcache_sync() with
a FIFO reset, we can just reuse that code for your reset routine.

Thanks a lot
Nicolin
