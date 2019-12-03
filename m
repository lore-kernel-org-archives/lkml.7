Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0AAAC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 18:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A5C82073B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 18:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfLCSCb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 13:02:31 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42869 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfLCSCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 13:02:31 -0500
Received: by mail-ot1-f65.google.com with SMTP id 66so3726176otd.9;
        Tue, 03 Dec 2019 10:02:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=acRXlgJMgS4zFgkuBK6LomlOW0ErW4UsPjySwRogk2A=;
        b=jvi01UwAOjHJt5/monrCsKvhZ2E8wjf1+njlqnKt0NzfRgRxCR+R/yPuEYIp1tNOE5
         MoKc6iMMRu567Gh5xIM5UKhOXtIfw6+MlAYNZbedE05Ox85McG8Uucst5kBJbBCozzIz
         nuFqnLaP45UnPXwwaJwd+3oLkq8A26X8zUzW8sQsoEzNvbCBBCZSqM/Qnysj9asJ5eak
         Zx5+gH2bFQRrL2lD3vQQPB4WGwfkRf7zdRWd36g9Ny1JEQHvsoX44v7RHr6KBYbuDWVG
         Bhao3oQAR3kms1Is4m/QTTrVEZT3gWAcz/pltuDkvFDe6lR/u9nvE2I9eI2SS0OTvX2N
         IVxg==
X-Gm-Message-State: APjAAAVDLjDXrjI1xrNA9/mmS70vHvMZAllU9PI7lJ9FLW7Utm5lZ98A
        kui14EE8SoXrT/Hwsas5kS+hR0HOexCKBUscpnM=
X-Google-Smtp-Source: APXvYqzm078DyDYSc09q2nCaJjtAQG8kC+kqRgZV1G9E7e37ceqH80/zXtwjyI1TeERQv3De/lCePm03uz4ONF7QF5M=
X-Received: by 2002:a9d:19ed:: with SMTP id k100mr4147256otk.297.1575396150332;
 Tue, 03 Dec 2019 10:02:30 -0800 (PST)
MIME-Version: 1.0
References: <20191203162645.19950-1-geert+renesas@glider.be> <20191203162645.19950-6-geert+renesas@glider.be>
In-Reply-To: <20191203162645.19950-6-geert+renesas@glider.be>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 3 Dec 2019 19:02:19 +0100
Message-ID: <CAMuHMdUpDcmu=z35d8HDstrqE1+Ef-ZLUGo2dx_5wUkRNPmG4g@mail.gmail.com>
Subject: Re: [PATCH 5/7] sh: pci: Modernize printing of kernel messages
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 3, 2019 at 5:26 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>   - Convert from printk() to pr_*(),
>   - Add missing continuations,
>   - Join broken messages.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/arch/sh/drivers/pci/common.c
> +++ b/arch/sh/drivers/pci/common.c
> @@ -143,7 +143,7 @@ unsigned int pcibios_handle_status_errors(unsigned long addr,
>                 printk(KERN_DEBUG "PCI: parity error detected: ");

Forgot to mention: I did not replace "printk(KERN_DEBUG" by "pr_debug",
as this changes behavior (pr_debug() is a dummy if DEBUG is not defined).

>                 pcibios_report_status(PCI_STATUS_PARITY |
>                                       PCI_STATUS_DETECTED_PARITY, 1);
> -               printk("\n");
> +               pr_cont("\n");
>
>                 cmd |= PCI_STATUS_PARITY | PCI_STATUS_DETECTED_PARITY;
>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
