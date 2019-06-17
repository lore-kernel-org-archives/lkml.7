Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB37C31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 10:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00FEB2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 10:22:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="g+ByyIO8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbfFQKWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 06:22:55 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43661 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbfFQKWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 06:22:54 -0400
Received: by mail-lj1-f194.google.com with SMTP id 16so8707765ljv.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 03:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g2oUEZzHP2whF33vnG7n908pNLNyu4ePU235OE7To5w=;
        b=g+ByyIO85CiT/cyls2vY5BdJ8YR5+16TYt0U66RxbYBWithsj4AA58h393JNAXdY00
         5Eu2+TraYBbgESsrbtnwSAr9vFoLM6ZFcexKX8MswlFpuScPljErsERZ9c6PSxbGP5d2
         YN04GWhsvjiSFSKzdmUrEyUE12f07l0nsGALcV7pct9cBoGBneYdcFHxos1w4RcvnMi2
         USPzjMwlPVjdt+YML47NYRfUR+ZsmupQwS1XVHT4um5f8eLihBmDK6aL31q+Lr9CxboB
         zsvqEQ35rA7zBApMEiu+KkaRannwbR0Ag778K4XtCk4mc6CzmtKAhJxxyXY0riSaFlnf
         XYVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g2oUEZzHP2whF33vnG7n908pNLNyu4ePU235OE7To5w=;
        b=g3VnMxsey1ZXmf3RHIsKh1hrzQoBynNVQK0yNH77IorQG7fEDhsy/r4dKqbTIcDdfq
         /4yso035EFiNLCDgqbTd1zwMvBzvHXeMwwkfA86eS6wMwNb7z8Va1jLLXrFAa11jAPWP
         +jN+peL/WVosu7XL9ztICEuGyblq/y1D3druOEhG/vuCjLuxhNdwvjyzi8BX/ZrcUcga
         bg+jMEmF6EJi++hl+hTlrZtBTTpbVla6Ae7BXuNbLDwrK9cNzSvOrHtZm5IfDovMc7mf
         XTF/1LHhSEnQPb3jk+u33Q7dzB1ot0EWfUULxaaFfuzGJxLOJagQqhyJ9LfgZd4X7Jr6
         OGHg==
X-Gm-Message-State: APjAAAWmQiZjobARLqBGNLNAisJrhckvuI+krPxhL2/9havH0v7xPbDE
        GMyC/IyXrdRj4cvxSwkDSXUqBNb2jdqB5paQJVo3Dg==
X-Google-Smtp-Source: APXvYqx4hPynEVTRoMbFzeRC1RMi/6+9FpSi2w64JI1pMvwgPj2Nh1KEyMr6rGcUZcLvX4skV4KJLmtmNmIY4M2KLQ4=
X-Received: by 2002:a2e:9c03:: with SMTP id s3mr43444283lji.209.1560766972421;
 Mon, 17 Jun 2019 03:22:52 -0700 (PDT)
MIME-Version: 1.0
References: <1560745167-9866-1-git-send-email-yash.shah@sifive.com>
 <mvmtvco62k9.fsf@suse.de> <alpine.DEB.2.21.9999.1906170252410.19994@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1906170252410.19994@viisi.sifive.com>
From:   Yash Shah <yash.shah@sifive.com>
Date:   Mon, 17 Jun 2019 15:52:16 +0530
Message-ID: <CAJ2_jOH-CacU9+Lce80PQzG1ytxvSZmjfSMwL9=kbXpWxyU96Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Add macb support for SiFive FU540-C000
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Andreas Schwab <schwab@suse.de>,
        David Miller <davem@davemloft.net>, devicetree@vger.kernel.org,
        netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        =?UTF-8?Q?Petr_=C5=A0tetiar?= <ynezz@true.cz>,
        Sachin Ghadi <sachin.ghadi@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 3:28 PM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>
> Hi Yash,
>
> On Mon, 17 Jun 2019, Andreas Schwab wrote:
>
> > On Jun 17 2019, Yash Shah <yash.shah@sifive.com> wrote:
> >
> > > - Add "MACB_SIFIVE_FU540" in Kconfig to support SiFive FU540 in macb
> > >   driver. This is needed because on FU540, the macb driver depends on
> > >   SiFive GPIO driver.
> >
> > This of course requires that the GPIO driver is upstreamed first.
>
> What's the impact of enabling CONFIG_MACB_SIFIVE_FU540 when the GPIO
> driver isn't present?  (After modifying the Kconfig "depends" line
> appropriately.)
>
> Looks to me that it shouldn't have an impact unless the DT string is
> present, and even then, the impact might simply be that the MACB driver
> may not work?

Yes, there won't be an impact other than MACB driver not working.
In any case, without GPIO driver, PHY won't get reset and the network
interface won't come up.

>
>
> - Paul
