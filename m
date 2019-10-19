Return-Path: <SRS0=/uHP=YM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E3F0CA9EA0
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 01:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44F95222C5
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 01:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbfJSBTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 21:19:21 -0400
Received: from smtprelay0208.hostedemail.com ([216.40.44.208]:35928 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725800AbfJSBTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 21:19:20 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 268FB182CED28;
        Sat, 19 Oct 2019 01:19:19 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: books16_8b4f00402920f
X-Filterd-Recvd-Size: 3041
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Sat, 19 Oct 2019 01:19:17 +0000 (UTC)
Message-ID: <184cdd47d4064420b05c16f10588595c65f789e5.camel@perches.com>
Subject: Re: [PATCH] omapfb: reduce stack usage
From:   Joe Perches <joe@perches.com>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Ladislav Michl <ladis@linux-mips.org>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Date:   Fri, 18 Oct 2019 18:19:15 -0700
In-Reply-To: <20191018223012.tkpwbo3mg5mthlnz@debian>
References: <20191018163004.23498-1-sudipm.mukherjee@gmail.com>
         <20191018172728.GA11857@lenoch> <20191018223012.tkpwbo3mg5mthlnz@debian>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-10-18 at 23:30 +0100, Sudip Mukherjee wrote:
> On Fri, Oct 18, 2019 at 07:27:28PM +0200, Ladislav Michl wrote:
> > On Fri, Oct 18, 2019 at 05:30:04PM +0100, Sudip Mukherjee wrote:
> > > The build of xtensa allmodconfig is giving a warning of:
> > > In function 'dsi_dump_dsidev_irqs':
> > > warning: the frame size of 1120 bytes is larger than 1024 bytes
> > > 
> > > Allocate the memory for 'struct dsi_irq_stats' dynamically instead
> > > of assigning it in stack.
> > 
> > So now function can fail silently, executes longer, code is sligthly
> > bigger... And all that to silent warning about exceeding frame size.
> > Is it really worth "fixing"?

Depends if it could fail in practice due to a stack overrun.

> The only point of failure is if kmalloc() fails and if kmalloc() fails then
> there will be error prints in dmesg to tell the user that there is no
> memory left in the system. About the size bigger, it seems
> the drivers/video/fbdev/omap2/omapfb/dss/dsi.o file is smaller with the
> patch.
> This is without the patch:
> -rw-r--r-- 1 sudip sudip 316856 Oct 18 22:27 drivers/video/fbdev/omap2/omapfb/dss/dsi.o
> And this is with the patch:
> -rw-r--r-- 1 sudip sudip 316436 Oct 18 20:09 drivers/video/fbdev/omap2/omapfb/dss/dsi.o
> 
> And also, objdump shows me that <dsi_dump_dsidev_irqs> was taking up 0xD7D
> bytes, and now with the patch it is taking up 0xBED bytes, thats a saving
> of 400 bytes. If it has 400 bytes of less code to execute will it not be
> faster now?

You should try compiling without all the debugging symbols (defconfig)

> But, I may be totally wrong in my thinking, and in that case, please feel
> free to reject the patch.

Without your patch:

$ objdump -x drivers/video/fbdev/omap2/omapfb/dss/dsi.o | grep dsi_dump_dsidev_irqs
00000d20 l     F .text	0000061c dsi_dump_dsidev_irqs

With your patch:

$ objdump -x drivers/video/fbdev/omap2/omapfb/dss/dsi.o | grep dsi_dump_dsidev_irqs
00000d20 l     F .text	00000638 dsi_dump_dsidev_irqs


