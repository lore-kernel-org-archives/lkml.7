Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D65FC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 16:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E221206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 16:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nXhNdnpz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730096AbfGaQGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 12:06:10 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42000 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727799AbfGaQGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 12:06:09 -0400
Received: by mail-pg1-f196.google.com with SMTP id t132so32246181pgb.9
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 09:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dw5dQKwX8ASG6Ts6LgBuSFToiWxM+evOZX45eitYT60=;
        b=nXhNdnpzQ5klubCtfPKL3rrjBDdkcECAJhbzNalPGdQFtuHxtHL5KFS8kYJxX01zI+
         3GqX/EXvBnWwabWBFeHJWv8ENvMiwnd744dcdIMl23dIdrN9eqdKH3FEaOzYWG/FLHW+
         snA2P3tt9xmBEcE0wzL9JO6YiPQXK/ecFHfTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dw5dQKwX8ASG6Ts6LgBuSFToiWxM+evOZX45eitYT60=;
        b=liDdX7PLJeOL2/i5E5vA4QjaZ6V8YvTLBDQB6BFEj8tLRjt8CRTP77MdO/lMXcZk6O
         IzBPCChOOElkm2swVr5Sq7Z2eHQ7pv4DZaPckrTA3XVj0DYYGRvn+vu/BMljY/d/zU0/
         YaBkAxMD6cBoE0Cj1b++VZGTeaIVsfLNO7MpXdF4j4bcbcmhXEUyD8BWiOZBV9MpNwOj
         mo8uNg43aVdBjdP1znKuUWgBnKkYsiIGpjmMH0CYJu+gtGMoeNe3r0YLOD455Me7aXL+
         F2/ASwRjhJEmGekU4s+DqbNg1ssT3NP8Yc4x7Gq//78aK/J/4Lxc8jf//qBxPSJ5/RQW
         Bgiw==
X-Gm-Message-State: APjAAAUG6W4WECsDWLoHJH7jtXIetrulDve9Nv9N6RAZubV2IrOEg3DM
        d4yg6TDArtBi046NhKEzGhOe/Q==
X-Google-Smtp-Source: APXvYqyp+rY/4Em+/ZUkiOjo98nR6upEwWWg4wXYmcr0OQ9k/QFwbGOVWkGPKkn54UdzEr838uzIjQ==
X-Received: by 2002:a63:ff03:: with SMTP id k3mr19399349pgi.40.1564589168950;
        Wed, 31 Jul 2019 09:06:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j15sm98920836pfn.150.2019.07.31.09.06.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Jul 2019 09:06:08 -0700 (PDT)
Date:   Wed, 31 Jul 2019 09:06:07 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] mmc: atmel-mci: Mark expected switch fall-throughs
Message-ID: <201907310905.B90C6E25@keescook>
References: <20190729000123.GA23902@embeddedor>
 <20190731113216.ztxckd54a74g2lw5@M43218.corp.atmel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731113216.ztxckd54a74g2lw5@M43218.corp.atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 01:32:16PM +0200, Ludovic Desroches wrote:
> > drivers/mmc/host/atmel-mci.c:2426:40: warning: this statement may fall through [-Wimplicit-fallthrough=]
> >    host->caps.need_notbusy_for_read_ops = 1;
> >    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
> > drivers/mmc/host/atmel-mci.c:2427:2: note: here
> >   case 0x100:
> >   ^~~~
> > 
> > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> 
> I don't know if there is a policy in the kernel about the expression to
> use. As this one does the job

Yup, documented here:
https://www.kernel.org/doc/html/latest/process/deprecated.html#implicit-switch-case-fall-through

> Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>

Thanks!

-- 
Kees Cook
