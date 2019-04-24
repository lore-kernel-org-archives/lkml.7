Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D9EEC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 209E2208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387875AbfDXSqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 14:46:05 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45584 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727258AbfDXSqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 14:46:04 -0400
Received: by mail-qt1-f196.google.com with SMTP id b3so6640780qtc.12;
        Wed, 24 Apr 2019 11:46:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4CRB1/NYjuofCzOEDUzpmA+u8tPDHZHa2Y4BTJtdo7M=;
        b=sNHYrvCEu4Ai8URmaJoEb0TOf5oHNLq8O1tt3n1AuJ22UiGIJn4rMl/ErKhiQqwSJT
         FP3mkRJyNjZhcm0BNxE3C34Pig1rGlYU/YunZj4W9vnwht5v2f1ka4m9Xedb55QLq1oQ
         xWHF4V7k4IEvu552TMRUaLC/cMJrbSRgjPq4l9aCJwjuzO/KMToq7I+nh9CwvE2lmqgF
         ry0tMaC+6izWvJPFZzGkjanrVzkYo49OY8/J94R/GsmgJG2EN/WGTLARUMrxEOZmOzT2
         pRx+oHgoRgO938IcYvDBmv4pkBxAqZsuAebiDyt3vd3bUzqUYHdmbt3+ie3h12nEIQc+
         RKlw==
X-Gm-Message-State: APjAAAUhw4UBi4tjkSAZ3zI2g8epIKvHDRVsdaoWYpEDxs4D6xMIO0vK
        9CGUxPnDrwDmMLuA55OVolCzT00jwuLuUK+ap68=
X-Google-Smtp-Source: APXvYqxGjhNk3KYRau+QaKcUNCI3LF4BskMW+8wPn2ZSkGUw0FxkShUowr8blLgIbpMphhuseU89OvlIs6RWAdLcgoo=
X-Received: by 2002:a0c:b24e:: with SMTP id k14mr14594566qve.180.1556131563752;
 Wed, 24 Apr 2019 11:46:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190424153124.GA9475@embeddedor>
In-Reply-To: <20190424153124.GA9475@embeddedor>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 24 Apr 2019 20:45:46 +0200
Message-ID: <CAK8P3a0Ak95EUq6-6ASHKEKw=x+9_+MO5ZaFcctaS4esz__J3A@mail.gmail.com>
Subject: Re: [PATCH net-next] net: socket: Fix missing break in switch statement
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 5:33 PM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> Add missing break statement in order to prevent the code from falling
> through to cases SIOCGSTAMP_NEW and SIOCGSTAMPNS_NEW.
>
> This bug was found thanks to the ongoing efforts to enable
> -Wimplicit-fallthrough.
>
> Fixes: 0768e17073dc ("net: socket: implement 64-bit timestamps")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>

I had just prepared the same patch after Dan told me about the issue today,
but you managed to submit it first.

Thanks for the fix!

     Arnd
