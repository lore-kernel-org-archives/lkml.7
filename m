Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACDFC0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 20:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F12E21852
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 20:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="VkvlDok6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbfGDUmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 16:42:45 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:43801 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbfGDUmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 16:42:44 -0400
Received: by mail-vs1-f67.google.com with SMTP id j26so2569952vsn.10
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 13:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rcJ0C5reJPUPRr282vI9k081OUcgrz+/xcYOLqs9gP0=;
        b=VkvlDok6E4OX5H7Q5JvfdGowsbZDdxUCKC6KLupjDhRgWTZMuK5h1gXLVfPFeU8jXO
         T01nirzQnrayUcnFBKfOk1zYC+tIUntJ8ihjX8+YyZadlCcIztlDkpcBQq4BHTKjTt49
         AzQXmEepycbdGCSNnp2E+39UUQ7YnqzZErGXo8i6cLhWbOW0Wx6rcje/SLN5qDaefkKp
         Oyv69SFa/LFlamy8EiXCVitMuCHydzwc1I1ATCcJw7LIP8YwGSYjGP/BirgPqRIBCLwQ
         2kEaRgD/Up6e97bCHLJchdt4SX827hmBJRvjwsf5icokb+NfaRaUxHLiehNL0tlVBird
         b72A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rcJ0C5reJPUPRr282vI9k081OUcgrz+/xcYOLqs9gP0=;
        b=QzLnVjlnECCtWGN8o9E2syOA5N4xuEPPZkRM5GUCcmKkgGNtCDZ5J/SyGzRosN1lJ8
         6ih9td2dQnAyhLhMJq27fkvLS7bnR6Mi+x2EuOocqeK/TiFVnscOPmexjc5JwNuaFrvt
         B1O8scM8ymyug4yFzRcshcLI/6prn+Gnk0iAQtYE7WiPKiXid6Nn/zPsdr6PR1fHb5tf
         J1z6+pIzJ7b9Tr4D8EU5ZwurZoT2w50yY5sU/3ggiF8lT21TSzkAhX6/Rad5SMvoJEax
         hU43YYT0e5G4ocvH471fQlJA6FVdqjjHt14s0WAypBObF2sGmWkGS+psDwPYXyzE9iI3
         LUEQ==
X-Gm-Message-State: APjAAAUOclPvQ4zHrDsyyTYlYTllVz7RqiOV9DFTVo1AyeEWwxzPeASc
        u3pfmZ0LtDzilRsNdn03Od3l2P3i68P6Wfjtm/Lu9g==
X-Google-Smtp-Source: APXvYqwXd/B81tX4NOC9TTmvSWzTMjjs8ARqpz+wtD2NqFhfTltyEEUu8d8/9kTn14bdE5bkKc7e63shL2zV4htuJKA=
X-Received: by 2002:a67:eb12:: with SMTP id a18mr75466vso.119.1562272963879;
 Thu, 04 Jul 2019 13:42:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190704153803.12739-1-bigeasy@linutronix.de> <20190704153803.12739-7-bigeasy@linutronix.de>
In-Reply-To: <20190704153803.12739-7-bigeasy@linutronix.de>
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
Date:   Thu, 4 Jul 2019 13:42:32 -0700
Message-ID: <CAJpBn1x=s8YLD6B3jY4aT_v=uhjA6gYJJ-DGoyeiqno7+by_kw@mail.gmail.com>
Subject: Re: [PATCH 6/7] nfp: Use spinlock_t instead of struct spinlock
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, tglx@linutronix.de,
        Peter Zijlstra <peterz@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        OSS Drivers <oss-drivers@netronome.com>,
        Linux Netdev List <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  4 Jul 2019 17:38:02 +0200, Sebastian Andrzej Siewior wrote:
> For spinlocks the type spinlock_t should be used instead of "struct
> spinlock".
>
> Use spinlock_t for spinlock's definition.
>
> Cc: Jakub Kicinski <jakub.kicinski@netronome.com>

Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>


> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: oss-drivers@netronome.com
> Cc: netdev@vger.kernel.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  drivers/net/ethernet/netronome/nfp/nfp_net.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net.h b/drivers/net/ethernet/netronome/nfp/nfp_net.h
> index df9aff2684ed0..4690363fc5421 100644
> --- a/drivers/net/ethernet/netronome/nfp/nfp_net.h
> +++ b/drivers/net/ethernet/netronome/nfp/nfp_net.h
> @@ -392,7 +392,7 @@ struct nfp_net_r_vector {
>               struct {
>                       struct tasklet_struct tasklet;
>                       struct sk_buff_head queue;
> -                     struct spinlock lock;
> +                     spinlock_t lock;
>               };
>       };
>
