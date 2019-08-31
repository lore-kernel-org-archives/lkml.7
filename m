Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93EC2C3A5A8
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 16:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 685172190F
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 16:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fS+2dRlM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbfHaQqO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 31 Aug 2019 12:46:14 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:32860 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727836AbfHaQqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 12:46:14 -0400
Received: by mail-wm1-f68.google.com with SMTP id r17so8664753wme.0
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2019 09:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bWNyzY6frPd9AVvoBYLqQl+upEDUNdJLOAMB1R+T9tw=;
        b=fS+2dRlMhE+Nq5glJysLmAuytzq9t4tg0oXMrARfiKlHHK7ICA88SF8nlV23LyVver
         dZ7iD91N78LuBLyx36/IgB3mzS7pCjbMu0Burnkf9y8qaVzliT7X6jKR8Mkps5/hhljF
         coeveC5lriwf0g1b01PlY3yav3r33RPaCOgRS7wd/DMXs+mIxBj/wk5zu7+sT7wxjGTr
         fTHxhUPECasNXgXz79az5b4ChhtUd6Q2wxz6iuDKEqo+jjJiLwc9xdDZSusSWlvBgeJT
         la19MgY9UhYxuhZ5wIeIVhMH0u3Loaw13hgns8mk//FxDYwBUuP/T2oWBLYXdu4kzfr5
         c/rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bWNyzY6frPd9AVvoBYLqQl+upEDUNdJLOAMB1R+T9tw=;
        b=UQrmAaNGTneniIwR30BVLSy8NziXKvBfZYwKVy51ptXGxvoxC2E5i52RLR6AatS214
         31+TiZRx3VJ8Ih5pH4JMqJ8zDtzWrK5vKwLbGrnGWNEPYNRXSDor/NdzTl74X9OwS3/g
         sWVivEIMLMhafYXcxYssQ1JXtv/pgxQTsUGgj2M9n1HkV7rmxlv8MCGRlEYAL0BVMEeL
         5gwXhIAa0Z8cjWLN56+vn6xkzkJHA8bOPcuXadLmQOZQ6AsMFXThBWi1oq5u6xJokvKY
         +RKZqUDIg0D/d3Ztqv0568N6Jd9xz5jr28TVOtHQPO8sTmR48MWKudzKu8JelzeGlT/O
         AjiA==
X-Gm-Message-State: APjAAAWiu35az3K1Z54v+jrusUn/qch/iwYq3Gb5sWmXksuDV2j9A0Zw
        yFqPfv+G/Pm2FP7LnsVUIL6iO6Fnf0KJQXQ42Ig7Nw==
X-Google-Smtp-Source: APXvYqw73e47gqPAFZzq9Fl8OhY84mjlhLrpWKD4cPQ2bmwO8nm9bJP4z3WDbiTuRuxz5sygO3s2fj/kXPbJhsfJbJY=
X-Received: by 2002:a7b:cb8e:: with SMTP id m14mr26387918wmi.10.1567269971792;
 Sat, 31 Aug 2019 09:46:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190826153028.32639-1-pjones@redhat.com> <20190826153028.32639-2-pjones@redhat.com>
In-Reply-To: <20190826153028.32639-2-pjones@redhat.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sat, 31 Aug 2019 19:46:00 +0300
Message-ID: <CAKv+Gu-MvRyq5ODkkMcT500iw6Di4CDWEfWh9-7pLkj425rPFA@mail.gmail.com>
Subject: Re: [PATCH 2/2] efi+tpm: don't traverse an event log with no events
To:     Peter Jones <pjones@redhat.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Matthew Garrett <mjg59@google.com>,
        Bartosz Szczepanek <bsz@semihalf.com>,
        Lyude Paul <lyude@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Aug 2019 at 18:30, Peter Jones <pjones@redhat.com> wrote:
>
> When there are no entries to put into the final event log, some machines
> will return the template they would have populated anyway.  In this case
> the nr_events field is 0, but the rest of the log is just garbage.
>
> This patch stops us from trying to iterate the table with
> __calc_tpm2_event_size() when the number of events in the table is 0.
>
> Signed-off-by: Peter Jones <pjones@redhat.com>
> Tested-by: Lyude Paul <lyude@redhat.com>
> ---
>  drivers/firmware/efi/tpm.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
> index 1d3f5ca3eaa..be51ed17c6e 100644
> --- a/drivers/firmware/efi/tpm.c
> +++ b/drivers/firmware/efi/tpm.c
> @@ -75,11 +75,15 @@ int __init efi_tpm_eventlog_init(void)
>                 goto out;
>         }
>
> -       tbl_size = tpm2_calc_event_log_size((void *)efi.tpm_final_log
> -                                           + sizeof(final_tbl->version)
> -                                           + sizeof(final_tbl->nr_events),
> -                                           final_tbl->nr_events,
> -                                           log_tbl->log);
> +       tbl_size = 0;
> +       if (final_tbl->nr_events != 0) {
> +               void *events = (void *)efi.tpm_final_log
> +                               + sizeof(final_tbl->version)
> +                               + sizeof(final_tbl->nr_events);

Please put a newline here

With that fixed,

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> +               tbl_size = tpm2_calc_event_log_size(events,
> +                                                   final_tbl->nr_events,
> +                                                   log_tbl->log);
> +       }
>         memblock_reserve((unsigned long)final_tbl,
>                          tbl_size + sizeof(*final_tbl));
>         early_memunmap(final_tbl, sizeof(*final_tbl));
> --
> 2.23.0.rc2
>
