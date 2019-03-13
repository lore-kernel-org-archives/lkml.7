Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C28C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B8712077B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbfCMUwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 16:52:55 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37228 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbfCMUwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 16:52:53 -0400
Received: by mail-oi1-f194.google.com with SMTP id n7so2455576oic.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 13:52:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4xCRVpdWMpogBgj+dLIYh+kwDQutwY3HJvb5mriq3eg=;
        b=qwk1nO57pNzgnvuTKnNX7TDNEdllHnrIPYNhb+BKk7+N6mhLXnPnznWf0ar1l5k0qX
         M7mFZ2pPgSjQGhJOLeFhe2pJffj2DslOYRK9krSawzZGwM9e9WaIK1H0qXkSu+Ftgpok
         lbGFUO88qTnyNn/AeYS6JEha+YwGAvGOLHblsze3xayDXJglXabgR8h4h1md2XROY/C/
         E3ljwobtkRqldrE9XwzXsB62lql7wEJhVZWbnN396ZK4wj2qG3p5ppOsspUfajRaaCMG
         5gVox+lo5zxBwNQop0lmv6IcFKWxHTSEdkWutLgqx/bRCFoJR9vzE77fumOY0tUr2Z30
         zYng==
X-Gm-Message-State: APjAAAXxH/teuUwVaHdg0D0AxqEkGNaj86abQgeNXMDRgch7WcFwFPeD
        ZcHd8AHemNJzIecuVUKbT2fanU2z5ixv3YWdWH8=
X-Google-Smtp-Source: APXvYqzVS86zucNF7ygQcccRCjLrvANXYNVhMGB5QhVmo09nTs+k9DnXULkuQ7T4VbgjZsyLkzIjYo9NzOHm8NxJgns=
X-Received: by 2002:aca:3e8a:: with SMTP id l132mr65000oia.107.1552510372442;
 Wed, 13 Mar 2019 13:52:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190114201911.13725-1-malat@debian.org> <20190313202429.20797-1-malat@debian.org>
 <CAHmME9psZb0XoKHjGP23TYsSwMU2G-WN81RKg8AvyY-rZLvy4g@mail.gmail.com>
In-Reply-To: <CAHmME9psZb0XoKHjGP23TYsSwMU2G-WN81RKg8AvyY-rZLvy4g@mail.gmail.com>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Wed, 13 Mar 2019 21:52:41 +0100
Message-ID: <CA+7wUsxbieZVP3Bh8pXdemf2Q3qY3vAjE2y-Dg6yGF3oWHSPuQ@mail.gmail.com>
Subject: Re: [PATCH v2] lib/siphash.c: annotate implicit fall throughs
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 9:34 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Conceptually this seems pretty reasonable. Though, style-wise, perhaps
> you might want to put those breaks on the next line too, i.e. s/;
> break;/;\n\t\tbreak;/?

Good point. This needs some more love since checkpatch complains now with:

ERROR: trailing statements should be on next line
#42: FILE: lib/siphash.c:77:
+ case 4: b |= le32_to_cpup(data);

Let me merge all that and send a v2.

Thanks
