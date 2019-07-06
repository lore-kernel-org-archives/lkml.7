Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA29EC48BD3
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 13:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3DF420989
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 13:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="n0OGt9lY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfGFNOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 09:14:15 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:25638 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfGFNOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 09:14:14 -0400
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x66DE1pa022118
        for <linux-kernel@vger.kernel.org>; Sat, 6 Jul 2019 22:14:01 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x66DE1pa022118
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1562418842;
        bh=yR96820x8dCsUN7jsyb8LhZwwDE7H4JmOUSfV5/t9ow=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=n0OGt9lYpUV3X8BVIBRNfCVFkAbpM8YUX6etjGciXbbg58GpQlVo48ed8yh/e6LOw
         4XqaFs4Kancu2+A3eWAoSim/EnGZWAF4kGsGzbbMUd1q9VTOdXS6nquq4u0BFLfPit
         eS+JYR6h1An/lBqh6PUFd5bUAf3PPnVN4pPQK3kk7K3HXkAT5ktz4LrNi7GAxQ+oab
         e2aOn1wP3LvmWpWH0+4HnHB92TJl+nqRiahhIYPMoQokotxNhaNccaezg3fp5gM0IC
         Kmnh5exBPfmxex5/ktMCWk5PWIPpNrx+DG7prpd1OS4Pd0uxyLMPqHj1MUa3c1tV6p
         yqtl8/cuWBHLA==
X-Nifty-SrcIP: [209.85.222.45]
Received: by mail-ua1-f45.google.com with SMTP id o2so3175022uae.10
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2019 06:14:01 -0700 (PDT)
X-Gm-Message-State: APjAAAW/g/OU2SEK0Gc9zsCEUCUFK8sdLeaAtJzL/arGyAhrnhYtVTeZ
        BFOQb2c9VNo6rO4rPL2QmNIV+loGnyakylA5S7M=
X-Google-Smtp-Source: APXvYqzJ89qUy8ATJQiEXDG2nXMrBJeh3RIwp0lned5asyXvyR9wOUeOo4ghtOWnxd9GXq6uo9GMfDtI5G9j6t8OLew=
X-Received: by 2002:a9f:25e9:: with SMTP id 96mr4960816uaf.95.1562418840867;
 Sat, 06 Jul 2019 06:14:00 -0700 (PDT)
MIME-Version: 1.0
References: <1553321671-27749-1-git-send-email-wen.yang99@zte.com.cn>
 <e34d47fe-3aac-5b01-055d-61d97cf50fe7@web.de> <07e17d87-09ff-311f-015c-d201df053f56@web.de>
In-Reply-To: <07e17d87-09ff-311f-015c-d201df053f56@web.de>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 6 Jul 2019 22:13:25 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ=oVfmHWYSp2hsKTGGAkrY7faDfNYCfx88k7fTdnoKLQ@mail.gmail.com>
Message-ID: <CAK7LNAQ=oVfmHWYSp2hsKTGGAkrY7faDfNYCfx88k7fTdnoKLQ@mail.gmail.com>
Subject: Re: [Cocci] [PATCH 2/5] Coccinelle: put_device: Add a cast to an
 expression for an assignment
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Julia Lawall <julia.lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Wen Yang <wen.yang99@zte.com.cn>,
        Yi Wang <wang.yi59@zte.com.cn>, cocci@systeme.lip6.fr,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 6:02 PM Markus Elfring <Markus.Elfring@web.de> wrote:
>
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 8 May 2019 13:50:49 +0200
>
> Extend a when constraint in a SmPL rule so that an additional cast
> is optionally excluded from source code searches for an expression
> in assignments.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> Suggested-by: Julia Lawall <Julia.Lawall@lip6.fr>
> Link: https://lore.kernel.org/lkml/alpine.DEB.2.21.1902160934400.3212@hadrien/
> Link: https://systeme.lip6.fr/pipermail/cocci/2019-February/005592.html
> ---

Applied to linux-kbuild.

>  scripts/coccinelle/free/put_device.cocci | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/coccinelle/free/put_device.cocci b/scripts/coccinelle/free/put_device.cocci
> index 3ebebc064f10..120921366e84 100644
> --- a/scripts/coccinelle/free/put_device.cocci
> +++ b/scripts/coccinelle/free/put_device.cocci
> @@ -24,7 +24,7 @@ if (id == NULL || ...) { ... return ...; }
>      when != of_dev_put(id)
>      when != if (id) { ... put_device(&id->dev) ... }
>      when != e1 = (T)id
> -    when != e1 = &id->dev
> +    when != e1 = (T)(&id->dev)
>      when != e1 = get_device(&id->dev)
>      when != e1 = (T1)platform_get_drvdata(id)
>  (
> --
> 2.21.0
>
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci



-- 
Best Regards
Masahiro Yamada
