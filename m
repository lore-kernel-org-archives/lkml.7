Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13AADCA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E61CA21928
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:45:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403930AbfJWMpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 08:45:39 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:52765 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391037AbfJWMpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 08:45:38 -0400
Received: from mail-qt1-f175.google.com ([209.85.160.175]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MZl1l-1iTZ7G04IB-00WnZl; Wed, 23 Oct 2019 14:45:37 +0200
Received: by mail-qt1-f175.google.com with SMTP id g50so17884261qtb.4;
        Wed, 23 Oct 2019 05:45:36 -0700 (PDT)
X-Gm-Message-State: APjAAAXqU4eAJDwvhXDnj0TiMlz8//56JCfVHX2zVi0IcP9DLdJ4ol2M
        rzaAsTbJUpOEy+oWFQrczxknQ6IPGOtPq7v6fY8=
X-Google-Smtp-Source: APXvYqyy9eLPSjSegvDzhnQvcTJZRNXOvgxtascK9z6lCnK+he0UZpFg1zpN14r2VDhc4zyiPUa1Ko1f6GMezspKs4c=
X-Received: by 2002:ac8:6956:: with SMTP id n22mr8794799qtr.7.1571834735758;
 Wed, 23 Oct 2019 05:45:35 -0700 (PDT)
MIME-Version: 1.0
References: <20191010202802.1132272-1-arnd@arndb.de> <20191010203043.1241612-1-arnd@arndb.de>
 <20191010203043.1241612-9-arnd@arndb.de> <20191023113252.GG10630@pi3>
In-Reply-To: <20191023113252.GG10630@pi3>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 23 Oct 2019 14:45:19 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2f8USPJP5OL2J=wi=GqvBrTJpwVOtYg=WcWQM2PZ30cQ@mail.gmail.com>
Message-ID: <CAK8P3a2f8USPJP5OL2J=wi=GqvBrTJpwVOtYg=WcWQM2PZ30cQ@mail.gmail.com>
Subject: Re: [PATCH 09/36] ARM: samsung: move pm check code to drivers/soc
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:AHM2NU0QTJyje//gruH+Don3wT44Dal5JmNeL0fdw/0WSkF9AgN
 5mb3zodeOahxj/ah4jl8zsJJMaYkxK1NMQ3IlkmKIA9nO51hWcnn+lgTZG7NRQQfdN1pVdJ
 /n/GzSYR6SpztHI8sA/r+VU9NGUJXATN1ipnckRdx9peHq3iWSR8VA5aScIYhdLFi2pdDFL
 ZMqQMKUZcAO8DFO4/rvNw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Pgu5C6zyWb8=:fn/zWAD0SS67j6IUs1VIDX
 FoMqLpjtdvL5/MSUxUOjHtEG5vOoI8U1LHkAnVO1lDhCyatWAJyeMKj7sI6YTFelTvjRKTJZf
 5OAFWsqxvoq0+SBmimt1766oM+46fCG+y0KRKYloGz9aUFEdvntl9hKnPZ9l9bXig41Iug03X
 22cphV68qYI3ggQLAyMUVH9YkTxCALaKLvrCB1I3x45pqilHB1Fcklq2fmbWLtKPxhx6X159R
 TRF1xnSGsOBp4q4cLEnYcn2J+zHZN9ktKwtTDcuKcIWdGutMosiRFOIn33nwQp8MAapN6Oqwb
 OUTW783/UY8mDtvMD42/ChrwDtSMavCE0c5wWKoeWT9WPZahG/n8jwuYPFM4YfVQVwiQaWRIU
 CIOjwDCdhLHsAXqPzuv6JuuDGSwpPMwwaeBFujePf1/32e0kZkbiZfyhXZoC0ZbMaQ8N2ro6s
 8vp7Sqx3M2ALuurIUzmDL1Ad51IOElvt98o+HSEt8Wj7utXoI3TJimpkjGIuR3DUJtj5o6Jh8
 i9RICA92Nj6abLrgO8TslqCdjgDruvt/xPREskCIHkK0o/gUqPL7V9R6b6SVw9lQAv7Q9MdhJ
 yfklDBHfQEfapbino8NofiFmGqs+jZ+aJ+I8roI75p5xTpiZQyd2jdUsXlGc2SvIjzIWkqaDa
 oCMFWDNEh+l6cSf8lOf2b9+5fH2ufrsAb7WmLr+B8C2/tCeANZY9NavKUqEKC4Wo3x90YqbhY
 H+P4MxQQW7PhzuZ8seqo/C8nqSRe9jB4b23g04Rez15VzY/1gwd55OL89pVf3yG5/VEvv0BNR
 EJFJc9JMcxbu4MO8VY70HzbT1n6JKWgoyVYY77J7OWyzuqc/sgzV5QIRW8eMxwSKVYUwIJoy/
 OlNhyqH1Szjx3f5uVQmA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 1:33 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Thu, Oct 10, 2019 at 10:29:53PM +0200, Arnd Bergmann wrote:
> > This is the only part of plat-samsung that is really
> > shared between the s3c and s5p ports. Moving it to
> > drivers/soc/ lets us make them completely independent.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> > + *   Tomasz Figa <t.figa@samsung.com>
> > + * Copyright (c) 2004 Simtec Electronics
> > + *   http://armlinux.simtec.co.uk/
> > + *   Written by Ben Dooks, <ben@simtec.co.uk>
> > + */
> > +
> > +#ifndef __SAMSUNG_SOC_S3C_PM_H
> > +#define __SAMSUNG_SOC_S3C_PM_H __FILE__
>
> Use guard name prefix consistent with other files, so:
> __LINUX_SOC_SAMSUNG_S3C_PM_H

Ok, done.

        Arnd
