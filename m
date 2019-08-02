Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF8E4C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2E6320679
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCk6lApF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436539AbfHBNq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 09:46:56 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:34452 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732669AbfHBNq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 09:46:56 -0400
Received: by mail-yw1-f66.google.com with SMTP id q128so27291236ywc.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 06:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=87nWth1qwkhZ1eXAHRwTJ+WjegXhw+N8PNzvPKErqiI=;
        b=mCk6lApFIOYFCE3bZlJdfRIULk2LdKeUPxWmUybHzo0Yaxeyj+CpyB+J/wuFoVrWSF
         gzGYdcnNrMDeTW8ONpOP30VbBDbMbNXAPePMk1DVPPjNrHDPGHEfKSpba6h/3gFnh7gm
         B3C390NPInuszW/nW11OokHsjQwZRedE4pDrAUS7uJbLdEHqwn4S7jYgeuUrH0l7SV5K
         elRfwudymEVNzdFUD6Kh6NUXNbC37Hs1QM67ptqkbvATaEUz4MHpZ+pE7GCu+MoJgFrU
         qGQVBNSIaEi1LCi+GpoQ5uIrukfNuDGhy0bILWVeYFDvnUXTGr5Ar4u0xt9avya5677U
         qaXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=87nWth1qwkhZ1eXAHRwTJ+WjegXhw+N8PNzvPKErqiI=;
        b=JAx4k6wWSdEso4MmFy3L+6vnfO1Oj90vD8hsvXrmgiQlqYhb/yjb/RZeB3u7Edh0lz
         V7vaQzNtjxXgWetjqgerUJ4SHujV7taBsK5mMo4wRk7no4jMOPIUvBtLxS6l91MLLosQ
         byj+x3+1Hx5GHWEe5fJX5suCFlzaito1wSQV/hT9NcxpEk+fArTwBZ+UQ25592uFjwIN
         GODBwssgObeCBI/ybXwz25UPA9GpQtEvsmwFWp3LmRoOr8UoI8lL8jequZK6NnhshlxY
         bkiDTpA9Hb8+k7eoAK4E5p9a9Wj6N+Tf8GG/a9KMFPn4OzfJbyI+9aNBvs4QZ/Aezi4W
         EgIw==
X-Gm-Message-State: APjAAAU9Hkx6kvKaJ0lKhjUo65HIfLW+ttlBpbzOg2KxjZ4CqKOU5b7g
        6QmKbrVU/vpJsJQ2H5qu3QdOd4mv
X-Google-Smtp-Source: APXvYqzDlxQEJN7v80kV4DEfaLp6yf9DhkC+IZ9RRQfwyebbX3rxyxPNY/nFHh6StdmpuebmFjSPTw==
X-Received: by 2002:a81:a343:: with SMTP id a64mr79656520ywh.142.1564753614452;
        Fri, 02 Aug 2019 06:46:54 -0700 (PDT)
Received: from mail-yw1-f46.google.com (mail-yw1-f46.google.com. [209.85.161.46])
        by smtp.gmail.com with ESMTPSA id n38sm2046837ywh.11.2019.08.02.06.46.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Aug 2019 06:46:53 -0700 (PDT)
Received: by mail-yw1-f46.google.com with SMTP id u141so27273321ywe.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 06:46:53 -0700 (PDT)
X-Received: by 2002:a81:4d86:: with SMTP id a128mr79663944ywb.291.1564753613185;
 Fri, 02 Aug 2019 06:46:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190802105507.16650-1-hslester96@gmail.com>
In-Reply-To: <20190802105507.16650-1-hslester96@gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Fri, 2 Aug 2019 09:46:17 -0400
X-Gmail-Original-Message-ID: <CA+FuTScLs-qJApj5Yw9OOjVk4++HSjn__Vdy+xX2V1rpWU8uLg@mail.gmail.com>
Message-ID: <CA+FuTScLs-qJApj5Yw9OOjVk4++HSjn__Vdy+xX2V1rpWU8uLg@mail.gmail.com>
Subject: Re: [PATCH 2/2] ixgbe: Use refcount_t for refcount
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        intel-wired-lan@lists.osuosl.org,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 2, 2019 at 6:55 AM Chuhong Yuan <hslester96@gmail.com> wrote:
>
> refcount_t is better for reference counters since its
> implementation can prevent overflows.
> So convert atomic_t ref counters to refcount_t.
>
> Also convert refcount from 0-based to 1-based.
>
> This patch depends on PATCH 1/2.
>
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c | 6 +++---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.h | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
> index 00710f43cfd2..d313d00065cd 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
> @@ -773,7 +773,7 @@ int ixgbe_setup_fcoe_ddp_resources(struct ixgbe_adapter *adapter)
>
>         fcoe->extra_ddp_buffer = buffer;
>         fcoe->extra_ddp_buffer_dma = dma;
> -       atomic_set(&fcoe->refcnt, 0);
> +       refcount_set(&fcoe->refcnt, 1);

Same point as in the cxgb4 driver patch: how can you just change the
initial value without modifying the condition for release?

This is not a suggestion to resubmit all these changes again with a
change to the release condition.
