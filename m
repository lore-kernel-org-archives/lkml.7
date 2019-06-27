Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6822CC4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 23:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35EB9208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 23:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dev-mellanox-co-il.20150623.gappssmtp.com header.i=@dev-mellanox-co-il.20150623.gappssmtp.com header.b="cywHBuyG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfF0XAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 19:00:06 -0400
Received: from mail-lf1-f43.google.com ([209.85.167.43]:39916 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbfF0XAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 19:00:03 -0400
Received: by mail-lf1-f43.google.com with SMTP id p24so2670650lfo.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 16:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dev-mellanox-co-il.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hlkWLIAXD/X1/Rol3Kp/jDc7fHX/O8gfTPi+EszwxMk=;
        b=cywHBuyGo6Bo8Pe0YgCNqDTgGJXYeW2qfryVIdoqHLuFB6yVVqj4P4FcYcesoQD+m5
         TH+oD3vLkdsTZjS7ipHAHxbrFPfsWa/I0k3IFc0KXP9sFx57JS1JKyJZOhCjqg5cfHiB
         Q+KdkYr3u9lzZAKNwJ6Yx/l3qrJiwLxSJZJ13O61YI+bR/IzNi1EO1hJd8FI2St30Gju
         84q4N6104fdJmZ0apSLhS7IkHbW3xo3/iZdts4nWc6wgla3KR7MQBxoDL6I4DP67jooz
         pzsfcKWnggz7Gx/7O1BGpZPyThLAoMi+Exa2uxy0zBpn18UwNlFwKEQ8PW/AODf4F122
         af5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hlkWLIAXD/X1/Rol3Kp/jDc7fHX/O8gfTPi+EszwxMk=;
        b=LDCeA2klGMI5Yp8C/D9x9lHfB1MFhRds9yFUKxX6s4ILss7rn5QSxQQ/OybpQOZRYO
         vIV69I5dmMaN2RjTLpKguBBVa5uj8jBnCWF6mDZJp+1cO+ts8C2mN86XMYDYzrZ6xs26
         BFSgU/YedOFLhHuH5Hxf7K/MG4mdbsA4hWt8LgiRQWqPlaYIvRdyzgZwmYLI1PyVQk9B
         KiwVYyYW5UJiasvMiItkKPJrn247J/jd+nuVu0tGYIAcUudlwaxcoZ5Zzf0Y5v5hMgm+
         hY2J69dAWNzC1jZpXP+LjiKeTuhzimpOpnthtLhFSB2CJAgX7miLYa7FStbyAVBlCP3x
         s7GA==
X-Gm-Message-State: APjAAAX+kLeIYD3/Hb+CX4q0nqf6fONnnoMruir+J50x/rZYFJch2wjc
        0V2zInmHxJuUAAjusqT+d2Ih2Y1AzDPT7GRtbD0qSw==
X-Google-Smtp-Source: APXvYqwDjhyAm/JnXPDZNdNiwHLoYgZLNOeH0iN1jwqCMcd99dUJxH9I59IhGTbrF+XNbuezHXXX+OBkXWphnKAhluQ=
X-Received: by 2002:ac2:518d:: with SMTP id u13mr3366240lfi.40.1561676401476;
 Thu, 27 Jun 2019 16:00:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190627140929.74ae7da6@canb.auug.org.au>
In-Reply-To: <20190627140929.74ae7da6@canb.auug.org.au>
From:   Saeed Mahameed <saeedm@dev.mellanox.co.il>
Date:   Thu, 27 Jun 2019 15:59:50 -0700
Message-ID: <CALzJLG9pmK-OPK1+iVkKWkKPvPUf0icFKZuUojJej7WR1BtV3w@mail.gmail.com>
Subject: Re: linux-next: manual merge of the mlx5-next tree with the net-next tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Leon Romanovsky <leon@kernel.org>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yevgeny Kliteynik <kliteyn@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Eli Britstein <elibr@mellanox.com>,
        Jianbo Liu <jianbol@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 9:09 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the mlx5-next tree got a conflict in:
>
>   drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
>
> between commits:
>
>   955858009708 ("net/mlx5e: Fix number of vports for ingress ACL configuration")
>   d4a18e16c570 ("net/mlx5e: Enable setting multiple match criteria for flow group")
>
> from the net-next tree and commits:
>
>   7445cfb1169c ("net/mlx5: E-Switch, Tag packet with vport number in VF vports and uplink ingress ACLs")
>   c01cfd0f1115 ("net/mlx5: E-Switch, Add match on vport metadata for rule in fast path")
>
> from the mlx5-next tree.
>
> I fixed it up (I basically used the latter versions) and can carry the
> fix as necessary. This is now fixed as far as linux-next is concerned,
> but any non trivial conflicts should be mentioned to your upstream
> maintainer when your tree is submitted for merging.  You may also want
> to consider cooperating with the maintainer of the conflicting tree to
> minimise any particularly complex conflicts.
>

Thanks Stephen, this will be handled in my next pull request to net-next.


> --
> Cheers,
> Stephen Rothwell
