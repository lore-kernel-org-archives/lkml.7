Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A02C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 14:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFA2223DD4
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 14:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iSRYrtqf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbfFDOpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 10:45:18 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43819 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727385AbfFDOpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 10:45:18 -0400
Received: by mail-pf1-f193.google.com with SMTP id i189so825822pfg.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 07:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=8kQJWWH20FmLV+D34/UlcFgcPuTQNqFlHhk2FqlLjKs=;
        b=iSRYrtqfNi6ssM9SlZbA4fGmokaRJAsxkcVcpGY8CiLBP2/HVranJB8xgQTGQA6DaH
         O6L0th9lpChMb0EBf5YxHaQLdDW9XRX1b1ADBlqSE27ssjDmRsQoTafplh4fksvVamKB
         2qPTWaA1GZhjZY+VkCuquleMbIT3Af1MhAzHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=8kQJWWH20FmLV+D34/UlcFgcPuTQNqFlHhk2FqlLjKs=;
        b=dVxXVt2q565ds8OReBrI8M+1nRU0ibG1W1JH42IpNe5Ho5mkRRlQhOZesnQBHkuOfR
         f+gNQdcWxzd4yElT1n5KWQn/AQdEx5Mr9bQcBjaT2aY7BCXkEB5POt3+H0ltEqgFM1PT
         F4sOhS4u9LHjogVtv0kGPskVkqeb24pwvpVagVCS1W57JCInT5Lo4XH9fuv3LYaXQhIZ
         zpagExmgFRxvLWK0Rysu4dsXqc0beOtt5ueZgs643F4ambPd5Q6sPv43586FPRejTN9C
         dKIyoQjpUoBSLiQtUe2ZbMTIfnXmAog2Awk+W/LbwSeTA9BwGKJ27Io2Ya17dXWVO5wD
         7jQQ==
X-Gm-Message-State: APjAAAWpM5uA3xebcpOk1+LzZySnf9RSIBuLZNy34GjdwZ2ZUV71pR23
        0H5NvYU8qmxY2UYNuIIXgWqFwg==
X-Google-Smtp-Source: APXvYqx9qVDV0aL129br1HvP76lImRIInL1ekOewwGewtN2/L6DHIclTxW/oSrWDb0LEZ2FL+WFJgQ==
X-Received: by 2002:a62:6d47:: with SMTP id i68mr39283857pfc.189.1559659517462;
        Tue, 04 Jun 2019 07:45:17 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k22sm7663683pfk.178.2019.06.04.07.45.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Jun 2019 07:45:16 -0700 (PDT)
Date:   Tue, 4 Jun 2019 07:45:15 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jonathan Bakker <xc-racer2@live.ca>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: onenand_base: Mark expected switch fall-through
Message-ID: <201906040745.B6AE4C6@keescook>
References: <20190604141737.GA1064@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190604141737.GA1064@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 09:17:37AM -0500, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> This patch fixes the following warning:
> 
> drivers/mtd/nand/onenand/onenand_base.c: In function ‘onenand_check_features’:
> drivers/mtd/nand/onenand/onenand_base.c:3264:17: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    this->options |= ONENAND_HAS_NOP_1;
> drivers/mtd/nand/onenand/onenand_base.c:3265:2: note: here
>   case ONENAND_DEVICE_DENSITY_4Gb:
>   ^~~~
> 
> Warning level 3 was used: -Wimplicit-fallthrough=3
> 
> This patch is part of the ongoing efforts to enable
> -Wimplicit-fallthrough.
> 
> Cc: Jonathan Bakker <xc-racer2@live.ca>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/mtd/nand/onenand/onenand_base.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mtd/nand/onenand/onenand_base.c b/drivers/mtd/nand/onenand/onenand_base.c
> index ba46d0cf60a1..bdb5f4733d28 100644
> --- a/drivers/mtd/nand/onenand/onenand_base.c
> +++ b/drivers/mtd/nand/onenand/onenand_base.c
> @@ -3262,6 +3262,7 @@ static void onenand_check_features(struct mtd_info *mtd)
>  	switch (density) {
>  	case ONENAND_DEVICE_DENSITY_8Gb:
>  		this->options |= ONENAND_HAS_NOP_1;
> +		/* fall through */
>  	case ONENAND_DEVICE_DENSITY_4Gb:
>  		if (ONENAND_IS_DDP(this))
>  			this->options |= ONENAND_HAS_2PLANE;
> -- 
> 2.21.0
> 

-- 
Kees Cook
