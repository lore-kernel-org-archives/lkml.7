Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FD9C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3FAB22ADA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564150186;
	bh=tkXLEuLkLzPDR2w8WjxNouA5Bu/rM+Uut2ffX26Qtnc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EWLoZkkC/F3gA0YX5I4mtfgI0hB4aCjTZHnd6IQMjVm+daaXY8tpX6uXV7dIuAXaW
	 mBiftkAmWd+LjzHkXqeNfOZLX+TKws5l61iXg4FfGgvymkOkS5WjWJaCtfH8Q1YGyv
	 35+oQGYiytQRsX2Z1XDkRHJLIs3+qnk6ll78sVTM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbfGZOJo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 10:09:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:45028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726902AbfGZOJo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 10:09:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66DB521850;
        Fri, 26 Jul 2019 14:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564150182;
        bh=tkXLEuLkLzPDR2w8WjxNouA5Bu/rM+Uut2ffX26Qtnc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YvU/rChB/CRL8mlz3pbzUgFRM+/BcV9U4s5a6S3GF0wDUrvt4WUm31YCtSt0fgAK+
         QttyzzBPX3CX6MCJm6RKI6qyEcjr6kMDfS6vnAiEq3RFDC67SanmomPY2fbkUuReYa
         g1A9cjRFfHmYO0YS/8ZBDDt2o3URxzEEVS2Bt1dc=
Date:   Fri, 26 Jul 2019 16:09:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [RFC PATCH 04/40] soundwire: intel: add debugfs register dump
Message-ID: <20190726140940.GE8767@kroah.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-5-pierre-louis.bossart@linux.intel.com>
 <20190726140635.GB8767@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726140635.GB8767@kroah.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 04:06:35PM +0200, Greg KH wrote:
> On Thu, Jul 25, 2019 at 06:39:56PM -0500, Pierre-Louis Bossart wrote:
> > Add debugfs file to dump the Intel SoundWire registers
> > 
> > Credits: this patch is based on an earlier internal contribution by
> > Vinod Koul, Sanyog Kale, Shreyas Nc and Hardik Shah. The main change
> > is the use of scnprintf to avoid known issues with snprintf.
> > 
> > Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > ---
> >  drivers/soundwire/intel.c | 115 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 115 insertions(+)
> > 
> > diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
> > index 317873bc0555..aeadc341c0a3 100644
> > --- a/drivers/soundwire/intel.c
> > +++ b/drivers/soundwire/intel.c
> > @@ -6,6 +6,7 @@
> >   */
> >  
> >  #include <linux/acpi.h>
> > +#include <linux/debugfs.h>
> >  #include <linux/delay.h>
> >  #include <linux/module.h>
> >  #include <linux/interrupt.h>
> > @@ -16,6 +17,7 @@
> >  #include <linux/soundwire/sdw.h>
> >  #include <linux/soundwire/sdw_intel.h>
> >  #include "cadence_master.h"
> > +#include "bus.h"
> >  #include "intel.h"
> >  
> >  /* Intel SHIM Registers Definition */
> > @@ -98,6 +100,7 @@ struct sdw_intel {
> >  	struct sdw_cdns cdns;
> >  	int instance;
> >  	struct sdw_intel_link_res *res;
> > +	struct dentry *fs;
> >  };
> >  
> >  #define cdns_to_intel(_cdns) container_of(_cdns, struct sdw_intel, cdns)
> > @@ -161,6 +164,115 @@ static int intel_set_bit(void __iomem *base, int offset, u32 value, u32 mask)
> >  	return -EAGAIN;
> >  }
> >  
> > +/*
> > + * debugfs
> > + */
> > +
> > +#define RD_BUF (2 * PAGE_SIZE)
> > +
> > +static ssize_t intel_sprintf(void __iomem *mem, bool l,
> > +			     char *buf, size_t pos, unsigned int reg)
> > +{
> > +	int value;
> > +
> > +	if (l)
> > +		value = intel_readl(mem, reg);
> > +	else
> > +		value = intel_readw(mem, reg);
> > +
> > +	return scnprintf(buf + pos, RD_BUF - pos, "%4x\t%4x\n", reg, value);
> > +}
> > +
> > +static ssize_t intel_reg_read(struct file *file, char __user *user_buf,
> > +			      size_t count, loff_t *ppos)
> > +{
> > +	struct sdw_intel *sdw = file->private_data;
> > +	void __iomem *s = sdw->res->shim;
> > +	void __iomem *a = sdw->res->alh;
> > +	char *buf;
> > +	ssize_t ret;
> > +	int i, j;
> > +	unsigned int links, reg;
> > +
> > +	buf = kzalloc(RD_BUF, GFP_KERNEL);
> > +	if (!buf)
> > +		return -ENOMEM;
> > +
> > +	links = intel_readl(s, SDW_SHIM_LCAP) & GENMASK(2, 0);
> > +
> > +	ret = scnprintf(buf, RD_BUF, "Register  Value\n");
> > +	ret += scnprintf(buf + ret, RD_BUF - ret, "\nShim\n");
> > +
> > +	for (i = 0; i < 4; i++) {
> > +		reg = SDW_SHIM_LCAP + i * 4;
> > +		ret += intel_sprintf(s, true, buf, ret, reg);
> > +	}
> > +
> > +	for (i = 0; i < links; i++) {
> > +		ret += scnprintf(buf + ret, RD_BUF - ret, "\nLink%d\n", i);
> > +		ret += intel_sprintf(s, false, buf, ret, SDW_SHIM_CTLSCAP(i));
> > +		ret += intel_sprintf(s, false, buf, ret, SDW_SHIM_CTLS0CM(i));
> > +		ret += intel_sprintf(s, false, buf, ret, SDW_SHIM_CTLS1CM(i));
> > +		ret += intel_sprintf(s, false, buf, ret, SDW_SHIM_CTLS2CM(i));
> > +		ret += intel_sprintf(s, false, buf, ret, SDW_SHIM_CTLS3CM(i));
> > +		ret += intel_sprintf(s, false, buf, ret, SDW_SHIM_PCMSCAP(i));
> > +
> > +		for (j = 0; j < 8; j++) {
> > +			ret += intel_sprintf(s, false, buf, ret,
> > +					SDW_SHIM_PCMSYCHM(i, j));
> > +			ret += intel_sprintf(s, false, buf, ret,
> > +					SDW_SHIM_PCMSYCHC(i, j));
> > +		}
> > +
> > +		ret += intel_sprintf(s, false, buf, ret, SDW_SHIM_PDMSCAP(i));
> > +		ret += intel_sprintf(s, false, buf, ret, SDW_SHIM_IOCTL(i));
> > +		ret += intel_sprintf(s, false, buf, ret, SDW_SHIM_CTMCTL(i));
> > +	}
> > +
> > +	ret += intel_sprintf(s, false, buf, ret, SDW_SHIM_WAKEEN);
> > +	ret += intel_sprintf(s, false, buf, ret, SDW_SHIM_WAKESTS);
> > +
> > +	ret += scnprintf(buf + ret, RD_BUF - ret, "\nALH\n");
> > +	for (i = 0; i < 8; i++)
> > +		ret += intel_sprintf(a, true, buf, ret, SDW_ALH_STRMZCFG(i));
> > +
> > +	ret = simple_read_from_buffer(user_buf, count, ppos, buf, ret);
> > +	kfree(buf);
> > +
> > +	return ret;
> > +}
> > +
> > +static const struct file_operations intel_reg_fops = {
> > +	.open = simple_open,
> > +	.read = intel_reg_read,
> > +	.llseek = default_llseek,
> > +};
> 
> DEFINE_SIMPLE_ATTRIBUTE()?

Oops, I mean DEFINE_SHOW_ATTRIBUTE()?
