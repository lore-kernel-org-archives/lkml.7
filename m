Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A4EBC00454
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 21:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 354262465B
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 21:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576273746;
	bh=JkU7pUvaKNy5Abj/NmXgU27ugejd1YYKGoQ2rkZGU+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BAzcueu9m/hydIks8hwMqL5ua4VLbhoUtfEs4AjMmvcGr3ibhkOgorNJfTugkCyvf
	 ttfW+kcnrniLF2ZtaIBgXUjItfjGSezkcV1nrQzgG3VGbB9Y9RkY2VoFCJ9ROy/0MB
	 im+HqahppoM61+86JO/PkiEU728EJ1p9ph3I7kjE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfLMVtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 16:49:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:52884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726879AbfLMVtB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 16:49:01 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5559A24671;
        Fri, 13 Dec 2019 21:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576273740;
        bh=JkU7pUvaKNy5Abj/NmXgU27ugejd1YYKGoQ2rkZGU+w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NNxGGuTfHNgQJd1A4PyH2px5iUPwIg7glsLCWqKEOgDKkPBjl/VUbclA4hcTJiWnU
         hqIYMNlsBBOKPz2jCEcV2rchcjdAG4UYQ9DFv7xVK5pQD8Z83nt4fegstWbLIrv0ID
         ZCvac/xIjGViCuy6kMI+bYY10QcPPuEd+meaFp5w=
Date:   Fri, 13 Dec 2019 17:11:22 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [alsa-devel] [PATCH v4 07/15] soundwire: slave: move uevent
 handling to slave
Message-ID: <20191213161122.GB2653074@kroah.com>
References: <20191213050409.12776-1-pierre-louis.bossart@linux.intel.com>
 <20191213050409.12776-8-pierre-louis.bossart@linux.intel.com>
 <20191213072231.GE1750354@kroah.com>
 <032e6505-22b6-45bb-ff04-87db1f8d8be9@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <032e6505-22b6-45bb-ff04-87db1f8d8be9@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2019 at 09:11:27AM -0600, Pierre-Louis Bossart wrote:
> On 12/13/19 1:22 AM, Greg KH wrote:
> > On Thu, Dec 12, 2019 at 11:04:01PM -0600, Pierre-Louis Bossart wrote:
> > > Currently the code deals with uevents at the bus level, but we only care
> > > for Slave events
> > 
> > What does this mean?  I can't understand it, can you please provide more
> > information on what you are doing here?
> 
> In the earlier versions of the patch, the code looks like this and there was
> an open on what to do with a master-specific event.
> 
>  static int sdw_uevent(struct device *dev, struct kobj_uevent_env *env)
>  {
> +	struct sdw_master_device *md;
>  	struct sdw_slave *slave;
>  	char modalias[32];
> 
> -	if (is_sdw_slave(dev)) {
> +	if (is_sdw_md(dev)) {
> +		md = to_sdw_master_device(dev);
> +		/* TODO: do we need to call add_uevent_var() ? */
> +	} else if (is_sdw_slave(dev)) {
>  		slave = to_sdw_slave_device(dev);
> +
> +		sdw_slave_modalias(slave, modalias, sizeof(modalias));
> +
> +		if (add_uevent_var(env, "MODALIAS=%s", modalias))
> +			return -ENOMEM;
>  	} else {
>  		dev_warn(dev, "uevent for unknown Soundwire type\n");
>  		return -EINVAL;
>  	}
> 
> Vinod suggested this was not needed and suggested the code for uevents be
> moved to be slave-specific, which is what this patch does.

Then describe it really really well in the changelog text.  We have no
rememberance of prior conversations when looking at commits in the tree
in the future.

thaniks,

greg k-h
