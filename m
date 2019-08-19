Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3832C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 05:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B225C2087E
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 05:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566192343;
	bh=AwTUduT9b22UbtIBvD/06jT9jdDhKUoHKsa26bnugjw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZNuoktSyGm1ruN2otLKdAcexF71nCvDmUlPaYd2KW6VSbsdFFo4ALbPCmq0jobTw6
	 QtQuInrgVA6Vxi65cw7LBNSJetF7ZJdcBqF3FY0OBsHQn2hZH3H5anmvLx7VH0C07S
	 3Hfe3xX8McgF/uRsvDBP0Mm1rsNh+E7IGBMMfoEc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbfHSFZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 01:25:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:34454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725871AbfHSFZm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 01:25:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C80C2087E;
        Mon, 19 Aug 2019 05:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566192341;
        bh=AwTUduT9b22UbtIBvD/06jT9jdDhKUoHKsa26bnugjw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gd+A7R4e6F3qWauynpPW2cCYzfyMKPTuWJGy+I9yt7Ou8mlwFwDAwJavSq18/njvn
         H3S7ngdvQxHxGxAoGKs9o5T1wQbHoaWayL9CwgicLX3pfId2DTaB3PNyplDmPoNAAO
         9EcA6H4cn+a0Z5Wypd/qOqHY4zecCaJ1F81EVvu4=
Date:   Mon, 19 Aug 2019 07:25:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Zhao, Yakui" <yakui.zhao@intel.com>
Cc:     devel@driverdev.osuosl.org, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 00/15] acrn: add the ACRN driver module
Message-ID: <20190819052539.GB915@kroah.com>
References: <1565922356-4488-1-git-send-email-yakui.zhao@intel.com>
 <20190816063925.GB18980@zn.tnic>
 <20190816070343.GA1368@kroah.com>
 <30d31b78-7da6-5344-6f64-b7273b40f611@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <30d31b78-7da6-5344-6f64-b7273b40f611@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 10:39:32AM +0800, Zhao, Yakui wrote:
> 
> 
> On 2019年08月16日 15:03, Greg KH wrote:
> > On Fri, Aug 16, 2019 at 08:39:25AM +0200, Borislav Petkov wrote:
> > > On Fri, Aug 16, 2019 at 10:25:41AM +0800, Zhao Yakui wrote:
> > > > The first three patches are the changes under x86/acrn, which adds the
> > > > required APIs for the driver and reports the X2APIC caps.
> > > > The remaining patches add the ACRN driver module, which accepts the ioctl
> > > > from user-space and then communicate with the low-level ACRN hypervisor
> > > > by using hypercall.
> > > 
> > > I have a problem with that: you're adding interfaces to arch/x86/ and
> > > its users go into staging. Why? Why not directly put the driver where
> > > it belongs, clean it up properly and submit it like everything else is
> > > submitted?
> > > 
> > > I don't want to have stuff in arch/x86/ which is used solely by code in
> > > staging and the latter is lingering there indefinitely because no one is
> > > cleaning it up...
> > 
> > I agree, stuff in drivers/staging/ must be self-contained, with no
> > changes outside of the code's subdirectory needed in order for it to
> > work.  That way it is trivial for us to delete it when it never gets
> > cleaned up :)
> 
> Thanks for pointing out the rule of drivers/staging.
> The acrn staging driver is one self-contained driver. But it has some
> dependency on arch/x86/acrn and need to call the APIs in arch/x86/acrn.

Then it should not be in drivers/staging/  Please work to get this
accepted "normally".

thanks,

greg k-h
