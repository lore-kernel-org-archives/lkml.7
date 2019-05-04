Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3561C43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 07:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B4AE206DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 07:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556956515;
	bh=rYPN3R+HI0gzJ3zG999qqQnoIuSpK9XHHiTCWGM41vE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SlBMqUTKd4bXn5+FgKcxSbXORiWU91XkMRlTQriAA2Gz65yEUI8O7RH/qjS30FpIJ
	 xLkc8KibFfjFkxRMiMIoEAykyHB/lI/Q66MvgmZUmM7c7ANJBECCkXaoYf7SubWZm2
	 dtI9BiBQbz4MNVtkHosL68uv2EwkDd+QNyPozQMM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfEDHzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 03:55:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:54378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbfEDHzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 03:55:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD94A206DF;
        Sat,  4 May 2019 07:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556956505;
        bh=rYPN3R+HI0gzJ3zG999qqQnoIuSpK9XHHiTCWGM41vE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y8g6vWADpPZNrwosyOhB4k2QUKfIiD2hX6aCDYfnFrXrnot4C5HkGTT+mN7IL9N1d
         P3EVHLgxD7l8Hk4kKaR0DHXaMqekVxvGkdOjv9yRJR3NuFYmETNCoXmGINZEfifezy
         0wRMqWdU/sCwOeNyi2HgdwKAUt08vfWZPaT8SMEc=
Date:   Sat, 4 May 2019 09:55:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dragan Cvetic <draganc@xilinx.com>
Cc:     "arnd@arndb.de" <arnd@arndb.de>, Michal Simek <michals@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Derek Kiernan <dkiernan@xilinx.com>
Subject: Re: [PATCH V3 02/12] misc: xilinx-sdfec: add core driver
Message-ID: <20190504075502.GA11133@kroah.com>
References: <1556402706-176271-1-git-send-email-dragan.cvetic@xilinx.com>
 <1556402706-176271-3-git-send-email-dragan.cvetic@xilinx.com>
 <20190502172007.GA1874@kroah.com>
 <BL0PR02MB5681B0F2BC0D74D8604D4289CB350@BL0PR02MB5681.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL0PR02MB5681B0F2BC0D74D8604D4289CB350@BL0PR02MB5681.namprd02.prod.outlook.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2019 at 04:41:21PM +0000, Dragan Cvetic wrote:
> Hi Greg,
> 
> Please find my inline comments below,
> 
> Regards
> Dragan
> 
> > -----Original Message-----
> > From: Greg KH [mailto:gregkh@linuxfoundation.org]
> > Sent: Thursday 2 May 2019 18:20
> > To: Dragan Cvetic <draganc@xilinx.com>
> > Cc: arnd@arndb.de; Michal Simek <michals@xilinx.com>; linux-arm-kernel@lists.infradead.org; robh+dt@kernel.org;
> > mark.rutland@arm.com; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Derek Kiernan <dkiernan@xilinx.com>
> > Subject: Re: [PATCH V3 02/12] misc: xilinx-sdfec: add core driver
> > 
> > On Sat, Apr 27, 2019 at 11:04:56PM +0100, Dragan Cvetic wrote:
> > > +#define DRIVER_NAME "xilinx_sdfec"
> > > +#define DRIVER_VERSION "0.3"
> > 
> > Version means nothing with the driver in the kernel tree, please remove
> > it.
> 
> Will be removed. Thank you.
> 
> > 
> > > +#define DRIVER_MAX_DEV BIT(MINORBITS)
> > 
> > Why this number?  Why limit yourself to any number?
> > 
> 
> There can be max 8 devices for this driver. I'll change to 8.
> 
> > > +
> > > +static struct class *xsdfec_class;
> > 
> > Do you really need your own class?
> 
> When writing a character device driver, my goal is to create and register an instance
> of that structure associated with a struct file_operations, exposing a set of operations
> to the user-space. One of the steps to make this goal is Create a class for a devices,
> visible in /sys/class/.

Why do you need a class?  Again, why not just use the misc_device api,
that seems much more relevant here and will make the code a lot simpler.

thanks,

greg k-h
