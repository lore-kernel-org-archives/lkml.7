Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1050BC04E87
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 15:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF62B21019
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 15:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SCWW9XLd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728651AbfEUPxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 11:53:09 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:32849 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbfEUPxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 11:53:08 -0400
Received: by mail-vs1-f66.google.com with SMTP id y6so11471502vsb.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 08:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=M+Fy+Dv7IAvIp9wM9LD81KQdUDxns6+Ve3Y3gCcA6+w=;
        b=SCWW9XLdsPw9Dbsh5KL6xVyDY0rX4O5d9enGOPhpycV9Y6K9rosydI/Wlk6NyU8Kte
         BDjViIeiW8pDzy0+pXpuKIfOK6q7lCzsR5o+tsDOcS4oVA/Plo1Z/Gl7Xaw4/S3dfjlP
         +TYxG53nLwL/Hdxn/s7e8xypiQ2nTrPoW61MZCVDiWXaRdvGPcbHk5weJMjYioOICzdR
         HDJC8Ks4/5DvyQMaqKCbH20Idmf9eRPgf4NxzUvXhYL1aiewFYDHnFJO8yWGFdC4Sto5
         DpzS2u0AHAD5Fl5qXsTv9dmc55eSJa/zwDTnnViImT0urRRTpNpJ3KPIQsiYspU1cWtG
         Qnjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=M+Fy+Dv7IAvIp9wM9LD81KQdUDxns6+Ve3Y3gCcA6+w=;
        b=ZNXcHC4GVnzomAYYiqF3OYRdqzW4sysIXwnTv602mGQ18EvFFj2sY272stgz/je06t
         i7FYV+GzFJJ4QP7kPnn/nrqK9kd4LOUHExKap8T1P13kXZko37aOOemSCCjGfi5ug1so
         LS0EED22GyHMwYsaIvwO7Z2AZoMSjhl4PqPhHb0BdWkcV2h8nvBj6gIJEP29fZOVlmig
         bFUEK/V9vPprh1lF4acf5N/TqxpObfLz7tQMQy3n38CaBh1U8PYvQYp2MAOTX5E6TTV7
         BxmdjxnlqAQYxtATAJy0EWc6WusdXi9TQiuRhJ1Z9qMDNCznWGvTMdmDwX0S4AXEWBO5
         kmdw==
X-Gm-Message-State: APjAAAUWduNl3o/fXGOEzeg7WTXCaJ+MNFYM5F4+lqzim1xUGiz4UllF
        X+0d8kPAE/lCWzVdJP0IQjHlAZ3ovLfORtfAIpMsnQ==
X-Google-Smtp-Source: APXvYqy6IGMQPbJZO+kIouZqRoFw9qUZHLRLgIs6Dh6Xv5coJSMBcpEofSB2jHGaaeH09CNzCZFcAI0DOxFM1m/T2nA=
X-Received: by 2002:a67:d615:: with SMTP id n21mr26515680vsj.39.1558453987203;
 Tue, 21 May 2019 08:53:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190520154751.84763-1-elver@google.com> <ebec4325-f91b-b392-55ed-95dbd36bbb8e@virtuozzo.com>
In-Reply-To: <ebec4325-f91b-b392-55ed-95dbd36bbb8e@virtuozzo.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 21 May 2019 17:52:55 +0200
Message-ID: <CAG_fn=W+_Ft=g06wtOBgKnpD4UswE_XMXd61jw5ekOH_zeUVOQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm/kasan: Print frame description for stack bugs
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     Marco Elver <elver@google.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 5:43 PM Andrey Ryabinin <aryabinin@virtuozzo.com> w=
rote:
>
>
>
> On 5/20/19 6:47 PM, Marco Elver wrote:
>
> > +static void print_decoded_frame_descr(const char *frame_descr)
> > +{
> > +     /*
> > +      * We need to parse the following string:
> > +      *    "n alloc_1 alloc_2 ... alloc_n"
> > +      * where alloc_i looks like
> > +      *    "offset size len name"
> > +      * or "offset size len name:line".
> > +      */
> > +
> > +     char token[64];
> > +     unsigned long num_objects;
> > +
> > +     if (!tokenize_frame_descr(&frame_descr, token, sizeof(token),
> > +                               &num_objects))
> > +             return;
> > +
> > +     pr_err("\n");
> > +     pr_err("this frame has %lu %s:\n", num_objects,
> > +            num_objects =3D=3D 1 ? "object" : "objects");
> > +
> > +     while (num_objects--) {
> > +             unsigned long offset;
> > +             unsigned long size;
> > +
> > +             /* access offset */
> > +             if (!tokenize_frame_descr(&frame_descr, token, sizeof(tok=
en),
> > +                                       &offset))
> > +                     return;
> > +             /* access size */
> > +             if (!tokenize_frame_descr(&frame_descr, token, sizeof(tok=
en),
> > +                                       &size))
> > +                     return;
> > +             /* name length (unused) */
> > +             if (!tokenize_frame_descr(&frame_descr, NULL, 0, NULL))
> > +                     return;
> > +             /* object name */
> > +             if (!tokenize_frame_descr(&frame_descr, token, sizeof(tok=
en),
> > +                                       NULL))
> > +                     return;
> > +
> > +             /* Strip line number, if it exists. */
>
>    Why?
>
> > +             strreplace(token, ':', '\0');
> > +
>
> ...
>
> > +
> > +     aligned_addr =3D round_down((unsigned long)addr, sizeof(long));
> > +     mem_ptr =3D round_down(aligned_addr, KASAN_SHADOW_SCALE_SIZE);
> > +     shadow_ptr =3D kasan_mem_to_shadow((void *)aligned_addr);
> > +     shadow_bottom =3D kasan_mem_to_shadow(end_of_stack(current));
> > +
> > +     while (shadow_ptr >=3D shadow_bottom && *shadow_ptr !=3D KASAN_ST=
ACK_LEFT) {
> > +             shadow_ptr--;
> > +             mem_ptr -=3D KASAN_SHADOW_SCALE_SIZE;
> > +     }
> > +
> > +     while (shadow_ptr >=3D shadow_bottom && *shadow_ptr =3D=3D KASAN_=
STACK_LEFT) {
> > +             shadow_ptr--;
> > +             mem_ptr -=3D KASAN_SHADOW_SCALE_SIZE;
> > +     }
> > +
>
> I suppose this won't work if stack grows up, which is fine because it gro=
ws up only on parisc arch.
> But "BUILD_BUG_ON(IS_ENABLED(CONFIG_STACK_GROUWSUP))" somewhere wouldn't =
hurt.
Note that KASAN was broken on parisc from day 1 because of other
assumptions on the stack growth direction hardcoded into KASAN
(e.g. __kasan_unpoison_stack() and __asan_allocas_unpoison()).
So maybe this BUILD_BUG_ON can be added in a separate patch as it's
not specific to what Marco is doing here?
>
> --
> You received this message because you are subscribed to the Google Groups=
 "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kasan-dev+unsubscribe@googlegroups.com.
> To post to this group, send email to kasan-dev@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/kasan-dev/ebec4325-f91b-b392-55ed-95dbd36bbb8e%40virtuozzo.com.
> For more options, visit https://groups.google.com/d/optout.



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
