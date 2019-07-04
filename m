Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9241C0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 08:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B1CA218A3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 08:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562228105;
	bh=FSwfc1Oz6+sWF+mhj4ShKI9hbCfIqFpwhfC/JK0it+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cnKr8Vofa7WGLklJgMl6GcnRSC0WapbV16V2oqz2zeuihLQMxDeZF6to5lVHmoJbt
	 +iKM3TPI6rFgX5JCEJ1cT7sz1NyFgaZiiOUO7wwQml7z4qhPxd69JtZAboo+SrQmcC
	 MBRxxjz1I/GOf1lKBcUQFUtUtAvFiSIKVYZIuOxk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfGDIPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 04:15:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:37116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbfGDIPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 04:15:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0E5D218A3;
        Thu,  4 Jul 2019 08:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562228103;
        bh=FSwfc1Oz6+sWF+mhj4ShKI9hbCfIqFpwhfC/JK0it+s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m3bwndtl3MB460a5ohTWu0F4FWdOW62bplRWYHSbvS+gPVgWTqBbZ5My9g4rDSQr7
         I8qihYB0RuGmdZXP2DaM/Uofo94HOa3dE4vqNbKfj300+X3G5vGQcoyYZABxaiikzT
         zdHQAvPo3T2Y5PYMQRr0pmTFU6kXFmAYDcmqjEPM=
Date:   Thu, 4 Jul 2019 10:15:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Je Yen Tam <je.yen.tam@ni.com>
Cc:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH V2 1/2] serial/8250: Add support for NI-Serial
 PXI/PXIe+485 devices
Message-ID: <20190704081500.GA6438@kroah.com>
References: <20190703072435.34152-1-je.yen.tam@ni.com>
 <20190703084220.GD8996@kroah.com>
 <MN2PR04MB59207BEC9DBAB5E69656DD42B7FA0@MN2PR04MB5920.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR04MB59207BEC9DBAB5E69656DD42B7FA0@MN2PR04MB5920.namprd04.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2019 at 07:55:33AM +0000, Je Yen Tam wrote:
> > On Wed, Jul 03, 2019 at 12:24:35AM -0700, jeyentam wrote:
> > > Add support for NI-Serial PXIe-RS232, PXI-RS485 and PXIe-RS485 devices.
> > >
> > > Signed-off-by: jeyentam <je.yen.tam@ni.com>
> > 
> > I need a "full" name here please.
> 
> Ok, will do so.
> 
> > 
> > Also, this patch breaks the build, which is not allowed, and makes me wonder how
> > you tested it :(
> 
> I've tested my changes with the steps as follows, it did not break.
> 
> 1. Clone the Linux repo, check out the source and work on my project.
> 2. Compile the kernel source with "make j4".
> 3. Build the kernel modules with "make modules_install".
> 4. Install the kernel with "make install".
> 5. Reboot into the newly built kernel.
> 6. The kernel worked well and able to fit my needs.
> 
> Noted that my source is checked out from the latest Linux kernel 5.2.0-rc6.
> 
> Also, I checked my patch using checkpatch.pl, it did not show any errors and 
> warnings too.
> 
> May I know what do you mean by breaking the build?

If you only apply patch 1/2, the build breaks as you add new device ids
in the second patch.  At every individual patch, you can not break the
build.

thanks,

greg k-h
