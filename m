Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F18C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 22:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6475214D8
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 22:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XL5nzU0/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731636AbfFGWbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 18:31:21 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43959 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730078AbfFGWbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 18:31:20 -0400
Received: by mail-lf1-f65.google.com with SMTP id j29so2721863lfk.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 15:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OBui/9a2CWa3WtJXU/jukEhEgmzQX9Gxf6SYhKMTrpM=;
        b=XL5nzU0/lagm2y0Cg+y3kw3jZkhFKAozmrNpN0ep0KEpMDufL/OFbDtLCWioxSqeem
         nnCsgfgghmXCCYPpiKSQ9J48pnPNE/N++ztKjRYyIwf2g1E8CYfrFxor1jwbAFcusjX2
         qp4Dj3utI2POQI26TQeeVFDDA22wfjsAk9uhVnTNA1rd2ggkSAWceQpla8XJUZyh0cYw
         HIoL7JvAH0lcB3l43rBR8Kjib3yLsOmkNqGHPxKbzR+2TgP+76c97fiZv8q/uEHwyOZA
         yL5Dy8rn0ETmgAm2peBfaeGnICr8HXdYcru1DQ5tCUElnmG4FhO+3XNHslo4FxAQuHkI
         4CLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OBui/9a2CWa3WtJXU/jukEhEgmzQX9Gxf6SYhKMTrpM=;
        b=J2ofz7CcibrPtwDqiCjeADdDo93VczATEze3A/WVFgHJVXSOE4NvxDqE8kIbLo4bsQ
         GClk2MTDw8Za0A6B1pgGaga9wRyxRwlXvRzOgnOEURhC8rubnwZpesiPWmg8CTJh1bFD
         Vr0trGEuqTI6ZADQyGjaH/7xQWGgdPPqmKa0gnmqj/mX17Ey9bDQ/FRrZsGmZ3NHgAgk
         W9t0Tjcc21r6Esv7wX6l2nzplTnzc/oYHUWgr0MMcUs1vKPDbAi/FZd+sqf+m3ryK1FW
         FT9w87MSBvNQRPxqJvva+FSi4FfqRqMf8nhs9YBZSyVOwrqdwKPCLU1iOsO2qtnkcChY
         Lc9g==
X-Gm-Message-State: APjAAAWfqHdRBfhAqDB29wUDqH2WO7JFtXKIOjYAV8xnmAxUkFW32fKD
        IrTcHgV/a3qEPe4JbQ0woufMEHLI64YkLpkCjX+bO6i4
X-Google-Smtp-Source: APXvYqyb8lHnPKKyifZOVm3QT+J0KCRhQmn2cyfVQLPbutwEhYncdPoxkPCFfBx12/rPhEMByfO6ILpxfoiqWeYD6bE=
X-Received: by 2002:ac2:5212:: with SMTP id a18mr21196110lfl.50.1559946678567;
 Fri, 07 Jun 2019 15:31:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190607113509.15032-1-geert+renesas@glider.be>
In-Reply-To: <20190607113509.15032-1-geert+renesas@glider.be>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Sat, 8 Jun 2019 04:06:22 +0530
Message-ID: <CAFqt6zZzqjTb05Tepi-huW7PzV7Mn=FczqaRkAJFZXLjA7sBEQ@mail.gmail.com>
Subject: Re: [PATCH trivial] mm/vmalloc: Spelling s/configuraion/configuration/
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Jiri Kosina <trivial@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 7, 2019 at 5:05 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Subject line should be s/informaion/information. With that fix,
Acked-by: Souptick Joarder <jrdr.linux@gmail.com>

> ---
>  mm/vmalloc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 7350a124524bb4b2..08b8b5a117576561 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2783,7 +2783,7 @@ static int aligned_vwrite(char *buf, char *addr, unsigned long count)
>   * Note: In usual ops, vread() is never necessary because the caller
>   * should know vmalloc() area is valid and can use memcpy().
>   * This is for routines which have to access vmalloc area without
> - * any informaion, as /dev/kmem.
> + * any information, as /dev/kmem.
>   *
>   * Return: number of bytes for which addr and buf should be increased
>   * (same number as @count) or %0 if [addr...addr+count) doesn't
> @@ -2862,7 +2862,7 @@ long vread(char *buf, char *addr, unsigned long count)
>   * Note: In usual ops, vwrite() is never necessary because the caller
>   * should know vmalloc() area is valid and can use memcpy().
>   * This is for routines which have to access vmalloc area without
> - * any informaion, as /dev/kmem.
> + * any information, as /dev/kmem.
>   *
>   * Return: number of bytes for which addr and buf should be
>   * increased (same number as @count) or %0 if [addr...addr+count)
> --
> 2.17.1
>
