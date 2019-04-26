Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E949CC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 05:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDE57206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 05:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=innovation.ch header.i=@innovation.ch header.b="Vux0eKI+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfDZFek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 01:34:40 -0400
Received: from chill.innovation.ch ([216.218.245.220]:50284 "EHLO
        chill.innovation.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfDZFek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 01:34:40 -0400
Date:   Thu, 25 Apr 2019 22:34:39 -0700
DKIM-Filter: OpenDKIM Filter v2.10.3 chill.innovation.ch 4DCFF640142
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=innovation.ch;
        s=default; t=1556256879;
        bh=cobPhl1hKyKroPkhRLtOEz8ZiJGlI0EKEoUw/ZGd1Rw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vux0eKI+54KYt6HMcOWLlMAK1kJUOn2WSVYl51Sapsf0ZMsNaIrFnVNJbYC0KH5Ug
         D7wg3GGgyVXIaB7/bxAUY6G1+hkdSVAzNKunvEy0AD+kStDv291EVyU2jNmdYjBn5h
         xsPDRBCxeQiTtPhm8vmEI+40YYxWV/NTT41eevx1/b6/m5UVAuVVAYoXI9D3XoXwF2
         K5E9KP2i89A3BknRyUz6egBBBIu4Fns8ta1TrPr/AjXbwoegxbKeYedyOFOc37XqSd
         9EFqCwLbvhEQX+b9uvaD5LKYxisa7zqQ6Z/GrYLl3OPwd/MzyqCSmeCPN1K0flObI+
         loKEGEnP6zJfw==
From:   "Life is hard, and then you die" <ronald@innovation.ch>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lee Jones <lee.jones@linaro.org>, linux-input@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mfd: apple-ibridge: Add Apple iBridge MFD driver.
Message-ID: <20190426053439.GB31266@innovation.ch>
References: <20190422031251.11968-1-ronald@innovation.ch>
 <20190422031251.11968-2-ronald@innovation.ch>
 <20190422123426.2d0b4bdf@archlinux>
 <20190424104718.GA31301@innovation.ch>
 <20190424201317.2a472120@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190424201317.2a472120@archlinux>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


  Hi Jonathan,

On Wed, Apr 24, 2019 at 08:13:17PM +0100, Jonathan Cameron wrote:
> On Wed, 24 Apr 2019 03:47:18 -0700
> "Life is hard, and then you die" <ronald@innovation.ch> wrote:
> 
> >   Hi Jonathan,
> > 
> > On Mon, Apr 22, 2019 at 12:34:26PM +0100, Jonathan Cameron wrote:
> > > On Sun, 21 Apr 2019 20:12:49 -0700
> > > Ronald Tschalär <ronald@innovation.ch> wrote:
> > >   
> > > > The iBridge device provides access to several devices, including:
> > > > - the Touch Bar
> > > > - the iSight webcam
> > > > - the light sensor
> > > > - the fingerprint sensor
> > > > 
> > > > This driver provides the core support for managing the iBridge device
> > > > and the access to the underlying devices. In particular, since the
> > > > functionality for the touch bar and light sensor is exposed via USB HID
> > > > interfaces, and the same HID device is used for multiple functions, this
> > > > driver provides a multiplexing layer that allows multiple HID drivers to
> > > > be registered for a given HID device. This allows the touch bar and ALS
> > > > driver to be separated out into their own modules.
> > > > 
> > > > Signed-off-by: Ronald Tschalär <ronald@innovation.ch  
> > > Hi Ronald,
> > > 
> > > I've only taken a fairly superficial look at this.  A few global
> > > things to note though.  
> > 
> > Thanks for this review.
[snip]

I've applied all your feedback in my tree, but it now looks like this
module is going to be redone differently. I'll try to keep all your
comments in mind during the rewrite, though, so they're not wasted.


  Cheers,

  Ronald

