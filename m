Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68770C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37F372183F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nvkEZdQ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388499AbfDRJoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 05:44:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60850 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388070AbfDRJox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 05:44:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qMkC1T6ZJuUcdXnH9Yp0SsrwKBb1Irh2P/qjZGqcIw4=; b=nvkEZdQ9rFH3Terix674ZEQNo
        zCC4F0acxM9ojsrnHyOSjlqY9IfKpsl7TWinVqA7j7pqsQM0gWsi8gU011AauMKo3rimuqDWhhbYy
        KdiW8dseMvkzVJk0I+P0HB63KfkCHxCmWRrE/MKjIUfbD8gFW13T7Qkcj1IByCn7MpfotPWmvszMG
        aG6Q455QgSlVDU+/hF7IPRg2xl4DLB0QycoIsDxV0qI9734oVSfMaUohOfKr/35v0uyhNpYGm+O33
        1xsBqvrOHHFYeFrkKIoQobiUN/PaqSsKAzXjqj+9UfP8bBZ73hu1cBfbbB0QwligB4C0TP6d1ocgP
        EACpO1pcw==;
Received: from 177.132.233.55.dynamic.adsl.gvt.net.br ([177.132.233.55] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hH3b3-0000fU-Ni; Thu, 18 Apr 2019 09:44:46 +0000
Date:   Thu, 18 Apr 2019 06:44:36 -0300
From:   Mauro Carvalho Chehab <mchehab@infradead.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dirk Eibach <eibach@gdsys.de>,
        George Joseph <george.joseph@fairview5.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Juerg Haefliger <juergh@gmail.com>,
        Steve Glendinning <steve.glendinning@shawell.net>,
        Huang Rui <ray.huang@amd.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Clemens Ladisch <clemens@ladisch.de>,
        Rudolf Marek <r.marek@assembler.cz>,
        Andreas Werner <andreas.werner@men.de>,
        Jim Cromie <jim.cromie@gmail.com>,
        Kamil Debski <kamil@wypas.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Hulsman <m.hulsman@tudelft.nl>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH v3 21/21] docs: hwmon: Add an index file and rename docs
 to *.rst
Message-ID: <20190418064436.1803bf3a@coco.lan>
In-Reply-To: <20190417174728.GA17706@roeck-us.net>
References: <cover.1555494108.git.mchehab+samsung@kernel.org>
        <efbe0a2b5be35026c3a2dbdb9090c4fbd932c9a2.1555494108.git.mchehab+samsung@kernel.org>
        <20190417164741.GA12147@roeck-us.net>
        <20190417141352.3225bbb3@coco.lan>
        <20190417142215.791df5e7@coco.lan>
        <20190417174337.GA16749@roeck-us.net>
        <20190417174728.GA17706@roeck-us.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 17 Apr 2019 10:47:28 -0700
Guenter Roeck <linux@roeck-us.net> escreveu:

> On Wed, Apr 17, 2019 at 10:43:37AM -0700, Guenter Roeck wrote:
> > On Wed, Apr 17, 2019 at 02:22:15PM -0300, Mauro Carvalho Chehab wrote:  
> > > Em Wed, 17 Apr 2019 14:13:52 -0300
> > > Mauro Carvalho Chehab <mchehab+samsung@kernel.org> escreveu:
> > >   
> > > > Em Wed, 17 Apr 2019 09:47:41 -0700
> > > > Guenter Roeck <linux@roeck-us.net> escreveu:
> > > >   
> > > > > On Wed, Apr 17, 2019 at 06:46:29AM -0300, Mauro Carvalho Chehab wrote:    
> > > > > > Now that all files were converted to ReST format, rename them
> > > > > > and add an index.
> > > > > > 
> > > > > > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> > > > > > Acked-by: Liviu Dudau <liviu.dudau@arm.com>      
> > > > > 
> > > > > I applied all patches except this one, which fails due to a conflict in
> > > > > ab8500. I also notice that this file has not been touched by your series,
> > > > > which is odd. At the same time, patch 20/21 is missing from your series,
> > > > > and has been missing all along. Does the missing patch possibly touch
> > > > > Documentation/hwmon/ab8500 ?    
> > > > 
> > > > Patch 20/21 is the biggest one. Maybe vger rejected it either due to
> > > > its size or due to the number of c/c.
> > > > 
> > > > Just bounced it to you. Please let me know if you didn't receive it
> > > > yet.  
> > > 
> > > Btw, LKML got it:
> > > 
> > > https://lore.kernel.org/lkml/cccc2a52363a5aaeea10e186ead8570503ea648e.1555494108.git.mchehab+samsung@kernel.org/
> > >   
> > patchwork didn't get it (or didn't accept it). I got it now.
> > All patches applied, and pushed out to hwmon-next.
> > 
> > We have one (new) unconverted file left - Documentation/hwmon/lochnagar.  
> 
> Plus ir38064 and isl68137. Lots of new drivers recently.

Ok, just sent a patch for those three new files. I wrote a more
detailed description about what steps I followed at the conversion
of those tree files, and why I did it. 

Hopefully, this would help hwmon developers
that may already be preparing a new driver for submission.

Thanks,
Mauro
