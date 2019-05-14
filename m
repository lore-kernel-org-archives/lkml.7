Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C90FFC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 12:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9400020881
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 12:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=haabendal.dk header.i=@haabendal.dk header.b="mMDV9h8Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbfENMlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 08:41:39 -0400
Received: from mailrelay1-1.pub.mailoutpod1-cph3.one.com ([46.30.210.182]:36150
        "EHLO mailrelay1-1.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726211AbfENMlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 08:41:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=haabendal.dk; s=20140924;
        h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
         to:from:from;
        bh=HnisEmB9rene1C0dMXSi3rPqmd/yBP5rUS1HvFArXCQ=;
        b=mMDV9h8ZbtribX/YdtqBUt6oqJeKpB+R/OMcAkY1i8W2kuVST/T6G0ZR77LxwpxLaLD2qEuZhZqpD
         UreeqArfVhUJ9b6CMQLd1faIJhfjPOo6OklgXezf79nRrg/JndWHfAmFxY4FsfZRqAomvtTB1S0g1T
         c0iHxYXETKyMPYuk=
X-HalOne-Cookie: 2d661b2d6052723d9ee530127736b0184e99c321
X-HalOne-ID: 9be71f45-7645-11e9-bc24-d0431ea8a283
Received: from localhost (unknown [193.163.1.7])
        by mailrelay1.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 9be71f45-7645-11e9-bc24-d0431ea8a283;
        Tue, 14 May 2019 12:41:35 +0000 (UTC)
From:   Esben Haabendal <esben@haabendal.dk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-serial@vger.kernel.org,
        Jiri Slaby <jslaby@suse.com>, Nishanth Menon <nm@ti.com>,
        Vignesh R <vigneshr@ti.com>, Tony Lindgren <tony@atomide.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] serial: 8250: Add support for 8250/16550 as MFD function
In-Reply-To: <20190514122618.GA18859@kroah.com> (Greg Kroah-Hartman's message
        of "Tue, 14 May 2019 14:26:18 +0200")
References: <20190426084038.6377-1-esben@geanix.com>
        <20190426084038.6377-3-esben@geanix.com> <20190507114905.GB29524@dell>
        <87o94ejwrx.fsf@haabendal.dk> <20190507133844.GA6194@dell>
        <87bm05mpmx.fsf@haabendal.dk> <20190514104741.GO4319@dell>
        <20190514122618.GA18859@kroah.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
Date:   Tue, 14 May 2019 14:41:35 +0200
Message-ID: <87imudky2o.fsf@haabendal.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> On Tue, May 14, 2019 at 11:47:41AM +0100, Lee Jones wrote:
>> On Tue, 14 May 2019, Esben Haabendal wrote:
>> 
>> > Lee Jones <lee.jones@linaro.org> writes:
>> > 
>> > > On Tue, 07 May 2019, Esben Haabendal wrote:
>> > >
>> > >> Lee Jones <lee.jones@linaro.org> writes:
>> > >> 
>> > >> > On Fri, 26 Apr 2019, Esben Haabendal wrote:
>> > >> >
>> > >> >> The serial8250-mfd driver is for adding 8250/16550 UART ports as functions
>> > >> >> to an MFD driver.
>> > >> >> 
>> > >> >> When calling mfd_add_device(), platform_data should be a pointer to a
>> > >> >> struct plat_serial8250_port, with proper settings like .flags, .type,
>> > >> >> .iotype, .regshift and .uartclk.  Memory (or ioport) and IRQ should be
>> > >> >> passed as cell resources.
>> > >> >
>> > >> > What?  No, please!
>> > >> >
>> > >> > If you *must* create a whole driver just to be able to use
>> > >> > platform_*() helpers (which I don't think you should), then please
>> > >> > call it something else.  This doesn't have anything to do with MFD.
>> > >> 
>> > >> True.
>> > >> 
>> > >> I really don't think it is a good idea to create a whole driver just to
>> > >> be able to use platform_get_*() helpers.  And if I am forced to do this,
>> > >> because I am unable to convince Andy to improve the standard serial8250
>> > >> driver to support that, it should be called MFD.  The driver would be
>> > >
>> > > I assume you mean "shouldn't"?
>> > 
>> > Of-course.
>> > 
>> > >> generally usable for all usecases where platform_get_*() works.
>> > >> 
>> > >> I don't have any idea what to call such a driver.  It really would just
>> > >> be a fork of the current serial8250 driver, just allowing use of
>> > >> platform_get_*(), supporting exactly the same hardware.
>> > >> 
>> > >> I am still hoping that we can find a way to improve serial8250 to be
>> > >> usable in these cases.
>> > >
>> > > Me too.
>> > 
>> > Unfortunately, I don't seem to be able to convince Andy to accept
>> > something like that.
>> 
>> Andy is not he Maintainer.
>> 
>> What are Greg and Jiri's opinions?
>
> I've been ignoring all of this at the moment because of the 5.2-rc merge
> window.  I'll look at it after -rc1 is out.
>
> thanks,
> greg k-h

Great, thanks!

I will try ad hold back with this thread until you get back to it.

/Esben
