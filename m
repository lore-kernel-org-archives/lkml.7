Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19DBC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9124821734
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553712335;
	bh=lWA8wpE896V8916829QxZnsLpATu31sertHYovoMxt4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OCoaQC+RBQ3DnJdAw1EaNzbyNywN/bjx6w/mhICHQfwz/pAqUfeq8Uq4YtrSuGISv
	 sHrP6j6V3OXVH1j4qqU3LJlmZ9si8CJpP8rmTEOJPB09ky6cj6d82OV+yQvkfWScGj
	 cLAuZFhDA33L2MxJX+G5Fqj+T2Eb/KhXECRn47Ps=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391976AbfC0Spd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:45:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:38188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391389AbfC0Spa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:45:30 -0400
Received: from localhost (unknown [88.128.80.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A4C7205C9;
        Wed, 27 Mar 2019 18:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553712329;
        bh=lWA8wpE896V8916829QxZnsLpATu31sertHYovoMxt4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nb2vd2/35gS9bepcLAMK2SZhDyRviVJXsRfZREhdtq1pGOv1JOWFvWq1Lwb5aFXJw
         KWBLKX5SUoMVshDMqQT8bzDTUmRrS5acuO0IgZUA21DizPWl6QOG6tDGx2PSxcm/0I
         Sfzq8R1znIk638VLi6zY7VzvIs+ouwnizMOYrvGY=
Date:   Wed, 27 Mar 2019 19:45:26 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Ronald =?iso-8859-1?Q?Tschal=E4r?= <ronald@innovation.ch>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Federico Lorenzi <federico@travelground.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] Input: add Apple SPI keyboard and trackpad driver.
Message-ID: <20190327184526.GA11095@kroah.com>
References: <20190327014807.7472-1-ronald@innovation.ch>
 <20190327014807.7472-5-ronald@innovation.ch>
 <20190327093530.GH9224@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190327093530.GH9224@smile.fi.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 11:35:30AM +0200, Andy Shevchenko wrote:
> On Tue, Mar 26, 2019 at 06:48:07PM -0700, Ronald Tschalär wrote:
> > The keyboard and trackpad on recent MacBook's (since 8,1) and
> > MacBookPro's (13,* and 14,*) are attached to an SPI controller instead
> > of USB, as previously. The higher level protocol is not publicly
> > documented and hence has been reverse engineered. As a consequence there
> > are still a number of unknown fields and commands. However, the known
> > parts have been working well and received extensive testing and use.
> > 
> > In order for this driver to work, the proper SPI drivers need to be
> > loaded too; for MB8,1 these are spi_pxa2xx_platform and spi_pxa2xx_pci;
> > for all others they are spi_pxa2xx_platform and intel_lpss_pci. For this
> > reason enabling this driver in the config implies enabling the above
> > drivers.
> 
> > +// SPDX-License-Identifier: GPL-2.0
> 
> According to last changes this should be GPL-2.0-only

What "last changes"?  "GPL-2.0" is a totally valid SPDX identifier for
the kernel.  Don't buy into the "-only" prefix crud that the newer SPDX
version adopted for crazy reasons.  The in-kernel documentation lists
the valid identifiers and the version of SPDX we are currently using.

thanks,

greg k-h
