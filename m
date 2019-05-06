Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D89BC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 011B020B7C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557155999;
	bh=qjmx5CCEvPOYN+9XFMOjhWS/7gmlubDSJs+Xfcsz1HQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pQ2uiKmrVpKHCSntERBihhsvx2Dc65sY64zjT4VQlGgc20yciGyS5YFpkTYXd33nj
	 p95zK8kq7IEEgWuJWNqM4+dw6puyAWV0VFRdVda+3kYUJHHK2oIFbCFyjjDiGwhyRD
	 KYrV6yRZ4Qf9jwejQYj92lTjtIpQpAZQpzqc4MIg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfEFPT5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 11:19:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:45968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbfEFPT5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 11:19:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C31C42053B;
        Mon,  6 May 2019 15:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557155996;
        bh=qjmx5CCEvPOYN+9XFMOjhWS/7gmlubDSJs+Xfcsz1HQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o7BNpL7DyjFLGVMv7Juaj9HOoId2/EZ+35z4VYo7rSb8fjMuA5tNPuzy29ecaVrcD
         KMAw4jxnLysy5Ah4cFZ3aiXCxJRUULqvf0b6gdWNNe8zQ9b1C5yQ17DjpijYCg/wXM
         O68tSsU3MHwddeK1Vmo4hcyxJvbSBHxIC2wuguKg=
Date:   Mon, 6 May 2019 17:19:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        linux-kernel@vger.kernel.org, liam.r.girdwood@linux.intel.com,
        vkoul@kernel.org, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com, joe@perches.com,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 2/7] soundwire: add Slave sysfs support
Message-ID: <20190506151953.GA13178@kroah.com>
References: <20190504010030.29233-1-pierre-louis.bossart@linux.intel.com>
 <20190504010030.29233-3-pierre-louis.bossart@linux.intel.com>
 <20190504065444.GC9770@kroah.com>
 <c675ea60-5bfa-2475-8878-c589b8d20b32@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c675ea60-5bfa-2475-8878-c589b8d20b32@linux.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 06, 2019 at 09:42:35AM -0500, Pierre-Louis Bossart wrote:
> > > +
> > > +int sdw_sysfs_slave_init(struct sdw_slave *slave)
> > > +{
> > > +	struct sdw_slave_sysfs *sysfs;
> > > +	unsigned int src_dpns, sink_dpns, i, j;
> > > +	int err;
> > > +
> > > +	if (slave->sysfs) {
> > > +		dev_err(&slave->dev, "SDW Slave sysfs is already initialized\n");
> > > +		err = -EIO;
> > > +		goto err_ret;
> > > +	}
> > > +
> > > +	sysfs = kzalloc(sizeof(*sysfs), GFP_KERNEL);
> > 
> > Same question as patch 1, why a new device?
> 
> yes it's the same open. In this case, the slave devices are defined at a
> different level so it's also confusing to create a device to represent the
> slave properties. The code works but I am not sure the initial directions
> are correct.

You can just make a subdir for your attributes by using the attribute
group name, if a subdirectory is needed just to keep things a bit more
organized.

Otherwise, you need to mess with having multiple "types" of struct
device all associated with the same bus.  It is possible, and not that
hard, but I don't think you are doing that here.

thnaks,

greg k-h
