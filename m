Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 997F9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 07:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 613A3214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 07:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pwpmmOsQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfCLHO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 03:14:27 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34150 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfCLHO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 03:14:27 -0400
Received: by mail-pg1-f195.google.com with SMTP id v12so1150641pgq.1;
        Tue, 12 Mar 2019 00:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=40K4bEwW49mdO0g97HTNb3yDTTIDRWnyercG8bXT2Zg=;
        b=pwpmmOsQpLeKrDxKGoXgW0T6FL4Frp/C4vyN7ZTOmD/xlaw/hYhkQnUsl+a7f0hp5y
         Rq3eN7rDP2ZCGRTcaz5KBDV6uCLi85uqJu+2tXNSIrIzxNo3kZR3T237m6NfDbHa/PpU
         xVHDXIA6Fx+/6HYuJbcHCX3TmKHULicITZD53aQo9Bwud9nTug90hNnUOIgtRUdgzEri
         Og32pvRveIHoRIdABrk6nCeU92eX1ICAONIIAQa3LmV06hkXS/glwuqEgDg59b6jk7N7
         MYIgGJoL/cDvq57O+JZZUQmX/yef3zlx39XAmhJmUWqWNhrdr1MDWDncl7EveollSsFa
         evyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=40K4bEwW49mdO0g97HTNb3yDTTIDRWnyercG8bXT2Zg=;
        b=RFH9yzNkMg8P1LrkM6OGiIObeFvGwVWVY2ZqrHO1XNzl8naF9prORTnDvZHkJwR4W0
         fCmxSuVyqmfJCwqEfEJxgBCn7B68Pg7niSnbLsjgzki4jSx67nIiQm5WH27bjKcf4KVx
         rLtSwyJXmFtqeK1F1NFwNoTd7C2iDFe3ZOzvCEI5UzXGRUJvWu2EaevPjx/7U6ZRSdC0
         zmChPjhtYNd59kodR1J2WqS1JXRXrNErzMgAkBHmkG6O4ZbGs1G9gVPTQ8+fen/IiIfy
         KbHRDm956e0RJNAvfhbxqIlTlvB2ADVZA+I765Pua6TwvA2Jq1qRJHrRixF0mvRqAwTQ
         0MTQ==
X-Gm-Message-State: APjAAAXAenCuD0CnNxHDC+QKgxehXA9mrwNX30lhgC2ig4B7EKlsI3w6
        Neyv08+X6QBvmxQB9SZ/6uLZQ5mrk6nxpVQWj4k=
X-Google-Smtp-Source: APXvYqxijNDiNTvbtkISkcwJUJBkomeskkUW28eBK//jP4wDUxJmI1ALNy4FcHoWLSSzO5DaRXtA29XbCSdD1LPx1Zo=
X-Received: by 2002:a17:902:a40d:: with SMTP id p13mr37116602plq.144.1552374866349;
 Tue, 12 Mar 2019 00:14:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1551598603.git.vilhelm.gray@gmail.com> <12b3a364ac7fc32194fa6f55911dd800aca92a56.1551598603.git.vilhelm.gray@gmail.com>
 <CAK7LNATW7uKB2-wMytLSpb8dPLkWbirptCgU=LAq3PYRtgOuXg@mail.gmail.com>
In-Reply-To: <CAK7LNATW7uKB2-wMytLSpb8dPLkWbirptCgU=LAq3PYRtgOuXg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 12 Mar 2019 09:14:14 +0200
Message-ID: <CAHp75Veic69S5uG2VQxYT4L0WHp2H+SwiyJgHhQN_Lk8Atr55g@mail.gmail.com>
Subject: Re: [PATCH v9 1/9] bitops: Introduce the for_each_set_clump8 macro
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 7:04 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> On Sun, Mar 3, 2019 at 4:48 PM William Breathitt Gray
> <vilhelm.gray@gmail.com> wrote:
> >
> > This macro iterates for each 8-bit group of bits (clump) with set bits,
> > within a bitmap memory region. For each iteration, "start" is set to the
> > bit offset of the found clump, while the respective clump value is
> > stored to the location pointed by "clump". Additionally, the
> > bitmap_get_value8 and bitmap_set_value8 functions are introduced to
> > respectively get and set an 8-bit value in a bitmap memory region.

> > +/**
> > + * bitmap_get_value8 - get an 8-bit value within a memory region
> > + * @bitmap: address to the bitmap memory region
> > + * @size: bitmap size in number of bits
> > + * @start: bit offset of the 8-bit value
> > + *
> > + * Returns the 8-bit value located at the @start bit offset within the @bitmap
> > + * memory region.
> > + */
> > +unsigned long bitmap_get_value8(const unsigned long *const bitmap,
> > +                               const unsigned int size,
> > +                               const unsigned int start)
>
>
> The comment says this function returns '8-bit value'.
>
> The return type should be 'u8' instead of 'unsigned long', then.
>
> Same for other helpers.

This is done in a way to be consistent with the rest of bitmap API.
None of them returns boolean, for example, for single bit.

-- 
With Best Regards,
Andy Shevchenko
