Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA940C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 14:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCABC2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 14:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7ywDKvU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbfD3Ood (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 10:44:33 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39350 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfD3Ood (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 10:44:33 -0400
Received: by mail-wm1-f65.google.com with SMTP id n25so4134522wmk.4;
        Tue, 30 Apr 2019 07:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pOCCixSugNLHcLoYqitg1TZT4uv7ya5+Gsj2edpM8YY=;
        b=l7ywDKvUKy37DfKA1bXXREOj6NG4j43dDLqOVaD17pSX0GS3yxJo1WDDwqMvGF4uRU
         Q2p6DEjedQx7aHk9TsKN/90J6lampcqYrlG6ZQktl4AnPs6IhekPtFq0Ll3wlwjlsC57
         2thAMZVP9Glegaji2BsJDT3eLaLFbOinu93nvQVdwELwYXABHrt5ZGgmBzM5/ZT5d/Sw
         Ul0nKl07ZUmhYiX2vAYs7eqfjSYwjk8fWfY7o9WHUTbM6ZN7/N8nhoJRf3/rZY4I+6UN
         XlTNb42gXkEOAHI8qzwpQzZow6YXG+fy95VkKjYb05/Z+lZ2HVXDn0BgWfIiy5lwjUf2
         7d6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pOCCixSugNLHcLoYqitg1TZT4uv7ya5+Gsj2edpM8YY=;
        b=RuEsRHK1J03fo0NFcKpFjPz05y3KdT6Yn0pdoXJhtptggqlnePgiSmDW4FLthafIiy
         DfeqMzcqg1urX5OhkFDvqNfsb5NX2G8mweyEinNe+QX2k9TMxFA0T90Lzgrj440uIhaL
         RQS3EUalwVAfTRIM2hXbnbwgMZS3BV0OJwnpVFcWZon9t19M5aiOUmfj79Jlc5oWXgth
         SdhzL1y+mI+HeBlF3KYc8gkoXrA6mtqNvfWUX/iSnIm/tf5xrGSNAn2CNKcxd1Hi/byQ
         PRZUM6Hdau3cfky2okzQgqIhRIcEtqu2AvfQ5rCLy4TclmKSS/UZ67opcAbBs3QyAh3z
         V1wA==
X-Gm-Message-State: APjAAAWjUT/dqhQ+yvd9ZIhtnxigFvf7so0qrqZK6ry24vyrY6rH9krS
        Qktjwc7ndo1a4EGmt75VlCgKhN1cKEEhZtR5UqU=
X-Google-Smtp-Source: APXvYqxUPAnuO8hPP5iTe+wT+Y5GHV2cPdDfd/xk32hSaJ17FvPDy3axyPrC/Q8JjIcm4Zr99hnAIn+DTSGrxUUMD9o=
X-Received: by 2002:a7b:ce06:: with SMTP id m6mr3284490wmc.62.1556635471068;
 Tue, 30 Apr 2019 07:44:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190430090044.16345-1-tranmanphong@gmail.com> <20190430133231.GA5646@infradead.org>
In-Reply-To: <20190430133231.GA5646@infradead.org>
From:   Phong Tran <tranmanphong@gmail.com>
Date:   Tue, 30 Apr 2019 21:44:19 +0700
Message-ID: <CAD3AR6EU53O_KDR=k6B6Ubrn4Cvec7Gn5xQVQssCA-KFb=uBRg@mail.gmail.com>
Subject: Re: [PATCH] of: replace be32_to_cpu to be32_to_cpup
To:     Christoph Hellwig <hch@infradead.org>
Cc:     robh+dt@kernel.org, frowand.list@gmail.com,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        natechancellor@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 8:32 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Tue, Apr 30, 2019 at 04:00:44PM +0700, Phong Tran wrote:
> >
> > diff --git a/include/linux/of.h b/include/linux/of.h
> > index e240992e5cb6..1c35fc8f19b0 100644
> > --- a/include/linux/of.h
> > +++ b/include/linux/of.h
> > @@ -235,7 +235,7 @@ static inline u64 of_read_number(const __be32 *cell, int size)
> >  {
> >       u64 r = 0;
> >       while (size--)
> > -             r = (r << 32) | be32_to_cpu(*(cell++));
> > +             r = (r << 32) | be32_to_cpup(cell++);
> >       return r;
>
> This whole function looks odd.  It could simply be replaced with
> calls to get_unaligned_be64 / get_unaligned_be32.  Given that we have a
> lot of callers we can't easily do that, but at least we could try
> something like
>
It's risky. there are many callers of of_read_number().
There is suggestion from David
(https://lore.kernel.org/lkml/46b3e8edf27e4c8f98697f9e7f2117d6@AcuMS.aculab.com/)
only changing the loop.

> static inline u64 of_read_number(const __be32 *cell, int size)
> {
>         WARN_ON_ONCE(size < 1);
>         WARN_ON_ONCE(size > 2);
>
>         if (size == 1)
>                 return get_unaligned_be32(cell);
>         return get_unaligned_be64(cell);
> }

Thank you for your support.

Phong.
