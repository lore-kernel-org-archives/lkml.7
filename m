Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 046F1C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 14:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9F8F2499C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 14:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559658521;
	bh=O7gbnZkk6GvrbVTl6bI9UPon+W+udWxZvh/zYblS/1E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JKyZIYncpprSbGP3Tu6Ubq93jaOKD/r3gpmuILgyhMrn+XIqToVhdX87w+MpPaIcl
	 5uoTcn1wCbQUOx2N/prZEgTOWb3eq17zvDXYWxGsZQ+QVuTaTdgBtIDytwbJaPvXny
	 tV+GOeg5APigNcalGHel2RyJ0bx5N7ewxYhkkZNw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbfFDO2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 10:28:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:42988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727169AbfFDO2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 10:28:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E4AD2498F;
        Tue,  4 Jun 2019 14:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559658520;
        bh=O7gbnZkk6GvrbVTl6bI9UPon+W+udWxZvh/zYblS/1E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mGq/RcvUMLPKU/cWsDJ4IfF8EVqouENT3sn2nQ+9c7sYPAiCQmC0RxTwbc/mjHy5d
         83v105+qfyjymk+w+8cgUQ1eZuSbkvJHDCja+sAdzS+Dn8gRWNndYNjSvj0jOlm0HG
         emi4ss3C/xcI9UBK1CIYD1M/pARhXG19y7/N8KP4=
Date:   Tue, 4 Jun 2019 16:28:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Richard Gong <richard.gong@linux.intel.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, dinguyen@kernel.org,
        atull@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, sen.li@intel.com,
        Richard Gong <richard.gong@intel.com>
Subject: Re: A potential broken at platform driver?
Message-ID: <20190604142837.GB28355@kroah.com>
References: <1559074833-1325-1-git-send-email-richard.gong@linux.intel.com>
 <1559074833-1325-3-git-send-email-richard.gong@linux.intel.com>
 <20190528232224.GA29225@kroah.com>
 <1e3b5447-b776-f929-bca6-306f90ac0856@linux.intel.com>
 <b608d657-9d8c-9307-9290-2f6b052a71a9@linux.intel.com>
 <20190603180255.GA18054@kroah.com>
 <b3dd022b-b585-3dfb-5fe6-9c9f5498bc77@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3dd022b-b585-3dfb-5fe6-9c9f5498bc77@linux.intel.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 06:08:37PM -0500, Richard Gong wrote:
> Hi Greg,
> 
> On 6/3/19 1:02 PM, Greg KH wrote:
> > On Mon, Jun 03, 2019 at 10:57:18AM -0500, Richard Gong wrote:
> > > 
> > > Hi Greg,
> > > 
> > > Following your suggestion, I replaced devm_device_add_groups() with .group =
> > > rus_groups in my version #4 submission. But I found out that RSU driver
> > > outputs the garbage data if I use .group = rsu_groups.
> > 
> > What is "garbage"?
> I mean incorrect status info.
> 
> > 
> > > To make RSU driver work properly, I have to revert the change at version #4
> > > and use devm_device_add_groups() again. Sorry, I didn't catch this problem
> > > early.
> > > 
> > > I did some debug & below are captured log, you can see priv pointer get
> > > messed at current_image_show(). I am not sure if something related to
> > > platform driver work properly. I attach my debug patch in this mail.
> > > 
> > > 1. Using .groups = rsu_groups,
> > > 
> > > [    1.191115] *** rsu_status_callback:
> > > [    1.194782] res->a1=2000000
> > > [    1.197588] res->a1=0
> > > [    1.199865] res->a2=0
> > > [    1.202150] res->a3=0
> > > [    1.204433] priv=0xffff80007aa28e80
> > > [    1.207933] version=0, state=0, current_image=2000000, fail_image=0,
> > > error_location=0, error_details=0
> > > [    1.217249] *** stratix10_rsu_probe: priv=0xffff80007aa28e80
> > > root@stratix10:/sys/bus/platform/drivers/stratix10-rsu# cat current_image
> > > [   38.849341] *** current_image_show: priv=0xffff80007aa28d00
> > > ... output garbage data
> > > priv pointer got changed
> > 
> > I don't understand this, sorry.  Are you sure you are actually using the
> > correct pointer to your device?
> > 
> I think so.
> 
> The dev pointer at current_image_show() should points to RSU device, but it
> seems point to driver_private if I use .group = rsU_groups. As a result I
> can't get the priv pointer properly at current_image_show().

It points to the driver kobject, not the device kobject.  So that's the
issue here.  See the patch that I just posted for a potential fix for
this.

thanks,

greg k-h
