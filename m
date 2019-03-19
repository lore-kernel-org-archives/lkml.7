Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35F7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 10:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7703320989
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 10:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552991331;
	bh=7uru8hEoahmypSdyu9vk2O13cSiCTDja0FgNEgQYI5c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0Apvg49WsznBVIWppgB0Q0uLzYbebt5oDOcD9+JAKfmWW4CNMfQFTc9/BabmURCPH
	 lZ1LTxywRRNPCVYtTX0T2BALbmnXyV+Gt/cbFan4wqQ9P45McjZ33Ws9iwUW5IFk22
	 MQl9sJIm9CXKrLxKYTSgHqOTpA3d/rlKnLxn1xDM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfCSK2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 06:28:50 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45353 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfCSK2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 06:28:49 -0400
Received: by mail-lj1-f196.google.com with SMTP id y6so8586647ljd.12;
        Tue, 19 Mar 2019 03:28:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=tyI6rgnC+UpX8sancHSdmZtqijH+Q9qbvNjNb20gOVI=;
        b=nixmaBxyfT1n7djg0LLYAUDpjS62z2LxGgamLkZlkcHmbOvDeUC5/YeKG/g0ea5yoL
         1w8KzS2CLFR73naXGMeNiV/EJMbyVgb3yM3Ik4TYmxHef+l2Z0YpEnwdk8OmAQyPEPUl
         DUITOugqObpDdpnCrTAgqKeh2+O8SwSqHCG9tkGAEhme3DkVB92r21SsvLcoda+f/RRj
         q6cAfncfwiUsw4uLzqYZ+z9kEfS/DgeTgPEggZlh/JvyVTvf15p/cBphVx+e5W+3i7ZJ
         En6uMF1Jop5LLK+yBnRNR9ly6EHNpFbjPdjb0mIwGIODpR9nDLy8dWdxwW3eputza4bD
         bB5g==
X-Gm-Message-State: APjAAAVgjnUEMUyeofeRNMTV+TwzFWS8l8nN/nf+zgwxqkxe7IZEFNej
        5wKinqpoqbGYe3la1/xcc9s=
X-Google-Smtp-Source: APXvYqylX9wN06FgrUuSENkAa8joWU0FuvfIBE86jeRduZbY9UTOPhaS36gyC/rBicnU+oZXFLcwJA==
X-Received: by 2002:a2e:5b44:: with SMTP id p65mr13515470ljb.182.1552991327510;
        Tue, 19 Mar 2019 03:28:47 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id t18sm2730737ljg.64.2019.03.19.03.28.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 03:28:46 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1h6Bz6-0007yw-Q5; Tue, 19 Mar 2019 11:28:41 +0100
Date:   Tue, 19 Mar 2019 11:28:40 +0100
From:   Johan Hovold <johan@kernel.org>
To:     =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Cc:     Johan Hovold <johan@kernel.org>,
        =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: option: set driver_info for SIM5218 and
 compatibles
Message-ID: <20190319102840.GI6124@localhost>
References: <20190226170710.12709-1-mans@mansr.com>
 <20190227083342.GJ4747@localhost>
 <yw1xpnrdv3z7.fsf@mansr.com>
 <20190227131315.GO4747@localhost>
 <yw1xlg21uwrp.fsf@mansr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yw1xlg21uwrp.fsf@mansr.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 02:32:58PM +0000, Måns Rullgård wrote:
> Johan Hovold <johan@kernel.org> writes:
> 
> > Adding Bjørn.
> >
> > On Wed, Feb 27, 2019 at 11:57:16AM +0000, Måns Rullgård wrote:
> >> Johan Hovold <johan@kernel.org> writes:
> >> 
> >> > On Tue, Feb 26, 2019 at 05:07:10PM +0000, Mans Rullgard wrote:
> >> >> The SIMCom SIM5218 and compatible devices have 5 USB interfaces, only 4
> >> >> of which are serial ports.  The fifth is a network interface supported
> >> >> by the qmi-wwan driver.  Furthermore, the serial ports do not support
> >> >> modem control signals.  Add driver_info flags to reflect this.
> >> >> 
> >> >> Signed-off-by: Mans Rullgard <mans@mansr.com>
> >> >> ---
> >> >>  drivers/usb/serial/option.c | 3 ++-
> >> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >> >> 
> >> >> diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
> >> >> index fb544340888b..af4cbfecc3ff 100644
> >> >> --- a/drivers/usb/serial/option.c
> >> >> +++ b/drivers/usb/serial/option.c
> >> >> @@ -1066,7 +1066,8 @@ static const struct usb_device_id option_ids[] = {
> >> >>  	  .driver_info = RSVD(3) },
> >> >>  	{ USB_DEVICE(QUALCOMM_VENDOR_ID, 0x6613)}, /* Onda H600/ZTE MF330 */
> >> >>  	{ USB_DEVICE(QUALCOMM_VENDOR_ID, 0x0023)}, /* ONYX 3G device */
> >> >> -	{ USB_DEVICE(QUALCOMM_VENDOR_ID, 0x9000)}, /* SIMCom SIM5218 */
> >> >> +	{ USB_DEVICE(QUALCOMM_VENDOR_ID, 0x9000), /* SIMCom SIM5218 */
> >> >> +	  .driver_info = NCTRL(0) | NCTRL(1) | NCTRL(2) | NCTRL(3) | RSVD(4) },
> >> >>  	/* Quectel products using Qualcomm vendor ID */
> >> >>  	{ USB_DEVICE(QUALCOMM_VENDOR_ID, QUECTEL_PRODUCT_UC15)},
> >> >>  	{ USB_DEVICE(QUALCOMM_VENDOR_ID, QUECTEL_PRODUCT_UC20),
> >> >
> >> > Could you please provide the output of usb-devices (or lsusb -v) for
> >> > this device?
> >> 
> >> lsusb -v:
> >> [...]
> 
> > So the patch looks fine to me. The fifth interface is QMI, but hasn't
> > been available for use until now then, and this seems to have been the
> > vendors idea from the start:
> >
> > 	http://www.microchip.ua/simcom/WCDMA/APPNOTES/SIMCom_3G_Linux_driver_Application%20Note_V1.00.pdf
> 
> That document predates the qmi-wwan driver in the kernel.  Note that
> this driver has an ID table entry for interface 4 of this device.  Right
> now, whichever driver is probed first claims that interface.  I haven't
> actually tried using the QMI interface, though.

I didn't say it was correct, just that the vendor proposed binding to it
anyway.

> > And you're seeing errors when opening ports 0-3 due to the DTR calls
> > which I guess no one noticed or cared about before?
> 
> Right, some userspace tools complain about this.

Hmm. You shouldn't see any errors on open (they're not even logged), but
I guess your user space tools complains on receiving -EPROTO instead of
-EINVAL when trying to manage these signals directly?

> > Before you sent me the lsusb I searched for it and came across the below
> > thread where Bjørn's having a go at SIMCom. In it there's output from a
> > second device using the same id but with entirely different descriptors.
> >
> > 	https://forum.openwrt.org/t/lte-wireless-module-support-by-openwrt-led-on-tplink/13586?page=3
> >
> > If this is a common theme with this vendor we may need to be extra
> > careful when making changes.
> 
> Isn't this a common theme with most USB vendors, especially wireless things?
> 
> Regardless, setting the NCTRL flag should be harmless.

Well, there are devices that depend on getting these requests, at least
for the QMI interface. But we can always revert if anyone complains.

Now applied, thanks.

Johan
