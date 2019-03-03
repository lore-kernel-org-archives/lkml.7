Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF698C43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 18:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A90EC20842
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 18:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551637263;
	bh=9ZefKhs+LtPqrjrbTYELgifYXW/U2Cnz+OSwEEPHQG0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JCHuqYoCur3/sif65PXba7ImNt7O9BxZCviYHMbN7vxIu1JEEjEc2e7TL5Kn7UpT1
	 MJAwCLY3VC9E1lQs3nOBR8Vcm+1mQm8hBU6+uh+JEZtFz4rT2YDbns05TbrCE5Y67+
	 hmwBq4M7VwTkaJnCo6gXCd6WMMrr7CRfNrscrmzg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfCCSPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 13:15:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:37140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726533AbfCCSPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 13:15:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2843A20842;
        Sun,  3 Mar 2019 18:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551636912;
        bh=9ZefKhs+LtPqrjrbTYELgifYXW/U2Cnz+OSwEEPHQG0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NpaATc6CqHuQTfoaMTu2H244oyhQEB9y37SQdgDMstWHuIQQhlTQ6MGksXfj5Mx/8
         6yelQiez/bVnvsxaNnziJJFcUApJTv4zJhz6/1j5mZgx3OS1TUE8wiZUNClyEygPhb
         DhjYLh6m9g6qY8VEEqC8us1w6MkJWhFDEmPBPf6U=
Date:   Sun, 3 Mar 2019 19:15:09 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fwd: [PATCH net-next 1/2] lib: string: add strreplace_nonalnum
Message-ID: <20190303181509.GE16636@kroah.com>
References: <981d965e-b25b-be2b-2067-07aec5eafc7a@gmail.com>
 <43eb3aad-0e0b-9019-dfe3-47f205607df0@gmail.com>
 <20190303175514.GA16636@kroah.com>
 <e55de1df-b70a-93b5-9f18-072392fa0657@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e55de1df-b70a-93b5-9f18-072392fa0657@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 03, 2019 at 07:04:21PM +0100, Heiner Kallweit wrote:
> On 03.03.2019 18:55, Greg Kroah-Hartman wrote:
> > On Sun, Mar 03, 2019 at 06:47:32PM +0100, Heiner Kallweit wrote:
> >> I submitted this through the netdev tree, maybe relevant for you as well.
> >> See also here: https://marc.info/?t=155103900100003&r=1&w=2
> >>
> >> -------- Forwarded Message --------
> >> Subject: [PATCH net-next 1/2] lib: string: add strreplace_nonalnum
> >> Date: Sun, 3 Mar 2019 18:20:50 +0100
> >> From: Heiner Kallweit <hkallweit1@gmail.com>
> >> To: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>, David Miller <davem@davemloft.net>
> >> CC: netdev@vger.kernel.org <netdev@vger.kernel.org>
> >>
> >> Add a new function strreplace_nonalnum that replaces all
> >> non-alphanumeric characters. Such functionality is needed e.g. when a
> >> string is supposed to be used in a sysfs file name. If '\0' is given
> >> as new character then non-alphanumeric characters are cut. 
> > 
> > sysfs doesn't have any such requirements, it can use whatever you want
> > to give it for a filename.
> > 
> Even a slash?

Is a slash an illegal character for a file to have?  It's up to the vfs
to care about this, don't force random parts of the kernel to care :)

> HWMON drivers is an example where such functionality occurs open-coded.

Is that data coming from userspace or from a kernel driver?

thanks,

greg k-h
