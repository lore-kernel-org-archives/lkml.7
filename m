Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E78C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 00:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29E89206D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 00:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nL+Ih+Km"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfKNAGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 19:06:35 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40339 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbfKNAGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 19:06:34 -0500
Received: by mail-oi1-f194.google.com with SMTP id 22so3575624oip.7;
        Wed, 13 Nov 2019 16:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CYs/nJxcrD0OvcDkwrYD1+P/tnyruE/I9OPXiUWOTS0=;
        b=nL+Ih+KmDhnOWLnoFlHBVrDoy8xWwQvUddfZb2inpKyucsHxFjO5qlZxCts5NjGi3B
         zVZqZcjmwWVxYoCIPsoFtfR1wWfnbV9gOKWa8IJhGHCu5aTCd4LN3qTxR9DRirmuvNZl
         ZQS5eEb6WlYi7aI5/C4Vn9uAJRaGn07F2iNV3ULXq8TI+vzWEvdj4DW3H55HIxpb3c4p
         KkwfJJftf77SH5e2rhkv7ugpzLU+g1rNKbRyy5MpCwKTcmLSfyl7dgnHwPoHw6r71Z8B
         /KROHe+X2hjXAO7uYE+1F5BGR6J4Pj7Kt6t3PflIRUo2Ty7yXPJXZMbBMAOC/40M37NN
         3foA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CYs/nJxcrD0OvcDkwrYD1+P/tnyruE/I9OPXiUWOTS0=;
        b=P/neoCk5d6oGQBarWJHD7tCoQ3+VdCmUYc9p9iK5TYFwdxaTARiHX5Sz96c5F9Wrbj
         QYgUWHAUtP8YBtZkSxyKNKFrHu3yDkdsx99Oq2U7sU9OpGuKhV1BS3aJ/tv1gXF0onJ/
         tqHWHReH7Gi051Lq5tLLFPtvq+rlF2kPUnE/idotB/8kUDmeWw52B/VLvIwJ+LCq216h
         Liusf0EMRQvED24wtAuPcAZPWi1QJQveWQkP9tSJmUu1/+TFyNjo3ly+GB6D0el5yAfV
         M60rVyW0Cgu1qZtVUaTZP22It2OOOupiNJH6THacnWfRmCgBKmtZTxyk0iCnQGTviyAq
         HHiA==
X-Gm-Message-State: APjAAAXOZhL4PBYQdDid4Ob/pb9U1jC5DIQWLzi31LFpjbbUSR60qQU2
        gfHvCeqPzjoDqdIOM5f0H6WMd8s/dVXGVP7v/Ew=
X-Google-Smtp-Source: APXvYqwaqAw8MYbgnGuq2M1VJ3IV3A5udR+KEllRetHLmMBPRM5IzCj8YcQrRAbay+1u0NM34Wh5Dlk1Db7zy56LvtQ=
X-Received: by 2002:aca:5104:: with SMTP id f4mr1155126oib.40.1573689993880;
 Wed, 13 Nov 2019 16:06:33 -0800 (PST)
MIME-Version: 1.0
References: <20191106225527.9121-1-mihailescu2m@gmail.com> <20191106225527.9121-2-mihailescu2m@gmail.com>
 <20191112151915.GA15786@kozik-lap>
In-Reply-To: <20191112151915.GA15786@kozik-lap>
From:   Marian Mihailescu <mihailescu2m@gmail.com>
Date:   Thu, 14 Nov 2019 10:36:23 +1030
Message-ID: <CAM3PiRwkSzD=23r9decc+wsEUvGvDDQ9bQF-stGFY180T4PHwQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] ARM: dts: exynos5420: add mali dt node and enable
 mali on Odroid XU3/4
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies - it was applied and tested on latest -rc, however I had
gpu_tmu enabled as well (by adding status=okay), line which was not
included in the patch and was the cause of it not applying. Fixed it
in the coming v5, tested and applies on a fresh -rc7.

Either I've been missing something or nothing has been going on. (K. E. Gordon)

On Wed, Nov 13, 2019 at 1:49 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Thu, Nov 07, 2019 at 09:25:27AM +1030, Marian Mihailescu wrote:
> > Add device tree node for Mali GPU for Exynos 542x SoC.
> > GPU is disabled by default, and is enabled for each board after the
> > regulator is defined. Tested on Odroid-XU4.
> >
> > Changes since v3:
> > - fixed compatible to match bindings
> >
> > Changes since v2:
> > - separate patch for bindings
> > - fixed bindings typo
> >
> > Changes since v1:
> > - used generic node and label for GPU
> > - added bindings for compatible
> > - fixed irq indentation
> > - fixed interrupt-names to match bindings
> > - added cooling cells for future TMU connection
> > - used generic node and label for GPU opp table
> > - removed always-on from SoC GPU regulator
> >
> > Signed-off-by: Marian Mihailescu <mihailescu2m@gmail.com>
> > ---
> >  arch/arm/boot/dts/exynos5420.dtsi             | 50 +++++++++++++++++++++++++++
> >  arch/arm/boot/dts/exynos5422-odroid-core.dtsi |  6 +++-
>
> Hi,
>
> Unfortunately this does not apply around exynos5422-odroid-core.dtsi.
> I think there were no changes to this file in current development cycle
> so I am surprised that there are conflicts.
>
> On what version were you basing your patch? Was it tested on latest
> kernel? The patches should be based usually on one of:
> 1. current-rc1 (v5.4-rc1)
> 2. latest-rc (v5.4-rc7)
> 3. maintainer's tree (my next/dt or for-next)
> 4. linux-next
>
> In all other cases the patch would need rebasing and re-testing.
>
> Best regards,
> Krzysztof
>
