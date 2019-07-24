Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D39C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 18:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CE2B2173B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 18:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbfGXSjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 14:39:08 -0400
Received: from smtprelay0129.hostedemail.com ([216.40.44.129]:40636 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727499AbfGXSjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 14:39:08 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id DF68618038B74;
        Wed, 24 Jul 2019 18:39:06 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: force89_4f51dc7767217
X-Filterd-Recvd-Size: 2931
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Wed, 24 Jul 2019 18:39:04 +0000 (UTC)
Message-ID: <90a8807311ba434a63c9ab6331396d7094492323.camel@perches.com>
Subject: Re: [PATCH 11/12] staging: media: cedrus: Fix misuse of GENMASK
 macro
From:   Joe Perches <joe@perches.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Wed, 24 Jul 2019 11:39:03 -0700
In-Reply-To: <20190724183522.GA30299@kroah.com>
References: <cover.1562734889.git.joe@perches.com>
         <cd543a5f26b031a0bbd3baa55e1f15813f59f107.1562734889.git.joe@perches.com>
         <be536d37a3b58557cdacd33943915d397bcb5037.camel@perches.com>
         <20190724183522.GA30299@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-07-24 at 20:35 +0200, Greg Kroah-Hartman wrote:
> On Wed, Jul 24, 2019 at 10:09:44AM -0700, Joe Perches wrote:
> > On Tue, 2019-07-09 at 22:04 -0700, Joe Perches wrote:
> > > Arguments are supposed to be ordered high then low.
> > > 
> > > Signed-off-by: Joe Perches <joe@perches.com>
> > > ---
> > >  drivers/staging/media/sunxi/cedrus/cedrus_regs.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_regs.h b/drivers/staging/media/sunxi/cedrus/cedrus_regs.h
> > > index 3e9931416e45..ddd29788d685 100644
> > > --- a/drivers/staging/media/sunxi/cedrus/cedrus_regs.h
> > > +++ b/drivers/staging/media/sunxi/cedrus/cedrus_regs.h
> > > @@ -110,7 +110,7 @@
> > >  #define VE_DEC_MPEG_MBADDR			(VE_ENGINE_DEC_MPEG + 0x10)
> > >  
> > >  #define VE_DEC_MPEG_MBADDR_X(w)			(((w) << 8) & GENMASK(15, 8))
> > > -#define VE_DEC_MPEG_MBADDR_Y(h)			(((h) << 0) & GENMASK(0, 7))
> > > +#define VE_DEC_MPEG_MBADDR_Y(h)			(((h) << 0) & GENMASK(7, 0))
> > >  
> > >  #define VE_DEC_MPEG_CTRL			(VE_ENGINE_DEC_MPEG + 0x14)
> > 
> > Greg?  ping?
> >  
> > 
> 
> I am not the maintainer of drivers/staging/media, that is Mauro.

Maybe you want:
---
diff --git a/MAINTAINERS b/MAINTAINERS
index f7dc5bad396a..2fb95ad6ebef 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15312,6 +15312,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
 L:	devel@driverdev.osuosl.org
 S:	Supported
 F:	drivers/staging/
+X:	drivers/staging/media/
 
 STARFIRE/DURALAN NETWORK DRIVER
 M:	Ion Badulescu <ionut@badula.org>



