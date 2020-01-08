Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8DF4C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 20:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC5B320705
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 20:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578514683;
	bh=k29/a7uEuYqNAIhFsBFDfjAE0p9XzbeHTZjXgbV00jY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YqnjdRjWm2Yov4cf7w6iz+GKkXSBqpVD3piGtdyO7PF3p6IQlJwWVWm/VgiM1D9Mt
	 OjWsKuh0RJqjTltLrlVECS7OCFIDNZdwfblm4rYNwRArEjToQjLX/mSI8MTEQ/NWdq
	 qCgyIH06498B9sjky7xxeyaJKIEM5hIJyGtTM/Yk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbgAHUSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 15:18:02 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41132 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgAHUSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 15:18:02 -0500
Received: by mail-ot1-f68.google.com with SMTP id r27so4838859otc.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 12:18:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UM9Yhyyn+nTPYkkQGog0oC/YJwVnBTJCjtlyMYqJ2Ow=;
        b=YK4cLfj7OcGTCOMGd4+NthrodO1jG8NEW9eg+puUTcG6XhOG9kYk/A8/F0Jdx2vAxK
         GkOMmm2sfyc3UtYH5ijrr4ZygHxfWWpbWPsF6UoaN0HJhqOoa8FJk5iCQOYvPtXPRRv2
         6AlKdzL4bcFjl3kwrnL6IQRzRNXNBP/g8zwSmLL1HsJFcUTOQVd1bsLEUxAc/A6gEanS
         oxeSt5Y/eJdC97taQw/OcrOigb3Tmbe72GJ6TW/ApvhrwoaUC1rui7JkRVBnF/W4QrwC
         q1PG+n9I/SZqj1GWe0ABfycNdITGY0K5ZkWWPDNZLI/z/AKCB0LTZaz8U56hJqMElXIQ
         8Hlg==
X-Gm-Message-State: APjAAAVZRqCKHxvVVHMz4mwm33PGirsE35EPXDuVw+Xlu70PhqMCP+oV
        8zscvisvX40DyhU8L0mAZ9k+qd4=
X-Google-Smtp-Source: APXvYqx87qI5fGttDvLBk/HCFRXZdDmQcszWYJDZyrnpd0rQPuPNMSY1f65VchUWfdWvWuN6jf8kjA==
X-Received: by 2002:a9d:369:: with SMTP id 96mr5219243otv.228.1578514681284;
        Wed, 08 Jan 2020 12:18:01 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l17sm1519191ota.27.2020.01.08.12.18.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 12:18:00 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2208fa
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Wed, 08 Jan 2020 14:17:59 -0600
Date:   Wed, 8 Jan 2020 14:17:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org,
        netdev@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>,
        linux-mtd@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-i2c@vger.kernel.org
Subject: Re: [PATCH] treewide: remove redundent IS_ERR() before error code
 check
Message-ID: <20200108201759.GA28519@bogus>
References: <20200106045833.1725-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106045833.1725-1-masahiroy@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  6 Jan 2020 13:58:33 +0900, Masahiro Yamada wrote:
> 'PTR_ERR(p) == -E*' is a stronger condition than IS_ERR(p).
> Hence, IS_ERR(p) is unneeded.
> 
> The semantic patch that generates this commit is as follows:
> 
> // <smpl>
> @@
> expression ptr;
> constant error_code;
> @@
> -IS_ERR(ptr) && (PTR_ERR(ptr) == - error_code)
> +PTR_ERR(ptr) == - error_code
> // </smpl>
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  crypto/af_alg.c                      | 2 +-
>  drivers/acpi/scan.c                  | 2 +-
>  drivers/char/hw_random/bcm2835-rng.c | 2 +-
>  drivers/char/hw_random/omap-rng.c    | 4 ++--
>  drivers/clk/clk.c                    | 2 +-
>  drivers/dma/mv_xor_v2.c              | 2 +-
>  drivers/gpio/gpiolib-devres.c        | 2 +-
>  drivers/gpio/gpiolib-of.c            | 8 ++++----
>  drivers/gpio/gpiolib.c               | 2 +-
>  drivers/i2c/busses/i2c-mv64xxx.c     | 5 ++---
>  drivers/i2c/busses/i2c-synquacer.c   | 2 +-
>  drivers/mtd/ubi/build.c              | 2 +-
>  drivers/of/device.c                  | 2 +-
>  drivers/pci/controller/pci-tegra.c   | 2 +-
>  drivers/phy/phy-core.c               | 4 ++--
>  drivers/spi/spi-orion.c              | 3 +--
>  drivers/video/fbdev/imxfb.c          | 2 +-
>  fs/ext4/super.c                      | 2 +-
>  fs/f2fs/node.c                       | 2 +-
>  fs/ocfs2/suballoc.c                  | 2 +-
>  fs/sysfs/group.c                     | 2 +-
>  net/core/dev.c                       | 2 +-
>  net/core/filter.c                    | 2 +-
>  net/xfrm/xfrm_policy.c               | 2 +-
>  sound/soc/codecs/ak4104.c            | 3 +--
>  sound/soc/codecs/cs4270.c            | 3 +--
>  sound/soc/codecs/tlv320aic32x4.c     | 6 ++----
>  sound/soc/sunxi/sun4i-spdif.c        | 2 +-
>  28 files changed, 35 insertions(+), 41 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
