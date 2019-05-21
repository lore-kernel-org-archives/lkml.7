Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 328CDC04E87
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 16:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F211D2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 16:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SslTEkbd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbfEUQHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 12:07:51 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34249 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbfEUQHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 12:07:50 -0400
Received: by mail-ot1-f68.google.com with SMTP id l17so16862938otq.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 09:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z6DwY5PU6T6VLE2Cxc9SEtMv6vL/0lIxHi6A4Ph2gaM=;
        b=SslTEkbdrlh+dYn1Z2W0PtxBFm87izCTK1dQ7tOb865Ax7UFvqpS5sEEsMfHN/jPt4
         ArS1sJ3XSNP/EeAIKaLyVqYC8EiXiubErXlPjLcp+TyxJAnybFh16zALk/7gtxozJ41P
         KzASIrypc+6NtC9XdsGoAw1uMIjWfxQX6Z1RlBG3zDpvdLdxwWGRXiaAU9lXevplUU4q
         zUYpyyWHjMnF+TUT+mvvj0aHcn3/ZAaR/T7k6F8wm+ezWT12bHRSp0ZcoZBjjCUJtmlu
         hE6THKH/921P6gA0xBGqAXuBDU6uh+7eqvIz6hNvFTs+RsExIrG1H79MaOo4k4dkL4kY
         l5+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z6DwY5PU6T6VLE2Cxc9SEtMv6vL/0lIxHi6A4Ph2gaM=;
        b=Y2BM+g0gHwj1VH+VC3WAod9BM6Hgrr0P9O2T4B/ttmOXQw70Rl8WYlwndkdVJpiMHF
         KXOTNkgtNZA6splHBDvlhl6UuOM/wPQ6Wgl/b05hAyuQSl0VYqEWSqDO+Ks2RxFiqDA2
         9Rgh0jubWWytq2yVzfI2XPWoFOx3dU1ZO0liuiZLNwuqtvNbHXi6bJJcIF0c3WBZen42
         vdGCsUtaJEr9rz5dp4+YHpf9rwsBemSPEfOIQ3agDXq1U51mGb/MdCU9JEl9LBZN+04r
         nHPlbeaMZs+YXoxhJsxHqMEtMEQaQXWvLuwOx74gqVneAmG8y9UjH2k4BQuLDLBx0Bl5
         fK5g==
X-Gm-Message-State: APjAAAVN8JKqBKUcZtOnaoE+HXQvhEMnDFcc27bBUtp113UqKj1SePec
        6SMyKxUzY9Dv3l/OwO31Q2GcbkznAS1qFMllSnuS0Q==
X-Google-Smtp-Source: APXvYqyf0tOjVEyL+KKurLWTQXmmLJuTqu1V19ngBUj4PHyEdLuQ8Dtp7m/dOY8siMci3gIMl1odSi90OcaYYfOkpLw=
X-Received: by 2002:a9d:362:: with SMTP id 89mr6331724otv.17.1558454869448;
 Tue, 21 May 2019 09:07:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190520154751.84763-1-elver@google.com> <ebec4325-f91b-b392-55ed-95dbd36bbb8e@virtuozzo.com>
 <CAG_fn=W+_Ft=g06wtOBgKnpD4UswE_XMXd61jw5ekOH_zeUVOQ@mail.gmail.com>
In-Reply-To: <CAG_fn=W+_Ft=g06wtOBgKnpD4UswE_XMXd61jw5ekOH_zeUVOQ@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 21 May 2019 18:07:37 +0200
Message-ID: <CANpmjNN177XBadNfoSmizQF7uZV61PNPQSftT7hPdc3HmdzSjA@mail.gmail.com>
Subject: Re: [PATCH v2] mm/kasan: Print frame description for stack bugs
To:     Alexander Potapenko <glider@google.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 May 2019 at 17:53, Alexander Potapenko <glider@google.com> wrote:
>
> On Tue, May 21, 2019 at 5:43 PM Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:
> >
> > On 5/20/19 6:47 PM, Marco Elver wrote:
> >
> > > +static void print_decoded_frame_descr(const char *frame_descr)
> > > +{
> > > +     /*
> > > +      * We need to parse the following string:
> > > +      *    "n alloc_1 alloc_2 ... alloc_n"
> > > +      * where alloc_i looks like
> > > +      *    "offset size len name"
> > > +      * or "offset size len name:line".
> > > +      */
> > > +
> > > +     char token[64];
> > > +     unsigned long num_objects;
> > > +
> > > +     if (!tokenize_frame_descr(&frame_descr, token, sizeof(token),
> > > +                               &num_objects))
> > > +             return;
> > > +
> > > +     pr_err("\n");
> > > +     pr_err("this frame has %lu %s:\n", num_objects,
> > > +            num_objects == 1 ? "object" : "objects");
> > > +
> > > +     while (num_objects--) {
> > > +             unsigned long offset;
> > > +             unsigned long size;
> > > +
> > > +             /* access offset */
> > > +             if (!tokenize_frame_descr(&frame_descr, token, sizeof(token),
> > > +                                       &offset))
> > > +                     return;
> > > +             /* access size */
> > > +             if (!tokenize_frame_descr(&frame_descr, token, sizeof(token),
> > > +                                       &size))
> > > +                     return;
> > > +             /* name length (unused) */
> > > +             if (!tokenize_frame_descr(&frame_descr, NULL, 0, NULL))
> > > +                     return;
> > > +             /* object name */
> > > +             if (!tokenize_frame_descr(&frame_descr, token, sizeof(token),
> > > +                                       NULL))
> > > +                     return;
> > > +
> > > +             /* Strip line number, if it exists. */
> >
> >    Why?

The filename is not included, and I don't think it adds much in terms
of ability to debug; nor is the line number included with all
descriptions. I think, the added complexity of separating the line
number and parsing is not worthwhile here. Alternatively, I could not
pay attention to the line number at all, and leave it as is -- in that
case, some variable names will display as "foo:123".

> >
> > > +             strreplace(token, ':', '\0');
> > > +
> >
> > ...
> >
> > > +
> > > +     aligned_addr = round_down((unsigned long)addr, sizeof(long));
> > > +     mem_ptr = round_down(aligned_addr, KASAN_SHADOW_SCALE_SIZE);
> > > +     shadow_ptr = kasan_mem_to_shadow((void *)aligned_addr);
> > > +     shadow_bottom = kasan_mem_to_shadow(end_of_stack(current));
> > > +
> > > +     while (shadow_ptr >= shadow_bottom && *shadow_ptr != KASAN_STACK_LEFT) {
> > > +             shadow_ptr--;
> > > +             mem_ptr -= KASAN_SHADOW_SCALE_SIZE;
> > > +     }
> > > +
> > > +     while (shadow_ptr >= shadow_bottom && *shadow_ptr == KASAN_STACK_LEFT) {
> > > +             shadow_ptr--;
> > > +             mem_ptr -= KASAN_SHADOW_SCALE_SIZE;
> > > +     }
> > > +
> >
> > I suppose this won't work if stack grows up, which is fine because it grows up only on parisc arch.
> > But "BUILD_BUG_ON(IS_ENABLED(CONFIG_STACK_GROUWSUP))" somewhere wouldn't hurt.
> Note that KASAN was broken on parisc from day 1 because of other
> assumptions on the stack growth direction hardcoded into KASAN
> (e.g. __kasan_unpoison_stack() and __asan_allocas_unpoison()).
> So maybe this BUILD_BUG_ON can be added in a separate patch as it's
> not specific to what Marco is doing here?

Happy to send a follow-up patch, or add here. Let me know what you prefer.

Thanks,
-- Marco
