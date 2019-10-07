Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E25ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 17:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB429206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 17:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="l9ndA5Oi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbfJGROo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 13:14:44 -0400
Received: from mail.andi.de1.cc ([85.214.55.253]:36166 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727801AbfJGROo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 13:14:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=mm080KtOnLyBqIfHx4O7fkQurN0T478z2w4kEpoDaVc=; b=l9ndA5OiI6LWjL6S22yf+FBvXn
        hRASRP6kwn3i28/ygtaLOOUtX9K2r7nPWhh0RSWMUS/jQ4iTKiZfigt2U9vBZH+t03HNcNVqX8SMm
        hWxp3ZFoWYQZZLrRRLKKs2OX3PCGxtnAcxMEmHiNhD53x7wlvrorKR6qR7gKK6mAEmyo=;
Received: from p200300ccff0a88001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff0a:8800:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1iHWac-0001u4-JD; Mon, 07 Oct 2019 19:14:33 +0200
Date:   Mon, 7 Oct 2019 19:14:28 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        omi Valkeinen <tomi.valkeinen@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>, Tony Lindgren <tony@atomide.com>,
        Jyri Sarha <jsarha@ti.com>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] drm: panels: fix spi aliases of former omap panels
Message-ID: <20191007191428.016ddcd4@aktux>
In-Reply-To: <20191007170446.yotb24s6jhe6nx3r@earth.universe>
References: <20191007164130.31534-1-andreas@kemnade.info>
        <20191007170446.yotb24s6jhe6nx3r@earth.universe>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Oct 2019 19:04:46 +0200
Sebastian Reichel <sre@kernel.org> wrote:

> Hi,
> 
> On Mon, Oct 07, 2019 at 06:41:30PM +0200, Andreas Kemnade wrote:
> > When the panels were moved from omap/displays/ to panel/
> > omapdss prefix was stripped, which cause spi modalias
> > to not contain the vendor-prefix anymore.
> > 
> > so we had e.g. in former times:
> > compatible=omapdss,tpo,td028ttec1 -> modalias=spi:tpo,td028ttec1
> > now:
> > compatible=tpo,td028ttec1 -> modalias=spi:td028ttec1
> > 
> > This is consistent with other drivers. Tested the td028ttec.c
> > only, but the pattern looks the same for the other ones.
> > 
> > Fixes: 45f16c82db7e8 ("drm/omap: displays: Remove unused panel drivers")
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > ---  
> 
> Patch looks good to me, but you have one false positive.
> 
> > [...]
> >
> > diff --git a/drivers/gpu/drm/panel/panel-sharp-ls037v7dw01.c b/drivers/gpu/drm/panel/panel-sharp-ls037v7dw01.c
> > index 46cd9a2501298..838d39a263f53 100644
> > --- a/drivers/gpu/drm/panel/panel-sharp-ls037v7dw01.c
> > +++ b/drivers/gpu/drm/panel/panel-sharp-ls037v7dw01.c
> > @@ -204,7 +204,7 @@ static int ls037v7dw01_remove(struct platform_device *pdev)
> >  }
> >  
> >  static const struct of_device_id ls037v7dw01_of_match[] = {
> > -	{ .compatible = "sharp,ls037v7dw01", },
> > +	{ .compatible = "ls037v7dw01", },
> >  	{ /* sentinel */ },
> >  };
> >    
> 
> The DT compatible should have a vendor prefix.
> 

oops, sorry, but I it seems that Laurent already has submitted a fix.

Regards,
Andreas
