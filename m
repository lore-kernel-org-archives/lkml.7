Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC426C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 21:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D28820881
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 21:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c3fd0VNH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730574AbfEVVaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 17:30:17 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36703 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730555AbfEVVaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 17:30:14 -0400
Received: by mail-pf1-f193.google.com with SMTP id v80so2008963pfa.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 14:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2TF5wBqEPfwtII57G09NFjtSOT12Df/ulltyqul+I94=;
        b=c3fd0VNHS3cYGt7G8Sp7oGuQYSCSl9nUiKz4FKDIdBvSerPKMwG0ATynQ9uHD8Ix1M
         wl7zZ1VRMKgx+UMw1dFR3DEIH2gN3AjoJtfN6Vp1UvzDGpl8jCGTsWLqOWV/GwOV/Joy
         E/c8qwIDZbBYucklsCw5E4Ieo1MjJa3LBoG8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2TF5wBqEPfwtII57G09NFjtSOT12Df/ulltyqul+I94=;
        b=UGhfxbAg4yWZJ86JyXxNxexwmLjuds14ywGbve0TVSoyl/xOjw6DFKnlTvtjLIlLd7
         JLBrhxaIj+uUF8M4tV6orUFOJ6Uv4RMlqcxPR3zb/m12iecdDP5wCEhy/psQzT0xEOZv
         cVbunwtGRpNFAHmqWVbV5f1s84+GbN3AT8Uhfl7ZU2WChWNh93vPoAlEZ9XIeeKdjvBB
         EsDxSmJIdM/8JXmy6VctUbrQI2Vld9j0OPjXfk7ny0bf8BfHQDPik2H+4yltiCALml0N
         9lY25pt4R3REo4KaIawjSyBEYZPlWX285+GdX6III43m/LdWtgOGHZCzXFU1U9rFKTV6
         nk5Q==
X-Gm-Message-State: APjAAAUZXfv8R88R/qgK44Bf9cazoOBTcHMt3ub0E109jQx8xrAb8A32
        4Vf9s/jM8atWJZNDPN7IDTqkSg==
X-Google-Smtp-Source: APXvYqwGE8AikMohimZx119rGA4H9lW54C3uhROo02kUeuAING4Gdsj67jSdqEUttHH1Ci2yIOoMjg==
X-Received: by 2002:a62:86c4:: with SMTP id x187mr15083928pfd.34.1558560613248;
        Wed, 22 May 2019 14:30:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d186sm26750721pgc.58.2019.05.22.14.30.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 May 2019 14:30:12 -0700 (PDT)
Date:   Wed, 22 May 2019 14:30:11 -0700
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
Subject: Re: [PATCH] mtd: onenand_base: Avoid fall-through warnings
Message-ID: <201905221403.642AF6092@keescook>
References: <20190522180446.GA30082@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522180446.GA30082@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for being late to speaking up on this. I missed something in the
code the first time I read the thread, that now stood out to me. Notes
below...

On Wed, May 22, 2019 at 01:04:46PM -0500, Gustavo A. R. Silva wrote:
> diff --git a/drivers/mtd/nand/onenand/onenand_base.c b/drivers/mtd/nand/onenand/onenand_base.c
> index f41d76248550..6cf4df9f8c01 100644
> --- a/drivers/mtd/nand/onenand/onenand_base.c
> +++ b/drivers/mtd/nand/onenand/onenand_base.c
> @@ -3280,12 +3280,14 @@ static void onenand_check_features(struct mtd_info *mtd)

Reverse-order review, second hunk first:

>  	case ONENAND_DEVICE_DENSITY_2Gb:
>  		/* 2Gb DDP does not have 2 plane */
>  		if (!ONENAND_IS_DDP(this))
>  			this->options |= ONENAND_HAS_2PLANE;
>  		this->options |= ONENAND_HAS_UNLOCK_ALL;
> +		/* Fall through - ? */
>  
>  	case ONENAND_DEVICE_DENSITY_1Gb:
>  		/* A-Die has all block unlock */

So, I think the ONENAND_DEVICE_DENSITY_2Gb should be a "break". Though,
actually, it doesn't matter:

        case ONENAND_DEVICE_DENSITY_2Gb:
                /* 2Gb DDP does not have 2 plane */
                if (!ONENAND_IS_DDP(this))
                        this->options |= ONENAND_HAS_2PLANE;
                this->options |= ONENAND_HAS_UNLOCK_ALL;

        case ONENAND_DEVICE_DENSITY_1Gb:
                /* A-Die has all block unlock */
                if (process)
                        this->options |= ONENAND_HAS_UNLOCK_ALL;
                break;

Falling through from ONENAND_DEVICE_DENSITY_2Gb to
ONENAND_DEVICE_DENSITY_1Gb will actually have no side-effects:
ONENAND_HAS_UNLOCK_ALL was unconditionally set in ..._2Gb, so there is
no reason to fall through to ..._1Gb. (But falling through is harmless.)

Now the first hunk:

>  			if ((this->version_id & 0xf) == 0xe)
>  				this->options |= ONENAND_HAS_NOP_1;
>  		}
> +		/* Fall through - ? */
>  

        case ONENAND_DEVICE_DENSITY_4Gb:
                if (ONENAND_IS_DDP(this))
                        this->options |= ONENAND_HAS_2PLANE;
                else if (numbufs == 1) {
                        this->options |= ONENAND_HAS_4KB_PAGE;
                        this->options |= ONENAND_HAS_CACHE_PROGRAM;
                        /*
                         * There are two different 4KiB pagesize chips
                         * and no way to detect it by H/W config values.
                         *
                         * To detect the correct NOP for each chips,
                         * It should check the version ID as workaround.
                         *
                         * Now it has as following
                         * KFM4G16Q4M has NOP 4 with version ID 0x0131
                         * KFM4G16Q5M has NOP 1 with versoin ID 0x013e
                         */
                        if ((this->version_id & 0xf) == 0xe)
                                this->options |= ONENAND_HAS_NOP_1;
                }

Falling through from ONENAND_DEVICE_DENSITY_4Gb to
ONENAND_DEVICE_DENSITY_2Gb looks like it would mean that
ONENAND_HAS_2PLANE would be unconditionally set for ...4Gb, which seems
very strange to expect:

                if (ONENAND_IS_DDP(this))
                        this->options |= ONENAND_HAS_2PLANE;
...
                if (!ONENAND_IS_DDP(this))
                        this->options |= ONENAND_HAS_2PLANE;

However! This happens later:

        if (ONENAND_IS_4KB_PAGE(this))
                this->options &= ~ONENAND_HAS_2PLANE;

i.e. falling through to ...2Gb (which sets ONENAND_HAS_2PLANE) has no
effect because when ONENAND_HAS_2PLANE isn't set (numbufs == 1), it gets
_cleared_ by the above code due to ONENAND_HAS_4KB_PAGE getting set:

#define ONENAND_IS_4KB_PAGE(this) \
        (this->options & ONENAND_HAS_4KB_PAGE)


Unfortunately, though, it's less clear about ONENAND_HAS_UNLOCK_ALL,
which is getting set unconditionally for ...4Gb currently (due to the
fallthrough to ...2Gb). However, this happens later:

        if (FLEXONENAND(this)) {
                this->options &= ~ONENAND_HAS_CONT_LOCK;
                this->options |= ONENAND_HAS_UNLOCK_ALL;
        }
...
#define FLEXONENAND(this) \
        (this->device_id & DEVICE_IS_FLEXONENAND)

So it's possible this fall through has no effect (are all 4Gb density
devices also FLEXONENAND devices?)

Setting a "break" after 4Gb may remove ONENAND_HAS_UNLOCK_ALL in the
!FLEXONENAND(this) case. Does anyone have real hardware to test with?

Thoughts?

-- 
Kees Cook
