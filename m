Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,URIBL_CSS,URIBL_CSS_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECEE7C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 18:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C561F208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 18:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556305091;
	bh=+PPEhouhRGNIjdlyXYLeKxD5rR2C0IXYTjfOZlzK/IU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VoNxiMdcOJK+DEp+31i/nK+GYMHnjng88TNi5Bdk6hTB/I0ub+t4YjWcMxo9atcgD
	 2fH93pualNhviVFGqPW9+8046IbvMCzJZhRBUaFcDX5nqVTZqzKRXQOyPR15x7BwbU
	 EYsoucml/+SaGx0UyLruYF4+CiRFeKWe4zWKeHJw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfDZS6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 14:58:11 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38847 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfDZS6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 14:58:10 -0400
Received: by mail-oi1-f195.google.com with SMTP id a6so3765839oie.5;
        Fri, 26 Apr 2019 11:58:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VVR3nQDmYGS35vbiw2w7iYVooFWVVPoQj6xbw99X8Dc=;
        b=Q2K3gU6vB33uWHaUI8/Gzim0EQFGvNwZ6+MjaBji+PAbaN2XUm/HzunRLaYBx8z16p
         qHehnSzoxz7vTANZT4JFIt1VvlsKlc6eyJT5xYuKgXSCwsJuGgj1iXtdt2mVaqFbUE4j
         Cc1oku2hm+sSPs/a1pQsnF+LE3PHKF/TOof6tp4iOc68SM2jbRDR52p0BQOwr832k8jB
         yLokfmq7UxCWE503y8zz03bINplgyX06h8d944zOSSi6yx7a80viLkUCISqMkgveOCEu
         SsTMXRCEya60e2KHuTur9VMDm9Zi3bxOaSQ5pnB6t64bEAb4TXh6ENf/EopMwFwLuia4
         BfxQ==
X-Gm-Message-State: APjAAAUQyCiyP1nW42AHe1Pz4GTNWUk8Rb9Uv7XhTWV8eWrPm3w3Vx94
        mYCT3rrC7M5SIu5PF2gWTg==
X-Google-Smtp-Source: APXvYqwJBbkRUS8/vGnaSYPaohhvli+ON4cbIpZ1x0Va6Ffmls70lJ58RtHIlPKGSYHayuLrDxNeUA==
X-Received: by 2002:aca:b706:: with SMTP id h6mr7770577oif.7.1556305089747;
        Fri, 26 Apr 2019 11:58:09 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n185sm8247590oif.8.2019.04.26.11.58.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 11:58:08 -0700 (PDT)
Date:   Fri, 26 Apr 2019 13:58:08 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, pavel@ucw.cz, robh@kernel.org,
        dtor@google.com, linux@roeck-us.net, jacek.anaszewski@gmail.com,
        Baolin Wang <baolin.wang@linaro.org>,
        Dan Murphy <dmurphy@ti.com>, Daniel Mack <daniel@zonque.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Simon Shields <simon@lineageos.org>
Subject: Re: [PATCH v4 05/26] dt-bindings: leds: Add properties for LED name
 construction
Message-ID: <20190426185808.GA28168@bogus>
References: <20190417205439.17685-1-jacek.anaszewski@gmail.com>
 <20190417205439.17685-6-jacek.anaszewski@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417205439.17685-6-jacek.anaszewski@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Apr 2019 22:54:18 +0200, Jacek Anaszewski wrote:
> Introduce dedicated properties for conveying information about
> LED function and color. Mark old "label" property as deprecated.
> 
> Additionally function-enumerator property is being provided
> for the cases when neither function nor color can be used
> for LED differentiation.
> 
> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> Cc: Baolin Wang <baolin.wang@linaro.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Dan Murphy <dmurphy@ti.com>
> Cc: Daniel Mack <daniel@zonque.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Oleh Kravchenko <oleg@kaa.org.ua>
> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> Cc: Simon Shields <simon@lineageos.org>
> ---
>  Documentation/devicetree/bindings/leds/common.txt | 62 ++++++++++++++++++++---
>  1 file changed, 54 insertions(+), 8 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
