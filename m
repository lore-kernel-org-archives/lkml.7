Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1BF8C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 13:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4D7521789
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 13:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7bbPhUR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbfK1Nnk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 08:43:40 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35062 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbfK1Nnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 08:43:40 -0500
Received: by mail-lf1-f66.google.com with SMTP id r15so17159366lff.2;
        Thu, 28 Nov 2019 05:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cd2VbZg4ttAmtwowpOvGkpOMhfD47zV7nrpcB163FnI=;
        b=a7bbPhURvEt2bJ/jlJj4euoFwbntxk/kWi1v6jOt6tmwGxUaGRb2kGoPFPefJkufEu
         R1LP1Pls0n3Cq8YBcEJIk1aj1wC5nj7+/7qHkqPoCrsimkvp9I0qswMBFYCODLW+1K7O
         V9gG/ggmFng3NYmbFgK2T0cmwgu3UPwUo4zlYiXUpegu5ZfX7pp8X/Oz+5w3yZ07g6VK
         LRw2JFO9J7Z9MZHv4V6+ecmKCG1ZO0nyHwRx837oXDuNml65GeBY3p1BBccnKucNiPhZ
         ja1a6ZBO+7Z952Ub1Qm3hl9YnjL9trduLMJJEybWLMzOAfPVwRKpZM2uz0QuSk9ktSEx
         FZlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cd2VbZg4ttAmtwowpOvGkpOMhfD47zV7nrpcB163FnI=;
        b=dEW8867jPyLqZcKxsn0kJiZaAV4mellMlT/z9jhSS1NFWAFPyo6+t+b/i2qQ4X04wm
         8Ec7o2GICTXTtGZqnbzrUYXn+uC8jQ3Lp0MU+86eyCT3CpPuJp74f8MMjIjQvbHqIiTL
         Gez9RwxUCrcjS2pYIu4XY7O3YVSh49YjW9lEz1Pj8TYhG/l5kIIgb4LSigpPYXRabLve
         1+xtGTUMkE1KXd0Z4TKPxUCFNb+up7sJWEKJ/6+VE6WSytyRdCbUe0ZKhN4IwcVfn5ac
         nXQq8wonNg9SxWCBGqIX6lPvDfpRhEpmXoE78jgnfB2UaAjLqy7LJMcxt6IgXnF87hVq
         WD4g==
X-Gm-Message-State: APjAAAUw9BcISKjDXopmelAxGvKMGAvr91vQ6wBEt/qUBfF/+GLYsaJn
        qU53VhhXecdTWXSxLcjew/QP0fFT27e+gGOzzQc=
X-Google-Smtp-Source: APXvYqzZ5EpHcT4cXKjh6Jz7oyLhQIezJbIsIQiow34NAgZlQKYot8Q/s9s4FEI+DFH4Lou44c9BzsgnJAKle376DvI=
X-Received: by 2002:a19:a406:: with SMTP id q6mr32550464lfc.0.1574948617878;
 Thu, 28 Nov 2019 05:43:37 -0800 (PST)
MIME-Version: 1.0
References: <20191128105508.3916-1-kbingham@kernel.org> <20191128105508.3916-4-kbingham@kernel.org>
In-Reply-To: <20191128105508.3916-4-kbingham@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 28 Nov 2019 14:43:26 +0100
Message-ID: <CANiq72mnzeQ2SvKbFx+VMFhQnMYNeGQOXpKXy9Vz7kRZyXVbHg@mail.gmail.com>
Subject: Re: [PATCH 3/3] drivers: auxdisplay: Add JHD1313 I2C interface driver
To:     kbingham@kernel.org
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Simon Goda <simon.goda@doulos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran,

On Thu, Nov 28, 2019 at 11:55 AM <kbingham@kernel.org> wrote:
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8f075b866aaf..640f099ff7fb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8837,6 +8837,10 @@ S:       Maintained
>  F:     Documentation/admin-guide/jfs.rst
>  F:     fs/jfs/
>
> +JHD1313 LCD Dispaly driver

Typo (and it should be all uppercase; and perhaps "Display" is not
needed given LCD is there; but see also comments on the title below).

Also missing the "S:" entry.

> diff --git a/drivers/auxdisplay/Kconfig b/drivers/auxdisplay/Kconfig
> index b8313a04422d..cfc61c1abdee 100644
> --- a/drivers/auxdisplay/Kconfig
> +++ b/drivers/auxdisplay/Kconfig
> @@ -27,6 +27,18 @@ config HD44780
>           kernel and started at boot.
>           If you don't understand what all this is about, say N.
>
> +config JHD1313
> +       tristate "JHD1313 Character LCD support"
> +       depends on I2C
> +       select CHARLCD
> +       ---help---
> +         Enable support for Character LCDs using a JHD1313 controller on I2C.
> +         The LCD is accessible through the /dev/lcd char device (10, 156).
> +         This code can either be compiled as a module, or linked into the
> +         kernel and started at boot.
> +         This supports the LCD panel on the Grove 16x2 LCD series.
> +         If you don't understand what all this is about, say N.

Would it be useful/worth for users to put "Grove series" and/or "I2C"
in the tristate title? (i.e. like the help section explains and also
like the MODULE_DESCRIPTION says).

> diff --git a/drivers/auxdisplay/jhd1313.c b/drivers/auxdisplay/jhd1313.c
> new file mode 100644
> index 000000000000..abf270e128ac
> --- /dev/null
> +++ b/drivers/auxdisplay/jhd1313.c
> @@ -0,0 +1,111 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +

Unconventional (AFAIK) empty line.

Thanks for the driver!

Cheers,
Miguel
