Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0221AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C421621900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWdhwFmB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbfCVP5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:57:09 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34217 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727169AbfCVP5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 11:57:09 -0400
Received: by mail-ed1-f68.google.com with SMTP id a16so2114076edn.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 08:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z0B/Cv0OnhJkmn5yNu2Lngwyw6MsW1iAP//0V/4H8MA=;
        b=fWdhwFmBzai3h75T33BkPtxtkUojOIqMf1qW+uTibrnf9acvxZ1DE9mDth643oDWYm
         Rmo65LQzLme41zkKyzHT5PQm+J1rcNDHcOKLzWrOhC6APh7SkJirsolV+FlG8PRXeXy/
         d18BbvSZZo9vEpakiPlbgTUP+s3IP/Ty6NKmaopDRrgEVzbrdmKgeJvcLogwdfGwQ2zA
         QJ13zxQZ4Ec6IcVGxhPvWq1Jekyw0PesbSjFXpNHyJcpfyGVk+Dgbf4B3z510/lgMK2b
         ariAKcIY3PSpic91DF1nQSmqzYscupH0Ao++VtROvhrGD/VmrjbWugy3C5kG3WzYQ6Pg
         l8zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z0B/Cv0OnhJkmn5yNu2Lngwyw6MsW1iAP//0V/4H8MA=;
        b=UW8UHmpYLisfpdDPvlMgICizDRTNoV1JARLS67/fLIS6LqfDyMPluxEaNYxuSNsEBh
         6e1+wDsv6Q9/Z+L6BtatUutC8xJYzj37Dk/H/gVn7DskygoC+eSlWw8gO+zsNHrgvo6s
         eAQ1FuSqWs2fsLZkDTxDe3VKxl1D0M5lsectUGGMzDf6eKaiyO1hzmdMZq8lw8Fy8W6S
         JIcbZg82QHPSwsm/1hH5M4W2jrCe7voFvPMGZ2E5HlQjNPYX1Es4FLWvHjGLapdpyu5c
         4w3E+3WywqWk1CD6oWG7V+28A6ftAhtzjJOKRs1RsuZqg3nU3ZlVeNfpjdsgZkrIzfE5
         woEQ==
X-Gm-Message-State: APjAAAUnWEIkUG73dMyTSKyj1A/tOrYFcZyiJWW9p83lgv3vb7Io6UZK
        kW5Kemq+eRCWfDMoMzbE0Ow=
X-Google-Smtp-Source: APXvYqygh09plWLmf9DAMtKMUKcnAkSP2gljgFn8zfTv7Ryk1ZdFgqEFkjZ73RJYbvGF68LA6pGrfg==
X-Received: by 2002:a17:906:6a82:: with SMTP id p2mr5987790ejr.212.1553270227287;
        Fri, 22 Mar 2019 08:57:07 -0700 (PDT)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id w24sm2645564edb.72.2019.03.22.08.57.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 22 Mar 2019 08:57:06 -0700 (PDT)
Date:   Fri, 22 Mar 2019 08:57:04 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Lee Jones <lee.jones@linaro.org>,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sapthagiri Baratam <sapthagiri.baratam@cirrus.com>,
        Colin Ian King <colin.king@canonical.com>,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: arizona: fix undefined behavior
Message-ID: <20190322155704.GC21978@archlinux-ryzen>
References: <20190322143345.1208144-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322143345.1208144-1-arnd@arndb.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 03:33:37PM +0100, Arnd Bergmann wrote:
> When the driver is used with a subdevice that is disabled in the
> kernel configuration, clang gets a little confused about the
> control flow and fails to notice that n_subdevs is only
> uninitialized when subdevs is NULL, and we check for that,
> leading to a false-positive warning:
> 
> drivers/mfd/arizona-core.c:1423:19: error: variable 'n_subdevs' is uninitialized when used here
>       [-Werror,-Wuninitialized]
>                               subdevs, n_subdevs, NULL, 0, NULL);
>                                        ^~~~~~~~~
> drivers/mfd/arizona-core.c:999:15: note: initialize the variable 'n_subdevs' to silence this warning
>         int n_subdevs, ret, i;
>                      ^
>                       = 0
> 
> Ideally, we would rearrange the code to avoid all those early
> initializations and have an explicit exit in each disabled case,
> but it's much easier to chicken out and add one more initialization
> here to shut up the warning.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Took me a bit to follow the flow of this function. I agree that without
restructuring it, zero initializing this variable to shut up the warning
is the path of least resistance (clang must evaluate variables in
isolation like I did until I fully read the commit message *facepalm*).

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
>  drivers/mfd/arizona-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/arizona-core.c b/drivers/mfd/arizona-core.c
> index 27b61639cdc7..0ca0fc9a67fd 100644
> --- a/drivers/mfd/arizona-core.c
> +++ b/drivers/mfd/arizona-core.c
> @@ -996,7 +996,7 @@ int arizona_dev_init(struct arizona *arizona)
>  	unsigned int reg, val;
>  	int (*apply_patch)(struct arizona *) = NULL;
>  	const struct mfd_cell *subdevs = NULL;
> -	int n_subdevs, ret, i;
> +	int n_subdevs = 0, ret, i;
>  
>  	dev_set_drvdata(arizona->dev, arizona);
>  	mutex_init(&arizona->clk_lock);
> -- 
> 2.20.0
> 
