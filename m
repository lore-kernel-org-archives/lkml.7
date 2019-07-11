Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3351C74A46
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 06:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 747F320872
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 06:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dev-mellanox-co-il.20150623.gappssmtp.com header.i=@dev-mellanox-co-il.20150623.gappssmtp.com header.b="BcNT1qKA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbfGKGCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 02:02:14 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43004 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727636AbfGKGCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 02:02:13 -0400
Received: by mail-lj1-f195.google.com with SMTP id t28so4467912lje.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 23:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dev-mellanox-co-il.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5wfpCOZ83nI7HCRBNZYdSqgK08vpf3gVcSTnau6UYac=;
        b=BcNT1qKADluKUbaLesg1b4t+d4/iFYu5N8uvYFQrG2v7R4F/dqtkef3BhfnifY1XED
         uXCUzTzxiPb8fHnKmsGuGRQSGqeTp3WhYhS0adjv8D/cAjxgmZqFEd8Za/ZVPdpDzwAz
         Pko4W66+AGPjlyfXom/A7dW0sv9+sMcG+UTLB8cYN4Fz6E4e40Uf758G3DOP7j1kVNms
         a39z8cLDtR3qDXhyIsdfPJ2CWxz7Y42b4yEo+vifNNaraJ/Wx8T/bh3xYto7nl3I8waI
         BM7pf6kV+6OcUTwokyPlJQPiarEVIiVFwMn9Q341AoonwERkgPQA5aL7NyG3h+5U8ZaM
         O1og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5wfpCOZ83nI7HCRBNZYdSqgK08vpf3gVcSTnau6UYac=;
        b=iQY+XVQL7ES248Q7oY4qnEhwrjuq/JbxPDdwhenwD1itHZJLahfc5V6AnnY6ofKAwC
         +2w8tJYC2V3NCgk+/6Fe03vLTR+IUWoZyeT9Ivw5JY/Ju8TfzNBgjFBC/+Gwkr71Q8gP
         cm4yIWX+V+4lIIYfqBPznEtRrIYbKKiXaGc4yduHSWLvdWgKFBul4+f7pF9niwyPXneJ
         5E4aWm/E3UoKGYjhhA1tYpAV1mWphszwfU2z5lEMfEV/C5trh3ulUSiShFvTZoNPTkQD
         /fgE6eZdU5XrxKYXjHvvChhErvoTx8ZdztAD1YjyDiQ2ynOCh5jPHpd3+W3s9AAKQOE6
         xWbQ==
X-Gm-Message-State: APjAAAU04juCoyoHJz3AXAOioZEyA2z6IY2npFRwklOP/OBK0Ngcor4A
        v8aZXY6SCzZqq/bbmWpZzyuaXPgitRMu7Q9IpGY=
X-Google-Smtp-Source: APXvYqw/SKkWcDJJYhzh9Foxv18y0Hev4hCuXDzlEy58M1Sxo6DuPPrWfqWCtEi7kWCI77FTG7mPXUosCqvzTtc9cBI=
X-Received: by 2002:a2e:3604:: with SMTP id d4mr1227030lja.85.1562824931191;
 Wed, 10 Jul 2019 23:02:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190710190502.104010-1-natechancellor@gmail.com>
In-Reply-To: <20190710190502.104010-1-natechancellor@gmail.com>
From:   Saeed Mahameed <saeedm@dev.mellanox.co.il>
Date:   Wed, 10 Jul 2019 23:02:00 -0700
Message-ID: <CALzJLG9Aw=sVPDiewHr+4Jiuaod_1q=10vzMzCUVg-rCCXD6cQ@mail.gmail.com>
Subject: Re: [PATCH] net/mlx5e: Move priv variable into case statement in mlx5e_setup_tc
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Saeed Mahameed <saeedm@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Netdev List <netdev@vger.kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 12:05 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> There is an unused variable warning on arm64 defconfig when
> CONFIG_MLX5_ESWITCH is unset:
>
> drivers/net/ethernet/mellanox/mlx5/core/en_main.c:3467:21: warning:
> unused variable 'priv' [-Wunused-variable]
>         struct mlx5e_priv *priv = netdev_priv(dev);
>                            ^
> 1 warning generated.
>
> Move it down into the case statement where it is used.
>
> Fixes: 4e95bc268b91 ("net: flow_offload: add flow_block_cb_setup_simple()")
> Link: https://github.com/ClangBuiltLinux/linux/issues/597
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> index 6d0ae87c8ded..651eb714eb5b 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> @@ -3464,15 +3464,16 @@ static LIST_HEAD(mlx5e_block_cb_list);
>  static int mlx5e_setup_tc(struct net_device *dev, enum tc_setup_type type,
>                           void *type_data)
>  {
> -       struct mlx5e_priv *priv = netdev_priv(dev);
> -
>         switch (type) {
>  #ifdef CONFIG_MLX5_ESWITCH
> -       case TC_SETUP_BLOCK:
> +       case TC_SETUP_BLOCK: {
> +               struct mlx5e_priv *priv = netdev_priv(dev);
> +
>                 return flow_block_cb_setup_simple(type_data,
>                                                   &mlx5e_block_cb_list,
>                                                   mlx5e_setup_tc_block_cb,
>                                                   priv, priv, true);
> +       }

Hi Nathan,

We have another patch internally that fixes this, and it is already
queued up in my queue.
it works differently as we want to pass priv instead of netdev to
mlx5e_setup_tc_mqprio below,
which will also solve warning ..

So i would like to submit that patch if it is ok with you ?

>  #endif
>         case TC_SETUP_QDISC_MQPRIO:
>                 return mlx5e_setup_tc_mqprio(dev, type_data);
> --
> 2.22.0
>
