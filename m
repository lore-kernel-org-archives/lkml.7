Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34335FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 04:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F268B21882
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 04:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573185874;
	bh=SvuaRTCeiaXO1ulAR/hJt99i4giuW2xuFA2TDU0zp18=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=y58VbXCdsGonaub+X9wqZKfsfxoUIP1kGh9jh2skL4TOKYyPRstyqpCxJKY201UYJ
	 qL8uUm4ZYRU2GvzE6tRDw/kQdlTCYbk9fnETQmwyy1X1pjpUY8GDnCptoUDmFIfsUS
	 yPyQ0A9bWoP3z18vE+7/A7hZbuPnl/5hRmDhOcsg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729598AbfKHEEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 23:04:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:47984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbfKHEEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 23:04:32 -0500
Received: from localhost (unknown [106.200.194.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1743020679;
        Fri,  8 Nov 2019 04:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573185871;
        bh=SvuaRTCeiaXO1ulAR/hJt99i4giuW2xuFA2TDU0zp18=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nw6TiCjgbXAYPw4/yuxeXN1VTfWQPOYCZ720Hd4sVm2Fjp2XqgmMEUPstd7kcpMD6
         iLyGR/e0RXRctA8Vq+e+0xmMB8ZVpHLcn7/khJVx/yhcVG38OrKvyvgUm8Wh5LQIyp
         P8lIM256KMJw7TLMZOFSsv7yYu72KxT6iAu3R99M=
Date:   Fri, 8 Nov 2019 09:34:27 +0530
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
Subject: Re: [alsa-devel] [PATCH 07/14] soundwire: add initial definitions
 for sdw_master_device
Message-ID: <20191108040427.GT952516@vkoul-mobl>
References: <20191023212823.608-1-pierre-louis.bossart@linux.intel.com>
 <20191023212823.608-8-pierre-louis.bossart@linux.intel.com>
 <20191103063051.GJ2695@vkoul-mobl.Dlink>
 <9a8fb9ec-1ccb-4931-1ec6-bfae043e8c88@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8fb9ec-1ccb-4931-1ec6-bfae043e8c88@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-11-19, 08:42, Pierre-Louis Bossart wrote:
> 
> 
> On 11/3/19 1:30 AM, Vinod Koul wrote:
> > On 23-10-19, 16:28, Pierre-Louis Bossart wrote:
> > > Since we want an explicit support for the SoundWire Master device, add
> > > the definitions, following the Grey Bus example.
> > > 
> > > Open: do we need to set a variable when dealing with the master uevent?
> > 
> > I dont think we want that or we need that!
> 
> In GreyBus there are events and variables set, not sure what they were used
> for. The code works without setting an event, but we'd need to make a
> conscious design decision, and I am not too sure what usersace would use the
> informatio for.
> 
> > 
> > And to prevent that rather than adding a variable, can you please
> > modify the device_type and use separate ones for master_device and
> > slave_device
> 
> sorry, I don't get the comment. There is only already a different device
> type
> 
> 
> struct bus_type sdw_bus_type = {
> 	.name = "soundwire",
> 	.match = sdw_bus_match,
> 	.uevent = sdw_uevent,

We can remove this

> };
> 
> struct device_type sdw_slave_type = {
> 	.name =		"sdw_slave",
> 	.release =	sdw_slave_release,

Add here:

        uevent = sdw_uevent,

> };
> 
> struct device_type sdw_md_type = {
> 	.name =		"soundwire_master",
> 	.release =	sdw_md_release,
> };

And not have here!

Problem solved!

-- 
~Vinod
