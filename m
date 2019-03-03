Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98D0C43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 18:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 810CA20866
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 18:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551638476;
	bh=oAY+NlUxAiXTwMVCJ0vBvPvU9MPcY80xCTsO1Z/JMXs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Got4nbCzRB3ks34ptaYUvh27rLkcfM91/stVOSItRitWAZVl0jf6gnp67xik5Xmu0
	 XswUD28+lqGICLbHOD2Qc9hGdyuLt/xS+TvYj5xu7GDExsWjrkl3prpp1pMiEyjO6a
	 ettnTDm8P+mPCws1F75UCQwpKdBeVZyl2dkmx5ck=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbfCCSlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 13:41:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:48938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726593AbfCCSlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 13:41:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E33820830;
        Sun,  3 Mar 2019 18:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551638473;
        bh=oAY+NlUxAiXTwMVCJ0vBvPvU9MPcY80xCTsO1Z/JMXs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J9HGYKmgeZmJnJ1nU3PV4PIy/q5MGzspL7LT+WyFv/SO2GADutL2XoDkdxAZKn4kd
         +1ei7IytsgCPUis8PXDZP5gfKLDuKm40RCKCXRSS0pmg8cMAc8gH3iyZ7JH9VpPIMP
         gu2dbQUUWwQb76xE9GtqPu/Q/KOP5Sa8U7MlL81w=
Date:   Sun, 3 Mar 2019 19:41:11 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fwd: [PATCH net-next 1/2] lib: string: add strreplace_nonalnum
Message-ID: <20190303184111.GA28073@kroah.com>
References: <981d965e-b25b-be2b-2067-07aec5eafc7a@gmail.com>
 <43eb3aad-0e0b-9019-dfe3-47f205607df0@gmail.com>
 <20190303175514.GA16636@kroah.com>
 <e55de1df-b70a-93b5-9f18-072392fa0657@gmail.com>
 <20190303181509.GE16636@kroah.com>
 <a833dcdd-6473-3426-cc80-405b3d100750@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a833dcdd-6473-3426-cc80-405b3d100750@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 03, 2019 at 07:32:53PM +0100, Heiner Kallweit wrote:
> On 03.03.2019 19:15, Greg Kroah-Hartman wrote:
> > On Sun, Mar 03, 2019 at 07:04:21PM +0100, Heiner Kallweit wrote:
> >> On 03.03.2019 18:55, Greg Kroah-Hartman wrote:
> >>> On Sun, Mar 03, 2019 at 06:47:32PM +0100, Heiner Kallweit wrote:
> >>>> I submitted this through the netdev tree, maybe relevant for you as well.
> >>>> See also here: https://marc.info/?t=155103900100003&r=1&w=2
> >>>>
> >>>> -------- Forwarded Message --------
> >>>> Subject: [PATCH net-next 1/2] lib: string: add strreplace_nonalnum
> >>>> Date: Sun, 3 Mar 2019 18:20:50 +0100
> >>>> From: Heiner Kallweit <hkallweit1@gmail.com>
> >>>> To: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>, David Miller <davem@davemloft.net>
> >>>> CC: netdev@vger.kernel.org <netdev@vger.kernel.org>
> >>>>
> >>>> Add a new function strreplace_nonalnum that replaces all
> >>>> non-alphanumeric characters. Such functionality is needed e.g. when a
> >>>> string is supposed to be used in a sysfs file name. If '\0' is given
> >>>> as new character then non-alphanumeric characters are cut. 
> >>>
> >>> sysfs doesn't have any such requirements, it can use whatever you want
> >>> to give it for a filename.
> >>>
> >> Even a slash?
> > 
> > Is a slash an illegal character for a file to have?  It's up to the vfs
> > to care about this, don't force random parts of the kernel to care :)
> > 
> >> HWMON drivers is an example where such functionality occurs open-coded.
> > 
> > Is that data coming from userspace or from a kernel driver?
> > 
> Usually from a kernel driver. That's what
> Documentation/hwmon/hwmon-kernel-api.txt says:

Usually?  So userspace can set the name?

> All supported hwmon device registration functions only accept valid device
> names. Device names including invalid characters (whitespace, '*', or '-')
> will be rejected. The 'name' parameter is mandatory.
> 
> The hwmon subsystem has an own function to check for such characters:
> hwmon_is_bad_char()

It looks like hwmon is the only thing that cares about this then, why
do you want to make this a common function?

thanks,

greg k-h
