Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9EECC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 16:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA469206CD
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 16:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567786348;
	bh=yGQH991p6dsqZYSz7vQ4udqTo6UsMW6JF25Ax1+5bTY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=owrxTssHM+/M7qu/uxe3uyw6YQRWQ5rnI1chd+beqU22yUebMqocj+T0eTKCfaqnP
	 /eSCwcHPFY8EHSyEtL4Ou+BRw1zgceP5TETr2qBsDyMXc/mHhscN5Hgme1oSGhlpbE
	 Y5BjV5U8wh2/gWJRd07RZc9vp3k7UKDDrzvWa/1c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730469AbfIFQMV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 12:12:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:39628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729118AbfIFQMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 12:12:19 -0400
Received: from localhost (unknown [89.248.140.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D4EA206CD;
        Fri,  6 Sep 2019 16:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567786338;
        bh=yGQH991p6dsqZYSz7vQ4udqTo6UsMW6JF25Ax1+5bTY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jvP9oeE9ob6IfYj36ll63idsFgtnpga4HasXlDK5+NKLo86y0Wtogq8i/WcBmiV6L
         YhhiByE38lQk11oi1wxMHvJXCqv2LuMkbUYKcrUwbfrGtdlE8GaDKAYrW99xA+V+a0
         7+KcKYDTb8CXv5hAS/MHodNvB/2mPPFA0n340HhQ=
Date:   Fri, 6 Sep 2019 18:12:15 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jean Delvare <jdelvare@suse.de>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] eeprom: Deprecate the legacy eeprom driver
Message-ID: <20190906161215.GA10547@kroah.com>
References: <20190902104838.058725c2@endymion>
 <20190904075729.GA22307@kroah.com>
 <20190906165004.5e5748cc@endymion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906165004.5e5748cc@endymion>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2019 at 04:50:04PM +0200, Jean Delvare wrote:
> Hi Greg,
> 
> On Wed, 4 Sep 2019 09:57:29 +0200, Greg Kroah-Hartman wrote:
> > On Mon, Sep 02, 2019 at 10:48:38AM +0200, Jean Delvare wrote:
> > > Time has come to get rid of the old eeprom driver. The at24 driver
> > > should be used instead. So mark the eeprom driver as deprecated and
> > > give users some time to migrate. Then we can remove the legacy
> > > eeprom driver completely.
> > > 
> > > Signed-off-by: Jean Delvare <jdelvare@suse.de>
> > > Cc: Arnd Bergmann <arnd@arndb.de>
> > > ---
> > >  drivers/misc/eeprom/Kconfig |    5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)  
> > 
> > You might also want to add a big printk() message when the driver is
> > loaded that it shouldn't be used.
> 
> Good idea, although unfortunately this means expanding
> module_i2c_driver. Or maybe I can use printk_once() in eeprom_probe().
> Or even just a dev_warn() there to really spam the kernel log in a very
> visible way.

What ever you want is fine with me.

> Would you prefer a v2 of this patch including that change, or a
> separate, incremental patch?

An incremental patch as I've already applied this one.

thanks,

greg k-h
