Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912ACC74A45
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 04:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65DF021670
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 04:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech-se.20150623.gappssmtp.com header.i=@ragnatech-se.20150623.gappssmtp.com header.b="DYpUQkWd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbfGKEkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 00:40:37 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36546 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728285AbfGKEkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 00:40:31 -0400
Received: by mail-pf1-f195.google.com with SMTP id r7so2131758pfl.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 21:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=s0bvr757x/HKgrr4SbWQu6+ri+feUWUbw08Pt9QAMgg=;
        b=DYpUQkWdlDtQn6Fhy6+8tVMVE8yop90FkZt4Dtb69W5juQjpRM2mwMpVBKMc44Hyds
         O//APATsYeHnfMQEcPtYlljgmsP+mcWKGpYTxoeKL63s1iuHt7lIngrC+J+LH4ibuKZq
         S37m/GvoHuaxwaNzqwNza14matP7/YQlq+ZasImTcwEMj4EXtLcdNa0CUMyD6OTvYOCu
         ytJTSIkh6qimYgWl/UJprVq3v8vQGm9nttmtoYGteQcYp4zpqdfZkJC1OJX3We6vo7d5
         OjMUJXS0mRpNy3ZqWS+raPPQRsyfxzIIKvz7/YdV6ReaiAvXeqvetTolVo1diGiutqmk
         rtGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=s0bvr757x/HKgrr4SbWQu6+ri+feUWUbw08Pt9QAMgg=;
        b=fXctg5JH1N440zxVs9GR2gpbiMZ/XbbxJCgfylyXqjlXzwb1StgwSmZVfrTXiAUQ4C
         C7USF2iE35U65dkaPSaz+GO4fMrVi176TTdsGvE06aHQsfdcc9ZijpAr0gJy2fPnblSc
         Ojomg0q/N1+1heq4v30OiG8BBiZDwVN7diXGE3umEtcUCwxkagUnLFo52vmd1sntH+mP
         6ZYkRM59qlMV0aneReaqVNhHCXRxMnVmaBbbCjRmjx3rxVyS/42yiyRQj1ITSA9DGX7I
         Gy7+ixn8gYosiwGfOaDWn4y/9bksf7BoLeIwIjvw3ikd3EYn7KKaaYMri1phleqYNYdH
         Bn/w==
X-Gm-Message-State: APjAAAWO6FUbdjOTrUtIuSYpmGZjLmIfowYlvneSAIs2Pw+YWMPLgzHR
        f1DZR5fLjL+ZtsKb+O0yulk=
X-Google-Smtp-Source: APXvYqwlQpsbmXVpeN6NqHngMcXHiN6TsPBlygpq4xNU3S/XaZ+hBwUMo6avXye+V8k/sqLQkWu2kA==
X-Received: by 2002:a63:6fc9:: with SMTP id k192mr2204626pgc.20.1562820031052;
        Wed, 10 Jul 2019 21:40:31 -0700 (PDT)
Received: from localhost (softbank126163157105.bbtec.net. [126.163.157.105])
        by smtp.gmail.com with ESMTPSA id v8sm3363164pgs.82.2019.07.10.21.40.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 10 Jul 2019 21:40:30 -0700 (PDT)
Date:   Thu, 11 Jul 2019 13:40:27 +0900
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa@the-dreams.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] media: i2c: adv748x: Convert to new i2c device probe()
Message-ID: <20190711044027.GG1557@wyvern>
References: <20190710123719.3376-1-kieran.bingham+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190710123719.3376-1-kieran.bingham+renesas@ideasonboard.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran,

Thanks for your patch.

On 2019-07-10 13:37:19 +0100, Kieran Bingham wrote:
> The I2C core framework provides a simplified probe framework from commit
> b8a1a4cd5a98 ("i2c: Provide a temporary .probe_new() call-back type").
> 
> Convert the ADV748x to utilise this simplfied i2c driver registration.
> 
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

Looks good,

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
>  drivers/media/i2c/adv748x/adv748x-core.c | 13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/media/i2c/adv748x/adv748x-core.c b/drivers/media/i2c/adv748x/adv748x-core.c
> index 097e94279cf7..ae2b6eb93e09 100644
> --- a/drivers/media/i2c/adv748x/adv748x-core.c
> +++ b/drivers/media/i2c/adv748x/adv748x-core.c
> @@ -677,8 +677,7 @@ static void adv748x_dt_cleanup(struct adv748x_state *state)
>  		of_node_put(state->endpoints[i]);
>  }
>  
> -static int adv748x_probe(struct i2c_client *client,
> -			 const struct i2c_device_id *id)
> +static int adv748x_probe(struct i2c_client *client)
>  {
>  	struct adv748x_state *state;
>  	int ret;
> @@ -806,13 +805,6 @@ static int adv748x_remove(struct i2c_client *client)
>  	return 0;
>  }
>  
> -static const struct i2c_device_id adv748x_id[] = {
> -	{ "adv7481", 0 },
> -	{ "adv7482", 0 },
> -	{ },
> -};
> -MODULE_DEVICE_TABLE(i2c, adv748x_id);
> -
>  static const struct of_device_id adv748x_of_table[] = {
>  	{ .compatible = "adi,adv7481", },
>  	{ .compatible = "adi,adv7482", },
> @@ -825,9 +817,8 @@ static struct i2c_driver adv748x_driver = {
>  		.name = "adv748x",
>  		.of_match_table = adv748x_of_table,
>  	},
> -	.probe = adv748x_probe,
> +	.probe_new = adv748x_probe,
>  	.remove = adv748x_remove,
> -	.id_table = adv748x_id,
>  };
>  
>  module_i2c_driver(adv748x_driver);
> -- 
> 2.20.1
> 

-- 
Regards,
Niklas Söderlund
