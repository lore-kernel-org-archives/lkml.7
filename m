Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC646C282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 16:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A60FC20675
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 16:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Lxmfzh/x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbfDTQpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 12:45:08 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35542 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfDTQpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 12:45:08 -0400
Received: by mail-wr1-f66.google.com with SMTP id o12so7252268wrn.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2019 09:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lWvUwvIMR5sxWn1PcFzY+OqDU7vjqWatK4P9WgmC7VY=;
        b=Lxmfzh/xwlp+AS98SuSJSBMQVadP/wKuS75uALnIdYDYhysK42SmmNI1c54/eCRwJQ
         mQDhssu4Uayz/oyUiBMi0Z3YckhD1ZH1P2LUKDVKVc4jc8+/EQ/jwKnh0+nTIUKg7VXY
         3e08VytpyJqpix54uBMtYWOhAEfcSndsCRLND0/62LWpSP2PRiH8XOW7HGZ8FnozTN6/
         bWb4IrxkC8XX8YLZ1uiRAP526VyfRizLgBn1Yk6DBUZshMYlq6GD3I5JcNR+CTpqZ3X0
         tkpDP+Be+MtderzYgqMEBfrhA9DUux/ymN4hrL1ch/jm0Si4cN8P2RZ1UHFQuKb5OV+F
         WeSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lWvUwvIMR5sxWn1PcFzY+OqDU7vjqWatK4P9WgmC7VY=;
        b=Ieosd44RKk2J2DdVD84W1V2hs1UWrObM4esXe9yN668iZz6nne/oE9SEC4YSqmTIvB
         Q/jll41Rt2nWkKNB0YIt2rLEqL6LwolNTgRmiSe7Oiw5jhUD9J6/71xGGv/oDi4Fbr+9
         gwW7L5ckuPEoWEFA15olpvKv9r1I51qQlNzN+gDa29zC/f39fF+pqWdiRYJ/SXiN/04j
         KdrrF5pjAmnnzM6pSsarb888ZeITMdpD2/IwmApOD5W3oyDxhx1sXeGFKUOs+MNu2RQ0
         OgN+fC0KLTpdJmsx9H3uF8UaVDLn8UAc66pFdBy7vB1W6aAeQQCyxDz8A6O84HU2QoET
         zfzQ==
X-Gm-Message-State: APjAAAUIwJ05VCYhr/CpBV8h5FzSHkbwWDVjIFHKA+TnSuja/v8ydXvJ
        1j1Cd57OLAKg32w+BOCbJeMhbw==
X-Google-Smtp-Source: APXvYqyfYZtFEfX174ftlYHDeWGBc3F1qtaSawY8bhsvv/6dzvhX7nZPeGrpdX3HrEkK+yBpAK2a0w==
X-Received: by 2002:a5d:5343:: with SMTP id t3mr7388380wrv.49.1555778706527;
        Sat, 20 Apr 2019 09:45:06 -0700 (PDT)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id u17sm13818956wmu.36.2019.04.20.09.45.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Apr 2019 09:45:05 -0700 (PDT)
Date:   Sat, 20 Apr 2019 18:45:03 +0200
From:   LABBE Corentin <clabbe@baylibre.com>
To:     shc_work@mail.ru
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] spi: clps711x: remove unused header
Message-ID: <20190420164503.GA28622@Red>
References: <1537384674-12280-1-git-send-email-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537384674-12280-1-git-send-email-clabbe@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 07:17:54PM +0000, Corentin Labbe wrote:
> include/linux/platform_data/spi-clps711x.h is unused since commit 6acaadc852f1 ("spi: clps711x: Driver refactor")
> Let's remove it.
> 

Hello

Gentle ping

Regards

> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  include/linux/platform_data/spi-clps711x.h | 21 ---------------------
>  1 file changed, 21 deletions(-)
>  delete mode 100644 include/linux/platform_data/spi-clps711x.h
> 
> diff --git a/include/linux/platform_data/spi-clps711x.h b/include/linux/platform_data/spi-clps711x.h
> deleted file mode 100644
> index 301956e63143..000000000000
> --- a/include/linux/platform_data/spi-clps711x.h
> +++ /dev/null
> @@ -1,21 +0,0 @@
> -/*
> - *  CLPS711X SPI bus driver definitions
> - *
> - *  Copyright (C) 2012 Alexander Shiyan <shc_work@mail.ru>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - */
> -
> -#ifndef ____LINUX_PLATFORM_DATA_SPI_CLPS711X_H
> -#define ____LINUX_PLATFORM_DATA_SPI_CLPS711X_H
> -
> -/* Board specific platform_data */
> -struct spi_clps711x_pdata {
> -	int *chipselect;	/* Array of GPIO-numbers */
> -	int num_chipselect;	/* Total count of GPIOs */
> -};
> -
> -#endif
> -- 
> 2.16.4
> 
