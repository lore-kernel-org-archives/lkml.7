Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D0AC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 09:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 265F2207E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 09:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560332251;
	bh=SbSPA8xt3FtSbVH4/KwmzKQS6tu9FOWGMzFrwJJKrBM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ik+aUGCjsUi3h02IXob+dnczhpDU97fOtobhqWcrLZ2L6rMEnrQH7ePpdW2yx/KrS
	 gisRKNuCEI6luYWuokxJcab/usJCxnPFWcqvQA516flsxdeGMhiD0J/907ca+lu90f
	 qw47JtUfGKnv9gO/rh0Hbubhytz59OwJyb+v4kqA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408835AbfFLJha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 05:37:30 -0400
Received: from casper.infradead.org ([85.118.1.10]:45994 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408577AbfFLJh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 05:37:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=04GCIstyKMujcBHa4O6zSpjG2Oz0E3c+JB6XSFE/UrI=; b=mu4uAjLNncFHGDGq4L4qZDo9wt
        NsrMgf2WNt8yYLcUBfBCqqJ5qRlV7K2XZR20CBv9PM4ZzLdjwc7hpvOfnpX23SSj1M/KbK+6Qc1Ay
        iXXoFcJxtG4o3fwbRzSJHZ6Wa9HCxObTuybjFsjVST3+ISYlEesSjhSU9WoBPW1aTYpDvp+vcrp8k
        sWdNxkeY6U3J1Ury/o+wiAg8rxcMyjI2vsYwBgSa9ZdWtNZdxF73GtiaIDlXc/GbLbszm3ULwr20P
        dScbq6e+TQBXi0RqRGvWXSGyENPNez5rN7S+iGF06x3utuGHkRSl0H7eM8P2PIHqk6foytMM9uZXN
        lsAzhG+w==;
Received: from 177.41.119.178.dynamic.adsl.gvt.net.br ([177.41.119.178] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hazgw-0004ue-4U; Wed, 12 Jun 2019 09:37:14 +0000
Date:   Wed, 12 Jun 2019 06:37:08 -0300
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Sean Young <sean@mess.org>
Cc:     YueHaibing <yuehaibing@huawei.com>, tglx@linutronix.de,
        corbet@lwn.net, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH] media: ttpci: Fix build error without RC_CORE
Message-ID: <20190612063708.64498b44@coco.lan>
In-Reply-To: <20190612074254.eky2xo7bajorkhfy@gofer.mess.org>
References: <20190612034310.4640-1-yuehaibing@huawei.com>
        <20190612074254.eky2xo7bajorkhfy@gofer.mess.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 12 Jun 2019 08:42:55 +0100
Sean Young <sean@mess.org> escreveu:

> On Wed, Jun 12, 2019 at 11:43:10AM +0800, YueHaibing wrote:
> > If RC_CORE is not set, building fails:
> > 
> > drivers/media/pci/ttpci/av7110_ir.o: In function `av7110_ir_init':
> > av7110_ir.c:(.text+0x1b0): undefined reference to `rc_allocate_device'
> > av7110_ir.c:(.text+0x2c1): undefined reference to `rc_register_device'
> > av7110_ir.c:(.text+0x2dc): undefined reference to `rc_free_device'
> > 
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Fixes: 71f49a8bf5c5 ("media: ttpci: use rc-core for the IR receiver")
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>  
> 
> Thank you for spotting this and writing a patch.
> 
> > ---
> >  drivers/media/pci/ttpci/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/media/pci/ttpci/Kconfig b/drivers/media/pci/ttpci/Kconfig
> > index d96d4fa..b705631 100644
> > --- a/drivers/media/pci/ttpci/Kconfig
> > +++ b/drivers/media/pci/ttpci/Kconfig
> > @@ -7,7 +7,7 @@ config DVB_AV7110
> >  	depends on DVB_CORE && PCI && I2C
> >  	select TTPCI_EEPROM
> >  	select VIDEO_SAA7146_VV
> > -	select DVB_AV7110_IR if INPUT_EVDEV=y || INPUT_EVDEV=DVB_AV7110  
> 
> This says if
>  - select DVB_AV7110_IR if INPUT_EVDEV and DVB_AV7110 are both y or m
>  - select DVB_AV7110_IR if INPUT_EVDEV=y
>    This exists for the case when INPUT_EVDEV=y and DVB_AV7110=m, which is fine
> 
> > +	select DVB_AV7110_IR if RC_CORE=DVB_AV7110 && (INPUT_EVDEV=y || INPUT_EVDEV=DVB_AV7110)  
> 
> That's not exactly the same. For one thing it should not longer depend on
> INPUT_EVDEV=y.
> 
> Now if DVB_AV7110=m and RC_CORE=y is not allowed which should be (this is
> the case in Fedora default kernel config for example).

My suggestion here is to stop using select here, using, instead
a depends on for DVB_AV7110_IR, e. g. something like (untested):

config DVB_AV7110_IR
	bool
	depends on RC_CORE && DVB_AV7110
	default DVB_AV7110


> 
> >  	depends on VIDEO_DEV	# dependencies of VIDEO_SAA7146_VV
> >  	select DVB_VES1820 if MEDIA_SUBDRV_AUTOSELECT
> >  	select DVB_VES1X93 if MEDIA_SUBDRV_AUTOSELECT
> > -- 
> > 2.7.4
> >   
> 
> Thanks,
> 
> Sean



Thanks,
Mauro
