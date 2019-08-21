Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7966BC41514
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 20:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4088F233A2
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 20:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566420840;
	bh=WVv7OC/wjSPYjgZPpA23H9SG+kB2lX2pXPtA5l+Bz9Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0g965FH0WnsXSn1K+7dPJhY2cIEbSjorFh75J2ENcZLpQJLIOGleXHQQzm43TYQmb
	 jOY1gxThcWlfzyej55ANXH0I5U/8DIISGnpfNIgDD2LcXGoLHhW7NrnBECKa8yLxuH
	 ZReNuRKouImGh77r7lVLlrnzu5oThJYmBnZOwAFY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730648AbfHUUx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 16:53:59 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43939 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbfHUUx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 16:53:58 -0400
Received: by mail-oi1-f196.google.com with SMTP id y8so2672252oih.10;
        Wed, 21 Aug 2019 13:53:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iN2Cyapy/c+udG8GVjOneUf6PsDSAtIb74EbQ1qpId0=;
        b=Ogkhw6Le/V+YH83ya5C8oBdBxJzDljPFl0zrlCDPxJsOJFhYtn9ukoGQCqC8rGAkz4
         qZ/iJCyAb78i4Yy0PaXVxMvAl0wuCMb/ZUs3aIP64NL8ltXIkJnEt1X61MLneO+CWGR2
         WPGA20HAVZwVaw+Zgr0S07o1tPY1Y+N++WAwxTYqbINmkK7/9f+Zx+YcuNfkS1UQke7i
         O48xu2fYzV1ODMcnWIaFKOW1ZM3iVyHqW/U4kUA33KdaGAVjFUwEFSE7sXmYv9mDEXkl
         ObGXrwStFlol2PS9gfM0+0jSkh8zKIGwgCy0zKlqCGhWsDNChHWyGZyTPUTubBmp8qBe
         u1Eg==
X-Gm-Message-State: APjAAAUfm4t6OcICkVW8yI+C5Q/rOqbat8QzrxcwY5fGWau6I2WHk3fy
        iipADvnz2Z/jXKoHx/w8vA==
X-Google-Smtp-Source: APXvYqyF7OdLJMF4z4ZxUcRUJPQqxFX+w2EQg50WBPyrjB+YPmYit8gOvuo6+I7+ymbPoLac9h5cgA==
X-Received: by 2002:aca:f256:: with SMTP id q83mr1290528oih.99.1566420837625;
        Wed, 21 Aug 2019 13:53:57 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p2sm7799009otl.59.2019.08.21.13.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 13:53:57 -0700 (PDT)
Date:   Wed, 21 Aug 2019 15:53:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     Hui Song <hui.song_1@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Song Hui <hui.song_1@nxp.com>
Subject: Re: [PATCH v1 1/3] gpio: mpc8xxx: add ls1088a platform gpio node DT
 binding description
Message-ID: <20190821205356.GA14637@bogus>
References: <20190808101628.36782-1-hui.song_1@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808101628.36782-1-hui.song_1@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  8 Aug 2019 18:16:26 +0800, Hui Song wrote:
> From: Song Hui <hui.song_1@nxp.com>
> 
> ls1088a and ls1028a platform share common gpio node.
> 
> Signed-off-by: Song Hui <hui.song_1@nxp.com>
> ---
>  Documentation/devicetree/bindings/gpio/gpio-mpc8xxx.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
