Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E29C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 14:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72F902082E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 14:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="DJsGveXc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729275AbfDDOwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 10:52:05 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36095 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728656AbfDDOwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 10:52:05 -0400
Received: by mail-qt1-f195.google.com with SMTP id s15so3565251qtn.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 07:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=InJAUPygOFNLNyjqZpNbr6k2+i+f1+qkGPj3xxbuH/A=;
        b=DJsGveXcFTItFzq0MNrZW4ey1d9eZrf4VMtIeiyAjiCx6zdCeJia1xuAo061ITmWtw
         aZhmVdnA35B3sDXkJ2HKLQzj+hUIWTCQLxtH8bNbudpaShwW0k9YPLzL/Fbi4Dx4+ShM
         edGkcC3+qqHGiNdsMaun4kBz5y3YVDuiF1qj8YGcoVAnWDVhFP4GNTGbKfPWS676r+vD
         mH8/3YwJceiZJ0GWHn8IjijhWr86HXdaIj6IQC4ZdZpmJY4EVy2Igz2IrS3iv1yxU/SU
         jkZPS6r/CAXiGHIJXqbXE3Jzpi2adPLtdJXsKdC9HMwEyCEfL+7ZOnaoJmsOWZMMoRdA
         50og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=InJAUPygOFNLNyjqZpNbr6k2+i+f1+qkGPj3xxbuH/A=;
        b=LdiA1BsLCRuJkGfy9TdVLx1oYTIPfAWMO24Gy6tFfreTPz4VB0qg4qtql1EjHrCiCb
         DmZk3k/EKPJgwg5An9j5Q0+0qcN3ni5ZGhgZGsKinKgK+jH6gXgDsMVBl9Z9/0dFGod2
         fOyAKboIIYtprOy5wmpjoEYISWhnOnVN1z17kz7I0kF2e2W/QVymlaOpRxtaHrLTKZho
         cMtqsoB4O3THBORmUy5+wwqDHS9SkKADMI42Jcd7In+RxXdtOiEAKm3wdZ4856A2wmjW
         526vV/1LqUP6Hzz1AlnXDkVphUXtwEEwy3Wbf1ZR8k7TYeYLc3nAPDImZpTpTJpZDvx5
         rzag==
X-Gm-Message-State: APjAAAVtJXNiqFKFHS7HMcMvq3BJmgoV/LmIkPjJSMdHzr0Kn3GUNITZ
        g+4zO06zNtOkQajLgsCTRJejpw==
X-Google-Smtp-Source: APXvYqwZWADrTY6mLinp1iK2YGu8XUTPwO5g23NmxioeEbg2y3Nbf2d8RH2DJJc46h2298RNi8WThA==
X-Received: by 2002:a0c:81d4:: with SMTP id 20mr5305524qve.2.1554389524156;
        Thu, 04 Apr 2019 07:52:04 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id s64sm9779158qkc.39.2019.04.04.07.52.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 07:52:03 -0700 (PDT)
Date:   Thu, 4 Apr 2019 10:52:02 -0400
From:   Sean Paul <sean@poorly.run>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     sean@poorly.run, dri-devel@lists.freedesktop.org,
        linux-amlogic@lists.infradead.org, maxime.ripard@bootlin.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "Documentation/gpu/meson: Remove link to
 meson_canvas.c"
Message-ID: <20190404145202.GC17077@art_vandelay>
References: <20190404144342.15238-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404144342.15238-1-narmstrong@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 04:43:42PM +0200, Neil Armstrong wrote:
> This reverts commit a3f98bb22cbfaaf67717e156f79e2bfeb42d4cac.
> 
> Patch "Documentation/gpu/meson: Remove link to meson_canvas.c" was
> incorrectly applied on the wrong branch not containing the fixed
> commit 2bf6b5b0e374 ("drm/meson: exclusively use the canvas provider module")
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Acked-by: Sean Paul <sean@poorly.run>

and I'll leave this for Maxime to apply if he so chooses.

Sean

> ---
>  Documentation/gpu/meson.rst | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/gpu/meson.rst b/Documentation/gpu/meson.rst
> index b9e2f9aa3bd8..479f6f51a13b 100644
> --- a/Documentation/gpu/meson.rst
> +++ b/Documentation/gpu/meson.rst
> @@ -42,6 +42,12 @@ Video Encoder
>  .. kernel-doc:: drivers/gpu/drm/meson/meson_venc.c
>     :doc: Video Encoder
>  
> +Video Canvas Management
> +=======================
> +
> +.. kernel-doc:: drivers/gpu/drm/meson/meson_canvas.c
> +   :doc: Canvas
> +
>  Video Clocks
>  ============
>  
> -- 
> 2.21.0
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
