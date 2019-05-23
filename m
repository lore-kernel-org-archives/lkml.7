Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F784C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 20:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FF3520881
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 20:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aLLq1LPw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387715AbfEWUR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 16:17:28 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37669 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387454AbfEWUR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 16:17:28 -0400
Received: by mail-pf1-f193.google.com with SMTP id a23so3862783pff.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 13:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=SKLfhxDoCRYR8fbnF7GjoyQ7RxwPbketJUbGs3MbAvM=;
        b=aLLq1LPweL6v0NH0VzQsv/BdtOsCHUN+j8yEfKUuVosEi0AqLpqAgpOLM8CllMCFKs
         vZRd37/nw+m9uPkEqnyYU1+ft7yxHDmrKbt1VA66p+R+VPQpHLWUjoCMp475R4NileNN
         82hluF0iQardeJLlE3QARGTtij8YOXiEWItfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=SKLfhxDoCRYR8fbnF7GjoyQ7RxwPbketJUbGs3MbAvM=;
        b=QXLo827Rra5WjUbZnv7NS6UJIbanHrEMUP2ea1A0pbp5sgPm22AOAfUez5TlkofUKN
         zYKVatWCN0L+6D7ZuuYEPpaxjrT/YA5KjaABRNQ2aGfIiizomo5vxujKN5O8WCr9UBsE
         v7pHfbyvABtlc61N+KRFcHJl7AnmeXZ0bzgglc7ExPO/SieFZgMBWEUbwfZC/EUNSv/4
         TcWndFOpSgYStlI+7COx2zzjy+sfRm4A0Q8F92VzAc8iXMCH/qejkUlPvKcWa49dyvlE
         lqYnfY7oGgobPjtzYbGECIsFR5E6aasBjQKZgIbYH8mcxxDRcRdJ4NhJAOmzVnnGNVhr
         TPvg==
X-Gm-Message-State: APjAAAUnCowc7o8/g562vOZMok8dZJx5TsPLjYGi8qKFOci/Ly4vsZLy
        IqxiVWq/f2pWg1intpPvCGUbNg==
X-Google-Smtp-Source: APXvYqwK/wF9Kj//m0nPMhMHL9Re2ZbD4eTXDat4hg+nF2y3ZlFqGfW81QDITVyEItJ1+/dZvmov0A==
X-Received: by 2002:a62:62c1:: with SMTP id w184mr105268547pfb.95.1558642647484;
        Thu, 23 May 2019 13:17:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h62sm186703pgc.77.2019.05.23.13.17.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 13:17:26 -0700 (PDT)
Date:   Thu, 23 May 2019 13:17:25 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mtd: onenand_base: Avoid fall-through warnings
Message-ID: <201905231316.97C0BBF15@keescook>
References: <20190523191606.GA9838@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190523191606.GA9838@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 02:16:06PM -0500, Gustavo A. R. Silva wrote:
> NOTICE THAT:
> 
> "...we don't know whether we need fallthroughs or breaks here and this
> is just a change to avoid having new warnings when switching to
> -Wimplicit-fallthrough but this change might be entirely wrong."[1]
> 
> See the original thread of discussion here:
> 
> https://lore.kernel.org/patchwork/patch/1036251/
> 
> So, in preparation to enabling -Wimplicit-fallthrough, this patch silences
> the following warnings:
> 
> drivers/mtd/nand/onenand/onenand_base.c: In function ‘onenand_check_features’:
> drivers/mtd/nand/onenand/onenand_base.c:3264:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    if (ONENAND_IS_DDP(this))
>       ^
> drivers/mtd/nand/onenand/onenand_base.c:3284:2: note: here
>   case ONENAND_DEVICE_DENSITY_2Gb:
>   ^~~~
> drivers/mtd/nand/onenand/onenand_base.c:3288:17: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    this->options |= ONENAND_HAS_UNLOCK_ALL;
> drivers/mtd/nand/onenand/onenand_base.c:3290:2: note: here
>   case ONENAND_DEVICE_DENSITY_1Gb:
>   ^~~~
> 
> Warning level 3 was used: -Wimplicit-fallthrough=3
> 
> Also, notice that this patch doesn't change any functionality. See the
> most recent thread of discussion here:
> 
> https://lore.kernel.org/patchwork/patch/1077395/
> 
> This patch is part of the ongoing efforts to enable
> -Wimplicit-fallthrough.
> 
> [1] https://lore.kernel.org/lkml/20190509085318.34a9d4be@xps13/
> 
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
> Suggested-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

Thanks for updating this!

> ---
> Changes in v2:
>  - Add breaks instead of fall-through markings without altering any
>    functionality.
>  - Update changelog text.
> 
>  drivers/mtd/nand/onenand/onenand_base.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mtd/nand/onenand/onenand_base.c b/drivers/mtd/nand/onenand/onenand_base.c
> index f41d76248550..fd0da5c347db 100644
> --- a/drivers/mtd/nand/onenand/onenand_base.c
> +++ b/drivers/mtd/nand/onenand/onenand_base.c
> @@ -3280,12 +3280,15 @@ static void onenand_check_features(struct mtd_info *mtd)
>  			if ((this->version_id & 0xf) == 0xe)
>  				this->options |= ONENAND_HAS_NOP_1;
>  		}
> +		this->options |= ONENAND_HAS_UNLOCK_ALL;
> +		break;
>  
>  	case ONENAND_DEVICE_DENSITY_2Gb:
>  		/* 2Gb DDP does not have 2 plane */
>  		if (!ONENAND_IS_DDP(this))
>  			this->options |= ONENAND_HAS_2PLANE;
>  		this->options |= ONENAND_HAS_UNLOCK_ALL;
> +		break;
>  
>  	case ONENAND_DEVICE_DENSITY_1Gb:
>  		/* A-Die has all block unlock */
> -- 
> 2.21.0
> 

-- 
Kees Cook
