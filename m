Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 470F3C76186
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 01:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13AF421855
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 01:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="mVWrDOAS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YXNOT5yI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbfGYBKW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 21:10:22 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:40581 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726115AbfGYBKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 21:10:22 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 355FE21FBC;
        Wed, 24 Jul 2019 21:10:21 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Wed, 24 Jul 2019 21:10:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm3; bh=hT6VUAYNVIFczKSf7p2tdTIbi+IZpnd
        9IggzGcLtHyQ=; b=mVWrDOAS8HG4YyOWzxSU9uDXvpp/q9weSwMs3XphM6+9j4G
        Vn5uC+KFR+gSeezq3K6biFvC0IAw7FpCTooOSKmKNt/wAmOIGai7wXCP6hi9FMwV
        fmH8aADBK+O9iw6eWc5VQG32hdB/1zZ1mvC9tM0UDGIU/zSFZatxi103lvBA9ymE
        mQ+9YepIikdaS3zI4HcrIIgvw7sGA9Tyjcp1xYkFYmPq7OTL3ZbkQAzNJAulfvVs
        7xhpucFz6WHmVQhLoXGh0yXP3ZLy2+JnWAeVz2KrKsqzaT9sVmyWFyBsHZtlC5zQ
        t7oYf4T4oExHpv6azHLECU+C+VWrVBVxlZbsH0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=hT6VUA
        YNVIFczKSf7p2tdTIbi+IZpnd9IggzGcLtHyQ=; b=YXNOT5yI7R7e/gLkcPvVid
        o6vJv1Zkzo3zG02qo1uU4TnIth2J21EgzmyreA5qLiATdqEjgJ0T6kueXsEqoe/i
        IsvDprSz7d2La5nluRvdMpESMqz0nRTnmVuEhyjza/Rib82IcNVAMn5X8x19oj/P
        kmEh2NvRgsJKNeI4s+KhWon4/qSY01J1jkmC0f9bpuBPjL1JzsJOXasrbB6PwmSw
        WH1WUJ2iTUF1UsI9V01nGwusK5uuutXuyKPK6Ellc1yd5K+2jTgTuLBzt0BSKjk5
        rrdBpjmF1XMShHCsTZFWcTwFKLIw9XPohW2++c7WPq2aMq+jos/o0maU3Yu1/goQ
        ==
X-ME-Sender: <xms:egE5XeW7kZvQ9egeyjjFPGT_Jz-3NUpb2L8A72zmWRiLgAqmafE_sA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrkedugdefkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehnughr
    vgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucfrrghrrg
    hmpehmrghilhhfrhhomheprghnughrvgifsegrjhdrihgurdgruhenucevlhhushhtvghr
    ufhiiigvpedt
X-ME-Proxy: <xmx:egE5XVFmtKPksS0mLeVK3pJ2RvFGODGVseqK6TGANCZgoLCsneqJVQ>
    <xmx:egE5XfXzjZ6F9kA-eLW9_ZC-PHaoeYesnpKn4F1US-NptTJ5WvHDWg>
    <xmx:egE5XYDE54I6zx4Fhs2E7uu7j3gLff9Nwl8ozKKchsPSAewL0xBHjQ>
    <xmx:fQE5XQp0G_y4WUSzGSGO59QkCPaZRpqRwXl2fAfSy9Z7luzJZJ4Wdw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 64D16E0129; Wed, 24 Jul 2019 21:10:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.6-736-gdfb8e44-fmstable-20190718v2
Mime-Version: 1.0
Message-Id: <4f6709f8-381f-415c-8569-798b074b66c5@www.fastmail.com>
In-Reply-To: <2a0c5ef5c7e20b190156908991e4c964a501d80a.camel@perches.com>
References: <cover.1562734889.git.joe@perches.com>
 <cddd7ad7e9f81dec1e86c106f04229d21fc21920.1562734889.git.joe@perches.com>
 <2a0c5ef5c7e20b190156908991e4c964a501d80a.camel@perches.com>
Date:   Thu, 25 Jul 2019 10:40:32 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Joe Perches" <joe@perches.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Joel Stanley" <joel@jms.id.au>
Cc:     "David Airlie" <airlied@linux.ie>,
        "Daniel Vetter" <daniel@ffwll.ch>, linux-aspeed@lists.ozlabs.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/12] drm: aspeed_gfx: Fix misuse of GENMASK macro
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 25 Jul 2019, at 02:46, Joe Perches wrote:
> On Tue, 2019-07-09 at 22:04 -0700, Joe Perches wrote:
> > Arguments are supposed to be ordered high then low.
> > 
> > Signed-off-by: Joe Perches <joe@perches.com>
> > ---
> >  drivers/gpu/drm/aspeed/aspeed_gfx.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx.h b/drivers/gpu/drm/aspeed/aspeed_gfx.h
> > index a10358bb61ec..095ea03e5833 100644
> > --- a/drivers/gpu/drm/aspeed/aspeed_gfx.h
> > +++ b/drivers/gpu/drm/aspeed/aspeed_gfx.h
> > @@ -74,7 +74,7 @@ int aspeed_gfx_create_output(struct drm_device *drm);
> >  /* CTRL2 */
> >  #define CRT_CTRL_DAC_EN			BIT(0)
> >  #define CRT_CTRL_VBLANK_LINE(x)		(((x) << 20) & CRT_CTRL_VBLANK_LINE_MASK)
> > -#define CRT_CTRL_VBLANK_LINE_MASK	GENMASK(20, 31)
> > +#define CRT_CTRL_VBLANK_LINE_MASK	GENMASK(31, 20)

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

> 
> ping?
> 
> 
>
