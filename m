Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D9B9C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 07:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E2CC2070E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 07:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOPAr9Qp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfKNH45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 02:56:57 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55705 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbfKNH44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 02:56:56 -0500
Received: by mail-wm1-f67.google.com with SMTP id b11so4588711wmb.5;
        Wed, 13 Nov 2019 23:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3K2jlKns5uBLkzDh9Yqp5vanNtQbiJVshVMnoLizCHU=;
        b=LOPAr9QpwxQZ6yy5Z+4+Tbtd9Lt+/s7RGkLsFMpjZVMGHUYG8IJilruwObPEw2erMn
         HowM/VT/xT+bB4TCfwnJuXqPklx724lgWIfRhkz6v2eDkEJ4zhMLNUlUcElK2Nl+8KVK
         SAYvK7OQwbU9kdiWKA2m7Jkcmq+fr96f0xKpmNBdL571lsWm8LEQMlYDDgKLXcCTXqjT
         x5PrtMbuN7QaH1J/v1NUi+3gAxB3Ph0oYxSU5rzsWCmvgbS0I5xkJ4wJpjR41/uDZHD3
         gBRIY9zxM7eA9SSj/nIdWlVEhEfLOZ7mgUf9O+jTKVwToMCZTBL8qvEHPT3pRay9bZyX
         sMrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3K2jlKns5uBLkzDh9Yqp5vanNtQbiJVshVMnoLizCHU=;
        b=oEyUnLve2qHrWki21bQH5Lw00i3CMcF1lHKpaYcSefkIksOjC8uREVWv0YCELLk2CT
         y+LfjaKyqjNxPzFv4Huxau+pq0T6gg7A+Cq1EzovmWacMwbDJ+aOmIgri7mHfP5lgpaS
         qaPlfkuJa7WCuIlCKaaayCnLlT66g0g/cjReisMRS5JoSDo64zsMq5bf89tO3FdVPqPs
         vf+M1fU1xe2dcSb7vFvw/0KAbPH/LFEZVuFOeoGTK8lZBCB8WGczSyDt2qWH1IV5iWlP
         kRn88MPUB6G529io5VXtWx73cv9yM1BRMQv7TuKcQyNf0nG+POZmMrd+Vys3dsciApEh
         eZcQ==
X-Gm-Message-State: APjAAAVHUAWRgvV2Dsf1eZnc70gkFouUj20PObKrDx0pTGsenwQ1dhUC
        hRpS5hJAW0qgkVrsT2b2RrRKJ8rHxW1MXqpNYM4=
X-Google-Smtp-Source: APXvYqxBerVbJgV3OSodNbBETUOG4GiQVDJ4dW1YDf5/mNBYS1hXAjI97JZxFxwK80d6fUKmOiAK9WUORUEZ/dL0iyA=
X-Received: by 2002:a1c:4456:: with SMTP id r83mr6205339wma.2.1573718214611;
 Wed, 13 Nov 2019 23:56:54 -0800 (PST)
MIME-Version: 1.0
References: <20191111090230.3402-1-chunyan.zhang@unisoc.com>
 <20191111090230.3402-5-chunyan.zhang@unisoc.com> <20191112005600.GA9055@bogus>
 <CAAfSe-uohXXHyQ7txhPmLCpyQODDHAuxjuUVbGcwYySN6G9tNQ@mail.gmail.com> <CAL_JsqLUkaL=dq0Nrdcax3KG7TXW3LErHTSONa9mH2gXu4du9w@mail.gmail.com>
In-Reply-To: <CAL_JsqLUkaL=dq0Nrdcax3KG7TXW3LErHTSONa9mH2gXu4du9w@mail.gmail.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Thu, 14 Nov 2019 15:56:18 +0800
Message-ID: <CAAfSe-vVxYsHBVorqpw1sTyi-B+VtU8pgAe79-T8WXhW8ZZHwQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] dt-bindings: serial: Add a new compatible string
 for SC9863A
To:     Rob Herring <robh@kernel.org>
Cc:     Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Nov 2019 at 08:06, Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Nov 11, 2019 at 7:38 PM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
> >
> > On Tue, 12 Nov 2019 at 08:56, Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Mon, 11 Nov 2019 17:02:29 +0800, Chunyan Zhang wrote:
> > > >
> > > > SC9863A use the same serial device which SC9836 uses.
> > > >
> > > > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > > > ---
> > > >  Documentation/devicetree/bindings/serial/sprd-uart.yaml | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > >
> > > Please add Acked-by/Reviewed-by tags when posting new versions. However,
> >
> > Yes, I know.
> >
> > > there's no need to repost patches *only* to add the tags. The upstream
> > > maintainer will do that for acks received on the version they apply.
> > >
> > > If a tag was not added on purpose, please state why and what changed.
> >
> > The reason was that I switched to yaml rather than txt in last version
> > which recieved your Acked-by.
> > Not sure for this kind of case I can still add your Acked-by.
>
> This was a semi-automated reply. I do review it first, but if the

Thanks for the review!

Can you please also have a look at other binding patches in this
series when convenient?

Thanks,
Chunyan

> changelog is not in the patch I may miss the reason.
>
> Anyways,
>
> Acked-by: Rob Herring <robh@kernel.org>
