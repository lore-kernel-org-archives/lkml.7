Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4184C2D0C2
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 19:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7244A20409
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 19:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577734585;
	bh=GAbF97BAWuF7iRHb1+wf7ASujjlNhXc1dFX1hZGgbY0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=F54vgnBfZXxDt8Ve3EjQD021AnJzA59SUKHpNX6umjeKUtahudA2yAr9wYKfsGss0
	 idmkDZN6f5n6xxV2tvK+DpqhGCU4Pg/y4owyuw5NmUwLJteO0wNEhVdbC0bTk+5VUp
	 rnn4M/YgIEcRfvdieRQ80IET9QxyAHpHpC6S+7OA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbfL3TgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 14:36:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:53498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727278AbfL3TgY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 14:36:24 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE81E20409;
        Mon, 30 Dec 2019 19:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577734583;
        bh=GAbF97BAWuF7iRHb1+wf7ASujjlNhXc1dFX1hZGgbY0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BkKOKIg/OkUdFNHElIcXhItuh4NpDR2M6svLcZu6ghqnhWwZ+8hpmKHlr8XGOVc09
         +R35rB3z/N0wjE9wO317qeSA8z2soLBcU4aYsJy09G9MRyd1lg4ykdhLxytzJ9CK0W
         wEpVoe4nAuNQ1rASCd4mtez/32TnJhAl0Z+tv6mk=
Date:   Mon, 30 Dec 2019 20:36:21 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] usb: host: Enable compile testing for some of drivers
Message-ID: <20191230193621.GA1856526@kroah.com>
References: <20191230172215.17370-1-krzk@kernel.org>
 <20191230192956.GA1844196@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191230192956.GA1844196@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 30, 2019 at 08:29:56PM +0100, Greg Kroah-Hartman wrote:
> On Mon, Dec 30, 2019 at 06:22:14PM +0100, Krzysztof Kozlowski wrote:
> > Some of the USB host drivers can be compile tested to increase build
> > coverage.  Add 'if' conditional to 'default y' so they will not get
> > enabled by default on all other architectures.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >  drivers/usb/host/Kconfig | 54 ++++++++++++++++++++--------------------
> >  1 file changed, 27 insertions(+), 27 deletions(-)
> 
> Nice, thanks for these, they should help out a lot with development.

And now I get this build warning with this patch:

WARNING: unmet direct dependencies detected for PHY_DA8XX_USB
  Depends on [n]: ARCH_DAVINCI_DA8XX
  Selected by [m]:
  - USB_OHCI_HCD_DAVINCI [=m] && USB_SUPPORT [=y] && USB [=m] && (ARCH_DAVINCI_DA8XX || COMPILE_TEST [=y]) && USB_OHCI_HCD [=m]


Care to provide a fix?

thanks,

greg k-h
