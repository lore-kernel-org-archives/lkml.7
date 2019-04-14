Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F6CC10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 10:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB24C20848
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 10:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555237571;
	bh=/dcERjg2sEn/phzonHtWup1Qx9cet1TXUFX1uCkcVb0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LCnLPxrEerx5z8f4hCNdDP3EEyJLzfZOIC9MHTI7RsisiCBGSx+WwAsjulTHcOq6u
	 T8k3t8ubw3vPHZ6E33rH0J6QOr8QDBEZ5Lef0EQ7yayk2iLAVqAh2Mj2k2zRZ3mab6
	 YQ6gZmlkZKcR0Pmya5y+WsRjlTf6RT9p3yzWtCvQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfDNK0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 06:26:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:42750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbfDNK0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 06:26:09 -0400
Received: from localhost (unknown [106.198.180.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52E78206BA;
        Sun, 14 Apr 2019 10:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555237568;
        bh=/dcERjg2sEn/phzonHtWup1Qx9cet1TXUFX1uCkcVb0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TbAT4O1Flt5VpmLGPkeJuoZfUakm9z6foY6NblHMqM3Fxeo3L1p+76hbXHhoyoMhC
         7UKe1x3HtrbPYaJibXntIKoyW9bqJN3otkAyAqlOn0UFvrBxqfPPe1C4DlEJbTTFce
         37AtHAlgENLYMS9/o+voaS1Nx6Ifj5hJv3pDLbZc=
Date:   Sun, 14 Apr 2019 15:56:02 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Jan Kotas <jank@cadence.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        "sanyog.r.kale@intel.com" <sanyog.r.kale@intel.com>
Subject: Re: [alsa-devel] [PATCH] soundwire: fix pm_runtime_get_sync return
 code checks
Message-ID: <20190414102601.GM28103@vkoul-mobl>
References: <20190405072655.25995-1-jank@cadence.com>
 <367316fa-9d92-2dfc-32c4-3e0e8c76ef43@linux.intel.com>
 <92538D7E-C628-40AC-AFE9-52C97B3BC42D@global.cadence.com>
 <ace7e7f7-c3bf-f38c-0e70-da826175e3c5@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ace7e7f7-c3bf-f38c-0e70-da826175e3c5@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-04-19, 12:43, Pierre-Louis Bossart wrote:
> 
> 
> On 4/8/19 2:12 AM, Jan Kotas wrote:
> > 
> > 
> > > On 5 Apr 2019, at 17:04, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com> wrote:
> > > 
> > > On 4/5/19 2:26 AM, Jan Kotas wrote:
> > > > 
> > > >   	ret = pm_runtime_get_sync(slave->bus->dev);
> > > > -	if (ret < 0)
> > > > +	if (ret < 0 && ret != -EACCES)
> > > > 
> > > There was a patch submitted on 3/28 by Srinivas Kandagatla who suggested an alternate solution for exactly the same code.
> > > 
> > > +	if (pm_runtime_enabled(slave->bus->dev)) {
> > > +		ret = pm_runtime_get_sync(slave->bus->dev);
> > > +		if (ret < 0)
> > > +			return ret;
> > > 
> > > I am far from an expert on pm_runtime but Srinivas' solution looks more elegant to me.
> > 
> > Hello Pierre,
> > 
> > Please take a look at this patch, that was my inspiration:
> > https://lists.linuxfoundation.org/pipermail/linux-pm/2011-June/031930.html
> 
> The two patches seems to be identical:
> 
> static inline bool pm_runtime_enabled(struct device *dev)
> {
> 	return !dev->power.disable_depth;
> }
> 
> static int rpm_resume()
> [...]
> else if (dev->power.disable_depth > 0)
> 		retval = -EACCES;
> 
> 
> However I am still not clear on why this might fail.
> 
> I can only think of one possible explanation: there is no explicit
> pm_runtime_enable() in the soundwire code, so maybe the expectation is that
> the pm_runtime status is inherited from the parent (in the intel case the
> PCI driver), and that's missing in non-intel configurations?

IIRC that needs to be called by the Intel driver and those patches were
not upstreamed. So we dont have fully supported PM on upstream yet!

> 
> > I also took a look, and it seems the value returned by
> > pm_runtime_get_syncis simply ignored in a lot of places,
> > so checking its value may be excessive.
> But not checking seems careless at best...

-- 
~Vinod
