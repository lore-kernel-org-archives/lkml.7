Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C92A1CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 04:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 900F421783
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 04:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571720012;
	bh=pBTQ0YOEOQnzuYUb+FHQ4FBCyJ82lfDZHeeN8yBIiFw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=J1IVOs63+Tu1cY/KYYHTd0/eP8ysbmAn4nhbmCyWq6VdjtQbEps1L7DZN1E6PJX7N
	 JycE/Mfj3VjwMiEz9OujsqB5qw5esy27g3zSOFv0a7xWi6F4FKN2LEJLiBDZtdd8Tm
	 hhWuhueUU+dJC3Sol0SmyltQ2Gmkafb8cjeJOPbU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731066AbfJVExb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 00:53:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:42520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbfJVExb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 00:53:31 -0400
Received: from localhost (unknown [122.181.223.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64974214B2;
        Tue, 22 Oct 2019 04:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571720009;
        bh=pBTQ0YOEOQnzuYUb+FHQ4FBCyJ82lfDZHeeN8yBIiFw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q+OarvDzZbllVYVz8+gParOTzlzJoIHeghSRJUKIkjv5hWxaJdcM8ErWSazWiq13t
         HL7/yOC0TixjBbbwqMYUzp8kqC0WqWG4GQ+FpGZeTvLgb+DYCf7/t39ZPajRSuBQve
         m6Rd/HFCIPCIW82dDHW7zkP2PwJvAXwnlWaW88rI=
Date:   Tue, 22 Oct 2019 10:23:24 +0530
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
Subject: Re: [alsa-devel] [PATCH v2 2/5] soundwire: cadence_master: add
 hw_reset capability in debugfs
Message-ID: <20191022045324.GI2654@vkoul-mobl>
References: <20190916190952.32388-1-pierre-louis.bossart@linux.intel.com>
 <20190916190952.32388-3-pierre-louis.bossart@linux.intel.com>
 <20191021040458.GX2654@vkoul-mobl>
 <96f5b446-ae02-afd6-9e5c-12e3507567f3@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96f5b446-ae02-afd6-9e5c-12e3507567f3@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-10-19, 05:20, Pierre-Louis Bossart wrote:
> On 10/20/19 11:04 PM, Vinod Koul wrote:
> > On 16-09-19, 14:09, Pierre-Louis Bossart wrote:
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
> > > index e3d06330d125..5f900cf2acb9 100644
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
> > > +		return -EINVAL;
> > > +
> > > +	ret = sdw_cdns_exit_reset(cdns);
> > 
> > So we are performing reset of the device behind the kernel, so I think
> > it makes sense to mark the kernel as tainted.
> 
> This is a bit ironic. This reset is the only way to prove that the
> enumeration is done right and that all the subsystem fully recovers, and yet
> we'd mark the kernel as 'untrustworthy' and all bug reports would be
> ignored.

Nope you dont expect this would be done on a production system and for
you own testing you can choose not to ignore the reports!

> I don't mind doing this but we'd have to agree on a code. The only one I see
> relevant is "taint requested by userspace application", which is not exactly
> super useful.

But it does tell you that userspace did something so watch out!

> > > +	dev_dbg(cdns->dev, "link hw_reset done: %d\n", ret);
> > > +
> > > +	return ret;
> > 
> > We may want to get rid of the debug and do:
> >          return sdw_cdns_exit_reset();
> 
> this debug line is useful, it marks the start of the reset sequence and
> that's valuable information. Remove it and you've lost the ability to
> analyze the dmesg logs. It's even more useful if we mark the kernel as
> tainted as you suggested above.

ok

> 
> > 
> > > +}
> > > +
> > > +DEFINE_DEBUGFS_ATTRIBUTE(cdns_hw_reset_fops, NULL, cdns_hw_reset, "%llu\n");
> > > +
> > >   /**
> > >    * sdw_cdns_debugfs_init() - Cadence debugfs init
> > >    * @cdns: Cadence instance
> > > @@ -348,6 +365,9 @@ DEFINE_SHOW_ATTRIBUTE(cdns_reg);
> > >   void sdw_cdns_debugfs_init(struct sdw_cdns *cdns, struct dentry *root)
> > >   {
> > >   	debugfs_create_file("cdns-registers", 0400, root, cdns, &cdns_reg_fops);
> > > +
> > > +	debugfs_create_file("cdns-hw-reset", 0200, root, cdns,
> > > +			    &cdns_hw_reset_fops);
> > >   }
> > >   EXPORT_SYMBOL_GPL(sdw_cdns_debugfs_init);
> > > -- 
> > > 2.20.1
> > 

-- 
~Vinod
