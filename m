Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63251C2D0C3
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 20:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 257A820718
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 20:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577736383;
	bh=yQDvy7TJNkpK6gkIDKXU1GEX71zxmJFmFVTDc0zaUbo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RdxLBuIMp4uzCDKlNv4Dir611OIXoZm2fH/DFDWZ+MgjPI2R66wlHFoYPUM9f1B1X
	 C+9gB2C+3u36DrdtP2vIt9rkdnQxJt32bwuDPQVaXTlNjhbqHdjfVnCjbR/xiMeYpX
	 xlxX5kOP5SNYZItw60kJ4gvOxZmPBZJeIacaGBHs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbfL3UGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 15:06:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:49236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727667AbfL3UGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 15:06:21 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5D0F20718;
        Mon, 30 Dec 2019 20:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577736381;
        bh=yQDvy7TJNkpK6gkIDKXU1GEX71zxmJFmFVTDc0zaUbo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DHz+1zPhWKtXADuzWZ5QmqWaHex/R6xQV3Jasm0QwCeheJf/voBnJUB2wXq0mj1ey
         2jMNTc43FJie1/ysuVBRercnSKCDi5crzem3MgC331DQ/202AwMQ6YiAgdg4NtEi95
         tDlHD4GLmN6zLyRhOSQci9mQPHXnrzBkDoIq40Ek=
Date:   Mon, 30 Dec 2019 21:06:18 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] usb: host: Enable compile testing for some of drivers
Message-ID: <20191230200618.GA1882713@kroah.com>
References: <20191230172215.17370-1-krzk@kernel.org>
 <20191230192956.GA1844196@kroah.com>
 <20191230193621.GA1856526@kroah.com>
 <20191230194249.GA26581@kozik-lap>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191230194249.GA26581@kozik-lap>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 30, 2019 at 08:42:49PM +0100, Krzysztof Kozlowski wrote:
> On Mon, Dec 30, 2019 at 08:36:21PM +0100, Greg Kroah-Hartman wrote:
> > On Mon, Dec 30, 2019 at 08:29:56PM +0100, Greg Kroah-Hartman wrote:
> > > On Mon, Dec 30, 2019 at 06:22:14PM +0100, Krzysztof Kozlowski wrote:
> > > > Some of the USB host drivers can be compile tested to increase build
> > > > coverage.  Add 'if' conditional to 'default y' so they will not get
> > > > enabled by default on all other architectures.
> > > > 
> > > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > > > ---
> > > >  drivers/usb/host/Kconfig | 54 ++++++++++++++++++++--------------------
> > > >  1 file changed, 27 insertions(+), 27 deletions(-)
> > > 
> > > Nice, thanks for these, they should help out a lot with development.
> > 
> > And now I get this build warning with this patch:
> > 
> > WARNING: unmet direct dependencies detected for PHY_DA8XX_USB
> >   Depends on [n]: ARCH_DAVINCI_DA8XX
> >   Selected by [m]:
> >   - USB_OHCI_HCD_DAVINCI [=m] && USB_SUPPORT [=y] && USB [=m] && (ARCH_DAVINCI_DA8XX || COMPILE_TEST [=y]) && USB_OHCI_HCD [=m]
> > 
> > 
> > Care to provide a fix?
> 
> That's my fault. I was testing entire patchset which includes also other
> trees. I sent patch for PHY here:
> https://lore.kernel.org/lkml/20191230172449.17648-2-krzk@kernel.org/T/#u
> 
> Probably they should go together or we could ignore the error as it is
> only for build testing.

If that patchset gets merged, all is fine.  If not, let me know and I
can take it through my tree :)

thanks,

greg k-h
