Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C8A6C004C9
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 03:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 180E120830
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 03:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbfEFDdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 23:33:09 -0400
Received: from mail5.windriver.com ([192.103.53.11]:56328 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725813AbfEFDdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 23:33:08 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x463W2hq018658
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Sun, 5 May 2019 20:32:12 -0700
Received: from yow-pgortmak-d1.corp.ad.wrs.com (128.224.56.57) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.439.0; Sun, 5 May 2019 20:31:52 -0700
Received: by yow-pgortmak-d1.corp.ad.wrs.com (Postfix, from userid 1000)        id
 D3EFD2E04E4; Sun,  5 May 2019 23:31:51 -0400 (EDT)
Date:   Sun, 5 May 2019 23:31:51 -0400
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: Fwd: linux-next: build failure after merge of the kbuild tree
Message-ID: <20190506033151.GB2649@windriver.com>
References: <20190506094609.08e930f2@canb.auug.org.au>
 <CAK7LNASH4CuVBjfEJsT+aBx4aLrj9j2=aOD3B4f9+Tdcm=x2pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAK7LNASH4CuVBjfEJsT+aBx4aLrj9j2=aOD3B4f9+Tdcm=x2pg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Fwd: linux-next: build failure after merge of the kbuild tree] On 06/05/2019 (Mon 11:19) Masahiro Yamada wrote:

> Hi Paul,
> 
> In today's linux-next build testing,
> more "make ... explicitly non-modular"
> candidates showed up.
> 

Hi Masahiro,

I am not 100% clear on what you are asking me.  There are lots and lots
of these in the kernel.... many fixed, and many remain unfortunately.

> arch/arm/plat-omap/dma.c
> drivers/clocksource/timer-ti-dm.c
> drivers/mfd/omap-usb-host.c
> drivers/mfd/omap-usb-tll.c

None of these are "new".  I just checked, and I have had patches for all
these for a long time, in my personal queue, found by my audits.

> Would you send patches?

It isn't that simple.  I wish it was.  Some subsystem maintainers are
glad to take the patches, and some think they are a waste of time and
reject them immediately.  Some I've sent just simply get "crickets".

What that means is, that I need to look at each maintainer's
requirements, and ensure the patch and commit log are matching
expectatins - I will not just spam out hundreds of patches across all
subsystems.  Anyone who has spent considerable time in linux development
knows that is a recipe for failure.

So I need to work across each subsystem - one at a time, with their
individual maintainer requirements in mind, and if you look at git
history, you will see that has been what I've tried to do when I had
free time to work on fixing these across the whole linux tree.

But fortunately, none of these represent a CVE/security issue, so I've
never had a reason to try and pretend there was any reason for an
immediate fix/merge - they just represent a better attention to detail
in the code we merge and support that I'd like to see happen tree-wide.

I appreciate that you are also interested in seeing all these fixed, and
I also wish they could all be solved in one version, but unfortunately I
don't think that is pragmatic.  So in the meantime, I will continue to
chip away at things when we are early in the dev cycle and not starting
the two week merge window, as we are just now.

Thanks,
Paul.
--

> 
> I think EXPORT_SYMBOL_GPL() in omap-usb-tll.c
> are also unnecessary.
> 
> Thanks.
> 
> 
> 
> ---------- Forwarded message ---------
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Mon, May 6, 2019 at 8:51 AM
> Subject: linux-next: build failure after merge of the kbuild tree
> To: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Linux Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel
> Mailing List <linux-kernel@vger.kernel.org>, Alexey Gladkov
> <gladkov.alexey@gmail.com>, Keshava Munegowda <keshava_mgowda@ti.com>,
> Samuel Ortiz <sameo@linux.intel.com>
> 
> 
> Hi Masahiro,
> 
> After merging the kbuild tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
> 
> In file included from include/linux/module.h:18,
>                  from drivers/mfd/omap-usb-tll.c:21:
> drivers/mfd/omap-usb-tll.c:462:26: error: expected ',' or ';' before
> 'USBHS_DRIVER_NAME'
>  MODULE_ALIAS("platform:" USBHS_DRIVER_NAME);
>                           ^~~~~~~~~~~~~~~~~
> include/linux/moduleparam.h:26:47: note: in definition of macro '__MODULE_INFO'
>    = __MODULE_INFO_PREFIX __stringify(tag) "=" info
>                                                ^~~~
> include/linux/module.h:164:30: note: in expansion of macro 'MODULE_INFO'
>  #define MODULE_ALIAS(_alias) MODULE_INFO(alias, _alias)
>                               ^~~~~~~~~~~
> drivers/mfd/omap-usb-tll.c:462:1: note: in expansion of macro 'MODULE_ALIAS'
>  MODULE_ALIAS("platform:" USBHS_DRIVER_NAME);
>  ^~~~~~~~~~~~
> 
> Caused by commit
> 
>   6a26793a7891 ("moduleparam: Save information about built-in modules
> in separate file")
> 
> USBHS_DRIVER_NAME is not defined and this kbuild tree change has
> exposed it. It has been this way since commit
> 
>   16fa3dc75c22 ("mfd: omap-usb-tll: HOST TLL platform driver")
> 
> From v3.7-rc1 in 2012.
> 
> I have applied the following patch for today.
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Mon, 6 May 2019 09:39:14 +1000
> Subject: [PATCH] mfd: omap: remove unused MODULE_ALIAS from omap-usb-tll.c
> 
> USBHS_DRIVER_NAME has never been defined, so this cannot have ever
> been used.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/mfd/omap-usb-tll.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/omap-usb-tll.c b/drivers/mfd/omap-usb-tll.c
> index 446713dbee27..1cc8937e8bec 100644
> --- a/drivers/mfd/omap-usb-tll.c
> +++ b/drivers/mfd/omap-usb-tll.c
> @@ -459,7 +459,7 @@ EXPORT_SYMBOL_GPL(omap_tll_disable);
> 
>  MODULE_AUTHOR("Keshava Munegowda <keshava_mgowda@ti.com>");
>  MODULE_AUTHOR("Roger Quadros <rogerq@ti.com>");
> -MODULE_ALIAS("platform:" USBHS_DRIVER_NAME);
> +// MODULE_ALIAS("platform:" USBHS_DRIVER_NAME);
>  MODULE_LICENSE("GPL v2");
>  MODULE_DESCRIPTION("usb tll driver for TI OMAP EHCI and OHCI controllers");
> 
> --
> 2.20.1
> 
> --
> Cheers,
> Stephen Rothwell
> 
> 
> -- 
> Best Regards
> Masahiro Yamada


