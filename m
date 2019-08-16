Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30ED8C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 07:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01E9421655
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 07:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565939029;
	bh=harVtDZ3Mjw5P1AQ7Ik6ukdvdVe+6Ge5VYwU38+ajZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=M5vK+C60dUlaIXPCktGFQYPhoXdOvkZKrp4DXYg22HdP5vtE4kOLvwi4yp+RNAdeC
	 mfkQkOif+D/IU6Iw+CEObC6EmArvq0AlJB0mG5FMMhP7BAr3pmD94UsDGTJtTOPfiX
	 YTyKcov7GJH4QVqdZ77v3npAilDY2PtMM5Iv6Qq8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfHPHDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 03:03:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:34676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbfHPHDr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 03:03:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A679206C1;
        Fri, 16 Aug 2019 07:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565939026;
        bh=harVtDZ3Mjw5P1AQ7Ik6ukdvdVe+6Ge5VYwU38+ajZs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qsO94+A0bPL9zhDaWF3g9RCQFGvKtfFMVXDQK1TM9It4agcJIYZsnoGuBJqFDtc6v
         VRTpeHGWGg/PIR8H4OU2gS2T69sWzzHU4+zxgB80kb03Jm/gU8JxdGXa2L0r+6Ss1j
         ckeaXF8OL9nMl6/L5DCR7frYhxnngfZBfGcV0/uQ=
Date:   Fri, 16 Aug 2019 09:03:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhao Yakui <yakui.zhao@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, devel@driverdev.osuosl.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 00/15] acrn: add the ACRN driver module
Message-ID: <20190816070343.GA1368@kroah.com>
References: <1565922356-4488-1-git-send-email-yakui.zhao@intel.com>
 <20190816063925.GB18980@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816063925.GB18980@zn.tnic>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 08:39:25AM +0200, Borislav Petkov wrote:
> On Fri, Aug 16, 2019 at 10:25:41AM +0800, Zhao Yakui wrote:
> > The first three patches are the changes under x86/acrn, which adds the
> > required APIs for the driver and reports the X2APIC caps. 
> > The remaining patches add the ACRN driver module, which accepts the ioctl
> > from user-space and then communicate with the low-level ACRN hypervisor
> > by using hypercall.
> 
> I have a problem with that: you're adding interfaces to arch/x86/ and
> its users go into staging. Why? Why not directly put the driver where
> it belongs, clean it up properly and submit it like everything else is
> submitted?
> 
> I don't want to have stuff in arch/x86/ which is used solely by code in
> staging and the latter is lingering there indefinitely because no one is
> cleaning it up...

I agree, stuff in drivers/staging/ must be self-contained, with no
changes outside of the code's subdirectory needed in order for it to
work.  That way it is trivial for us to delete it when it never gets
cleaned up :)

You never say _why_ this should go into drivers/staging/, nor do you
have a TODO file like all other staging code that explains exactly what
needs to be done to get it out of there.

thanks,

greg k-h
