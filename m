Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB28AC432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 07:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8100C20723
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 07:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="yE7QrN1y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbfKPHSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 02:18:42 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:55423 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfKPHSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 02:18:42 -0500
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id xAG7IPvp009560
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2019 16:18:26 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com xAG7IPvp009560
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1573888706;
        bh=wEcD40KlL4hRWN44PHTQtvlzIboJTCA/cT3il2X2CW0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=yE7QrN1ydIRr0LnmwncAIJefKyfPe1sj4FG1Ox/O7u3o/7b8Uc6l3PrUg3pExNgeF
         gCH/tGDIR7pmdtrGTBaixBtsYCcyxOgTTtWfhJ4Abq22UvWYDseFNZ4vSJz8Z7nBPW
         +UGZZo0UycMNZlGzHZJb9LWvosuDBs2PPPQjID+wSWtGRywVyA4Q4i7b+UG0bMHAGc
         gsJ6MIlOG9JxePnl7mJiV4axPD4IbkGUmplg/h3vbqtTemSHd8Cs2i2p9LdjXG8lv+
         d4ShEo8rRm3QukhCLtALwD9fZj9/6EhNr65EIggsJH+aUjcziPpOIOPyQpzK2KRSti
         SgIqLNp88KOtA==
X-Nifty-SrcIP: [209.85.222.53]
Received: by mail-ua1-f53.google.com with SMTP id o9so3718545uat.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 23:18:26 -0800 (PST)
X-Gm-Message-State: APjAAAV0Vc3f3T23RQgm2MFseVQ4wrygnZDjLG80zo7PIn+cLUXxoUJP
        ydk8dup9yWPQCX4WRRTO+0GLbC6D8lVXXxKU5DI=
X-Google-Smtp-Source: APXvYqw3sHv8rd4DoJC83katM0DWjVv8RJpz4kKYhH4b6sa+dC+Og/B5BDNeVedVpIDNg3XF5LW+hwbBWKQfVo1KYUM=
X-Received: by 2002:a9f:3015:: with SMTP id h21mr11902836uab.95.1573888704938;
 Fri, 15 Nov 2019 23:18:24 -0800 (PST)
MIME-Version: 1.0
References: <d60946a1-fde3-ee6f-683a-42a611768bbf@kernel.dk>
In-Reply-To: <d60946a1-fde3-ee6f-683a-42a611768bbf@kernel.dk>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 16 Nov 2019 16:17:49 +0900
X-Gmail-Original-Message-ID: <CAK7LNATVHbMHqjboACJF8BbKianRfjiGhHTXjtQuJVmv2HFPUA@mail.gmail.com>
Message-ID: <CAK7LNATVHbMHqjboACJF8BbKianRfjiGhHTXjtQuJVmv2HFPUA@mail.gmail.com>
Subject: Re: Recent slowdown in single object builds
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 16, 2019 at 8:10 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> Hi,
>
> I've noticed that current -git is a lot slower at doing single object
> builds than earlier kernels. Here's an example, building the exact same
> file on 5.2 and -git:
>
> $ time make fs/io_uring.o
> real    0m5.953s
> user    0m5.402s
> sys     0m0.649s
>
> vs 5.2 based (with all the backports, identical file):
>
> $ time make fs/io_uring.o
> real    0m3.218s
> user    0m2.968s
> sys     0m0.520s
>
> Any idea what's going on here? It's almost twice as slow, which is
> problematic...



This is necessary cost
to do single builds
(394053f4a4b3e3eeeaa67b67fc886a9a75bd9e4d)
but, it is much better in linux-next.



-- 
Best Regards
Masahiro Yamada
