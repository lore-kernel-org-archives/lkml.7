Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF92AC10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A2252133D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sl2qd3Jf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731312AbfDJLby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 07:31:54 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:38866 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727206AbfDJLby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 07:31:54 -0400
Received: by mail-it1-f196.google.com with SMTP id f22so2743862ita.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 04:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fvn/7zFnF3HAnTBufLjHdB464PsWTUouxpzbMSb1H2g=;
        b=sl2qd3Jf3qmCvfIH/SLL8F3Jdiy1HR05kNdYcy8+mkI+eYuoGCyBXZ8jKlU2/ZvX3v
         j5BPcckdL8liLVmp0hb/d0qL/hnSN6a6y+emyi8hPCvPKkHhKBRTvguhIRJl7ukEj/TD
         AfIcEewOPg9RWGcp4deatK1YePDRlkk/ZrBo1QfsYvxHp3K1LvJps037mMeV6TFfYgDk
         7l+xa/X4JrKtOPDWSlTmFVfynoyr96WEJi+70PYVdKLUvQi9/vrXKCLZ+kJzm1IJOhVa
         a73mdwUY31qMvU1zriLqta/Q+Nb8TmzUDN6AL2UrUwnlmd4O99l17yGfkUnUcH4VBuZR
         Ufgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fvn/7zFnF3HAnTBufLjHdB464PsWTUouxpzbMSb1H2g=;
        b=hI51E6TkXqKLhENJiuu3jGnjB/lET4AbgNj8xiuu+obsxdZbHpWGqFk6gOLCQ44JAC
         JIcXtyNpXvlt4KcS+Aj7EDioJZv0isDHSdrv601+exrD6NfQUzfESr4oivN00/jp8yEf
         mm19TJfe65keFo3gAoDZtOwf4qmDTWnMowAsm/ZGbRXn95jKo7hFDe461OFCfaxbGt5Y
         C4RtSIlMWbrcx3l72ldzh0o+2tWDFZgNTek3VSvmPoYChC1+cOv7py8GCj5q7/ggKnhC
         gCDfiF+yBqZc3gIftI2FL+CU9ACc/OuIvRRceUYV5QId3lQRBu7Y8dEeH3B+xtpOEg+l
         WdlQ==
X-Gm-Message-State: APjAAAUwRR+CO6cXTDDPnFPpVK2O7YVDAsqgwSHRME34mShc5jUJOTGx
        451+Ua8DRl30azdCj0q5cOf/rjdXMKybL5Q3YVQVhGgrlkk=
X-Google-Smtp-Source: APXvYqx+/T8WY03v9xLmT+TvaJRfgwlIvB0PUC6j88bxk0iWtwftMluJ5tPLM6WK/fA+GPicKD1rsJwSBv8R4E8L55w=
X-Received: by 2002:a24:3d8f:: with SMTP id n137mr2634250itn.96.1554895912971;
 Wed, 10 Apr 2019 04:31:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190410102754.387743324@linutronix.de> <20190410103644.750219625@linutronix.de>
In-Reply-To: <20190410103644.750219625@linutronix.de>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 10 Apr 2019 13:31:41 +0200
Message-ID: <CACT4Y+YO45bfyCaeaLP-xAVDOjSE8xnbXpv-Dz7t3W7C5jPd6Q@mail.gmail.com>
Subject: Re: [RFC patch 13/41] mm/kasan: Remove the ULONG_MAX stack trace hackery
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexander Potapenko <glider@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 1:05 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> No architecture terminates the stack trace with ULONG_MAX anymore. Remove
> the cruft.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: kasan-dev@googlegroups.com
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: linux-mm@kvack.org
> ---
>  mm/kasan/common.c |    3 ---
>  1 file changed, 3 deletions(-)
>
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -74,9 +74,6 @@ static inline depot_stack_handle_t save_
>
>         save_stack_trace(&trace);
>         filter_irq_stacks(&trace);
> -       if (trace.nr_entries != 0 &&
> -           trace.entries[trace.nr_entries-1] == ULONG_MAX)
> -               trace.nr_entries--;
>
>         return depot_save_stack(&trace, flags);
>  }


Acked-by: Dmitry Vyukov <dvyukov@google.com>
