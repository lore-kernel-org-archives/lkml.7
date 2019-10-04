Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FA6C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 12:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C3AC2070B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 12:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570190946;
	bh=7vjNC+BSqWtykrlRJSZZb/g9Z06VBkpghycioCW8eHg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ZjwQ+77BJfxt3XdKSG9nEUxyIZMxXd7oWj0O6/VccoQjy5Vb2w/WkFvHKauHRISzG
	 2t642TMO/d118bPHsRsJTQMbB5nv2aWqk12a13Fn1iBtbWjgtaGMfwDpS483KaChaE
	 dRT4N5k8Jl23u1N6nII1KLZpO1oYIIw1zdd5Dx3s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730976AbfJDMJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 08:09:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54112 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729189AbfJDMJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 08:09:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Qv8kGhW91Tax4P4e+bafmAL2gzBdpy9269d1P/vaNO8=; b=eP+zYvje3k8HF64RmwOEKGW9F
        LIIn7DE8YtLWjFpFcXSkSqrgmkJl2KBlNWeZtDm4SBlmOiK+K8IdbJsPq+QIHwZEN2Hp1irBMVTaq
        /eN14/263q86D9TOFe56L1tIZ5e97p1gf5vRhq9FhY8nPP7HVvxi0x3G/H5lYhizkiUvNfKO1g0di
        oAxF4CpJZqebs5TVWo1GML9Bc0jNBTINU0hE7WeJ+Jwo0F27LvOnifSSakzvOuCr7c10QYBsM/lKw
        q39WnSGSJ00XwUvfnpqPTTnYSejelMMIApBkTKavEXUT27SVjWQDn5vjweFvDGAcuOAjQ5fSHzeUA
        gWXlZumRQ==;
Received: from 177.133.68.49.dynamic.adsl.gvt.net.br ([177.133.68.49] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iGMOJ-0006iY-9q; Fri, 04 Oct 2019 12:08:59 +0000
Date:   Fri, 4 Oct 2019 09:08:55 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     JP <jp@jpvw.nl>
Cc:     Gonsolo <gonsolo@gmail.com>, crope@iki.fi,
        Sean Young <sean@mess.org>, linux-media@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] si2157: Add support for Logilink VG0022A.
Message-ID: <20191004090855.14e418ed@coco.lan>
In-Reply-To: <23d9856c-cc12-7212-9126-90d80f67abfb@jpvw.nl>
References: <29ab2e43-4374-a3ea-6ae1-a4267867eaa4@jpvw.nl>
        <20191002154922.7f1cfc76@coco.lan>
        <CANL0fFRJZBfEDWK_c2w1TomvB5-i4g09LopyJUbO5NtOwKdDTg@mail.gmail.com>
        <20191003080539.2b13c03b@coco.lan>
        <CANL0fFSmvEEJhnA=qjTuEPr4N8q8eWLeYC5du+OoTMxe1Gnh5Q@mail.gmail.com>
        <20191003120238.75811da6@coco.lan>
        <20191003160336.GA5125@Limone>
        <20191003130909.01d29b77@coco.lan>
        <20191003162326.GA2727@Limone>
        <20191003144225.0137bf6c@coco.lan>
        <20191003183200.GA2631@Limone>
        <e468b867-1b45-8220-a5d2-ac40fdb4e0e6@jpvw.nl>
        <CANL0fFQms9oyec_1UevbJ7aLp+KNJ3h6UhGEbqrnCNO286rbGg@mail.gmail.com>
        <20191003163914.7c384d36@coco.lan>
        <20191003164426.6da8538f@coco.lan>
        <CANL0fFRSNbUhcik7rnhjZ0qUe-tZyzcjY+M1J_iGzUa5jNc9_A@mail.gmail.com>
        <20191003170329.3624f7f2@coco.lan>
        <23d9856c-cc12-7212-9126-90d80f67abfb@jpvw.nl>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 4 Oct 2019 13:50:43 +0200
JP <jp@jpvw.nl> escreveu:

> On 10/3/19 10:03 PM, Mauro Carvalho Chehab wrote:
> > Em Thu, 3 Oct 2019 21:51:35 +0200
> > Gonsolo <gonsolo@gmail.com> escreveu:
> >  
> >>> 1) The firmware file is likely at the Windows driver for this device
> >>> (probably using a different format). It should be possible to get
> >>> it from there.  
> >> If you tell me how I'm willing to do this. :)  
> > I don't know. I was not the one that extracted the firmware. I guess
> > Antti did it.
> >
> > I suspect that there are some comments about that in the past at the
> > ML. seek at lore.kernel.org.
> >  
> >>> 2) Another possibility would be to add a way to tell the si2168 driver
> >>> to not try to load a firmware, using the original one. That would
> >>> require adding a field at si2168_config to allow signalizing to it
> >>> that it should not try to load a firmware file, and add a quirk at
> >>> the af9035 that would set such flag for Logilink VG0022A.  
> >> I don't get this. Which firmware, si2168 or si2157?  
> > The one that it is causing the problem. If I understood well, the
> > culprit was the si2168 firmware.
> >  
> >> I'm still for option 3: If there is a bogus chip revision number it's
> >> likely the VG0022A and we can safely set fw to NULL, in which case
> >> everything works.
> >> All already working devices will continue to work as before.
> >> With a low probability there are other devices that will return 0xffff
> >> but a) they didn't work until now and b) they receive a clear message
> >> that they return bogus numbers and this works just for the VG0022A, in
> >> which case this hardware can be tested.
> >> At last, *my* VG0022A will work without a custom kernel which I'm a
> >> big fan of. :))
> >>
> >> Are there any counterarguments except that it is not the cleanest
> >> solution in the universe? ;)  
> > That's a really bad solution. Returning 0xff is what happens when
> > things go wrong during I2C transfers. Several problems can cause it,
> > including device misfunction. Every time someone comes with a patch
> > trying to ignore it, things go sideways for other devices (existing
> > or future ones).
> >
> > Ignoring errors is always a bad idea.  
> add module param say 'gonso_hack_vg0022a'
> if true, act on error by setting a flag
> if this flag is set don't load firmware

Adding a module param should be the last resort, only when there's
no way for the driver to autodetect.

Making af9035 to detect vg0022a is quite simple.

Considering this device's entry:

	{ DVB_USB_DEVICE(USB_VID_DEXATEK, 0x0100,
		&it930x_props, "Logilink VG0022A", NULL) },

the check, at af9035 would be:

	if (le16_to_cpu(d->udev->descriptor.idVendor) == USB_VID_DEXATEK &&
	    le16_to_cpu(d->udev->descriptor.idProduct) == 0x0100)
		/* do something to disable firmware load */

So, no need to add any load time parameter.

It should be noticed that a change just at af9035 won't work, as the
firmware is updated by si2168 driver. So, the caller code needs to
pass a config parameter to si2168 driver.

Thanks,
Mauro
