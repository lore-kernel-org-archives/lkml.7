Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD46C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 12:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C9A52190F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 12:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563797484;
	bh=7/4GGkbSj/BIq0gPMtDTgby1bEClkS3rXbv3+CaxRj0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QYjrbNlAPZ4GexI2K9w/X4nEkh7/QZPPPB0zjwlmGYRwEs0VeGmirQoMbwMp39vn3
	 la8R6BGbdyBSx39lztpXPQVQ9jI0dBHlW0YPQWN1W9x5BEptNJGyxiPhPMqL3QQkBB
	 HySFyT7VvWy83t3lmAR2EFKjOfxAlE9WWT/z2bcg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729286AbfGVMLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 08:11:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:54330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728413AbfGVMLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 08:11:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 096412190D;
        Mon, 22 Jul 2019 12:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563797481;
        bh=7/4GGkbSj/BIq0gPMtDTgby1bEClkS3rXbv3+CaxRj0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E/45y5utMHS76gj+/OZzr0orMa3o8x7cTZ/fsUoKlaM+CKlmpNv8OiNUk40QmXIql
         YNBt2DsE/pLGp2n1usNQV3Tz87lvNu8VOfuJ33ROfhSqYZlZhXXkttks4VI9mOgNTw
         H7tIQ9/ZuPZ96thOespCgXoaFUU9Pm7VeVxvpQNY=
Date:   Mon, 22 Jul 2019 14:11:18 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Pavel Machek <pavel@denx.de>
Cc:     Pawel Laszczak <pawell@cadence.com>,
        "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        Rahul Kumar <kurahul@cadence.com>,
        Anil Joy Varughese <aniljoy@cadence.com>
Subject: Re: [PATCH v10 0/6] Introduced new Cadence USBSS DRD Driver.
Message-ID: <20190722121118.GA31543@kroah.com>
References: <1563733939-21214-1-git-send-email-pawell@cadence.com>
 <20190721190335.GA19831@xo-6d-61-c0.localdomain>
 <BYAPR07MB470904ACCD1ED91B10BB6BEFDDC40@BYAPR07MB4709.namprd07.prod.outlook.com>
 <20190722114839.GA10515@kroah.com>
 <20190722115644.GA12069@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722115644.GA12069@amd>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 01:56:45PM +0200, Pavel Machek wrote:
> Hi!
> 
> > > >> This patch introduce new Cadence USBSS DRD driver to linux kernel.
> > > >>
> > > >> The Cadence USBSS DRD Controller is a highly configurable IP Core which
> > > >> can be instantiated as Dual-Role Device (DRD), Peripheral Only and
> > > >> Host Only (XHCI)configurations.
> > > >
> > > >I see you are using debugfs to select between DRD, peripheral-onlyh and XHCI...
> > > >
> > > >Is that good idea?
> > > 
> > > Yes driver allows selecting dr_mode by debugfs. Controller also support such functionality 
> > > so I don't understand why would it not be a good idea. 
> > > 
> > > I personally use this for testing but it can be used to limit controller functionality without 
> > > recompiling kernel. 
> > 
> > debugfs is ONLY for debugging, never rely on it being enabled, or
> > mounted, on a system in order to have any normal operation happen.
> > 
> > So for testing, yes, this is fine.  If this is going to be the normal
> > api/interface for how to control this driver, no, that is not acceptable
> > at all.
> 
> It makes a lot of sense for end-user to toggle this... for example
> when he is lacking right cable for proper otg detection. As it is
> third driver offering this functionality, I believe we should stop
> treating it as debugging.

Then it needs to get out of debugfs, as again, that can not be used for
any normal end-user operation.

thanks,

greg k-h
