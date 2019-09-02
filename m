Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C91ECC41514
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 18:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADF1621744
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 18:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbfIBSLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 14:11:50 -0400
Received: from smtprelay0176.hostedemail.com ([216.40.44.176]:58928 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726448AbfIBSLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 14:11:49 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id BF9D618224D8A;
        Mon,  2 Sep 2019 18:11:47 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: heat65_83e2ed7ab5f20
X-Filterd-Recvd-Size: 3481
Received: from XPS-9350.home (unknown [47.151.137.30])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Mon,  2 Sep 2019 18:11:46 +0000 (UTC)
Message-ID: <f7f8f751e77578edb88c0d9888930de3f3b60670.camel@perches.com>
Subject: Re: linux-next: Tree for Sep 2 (exfat)
From:   Joe Perches <joe@perches.com>
To:     Randy Dunlap <rdunlap@infradead.org>, Greg KH <greg@kroah.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Date:   Mon, 02 Sep 2019 11:11:45 -0700
In-Reply-To: <13e2db80-0c89-0f36-6876-f9639f0d30ab@infradead.org>
References: <20190902224310.208575dc@canb.auug.org.au>
         <cecc2af6-7ef6-29f6-569e-b591365e45ad@infradead.org>
         <20190902174631.GB31445@kroah.com>
         <13e2db80-0c89-0f36-6876-f9639f0d30ab@infradead.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-09-02 at 11:07 -0700, Randy Dunlap wrote:
> On 9/2/19 10:46 AM, Greg KH wrote:
> > On Mon, Sep 02, 2019 at 10:39:39AM -0700, Randy Dunlap wrote:
> > > On 9/2/19 5:43 AM, Stephen Rothwell wrote:
> > > > Hi all,
> > > > 
> > > > News: I will only be doing 2 more releases before I leave for Kernel
> > > > Summit (there may be some reports on Thursday, but I doubt I will have
> > > > time to finish the full release) and then no more until Sept 30.
> > > > 
> > > > Changes since 20190830:
> > > > 
> > > 
> > > Hi,
> > > I am seeing lots of exfat build errors when CONFIG_BLOCK is not set/enabled.
> > > Maybe its Kconfig should also say
> > > 	depends on BLOCK
> > > ?
> > 
> > Here's what I committed to my tree:
> > 
> > 
> > From e2b880d3d1afaa5cad108c29be3e307b1917d195 Mon Sep 17 00:00:00 2001
> > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Date: Mon, 2 Sep 2019 19:45:06 +0200
> > Subject: staging: exfat: make exfat depend on BLOCK
> > 
> > This should fix a build error in some configurations when CONFIG_BLOCK
> > is not selected.  Also properly set the dependancy for no FAT support at
> > the same time.
> > 
> > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > Cc: Valdis Kletnieks <valdis.kletnieks@vt.edu>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> That works. Thanks.
> Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
> 
> > ---
> >  drivers/staging/exfat/Kconfig | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/staging/exfat/Kconfig b/drivers/staging/exfat/Kconfig
> > index f52129c67f97..290dbfc7ace1 100644
> > --- a/drivers/staging/exfat/Kconfig
> > +++ b/drivers/staging/exfat/Kconfig
> > @@ -1,11 +1,13 @@
> >  config EXFAT_FS
> >  	tristate "exFAT fs support"
> > +	depends on BLOCK
> >  	select NLS
> >  	help
> >  	  This adds support for the exFAT file system.
> >  
> >  config EXFAT_DONT_MOUNT_VFAT
> >  	bool "Prohibit mounting of fat/vfat filesysems by exFAT"
> > +	depends on EXFAT_FS
> >  	default y
> >  	help
> >  	  By default, the exFAT driver will only mount exFAT filesystems, and refuse

I think this last one is backwards and should be

config EXFAT_ALLOW_MOUNT_VFAT
and
default n

> 
> 

