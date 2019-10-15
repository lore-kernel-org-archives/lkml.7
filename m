Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 223C7C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 18:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F32742086A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 18:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571162936;
	bh=72Jhf2gCfLKMsgroJ+dspsUWbLqIIaKdSi3E4kfQTHg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=H2w1c7LApZApGPBYKt5mZ9gQCw4M9dGWaIfOx2VS336eWzHbgpmsR1T5tuPJeWoRN
	 4Er2/8+Ifi+H5j4tzOYeT1VZtYTq5AVRGbybpcX39ZELE/O6nnOXyx3qzHPbj+yQ3N
	 eXslkI216zMKwaVz/Rt0pv0tciwJUnth+Kg//uHU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389090AbfJOSIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 14:08:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:40134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbfJOSIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 14:08:54 -0400
Received: from localhost (unknown [38.98.37.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2210920659;
        Tue, 15 Oct 2019 18:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571162933;
        bh=72Jhf2gCfLKMsgroJ+dspsUWbLqIIaKdSi3E4kfQTHg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NxpiRKvyPENu5nqLqiiuFfvP8HewQgS0FRdSFH07T5l3FMQbOQO44QHVHBgUFam0F
         eXDUI/uT1ldmjFXmLTQEiewhqryQ4Ac5n4vAV3hlsaHuBZOZnyuDDJRKQN+Wqkhlgx
         swd+tFNGfcfgwhilnMLjyfPZwq0ztzgXzUO+HuSs=
Date:   Tue, 15 Oct 2019 19:58:20 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Nagarjuna Kristam <nkristam@nvidia.com>, jonathanh@nvidia.com,
        mark.rutland@arm.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch V10 0/8] Tegra XUSB gadget driver support
Message-ID: <20191015175820.GC1072965@kroah.com>
References: <1569227152-3030-1-git-send-email-nkristam@nvidia.com>
 <20191014100257.GB419598@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014100257.GB419598@ulmo>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 12:02:57PM +0200, Thierry Reding wrote:
> On Mon, Sep 23, 2019 at 01:55:44PM +0530, Nagarjuna Kristam wrote:
> > Patches 1-3 are phy driver changes to add support for device
> > mode.
> > Patches 4-7 are changes related to XUSB device mode
> > controller driver.
> > Patch 8 is to enable drivers for XUDC support in defconfig
> > 
> > Test Steps(USB 2.0):
> > - Enable "USB Gadget precomposed configurations" in defconfig
> > - Build, flash and boot Jetson TX1
> > - Connect Jetson TX1 and Ubuntu device using USB A to Micro B
> >   cable
> > - After boot on Jetson TX1 terminal usb0 network device should be
> >   enumerated
> > - Assign static ip to usb0 on Jetson TX1 and corresponding net
> >   device on ubuntu
> > - Run ping test and transfer test(used scp) to check data transfer
> >   communication
> 
> Hi Felipe, Kishon, Greg,
> 
> Patches 1-3 provide new API that is required by patch 7, so I think
> patches 1, 2, 3, 4 and 7 should probably all go through a single tree to
> avoid having to model the dependencies using stable branches.
> 
> Kishon, patches 1-3 have gone through several rounds of review already,
> but do you have any remaining concerns on them? If not, it'd be great if
> you could ack them. Felipe and Greg could then pick them up along with
> patches 4 and 7 into the USB tree.
> 
> Felipe, Greg, does that sound like a reasonable plan?

Fine with me.

> I should also mention that while waiting for review, Nagarjuna has been
> able to extend support for the XUDC driver to Tegra186 but has so far
> been holding back on sending them out so as to not needlessly hold up
> progress on this series. However, given the interdependencies, I've come
> to think that it may be preferable to merge everything in one go instead
> of revisiting this in a couple of weeks.
> 
> If you guys prefer, Nagarjuna could send out v11 of the series and
> integrate Tegra186 support.

That's also fine.

thanks,

greg k-h
