Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A67C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 21:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 610452077B
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 21:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576273748;
	bh=V2CFaPZrBBdO4R3RxH32GOkPbplsMRGGeYhs5JVDvlo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ml53OBdxiLo9QVFHRm70GDrNNmSUnwgSS9ucfJLkBLPUlRaFgZsqgK0Ps99a23RAj
	 XlATi/KsE1xaSF2NDvuQQGd7zqd8jaznmCHVWnk7nTrLNlekFpHqhEbnk0gBFwx9A3
	 KwQf2IPtzsKPePp3JTBFGU1U8sMbdQIXdT5i3WRM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbfLMVtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 16:49:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:52956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726736AbfLMVtF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 16:49:05 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B6BF2465B;
        Fri, 13 Dec 2019 21:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576273743;
        bh=V2CFaPZrBBdO4R3RxH32GOkPbplsMRGGeYhs5JVDvlo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eFDk6Bl+gPJrHIciR4vBH+8r8r0dzIndAkbihFAR+VZl7n9w4+z4X3YS0jXCKDm2N
         L/xhDeR8Us+FMN0hmZj3LDaxscVUQRjdRF0vb6ofww0UVFzHgDtovR8oAR0FMZEkon
         +npXLMc+JdbVBYLeUDoJ7x2DHhpGZ2Bh7D1TAb9E=
Date:   Fri, 13 Dec 2019 17:12:18 +0100
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
Subject: Re: [alsa-devel] [PATCH v4 06/15] soundwire: add support for
 sdw_slave_type
Message-ID: <20191213161218.GC2653074@kroah.com>
References: <20191213050409.12776-1-pierre-louis.bossart@linux.intel.com>
 <20191213050409.12776-7-pierre-louis.bossart@linux.intel.com>
 <20191213072127.GD1750354@kroah.com>
 <41d1fcbc-47b7-bbee-5b55-759cbb5f5a7b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41d1fcbc-47b7-bbee-5b55-759cbb5f5a7b@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2019 at 09:05:37AM -0600, Pierre-Louis Bossart wrote:
> On 12/13/19 1:21 AM, Greg KH wrote:
> > On Thu, Dec 12, 2019 at 11:04:00PM -0600, Pierre-Louis Bossart wrote:
> > > Currently the bus does not have any explicit support for master
> > > devices.
> > > 
> > > First add explicit support for sdw_slave_type and error checks if this type
> > > is not set.
> > > 
> > > In follow-up patches we can add support for the sdw_md_type (md==Master
> > > Device), following the Grey Bus example.
> > 
> > How are you using greybus as an example of "master devices"?  All you
> > are doing here is setting the type of the existing devices, right?
> 
> I took your advice to look at GreyBus and used the 'gb host device' as the
> model to implement the 'sdw master' add/startup/remove interfaces we needed.
> 
> so yes in this patch we just add a type for the slave, the interesting part
> is in the next patches.

Is that what a "master" device really is?  A host controller, like a USB
host controller?  Or something else?

I thought things were a bit more complex for this type of topology.

greg k-h
