Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E04CC3A59B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 05:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E29802186A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 05:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566192310;
	bh=JX3Eh018TENEZILR9PKGvf8EpEV054KUxr7uqIPnTeQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=unDNUZVOcNeb2luUoSnNx1AtjD5XOdW8Ij+TZtEje26creFuS5TlQfrkJvk4cbzHH
	 BwMuIxeeJTdaU9TAmQGLRhd5ifKselM/Up3TvuKxvTaIO+9lbUvRSywyyrnPPHGq36
	 sDAFrSxympkkA5dzaBT7ZOlCl/zhJwU+UpRXcMZo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbfHSFZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 01:25:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:34172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbfHSFZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 01:25:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74E5A2087E;
        Mon, 19 Aug 2019 05:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566192308;
        bh=JX3Eh018TENEZILR9PKGvf8EpEV054KUxr7uqIPnTeQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dTDwhDwZg1RHfi6syCEpoC4MXweGcKactSujSeXt7/mJmugHxkuuVKz51gQGrb1Kv
         c0VbReRZNWqqjX4Wj9DZCo89IW85PK6RVa1Zp64GOtCpFuTFtdRYqia72eRUaXPqeY
         iSfsUAlahxSFiEd1eSFuGUaYdqeevC+0X5YDxX7k=
Date:   Mon, 19 Aug 2019 07:25:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Zhao, Yakui" <yakui.zhao@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, devel@driverdev.osuosl.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 00/15] acrn: add the ACRN driver module
Message-ID: <20190819052505.GA915@kroah.com>
References: <1565922356-4488-1-git-send-email-yakui.zhao@intel.com>
 <20190816063925.GB18980@zn.tnic>
 <78897bb2-e6eb-cac2-7166-eccb7cd5c959@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <78897bb2-e6eb-cac2-7166-eccb7cd5c959@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 09:44:25AM +0800, Zhao, Yakui wrote:
> 
> 
> On 2019年08月16日 14:39, Borislav Petkov wrote:
> > On Fri, Aug 16, 2019 at 10:25:41AM +0800, Zhao Yakui wrote:
> > > The first three patches are the changes under x86/acrn, which adds the
> > > required APIs for the driver and reports the X2APIC caps.
> > > The remaining patches add the ACRN driver module, which accepts the ioctl
> > > from user-space and then communicate with the low-level ACRN hypervisor
> > > by using hypercall.
> > 
> > I have a problem with that: you're adding interfaces to arch/x86/ and
> > its users go into staging. Why? Why not directly put the driver where
> > it belongs, clean it up properly and submit it like everything else is
> > submitted?
> 
> Thanks for your reply and the concern.
> 
> After taking a look at several driver examples(gma500, android), it seems
> that they are firstly added into drivers/staging/XXX and then moved to
> drivers/XXX after the driver becomes mature.
> So we refer to this method to upstream ACRN driver part.

Those two examples are probably the worst examples to ever look at :)

The code quality of those submissions was horrible, gma500 took a very
long time to clean up and there are parts of the android code that are
still in staging to this day.

> If the new driver can also be added by skipping the staging approach,
> we will refine it and then submit it in normal process.

That is the normal process, staging should not be needed at all for any
code.  It is a fall-back for when the company involved has no idea of
how to upstream their code, which should NOT be the case here.

thanks,

greg k-h
