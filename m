Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0883FC43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 18:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAEA920842
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 18:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551639588;
	bh=/mjPwQKaNAZ9KfAh+yet8nkNkRNN7S4GwWkSdML2ut4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=l7KbAeIdXc53jouV7PDEQKYQpc3w/sXFT1WEXX9ix3G2zRtrHGpduwg8ozJ2Yscnn
	 /BiyW0ZFZKHVuq2XTrvfblr2yQCtFObGYG5Bu0wtD2VcSFL+Ogvo7s6Gow0lu5tKpL
	 z4VKN7sCujwtcRQJiLgCvIkMtdmtagXP8uZX3yN8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbfCCS7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 13:59:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:59464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726440AbfCCS7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 13:59:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CDB920835;
        Sun,  3 Mar 2019 18:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551639586;
        bh=/mjPwQKaNAZ9KfAh+yet8nkNkRNN7S4GwWkSdML2ut4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R12n44wR81hjLsWZB12hlW+dDyCw5fmLq4+jXc4dkP2VMAm56Qrkpd4o46xhHOwpX
         IIb7z8w/FWjy33Pp8ecn2t9kn1vbP3GqwFRJMV1PauNgI4AujWTcPE503PH5m8rYjt
         Ll+36Pd8a2sOxw+mfRaGGLbWNbUzqZUUXkL9kHU8=
Date:   Sun, 3 Mar 2019 19:59:43 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fwd: [PATCH net-next 1/2] lib: string: add strreplace_nonalnum
Message-ID: <20190303185943.GA22945@kroah.com>
References: <981d965e-b25b-be2b-2067-07aec5eafc7a@gmail.com>
 <43eb3aad-0e0b-9019-dfe3-47f205607df0@gmail.com>
 <20190303175514.GA16636@kroah.com>
 <e55de1df-b70a-93b5-9f18-072392fa0657@gmail.com>
 <20190303181509.GE16636@kroah.com>
 <a833dcdd-6473-3426-cc80-405b3d100750@gmail.com>
 <20190303184111.GA28073@kroah.com>
 <0724dc17-728c-4748-0fe8-8378d682928b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0724dc17-728c-4748-0fe8-8378d682928b@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 03, 2019 at 07:47:29PM +0100, Heiner Kallweit wrote:
> On 03.03.2019 19:41, Greg Kroah-Hartman wrote:
> > On Sun, Mar 03, 2019 at 07:32:53PM +0100, Heiner Kallweit wrote:
> >> On 03.03.2019 19:15, Greg Kroah-Hartman wrote:
> >>> On Sun, Mar 03, 2019 at 07:04:21PM +0100, Heiner Kallweit wrote:
> >>>> On 03.03.2019 18:55, Greg Kroah-Hartman wrote:
> >>>>> On Sun, Mar 03, 2019 at 06:47:32PM +0100, Heiner Kallweit wrote:
> >>>>>> I submitted this through the netdev tree, maybe relevant for you as well.
> >>>>>> See also here: https://marc.info/?t=155103900100003&r=1&w=2
> >>>>>>
> >>>>>> -------- Forwarded Message --------
> >>>>>> Subject: [PATCH net-next 1/2] lib: string: add strreplace_nonalnum
> >>>>>> Date: Sun, 3 Mar 2019 18:20:50 +0100
> >>>>>> From: Heiner Kallweit <hkallweit1@gmail.com>
> >>>>>> To: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>, David Miller <davem@davemloft.net>
> >>>>>> CC: netdev@vger.kernel.org <netdev@vger.kernel.org>
> >>>>>>
> >>>>>> Add a new function strreplace_nonalnum that replaces all
> >>>>>> non-alphanumeric characters. Such functionality is needed e.g. when a
> >>>>>> string is supposed to be used in a sysfs file name. If '\0' is given
> >>>>>> as new character then non-alphanumeric characters are cut. 
> >>>>>
> >>>>> sysfs doesn't have any such requirements, it can use whatever you want
> >>>>> to give it for a filename.
> >>>>>
> >>>> Even a slash?
> >>>
> >>> Is a slash an illegal character for a file to have?  It's up to the vfs
> >>> to care about this, don't force random parts of the kernel to care :)
> >>>
> >>>> HWMON drivers is an example where such functionality occurs open-coded.
> >>>
> >>> Is that data coming from userspace or from a kernel driver?
> >>>
> >> Usually from a kernel driver. That's what
> >> Documentation/hwmon/hwmon-kernel-api.txt says:
> > 
> > Usually?  So userspace can set the name?
> > 
> I'm not sure about that.

You might want to check :)

> >> All supported hwmon device registration functions only accept valid device
> >> names. Device names including invalid characters (whitespace, '*', or '-')
> >> will be rejected. The 'name' parameter is mandatory.
> >>
> >> The hwmon subsystem has an own function to check for such characters:
> >> hwmon_is_bad_char()
> > 
> > It looks like hwmon is the only thing that cares about this then, why
> > do you want to make this a common function?
> > 
> In phylib we have a similar issue, sysfs is broken if a PHY driver name
> includes a slash, typically if some driver author uses "10 / 100 Mbit"
> or similar.
> IIRC for HWMON there has been some longer discussion about how to deal
> with naming, I'd be curious to hear Guenter's opinion on the topic.

Making drivers "safe" from themselves is pretty foolish, as if they
don't know they are doing stupid things, they will continue to do those
stupid things :)

Having a driver name itself something bad like this is fine, nothing
breaks except no one can access any sysfs files from the driver, so the
driver needs to be fixed.

Now if userspace can set this string, that's a totaly different story,
that needs to be properly sanitized, because as we all know, "all input
is evil."

thanks,

greg k-h
