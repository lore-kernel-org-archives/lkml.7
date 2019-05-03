Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0BFC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 07:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE241205F4
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 07:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfECHky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 03:40:54 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:45755 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbfECHky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 03:40:54 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id 741C73C0034;
        Fri,  3 May 2019 09:40:51 +0200 (CEST)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HggogzNF1TRK; Fri,  3 May 2019 09:40:44 +0200 (CEST)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 739DB3C00C1;
        Fri,  3 May 2019 09:40:44 +0200 (CEST)
Received: from vmlxhi-102.adit-jv.com (10.72.93.184) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 3 May 2019
 09:40:44 +0200
Date:   Fri, 3 May 2019 09:40:41 +0200
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Christian Gromm <christian.gromm@microchip.com>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        Andrey Shvetsov <andrey.shvetsov@k2l.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Takashi Iwai <tiwai@suse.de>,
        Marcin Ciupak <marcin.s.ciupak@gmail.com>,
        Suresh Udipi <sudipi@jp.adit-jv.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: Re: [PATCH] staging: most: cdev: fix chrdev_region leak in mod_exit
Message-ID: <20190503074041.GA4686@vmlxhi-102.adit-jv.com>
References: <20190424192343.15418-1-erosca@de.adit-jv.com>
 <20190502173920.GA14304@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190502173920.GA14304@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.72.93.184]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2019 at 07:39:20PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Apr 24, 2019 at 09:23:43PM +0200, Eugeniu Rosca wrote:
> > From: Suresh Udipi <sudipi@jp.adit-jv.com>
> > 
> > It looks like v4.18-rc1 commit [0] which upstreams mld-1.8.0
> > commit [1] missed to fix the memory leak in mod_exit function.
> > 
> > Do it now.
> > 
> > [0] aba258b7310167 ("staging: most: cdev: fix chrdev_region leak")
> > [1] https://github.com/microchip-ais/linux/commit/a2d8f7ae7ea381
> >     ("staging: most: cdev: fix leak for chrdev_region")
> > 
> > Signed-off-by: Suresh Udipi <sudipi@jp.adit-jv.com>
> > Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
> > Acked-by: Christian Gromm <christian.gromm@microchip.com>
> 
> In the future, please use the "correct" way to mark a fixup patch.  For
> this, it would be:
> Fixes: aba258b73101 ("staging: most: cdev: fix chrdev_region leak")
> 
> I'll go add it, and the needed stable tag to the patch when applying it.

Thank you for the suggestion. I'll follow it next time.

> 
> thanks,
> 
> greg k-h

-- 
Best Regards,
Eugeniu.
