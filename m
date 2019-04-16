Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96673C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 684CF2075B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXcGuNH/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730100AbfDPSgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 14:36:06 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46039 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbfDPSgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 14:36:06 -0400
Received: by mail-oi1-f193.google.com with SMTP id y84so17829346oia.12;
        Tue, 16 Apr 2019 11:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZDN1E8ErdeOqVWZMMn6li0vnQ0QD0oUu2tNufmLiGss=;
        b=dXcGuNH/M3EELaRFZcuURZy5kq+WTbBRSxfIOs3LaLcGRLQJQHiuNECCj7ul81KzDF
         Myf4wkHv2KXkn5wE4+u+7WI80+i8Qk/EOWC+RbOmf9sDLD6ujN5f3yt84xgkNFs9jedX
         x3tms2HwIpdgE557wOF364ef4TsFiRl3ubzdV+gzEN5vHruh2x2QOSwE8Nx/D2S+zOFi
         itkZSbVpEGe3lDfV+AcE3hBZngmBu3CADikdUFPpLwQvVTeUEN5c7dUhVKkqb6i25kiY
         B7sdJutoQwKBzPi8ObVkpIT/jXbuMmTsnpkk4qnf1ncnTN4jYD0PChNIvYj/vm9A330t
         +9XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZDN1E8ErdeOqVWZMMn6li0vnQ0QD0oUu2tNufmLiGss=;
        b=n4SB4mmtJpiD1H1s8+QPJTPJUW++iNN0Pzjqyq38vxEc0qGZIVpsptr1FXCnrFQRoC
         uOBAEtnLh/IbjL+8X0EpIDGLDCDNnUmKDiZ+sUwBvHws/fw5F2IsdFIc5q4xHcKU1+AF
         SGbZjELNj7KFNtCQ5hBpO8J48KB+k2A+5hrkkndcj3wGHPmfyMw4uUB1uVkjwCZO9pWT
         NYhLbj+V5ODdo0APQbCkKKMVg1RagacABYFrs2ZXaPLEbIDojYRzbnbld7OXMRRotX8h
         sJPxtgr1FIxn6FuhwMEgZC+Im9mLMLID9mLYPnAUB8e+RDXIvUeDdaIcbAoqiB4Fr/am
         1lqQ==
X-Gm-Message-State: APjAAAVgzbEvd9jyZb9UfyRtcCNLJ/4bt2GgJY/b6m6yizoRnm9bhAt6
        pk2I8AHFHtH6vNgwNqfJTgUanzXVtBdGrq6BBzU=
X-Google-Smtp-Source: APXvYqzjLFLWnP68Zh3PEoyhvjQf1DmG3tQbG6nlQquI5GWzzUVPiq/T21hdF+pi48RvlxqqMrk106dxT7p6ZChq4Bs=
X-Received: by 2002:aca:c405:: with SMTP id u5mr25694328oif.77.1555439765531;
 Tue, 16 Apr 2019 11:36:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190416155618.1369-1-TheSven73@gmail.com> <20190416155618.1369-4-TheSven73@gmail.com>
 <2caf5f92-164a-3723-e2ef-42e4045d2ec3@metux.net>
In-Reply-To: <2caf5f92-164a-3723-e2ef-42e4045d2ec3@metux.net>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Tue, 16 Apr 2019 14:35:54 -0400
Message-ID: <CAGngYiXZSaUwrCiqavMGDRb5Vuo2x8fTjDetT00PAjjtrYW+NA@mail.gmail.com>
Subject: Re: [PATCH v11 3/7] anybus-s: support the Arcx anybus controller
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, mark.rutland@arm.com,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        treding@nvidia.com, David Lechner <david@lechnology.com>,
        noralf@tronnes.org, johan@kernel.org,
        Michal Simek <monstr@monstr.eu>, michal.vokac@ysoft.com,
        Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        Stuart Yoder <stuyoder@gmail.com>,
        "J. Kiszka" <jan.kiszka@siemens.com>, maxime.ripard@bootlin.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enrico,

On Tue, Apr 16, 2019 at 1:31 PM Enrico Weigelt, metux IT consult
<lkml@metux.net> wrote:
>
> How do the anybus host and the CAN stuff relate to each other ?
>

The "CAN stuff" is just a binary power read-out, routed from an external CAN
card, which may or may not be present. The CAN card is not accessed from
within this driver. This situation arises because our h/w developer team
decided to integrate various unrelated pieces of functionality into the
same hardware card (even into the same 8-bit register).

This arcx-anybus controller card has two unrelated pieces of functionality:
1. implements an anybus-s slot
2. implements a power read-out from an external CAN card

This situation is not ideal but it's what we have :)

Sven
