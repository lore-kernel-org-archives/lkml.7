Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51C1C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 13:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F84820830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 13:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GcTUnz9x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731370AbfDJNuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 09:50:01 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:44269 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728553AbfDJNuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 09:50:01 -0400
Received: by mail-vk1-f193.google.com with SMTP id q189so564611vkq.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 06:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3/W7xviLZD4965MFFPe/ULcmZWMQnJA82fl70a5meCw=;
        b=GcTUnz9xZ4jlR0mziPMHMCPyYjEsgFQ23lhwxCfiku1AqXOgLalio/532ls+6j4kI7
         skoWjsH6+OdZ+t+jJJ+ixX6pUZn1cLxz1nDUAXK9J9gBaubc168GOFUFp6wiNU5nVw+u
         P8fvnezT8+ZSX7VoFzB/kP/mnicsinEktsniwy0SG9nChq3/u/oiRGo+xEbE3o3msDUa
         /+IvvuvtMChL8fGiQWmfQK2P8mArbSl3p5nrWyzo1LyWMQCM358Vlmyih8aEw9rgA9J5
         noyXsvaGJlK03d9iEa5cCxPjwqWNgRVoFN6zI0ZRjvYpFWmd+fibd5FWww109l8NlAci
         qb6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3/W7xviLZD4965MFFPe/ULcmZWMQnJA82fl70a5meCw=;
        b=m80rzE0Irkm3cs2GXO/mJCQkF72gBmQbUdfH4UOVtHiAnG0iRGBhUxaWUWrjw3WZ8a
         50buFgB7b8ADjaQB8uECSACzSv2ZcQ8bvh8yelYTUK9qt8aWLonkYUGk4BfXhS/BJgkm
         FN8Kw9C4MwNexTQeILImr9PNGAFWfAqxvOD0K7EVwGnlHJ1iuOFqfrh33Ta3KHH2fKyZ
         4MMoi+xYxCVLVuHxmOzYfSdsYAQUILPYsq9a0byRscSXgTIgjEHNVW7V49FXIIVuYWif
         7xz7JPtvQEKBZkzmDNmqnH8vtmi7l3DzCjrUYn27ZgE3DdpyvV4omgpbVH+WH34t/YRp
         8v2Q==
X-Gm-Message-State: APjAAAXbPiKq9NYwI8pBnL+8/wkiFL2Bd47M/yiPs8KXkWIumsNP5WA2
        ynAsO7LNKjJeKf823bjt34NRbBO+LtHhwbaM+XymILIoeMI=
X-Google-Smtp-Source: APXvYqwCaa0zmZGCCa/A1a9R/LBX3hsxT10Xt3XEk7G0+4YKHkL8bwg6kkrn42HB+McPtCsdq4Tj6NErVTUwvxWLYLc=
X-Received: by 2002:a1f:bf4b:: with SMTP id p72mr23769555vkf.77.1554904199690;
 Wed, 10 Apr 2019 06:49:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190410102754.387743324@linutronix.de> <20190410103647.294241460@linutronix.de>
In-Reply-To: <20190410103647.294241460@linutronix.de>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 10 Apr 2019 15:49:48 +0200
Message-ID: <CAG_fn=UbO3iMPe+CRF2GjenKT60264rktvSLK--eMbsfPuYCAw@mail.gmail.com>
Subject: Re: [RFC patch 41/41] lib/stackdepot: Remove obsolete functions
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 1:06 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> No more users of the struct stack_trace based interfaces.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Alexander Potapenko <glider@google.com>
> ---
>  include/linux/stackdepot.h |    4 ----
>  lib/stackdepot.c           |   20 --------------------
>  2 files changed, 24 deletions(-)
>
> --- a/include/linux/stackdepot.h
> +++ b/include/linux/stackdepot.h
> @@ -23,13 +23,9 @@
>
>  typedef u32 depot_stack_handle_t;
>
> -struct stack_trace;
> -
> -depot_stack_handle_t depot_save_stack(struct stack_trace *trace, gfp_t f=
lags);
>  depot_stack_handle_t stack_depot_save(unsigned long *entries,
>                                       unsigned int nr_entries, gfp_t gfp_=
flags);
>
> -void depot_fetch_stack(depot_stack_handle_t handle, struct stack_trace *=
trace);
>  unsigned int stack_depot_fetch(depot_stack_handle_t handle,
>                                unsigned long **entries);
>
> --- a/lib/stackdepot.c
> +++ b/lib/stackdepot.c
> @@ -212,14 +212,6 @@ unsigned int stack_depot_fetch(depot_sta
>  }
>  EXPORT_SYMBOL_GPL(stack_depot_fetch);
>
> -void depot_fetch_stack(depot_stack_handle_t handle, struct stack_trace *=
trace)
> -{
> -       unsigned int nent =3D stack_depot_fetch(handle, &trace->entries);
> -
> -       trace->max_entries =3D trace->nr_entries =3D nent;
> -}
> -EXPORT_SYMBOL_GPL(depot_fetch_stack);
> -
>  /**
>   * stack_depot_save - Save a stack trace from an array
>   *
> @@ -314,15 +306,3 @@ depot_stack_handle_t stack_depot_save(un
>         return retval;
>  }
>  EXPORT_SYMBOL_GPL(stack_depot_save);
> -
> -/**
> - * depot_save_stack - save stack in a stack depot.
> - * @trace - the stacktrace to save.
> - * @alloc_flags - flags for allocating additional memory if required.
> - */
> -depot_stack_handle_t depot_save_stack(struct stack_trace *trace,
> -                                     gfp_t alloc_flags)
> -{
> -       return stack_depot_save(trace->entries, trace->nr_entries, alloc_=
flags);
> -}
> -EXPORT_SYMBOL_GPL(depot_save_stack);
>
>


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
