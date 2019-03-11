Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9382C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 965D620657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="OtGfH3VQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbfCKOGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 10:06:40 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37686 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727485AbfCKOGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 10:06:40 -0400
Received: by mail-qt1-f193.google.com with SMTP id z17so5127531qtn.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 07:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e2/FNk3QWxKCUMpXFddWgL1d9mKg0cwp5ncD3YoYXOc=;
        b=OtGfH3VQXfXdDaYpXqwHOXqbxHTEfZyCsVXIz6uHDhoKvWwcNd77RBsGDDsxDyZZDd
         3dSzKeOa7ZTbzxvhr+UUg+6ynb7fQCSfWSpszEqiz3cfS1xOddxpvtaZsjX3KiOS5DDu
         tFW/J0+M07IIVCR15V0hK0ARVmnXBRrUA/f2nZUUGbAI/7F7mIAKmN4i2zfESXJxacBG
         3W1X6n7lrq8KcDJbvOGwpPy4qi0EXB2G2JIYp6KfRW3tqxTAEw7PABZdoPAsAFM9dSKQ
         zCM+7ko1u4aGED6uH8Azbo/0xcMNOr5V5E18Ev1zGK/091Y+LEhi05dNCduG4CxXJr2C
         nV+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e2/FNk3QWxKCUMpXFddWgL1d9mKg0cwp5ncD3YoYXOc=;
        b=fyE26P1nkWexZAqaGR9GHMZwYp5916CTSZ6UGlHKFXitczTrt86hYEJZGecqfcPQob
         +e8i4lxIlEAWQly4gBnQI0blpHrhSXKM/DdfmGewMDfFJWVD0BnaR3uVQYWRj6ElCXRc
         1Gx0hSZ1BsKU8eSlZhJmch/88W54Qm7uNzKfXqsl7rFrpshFmozMt80X2V9v0rCjoV4R
         pQ5q1kawwE1P51VZSxOUC3w24irU4EyXFLp9+UsHsOS+W7+ELiF5b4+fVXU0ilOrmV3F
         tyYeeuQrJDMFVho+EfWyuUd8ef4CkhIJHSs7ubyD1NymzDvMBi7nU3un1/vVKBnrcsqN
         jUkg==
X-Gm-Message-State: APjAAAV4xyjUEE8umx5Fkpe5VNzoejEWdQK0uDpeT9seUSmhDB8VLBgO
        QcGLOB/eqXUHpYk8b4paxbYxkg==
X-Google-Smtp-Source: APXvYqwI7HcPKD6H7N12Kb5oiNYjpL7/3yB9YI9uv08kS7gh0qzFRR4r5BwkCnXOufoZTfy4p35M5w==
X-Received: by 2002:a0c:9910:: with SMTP id h16mr26247230qvd.245.1552313198978;
        Mon, 11 Mar 2019 07:06:38 -0700 (PDT)
Received: from ziepe.ca ([24.137.65.181])
        by smtp.gmail.com with ESMTPSA id h18sm3116883qkj.50.2019.03.11.07.06.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 07:06:38 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1h3LZd-0002CM-5h; Mon, 11 Mar 2019 11:06:37 -0300
Date:   Mon, 11 Mar 2019 11:06:37 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Saeed Mahameed <saeedm@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: mlx5: fix a potential NULL pointer dereference
Message-ID: <20190311140637.GI22848@ziepe.ca>
References: <20190311063343.20188-1-kjlu@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311063343.20188-1-kjlu@umn.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 01:33:43AM -0500, Kangjie Lu wrote:
> In case skb_header_pointer fails, the fix issues a warning.
> 
> A better fix requires modifying the signature of mlx5e_get_fcs to
> pass an error code upstream.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
>  drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> index be396e5e4e39..6ec1c110e4be 100644
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> @@ -719,6 +719,8 @@ static u32 mlx5e_get_fcs(const struct sk_buff *skb)
>  
>  	fcs_bytes = skb_header_pointer(skb, skb->len - ETH_FCS_LEN,
>  				       ETH_FCS_LEN, &_fcs_bytes);
> +	if (unlikely(!fcs_bytes))
> +		pr_warn_once("skb_header_pointer returns NULL\n");

This is really pointless. Fix stuff like this so it doesn't oops or
don't bother.

Jason

>  	return __get_unaligned_cpu32(fcs_bytes);
>  }
