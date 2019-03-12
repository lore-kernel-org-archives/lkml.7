Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08EFCC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 13:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5367214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 13:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbfCLNrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 09:47:14 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:45750 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfCLNrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 09:47:13 -0400
Received: by mail-vs1-f66.google.com with SMTP id n14so1583704vsp.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 06:47:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jEqe7fHQSDq3P17fEHOwV74BVUOfoKmBYIAhanYgSNo=;
        b=nFAkbbRB13IiUEnwsZoREPcKzqWsk4S6N505Pe9qPQ7Hko0jVUqnqvcgCrsDA0cRXz
         m8HVjt6LhdS07WKF9NfFDdPTFDvsA7g2ZfEyCyGlB5FGPA3wKbQIMtq0UBd2Jx8Phs4x
         FQBXiOPyvG2ccM21IahH1EpUe48+oyfvOBvPvQhPx2xdztx8tWK+4HGrtyE1HTPHa6YK
         ZtBvf8/zHaHF6FoXv7g9HbvkeXyDox0JZtPp1jnlIDgShck9NEeTtcfUGUrTfhkHkxLU
         qsu4K+iHBuxRxVxz0sDdywJrd7M61nqq3jeU59ElJeTeUekWvTdhTxlRsXlbmWdlnm42
         AbuQ==
X-Gm-Message-State: APjAAAWqZ5J5ecAto4KPbeyEb1rkgMbj+Figpg+wCCxB/8e2MavY6xEA
        ZpmbOZ+VvmjSEEcGzS83R/cOSQe4yg0tt/FMLx8=
X-Google-Smtp-Source: APXvYqw1Lb6CnrtUOebSk9aR/iZsfg6F28h1I93uS4OseE+2hHRb5qilmatSoIbfz5FlBQY63KWYrDearW7d48RoD6o=
X-Received: by 2002:a67:78ce:: with SMTP id t197mr19789664vsc.152.1552398432798;
 Tue, 12 Mar 2019 06:47:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190312131830.4253-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20190312131830.4253-1-andriy.shevchenko@linux.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 12 Mar 2019 14:47:01 +0100
Message-ID: <CAMuHMdVTKRJJDqtpgExmEmwnYcpF8h2xTtbXwKLnVmVPz0bZqw@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] auxdisplay: hd44780: Fix memory leak on ->remove()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Willy Tarreau <willy@haproxy.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Tue, Mar 12, 2019 at 2:18 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> We have to free on ->remove() the allocated resources on ->probe().
>
> Fixes: d47d88361fee ("auxdisplay: Add HD44780 Character LCD support")
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks, nice catch!

> --- a/drivers/auxdisplay/hd44780.c
> +++ b/drivers/auxdisplay/hd44780.c
> @@ -280,6 +280,8 @@ static int hd44780_remove(struct platform_device *pdev)
>         struct charlcd *lcd = platform_get_drvdata(pdev);
>
>         charlcd_unregister(lcd);
> +
> +       kfree(lcd);

(wearing a newer (and hopefully wiser ;-) hat than when I wrote the code)

While this is correct for the current implementation of struct charlcd_priv,
this may be a bit fragile.

What about adding a charlcd_free() wrapper, which can do kfree(to_priv(lcd)),
and be used in the probe failure path, too?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
