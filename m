Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D483EC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 15:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE29A20684
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 15:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="ZChRgcFw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729341AbfFFP1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 11:27:17 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:47512 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729077AbfFFP1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 11:27:17 -0400
X-IronPort-AV: E=Sophos;i="5.60,559,1549926000"; 
   d="scan'208";a="7729995"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 06 Jun 2019 17:27:15 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Thu, 06 Jun 2019 17:27:15 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Thu, 06 Jun 2019 17:27:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1559834835; x=1591370835;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=umqEwzb8oK5WtqI9yBT0F9jXzaGIhXB44Au/hCBtBs8=;
  b=ZChRgcFw7UzOc9rbXEfwLchuZ0/ellpXnHkPlHEpklCREXdKLBLabKEJ
   6t03FegynYm2nVJvI1eJchD58VDBuWvCbkSps4rny6tMGvV3smC2c4kTc
   T/Xk2gl1hHt6Vfq8QDWvPjVuitT5wrIhHAb8PNnFwNcNHsv+uHFSBLCQm
   2pGrVHlkP7xLYCtdsLYyjyzRyeGg/iJALy6AQWF8YUfnZ5cm89GLrT0cz
   KI6iZn00QI0TB1ENhJ0ELOEgnGbQgw95evctYzDh/mXEglNaDYT1LFHSN
   SZjzC34zR2d40ERgt+0T8AWC7V1C9MPX2St3MlmiVfEr+dCSWUIEltyB2
   w==;
X-IronPort-AV: E=Sophos;i="5.60,559,1549926000"; 
   d="scan'208";a="7729994"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 06 Jun 2019 17:27:15 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 7FB7C280074;
        Thu,  6 Jun 2019 17:27:21 +0200 (CEST)
Message-ID: <004bda07469769f8a6e0609efd0327f184307493.camel@ew.tq-group.com>
Subject: Re: [PATCH modules 1/2] module: allow arch overrides for .exit
 section names
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org
Date:   Thu, 06 Jun 2019 17:27:12 +0200
In-Reply-To: <20190606150946.GA27669@linux-8ccs>
References: <20190603105726.22436-1-matthias.schiffer@ew.tq-group.com>
         <20190603105726.22436-2-matthias.schiffer@ew.tq-group.com>
         <20190606150946.GA27669@linux-8ccs>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-06-06 at 17:09 +0200, Jessica Yu wrote:
> +++ Matthias Schiffer [03/06/19 12:57 +0200]:
> > Some archs like ARM store unwind information for .exit.text in
> > sections
> > with unusual names. As this unwind information refers to
> > .exit.text, it
> > must not be loaded when .exit.text is not loaded (when
> > CONFIG_MODULE_UNLOAD
> > is unset); otherwise, loading a module can fail due to relocation
> > failures.
> > 
> > Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com
> > >
> > ---
> > include/linux/moduleloader.h | 8 ++++++++
> > kernel/module.c              | 2 +-
> > 2 files changed, 9 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/moduleloader.h
> > b/include/linux/moduleloader.h
> > index 31013c2effd3..cddbd85fb659 100644
> > --- a/include/linux/moduleloader.h
> > +++ b/include/linux/moduleloader.h
> > @@ -5,6 +5,7 @@
> > 
> > #include <linux/module.h>
> > #include <linux/elf.h>
> > +#include <linux/string.h>
> > 
> > /* These may be implemented by architectures that need to hook into
> > the
> >  * module loader code.  Architectures that don't need to do
> > anything special
> > @@ -93,4 +94,11 @@ void module_arch_freeing_init(struct module
> > *mod);
> > #define MODULE_ALIGN PAGE_SIZE
> > #endif
> > 
> > +#ifndef HAVE_ARCH_MODULE_EXIT_SECTION
> > +static inline bool module_exit_section(const char *name)
> > +{
> > +	return strstarts(name, ".exit");
> > +}
> > +#endif
> > +
> 
> Hi Matthias,
> 
> For sake of consistency, could we implement this as an arch-
> overridable
> __weak symbol like the rest of the module arch-overrides in
> moduleloader.h?

Fine with me - making such a tiny function inlineable just seemed more
appropriate to me. I can send a v2 tomorrow.


> 
> > #endif
> > diff --git a/kernel/module.c b/kernel/module.c
> > index 6e6712b3aaf5..e8e4cd0a471f 100644
> > --- a/kernel/module.c
> > +++ b/kernel/module.c
> > @@ -2924,7 +2924,7 @@ static int rewrite_section_headers(struct
> > load_info *info, int flags)
> > 
> > #ifndef CONFIG_MODULE_UNLOAD
> > 		/* Don't load .exit sections */
> > -		if (strstarts(info->secstrings+shdr->sh_name, ".exit"))
> > +		if (module_exit_section(info->secstrings+shdr-
> > >sh_name))
> > 			shdr->sh_flags &= ~(unsigned long)SHF_ALLOC;
> > #endif
> > 	}
> > -- 
> > 2.17.1
> > 

