Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE60AC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93329205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tUNmQb+L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbfH2Sft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 14:35:49 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:41540 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfH2Sft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 14:35:49 -0400
Received: by mail-io1-f67.google.com with SMTP id j5so8875254ioj.8;
        Thu, 29 Aug 2019 11:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dE7PRZQ345omAc8kJ4IwmsYptXobZW+/ikZLYjrE7WQ=;
        b=tUNmQb+LFpYbL1cSRPf5bCe64L++eHLfZ3CowzYJsxcHu6DWB7Khliqd+0WFFTUkut
         UgliUO5/JyqxYdKS3oPQorxRPZMGv/eyYDZinzXKZUFcL8wfTyTXE54NmzJF+Vo+c7C9
         /6CxcG+neGPSPOpPtQfvL+hWLHQo3leLd6FTrsSEHeCFcPw6gCq5tkMfnr/hnLWY6L/x
         hHQ9oTXwrZyOpp4pFqG1Ae7f1l91G0oPB0ISu+2CigxbB/+gg3e8WkinItIZ66L9sl3y
         sod6Sj1WOSojNdn7hOqcp4ojk/QPz2fC6PhALJTTkADd14rbnYMIbd76D8s9Zygo3Bwj
         /JgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dE7PRZQ345omAc8kJ4IwmsYptXobZW+/ikZLYjrE7WQ=;
        b=lr/03c13JUt9Dh/Vfw2PZdxocDFZqmNwcbLL+1lKzB83Lk7QFrZS4E81c6GwA/uaGj
         ehQq2V0nPGn10cXUtq9xn2OjFdIohMeXptyjmvXrBJGb4vz0Ia5km9iLkltDma4k7ebh
         Q0C1euk3VtquhJh6FLMHRX1x6TApPVR4YeBVBqB9J/sn8fcAJ1PAuLVUuikJhlzCt83e
         EsTpESg3oSA/U+4zzdV6fFqXWkeMDWKO4CFUFWLzX/XbTrOuFYWjbUOBya1lPXR/U9K2
         H7POacCpNlSkRwxGAX1SZzI6dNfpvomfCdez8EQQBifExZLq4cFUWOr7i1QPKCT9tcmq
         mm6A==
X-Gm-Message-State: APjAAAWJOEulYxispJTf155z3E7tALGi9rLICiCKE2KJ2wb5ImfTXFB4
        Dj3Ww6Fd3hAMFI5/S9el1P10wOdfbCvXfSS/60w=
X-Google-Smtp-Source: APXvYqzg2TrSvQ2sGfxlX6InibTPJ6qPNmnESCZkxiQHWcDZTe8CGM/4kKFmZ8yqnYQphNmu4/FiJ2pT0Ndftf28zJ8=
X-Received: by 2002:a5d:9bd4:: with SMTP id d20mr1721932ion.243.1567103748387;
 Thu, 29 Aug 2019 11:35:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190828202723.1145-1-linux.amoon@gmail.com> <8c40f334-c723-b524-857c-73734b7d0827@baylibre.com>
In-Reply-To: <8c40f334-c723-b524-857c-73734b7d0827@baylibre.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Fri, 30 Aug 2019 00:05:37 +0530
Message-ID: <CANAwSgShr-K-44UzdxFC7pvpTye_pbEMdS6ug1eWwYhnsVNGdQ@mail.gmail.com>
Subject: Re: [PATCHv1 0/3] Odroid c2 missing regulator linking
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Thu, 29 Aug 2019 at 13:58, Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> On 28/08/2019 22:27, Anand Moon wrote:
> > Below small changes help re-configure or fix missing inter linking
> > of regulator node.
> >
> > Changes based top on my prevoius series.
>
> For the serie:
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
>

Thanks for your review.

> >
> > [0] https://patchwork.kernel.org/cover/11113091/
> >
> > TOOD: Add support for DVFS GXBB odroid board in next series.
>
> I'm curious how you will do this !

I was just studying you previous series on how you have implemented
this feature for C1, N2 and VIM3 boards.

[0] https://patchwork.kernel.org/cover/11114125/

I started gathering key inputs needed for this ie *clk / pwm*
like VDDCPU and VDDE clk changes.

But it looks like of the complex clk framework needed, so I leave this to the
expert like your team of developers to do this much quick and efficiently.

Best Regards,
-Anand
