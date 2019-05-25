Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC70C04AB0
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 08:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4538B2133D
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 08:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nikanor-nu.20150623.gappssmtp.com header.i=@nikanor-nu.20150623.gappssmtp.com header.b="upKWGQ+8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbfEYIjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 04:39:23 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44365 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbfEYIjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 04:39:22 -0400
Received: by mail-lj1-f193.google.com with SMTP id e13so10585399ljl.11
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2019 01:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nikanor-nu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=WpJePGfJIkx4FN1WBzkrq9jAiVMdDuI8VDoj6jlDCJw=;
        b=upKWGQ+8nYg4SmyNCTZ+wtvSB9hiUgEmIQ2z7RttYczwgS0kUu2WPdGRHRuxqQiQug
         YJAzcW1nV/5MuyFv1ws+AzkXSeGh5w2fvs+rUQd+o6k3Qu4v0aPwuZdw4e/qX1O8mpJw
         uPIMLvjVMCxs3Q2qXyipQq37siSJg40ZFxpFA0jJ72pOM1ylmXAnY2TEnuAZGjLYX0aQ
         OdNtqYGIs0+rj1X+Y1D41nEqe9VmShi8EjBnePRXdOyk33jmICFemz+mVl/xXLe4Wui8
         4ybXb/ELQKKBc0MwUD3KfuRmSlyD7NPLqJiRrzOPwCRLnhhhAt9r5gTYOE1l90BhmbWP
         qIGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=WpJePGfJIkx4FN1WBzkrq9jAiVMdDuI8VDoj6jlDCJw=;
        b=FAWneno86Gj/7N/xFC3THb4+CIowpOftBjKh89XXe8shnyQ+VHmSFPU9xJ6KPu0bf6
         PIsESSilY1dTkkVr2SS3dsoCmYlLqt4plxxFBviYyJKDyUpm/Jka5gg5GlNsbE0IQavx
         UMN04swia7ikOQl7N2cng6OwdwV7ZEZDOdAH7wXQFr9BBfKrxA0h2t1FQnYpmkvjChau
         QuHd9Eoyk8oxpXnxGTmPFFOMV0xJAUuRq22h54DicxDk8fexVlZufqabPOqu+Oby/UMy
         UTWiPUHw4qJ5MXwZK+QgyR54iGKw2zz5VNeZSvnMifLG9sOxjT199cukecYVp2BsPppq
         HBSA==
X-Gm-Message-State: APjAAAW1GM/g8EpxZ1b6cWJUXx1Y0TQ4DnJjy0gbddHYsg7/f/zcTmfs
        Q+zChTKDGWExyXs88PgJt5Uw/20HH2ONsA==
X-Google-Smtp-Source: APXvYqzjUHk8+eGgs6xW9sGM4or2e8CwO+kAgBfVsPn2uuho8wMG4elnmrcXZBtsSzpvhH2RZogaqA==
X-Received: by 2002:a05:651c:1055:: with SMTP id x21mr36711486ljm.83.1558773560815;
        Sat, 25 May 2019 01:39:20 -0700 (PDT)
Received: from dev.nikanor.nu (78-72-133-4-no161.tbcn.telia.com. [78.72.133.4])
        by smtp.gmail.com with ESMTPSA id v9sm855551ljd.45.2019.05.25.01.39.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 25 May 2019 01:39:20 -0700 (PDT)
Date:   Sat, 25 May 2019 10:39:18 +0200
From:   Simon =?utf-8?Q?Sandstr=C3=B6m?= <simon@nikanor.nu>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: kpc2000: add missing dependencies for
 kpc2000
Message-ID: <20190525083918.dxa5qtomlu5yyqw5@dev.nikanor.nu>
References: <20190524203058.30022-1-simon@nikanor.nu>
 <20190524203058.30022-3-simon@nikanor.nu>
 <20190525050017.GA18684@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190525050017.GA18684@kroah.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 25, 2019 at 07:00:17AM +0200, Greg KH wrote:
> On Fri, May 24, 2019 at 10:30:58PM +0200, Simon Sandström wrote:
> > Fixes build errors:
> > 
> > ERROR: "mfd_remove_devices" [kpc2000.ko] undefined!
> > ERROR: "uio_unregister_device" [kpc2000.ko] undefined!
> > ERROR: "mfd_add_devices" [kpc2000.ko] undefined!
> > ERROR: "__uio_register_device" [kpc2000.ko] undefined!
> > 
> > Signed-off-by: Simon Sandström <simon@nikanor.nu>
> > ---
> >  drivers/staging/kpc2000/Kconfig | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/staging/kpc2000/Kconfig b/drivers/staging/kpc2000/Kconfig
> > index c463d232f2b4..5188b56123ab 100644
> > --- a/drivers/staging/kpc2000/Kconfig
> > +++ b/drivers/staging/kpc2000/Kconfig
> > @@ -3,6 +3,8 @@
> >  config KPC2000
> >  	bool "Daktronics KPC Device support"
> >  	depends on PCI
> > +	select MFD_CORE
> > +	select UIO
> >  	help
> >  	  Select this if you wish to use the Daktronics KPC PCI devices
> >  
> 
> This is already in linux-next (in a different form), are you sure you
> are working against the latest kernel tree?
> 
> thanks,
> 
> greg k-h

It's based on your staging tree. I think that I have to go back and read
about next trees again, because I thought it took longer time for things
to get from staging-next to linux-next.

Anyway, neither the MFD_CORE nor the typo fix is in linux-next so I
guess that I could just rebase this on linux-next and re-send as v2.
I'm not sure if MFD_CORE should be "depends on" or "select" though...


- Simon
