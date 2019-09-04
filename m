Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6175C3A5A9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 07:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98F43233A1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 07:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBpZ6A+8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbfIDH1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 03:27:16 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33148 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbfIDH1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 03:27:16 -0400
Received: by mail-pg1-f194.google.com with SMTP id n190so10758803pgn.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 00:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-description:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=9Et9BlRt+SMSDP1Q6IJeQ3vF/J+SFCi5Hqn0dALv4Fc=;
        b=NBpZ6A+8AN7oxcEXEc9nIbW6FJSXHK3UU5N0RJjm+KHzTpjtuxFTvGUJBa8Eswyp8Q
         LExWBIQplJX/7J0ailAW0WYmXrfrR0DnRd8OhbGVZa83Bhp85xasVCxvWh3UYGGbufHv
         /iu0w0YwOMpFeWCLHCoESpzHxsGfbEvzX7hS0roRhT8dt+7q3Xp4oSfWPiODpH+IQWPg
         +S1SDcNwPeC7phcGvbIg/c9QRgi+sRCfofKlup3tpyDNesNYlqbK6VLrHvapgqpbXsh6
         ZLy1IXUKl4OEdg1cqFlFORiMgyHGVkEEJiHXL/1LoFbqVUeHNpR4OFUIBg1DK19zTCK1
         yP1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-description:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=9Et9BlRt+SMSDP1Q6IJeQ3vF/J+SFCi5Hqn0dALv4Fc=;
        b=EqxLPKAFp9JdUrNwKF2q/zy9eUcC5sQgxq08ZZK0E3HSOLaln3oD9p7UHlULgDDz+/
         pL5cfnGAC3VtnG3VVnavg82709AMfbW73crf4ab9oatgtWooAq1JDEBK6feGbeI4gDE7
         28CeAJUH7nkNYzLadGPfMhcPSROPK9PtlW0L2hRyR5NOKJ1nAY2//X1DEX1lm45IhAoo
         FDzRimlE7Mwnps5WJTNFySTjWDFtdxjCcH9j4l6oPcbhjg45WQV7RmHagXBzCEiFJvAQ
         HuLPWeb+9yxsYiujSLlRXQDXDiEEx5WjFdAAD72kAp831Qxpg5Yk5vPN2Yl8KKFBeO6i
         Km9g==
X-Gm-Message-State: APjAAAWa2///vZ5ogLPDjAs8zv88ft/RtQpFZ8HiUd9O+Yd+5hvBaZcb
        hHwBAvmNdOrsldiPtQJ2gqE=
X-Google-Smtp-Source: APXvYqwkQ5SISgCkfFL+sDJH0M8PJaVzOA5OiyCjQZB/W197lTkysqAIIuyoI3KzZxUXpS/uPgFEcw==
X-Received: by 2002:a63:1310:: with SMTP id i16mr33404702pgl.187.1567582035511;
        Wed, 04 Sep 2019 00:27:15 -0700 (PDT)
Received: from raspberrypi ([61.83.141.141])
        by smtp.gmail.com with ESMTPSA id s76sm19416340pgc.92.2019.09.04.00.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 00:27:14 -0700 (PDT)
Date:   Wed, 4 Sep 2019 08:27:07 +0100
From:   Sidong Yang <realwakka@gmail.com>
To:     Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/vkms: Use alpha value to blend values.
Message-ID: <20190904072707.GA29211@raspberrypi>
References: <20190831172546.GA1972@raspberrypi>
 <20190902122858.GU7482@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Description: ri-devel@lists.freedesktop.org,
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190902122858.GU7482@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 02, 2019 at 03:28:58PM +0300, Ville Syrjälä wrote:
> On Sat, Aug 31, 2019 at 06:25:46PM +0100, Sidong Yang wrote:
> > Use alpha value to blend source value and destination value Instead of
> > just overwrite with source value.
> > 
> > Signed-off-by: Sidong Yang <realwakka@gmail.com>
> > ---
> >  drivers/gpu/drm/vkms/vkms_composer.c | 13 +++++++++++--
> >  1 file changed, 11 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
> > index d5585695c64d..b776185e5cb5 100644
> > --- a/drivers/gpu/drm/vkms/vkms_composer.c
> > +++ b/drivers/gpu/drm/vkms/vkms_composer.c
> > @@ -75,6 +75,9 @@ static void blend(void *vaddr_dst, void *vaddr_src,
> >  	int y_limit = y_src + h_dst;
> >  	int x_limit = x_src + w_dst;
> >  
> > +	u8 *src, *dst;
> > +	u32 alpha, inv_alpha;
> 
> These could all live in a tighter scope.

Hi, Ville.

Thank you for reviewing my patch.
I think that's good idea and I'll do that in next version.
I found some patch in mailing list that is similar with this patch.
So should I drop this patch and find other thing?

Sidong.

> 
> Apart from that lgtm
> Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> 
> > +
> >  	for (i = y_src, i_dst = y_dst; i < y_limit; ++i) {
> >  		for (j = x_src, j_dst = x_dst; j < x_limit; ++j) {
> >  			offset_dst = dest_composer->offset
> > @@ -84,8 +87,14 @@ static void blend(void *vaddr_dst, void *vaddr_src,
> >  				     + (i * src_composer->pitch)
> >  				     + (j * src_composer->cpp);
> >  
> > -			memcpy(vaddr_dst + offset_dst,
> > -			       vaddr_src + offset_src, sizeof(u32));
> > +			src = vaddr_src + offset_src;
> > +			dst = vaddr_dst + offset_dst;
> > +			alpha = src[3] + 1;
> > +			inv_alpha = 256 - src[3];
> > +			dst[0] = (alpha * src[0] + inv_alpha * dst[0]) >> 8;
> > +			dst[1] = (alpha * src[1] + inv_alpha * dst[1]) >> 8;
> > +			dst[2] = (alpha * src[2] + inv_alpha * dst[2]) >> 8;
> > +			dst[3] = 0xff;
> >  		}
> >  		i_dst++;
> >  	}
> > -- 
> > 2.20.1
> > 
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
> -- 
> Ville Syrjälä
> Intel
