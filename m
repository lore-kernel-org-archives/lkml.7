Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D55CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 04:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7889214B2
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 04:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571720128;
	bh=/UuJtR4yUNa3dIyz2E6GHXQxE0HGm8Ql3v3DS7hg5lE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FHIhFbUv64Uu/Zb7DiIc2r+4Q2MwG0/9Y3NYVwVrh845oHEsJFeMnTZHN0Z1jGdvy
	 llOBfjFTSu4R/0Zj4mVCC9dEt5dMevxdQE8bgjO5MpCG28VWW+4TkFdjla7HHqkACC
	 vA9o0ETbNhi3qD7RjTVILO7o1iD0a6E61RvwNwdQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731073AbfJVEzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 00:55:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:44112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730852AbfJVEzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 00:55:24 -0400
Received: from localhost (unknown [122.181.223.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C1E6214B2;
        Tue, 22 Oct 2019 04:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571720122;
        bh=/UuJtR4yUNa3dIyz2E6GHXQxE0HGm8Ql3v3DS7hg5lE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ehGK/HeAAY8pYPuARtN+ddW8n+XqzhnIbcoBWV/8j9nA06Fx2ySmAta+uaOSDDKXX
         Tb9lfmQtlsgXM5kmm99BlyzjIBz3PneTg9X3C6UcZZXMfyCcxZjB8FUNZT1LPfxwi0
         mNOQX8pH32J54NxkZfV63YyZv4Fz87gDlT0GFon8=
Date:   Tue, 22 Oct 2019 10:25:18 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        jank@cadence.com, slawomir.blauciak@intel.com,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH v2 4/5] soundwire: intel/cadence: add flag
 for interrupt enable
Message-ID: <20191022045518.GJ2654@vkoul-mobl>
References: <20190916190952.32388-1-pierre-louis.bossart@linux.intel.com>
 <20190916190952.32388-5-pierre-louis.bossart@linux.intel.com>
 <20191021041404.GY2654@vkoul-mobl>
 <8ba388e7-e344-068b-b233-8d96903abf6b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ba388e7-e344-068b-b233-8d96903abf6b@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-10-19, 05:26, Pierre-Louis Bossart wrote:
> On 10/20/19 11:14 PM, Vinod Koul wrote:
> > On 16-09-19, 14:09, Pierre-Louis Bossart wrote:
> > > Prepare for future PM support and fix error handling by disabling
> > > interrupts as needed.
> > > 
> > > Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > > ---
> > >   drivers/soundwire/cadence_master.c | 18 ++++++++++++------
> > >   drivers/soundwire/cadence_master.h |  2 +-
> > >   drivers/soundwire/intel.c          | 12 +++++++-----
> > >   3 files changed, 20 insertions(+), 12 deletions(-)
> > > 
> > > diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
> > > index 5f900cf2acb9..a71df99ca18f 100644
> > > --- a/drivers/soundwire/cadence_master.c
> > > +++ b/drivers/soundwire/cadence_master.c
> > > @@ -819,14 +819,17 @@ EXPORT_SYMBOL(sdw_cdns_exit_reset);
> > >    * sdw_cdns_enable_interrupt() - Enable SDW interrupts and update config
> > >    * @cdns: Cadence instance
> > >    */
> > > -int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns)
> > > +int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns, bool state)
> > >   {
> > > -	u32 mask;
> > > +	u32 slave_intmask0 = 0;
> > > +	u32 slave_intmask1 = 0;
> > > +	u32 mask = 0;
> > > +
> > > +	if (!state)
> > > +		goto update_masks;
> > > -	cdns_writel(cdns, CDNS_MCP_SLAVE_INTMASK0,
> > > -		    CDNS_MCP_SLAVE_INTMASK0_MASK);
> > > -	cdns_writel(cdns, CDNS_MCP_SLAVE_INTMASK1,
> > > -		    CDNS_MCP_SLAVE_INTMASK1_MASK);
> > > +	slave_intmask0 = CDNS_MCP_SLAVE_INTMASK0_MASK;
> > > +	slave_intmask1 = CDNS_MCP_SLAVE_INTMASK1_MASK;
> > >   	/* enable detection of all slave state changes */
> > >   	mask = CDNS_MCP_INT_SLAVE_MASK;
> > > @@ -849,6 +852,9 @@ int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns)
> > >   	if (interrupt_mask) /* parameter override */
> > >   		mask = interrupt_mask;
> > > +update_masks:
> > > +	cdns_writel(cdns, CDNS_MCP_SLAVE_INTMASK0, slave_intmask0);
> > > +	cdns_writel(cdns, CDNS_MCP_SLAVE_INTMASK1, slave_intmask1);
> > >   	cdns_writel(cdns, CDNS_MCP_INTMASK, mask);
> > >   	/* commit changes */
> > > diff --git a/drivers/soundwire/cadence_master.h b/drivers/soundwire/cadence_master.h
> > > index 1a67728c5000..302351808098 100644
> > > --- a/drivers/soundwire/cadence_master.h
> > > +++ b/drivers/soundwire/cadence_master.h
> > > @@ -162,7 +162,7 @@ int sdw_cdns_init(struct sdw_cdns *cdns);
> > >   int sdw_cdns_pdi_init(struct sdw_cdns *cdns,
> > >   		      struct sdw_cdns_stream_config config);
> > >   int sdw_cdns_exit_reset(struct sdw_cdns *cdns);
> > > -int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns);
> > > +int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns, bool state);
> > >   #ifdef CONFIG_DEBUG_FS
> > >   void sdw_cdns_debugfs_init(struct sdw_cdns *cdns, struct dentry *root);
> > > diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
> > > index cdb3243e8823..08530c136c5f 100644
> > > --- a/drivers/soundwire/intel.c
> > > +++ b/drivers/soundwire/intel.c
> > > @@ -1036,7 +1036,7 @@ static int intel_probe(struct platform_device *pdev)
> > >   	ret = sdw_add_bus_master(&sdw->cdns.bus);
> > >   	if (ret) {
> > >   		dev_err(&pdev->dev, "sdw_add_bus_master fail: %d\n", ret);
> > > -		goto err_master_reg;
> > > +		return ret;
> > 
> > I am not sure I like this line change, before this IIRC the function and
> > single place of return, so changing this doesn't seem to improve
> > anything here..?
> 
> Doing a goto to do a return is not very nice either.

Hrmm, isn't that what you are doing few lines below. The point here is
that this line of change here doesnt change anything, doesnt improve
anything so why change :)

> I can change this, but it doesn't really matter: this entire code will be
> removed anyways to get rid of platform_devices and the probe itself will be
> split in two.
> 
> > 
> > >   	}
> > >   	if (sdw->cdns.bus.prop.hw_disabled) {
> > > @@ -1067,7 +1067,7 @@ static int intel_probe(struct platform_device *pdev)
> > >   		goto err_init;
> > >   	}
> > > -	ret = sdw_cdns_enable_interrupt(&sdw->cdns);
> > > +	ret = sdw_cdns_enable_interrupt(&sdw->cdns, true);
> > >   	if (ret < 0) {
> > >   		dev_err(sdw->cdns.dev, "cannot enable interrupts\n");
> > >   		goto err_init;
> > > @@ -1076,7 +1076,7 @@ static int intel_probe(struct platform_device *pdev)
> > >   	ret = sdw_cdns_exit_reset(&sdw->cdns);
> > >   	if (ret < 0) {
> > >   		dev_err(sdw->cdns.dev, "unable to exit bus reset sequence\n");
> > > -		goto err_init;
> > > +		goto err_interrupt;
> > >   	}
> > >   	/* Register DAIs */
> > > @@ -1084,18 +1084,19 @@ static int intel_probe(struct platform_device *pdev)
> > >   	if (ret) {
> > >   		dev_err(sdw->cdns.dev, "DAI registration failed: %d\n", ret);
> > >   		snd_soc_unregister_component(sdw->cdns.dev);
> > > -		goto err_dai;
> > > +		goto err_interrupt;
> > >   	}
> > >   	intel_debugfs_init(sdw);
> > >   	return 0;
> > > +err_interrupt:
> > > +	sdw_cdns_enable_interrupt(&sdw->cdns, false);
> > >   err_dai:
> > 
> > Isn't this unused now?

??? you missed this.

-- 
~Vinod
