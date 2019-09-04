Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B6BC3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 403C922CEA
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567615839;
	bh=b/x7QUROWv0yxoBVITIFYudbm4LpCcqr2OJ2VY0gqq8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pmDK9ndTi9FeLE9dRyITcGBfMuYoDnSttqziWtjq4IImdDMiOoHECH5ecHF2Ms3/A
	 TmvfFlN45Pdliqh+QX7JWkySamLCfXhGrUSPCT9FR/5GC1jvaD87BoDTWT6gUbGaFe
	 LsRG5zH6u6quxIm+TjFbj0idK9/e6a1wt80/ZKoc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732191AbfIDQui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 12:50:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:37994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731599AbfIDQuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 12:50:37 -0400
Received: from localhost (unknown [122.182.201.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB1BF2087E;
        Wed,  4 Sep 2019 16:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567615836;
        bh=b/x7QUROWv0yxoBVITIFYudbm4LpCcqr2OJ2VY0gqq8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jOM2Hxu4umgWpQLtVXuFiGxx/FAXv3Gc+0G9Scdok9NzK6wiXb7aZyhPC86JhhrP4
         ijcxucrMe5zDGbFGP5vOjqO71gAR9JVMAP4mVLfHiWe+fa/AjDnmrlRHK8kte29lSP
         6PMctjjHWvLuhrkRDCt3sRRoRiHn4upxzLqmSh00=
Date:   Wed, 4 Sep 2019 22:19:26 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [alsa-devel] [PATCH 2/6] soundwire: cadence_master: add hw_reset
 capability in debugfs
Message-ID: <20190904164926.GA2672@vkoul-mobl>
References: <20190813213227.5163-1-pierre-louis.bossart@linux.intel.com>
 <20190813213227.5163-3-pierre-louis.bossart@linux.intel.com>
 <20190904071317.GJ2672@vkoul-mobl>
 <71411347-93cf-2617-4edd-f6b401fe7a9b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71411347-93cf-2617-4edd-f6b401fe7a9b@linux.intel.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-09-19, 08:18, Pierre-Louis Bossart wrote:
> On 9/4/19 2:13 AM, Vinod Koul wrote:
> > On 13-08-19, 16:32, Pierre-Louis Bossart wrote:
> > > Provide debugfs capability to kick link and devices into hard-reset
> > > (as defined by MIPI). This capability is really useful when some
> > > devices are no longer responsive and/or to check the software handling
> > > of resynchronization.
> > > 
> > > Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > > ---
> > >   drivers/soundwire/cadence_master.c | 20 ++++++++++++++++++++
> > >   1 file changed, 20 insertions(+)
> > > 
> > > diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
> > > index 046622e4b264..bd58d80ff636 100644
> > > --- a/drivers/soundwire/cadence_master.c
> > > +++ b/drivers/soundwire/cadence_master.c
> > > @@ -340,6 +340,23 @@ static int cdns_reg_show(struct seq_file *s, void *data)
> > >   }
> > >   DEFINE_SHOW_ATTRIBUTE(cdns_reg);
> > > +static int cdns_hw_reset(void *data, u64 value)
> > > +{
> > > +	struct sdw_cdns *cdns = data;
> > > +	int ret;
> > > +
> > > +	if (value != 1)
> > > +		return 0;
> > 
> > Should this not be EINVAL to indicate invalid value passed?
> 
> Maybe. I must admit I don't know what -EINVAL would do, this is used for
> debugfs so it's not clear to me if the user will see a difference?

Well user should see "write error: Invalid argument" when he writes
anything other than valid values :)

-- 
~Vinod
