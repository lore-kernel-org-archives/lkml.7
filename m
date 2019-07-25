Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E1EC76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA43A22BEF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOaCcdZd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389842AbfGYRn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 13:43:57 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40284 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388650AbfGYRnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 13:43:55 -0400
Received: by mail-pg1-f193.google.com with SMTP id w10so23404335pgj.7;
        Thu, 25 Jul 2019 10:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t5SEt75qcdQLeyNsgISfIFcUiLRspw97fiGfJI426FY=;
        b=OOaCcdZdBxd/c92WdcSebQtmHYOk2yKXMcVkoXGRjPp48wMuErNw/8FJGKC33rZ69v
         lNC3KchcfsyXpGQvbWPczkmcGySfLgaFBq3LO9cxcEl5xX8Pb2fYRFynULU2RXeFN950
         FessKS+lPPIadwP9FhGtB2cb7MQ3mdalQonPfbkZyCgvg7FPBdfXmEGUl+GwwIbsNbE7
         tn1hqHVuVOXSWosdhV7QV3Q0lt6gggL9rM1CB4HsYalGorvUwZ2qe8rUh5LA2IujMq+Z
         R4Z1k5aIP7cbXlFNnfioDDnyXXwmOLw1kkFwYLrBZ+3+Z8kwgMR9QV1PonLKlpx2dXBT
         7Hsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t5SEt75qcdQLeyNsgISfIFcUiLRspw97fiGfJI426FY=;
        b=rnnpohqUKjjET40mCTa5q9Qbx+08RDY14A+SY6OCDwFkCIdBkmXGefN9U5YBZVS6D5
         7cceTvuCt7OReP19yjf0rPpG98D2qRLLYIYRd8IfULkZzUl6IdJP0FRXbfJ0tweaiv43
         cFCnFez+LCUPmHynHuHRAW0SMwkyB+tgcJlmrb9axFos1TL0g8u0qJtIgyk6V86ElD/y
         3wRDHOxxV/lsdS8ezlDl1hY75uKKYs6J6ExwmUVorccI1LG090wQkcJ3fUt1ImgAkjdz
         G+yF8/N0lF8ePhMdGLa22PRTO8WJn12C6/fCYFo+NZwXIWjMxPiLlsuuyPVtthpWZTn+
         07yQ==
X-Gm-Message-State: APjAAAVew7EsCNvKEhmQJon1VMSZajqwI16bP/Qf70jiQtyyT3DQS7Xu
        bllQszQ0KfL7P0Oi/7hc9r1b5nDq/wQiDYAngCnSjPGy
X-Google-Smtp-Source: APXvYqwl+TiFrrT+zkrjzuDVWj496eVxJCSNlaPsIAvv+6zQ5C0vOaf6Ge3pLdrp6lfpo1uhmIHUt9LEKhZ/DyJ/z/E=
X-Received: by 2002:a63:6eca:: with SMTP id j193mr12182093pgc.74.1564076634408;
 Thu, 25 Jul 2019 10:43:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190703162951.32737-1-huangfq.daxian@gmail.com>
In-Reply-To: <20190703162951.32737-1-huangfq.daxian@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 25 Jul 2019 20:43:43 +0300
Message-ID: <CAHp75VeFrg6KwxAyMx6o46jbJ8teMMGSEckm8xM=J9kFyODQNg@mail.gmail.com>
Subject: Re: [PATCH v2 20/35] platform/x86/asus: Use kmemdup rather than
 duplicating its implementation
To:     Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 3, 2019 at 7:30 PM Fuqian Huang <huangfq.daxian@gmail.com> wrote:
>
> kmemdup is introduced to duplicate a region of memory in a neat way.
> Rather than kmalloc/kzalloc + memcpy, which the programmer needs to
> write the size twice (sometimes lead to mistakes), kmemdup improves
> readability, leads to smaller code and also reduce the chances of mistakes.
> Suggestion to use kmemdup rather than using kmalloc/kzalloc + memcpy.
>

Pushed to my review and testing queue, thanks!

> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
> ---
> Changes in v2:
>   - Fix a typo in commit message (memset -> memcpy)
>   - Split into two patches.
>
>  drivers/platform/x86/asus-wmi.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 9b18a184e0aa..472b317ad814 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -260,12 +260,11 @@ static int asus_wmi_evaluate_method_agfn(const struct acpi_buffer args)
>          * Copy to dma capable address otherwise memory corruption occurs as
>          * bios has to be able to access it.
>          */
> -       input.pointer = kzalloc(args.length, GFP_DMA | GFP_KERNEL);
> +       input.pointer = kmemdup(args.pointer, args.length, GFP_DMA | GFP_KERNEL);
>         input.length = args.length;
>         if (!input.pointer)
>                 return -ENOMEM;
>         phys_addr = virt_to_phys(input.pointer);
> -       memcpy(input.pointer, args.pointer, args.length);
>
>         status = asus_wmi_evaluate_method(ASUS_WMI_METHODID_AGFN,
>                                         phys_addr, 0, &retval);
> --
> 2.11.0
>


-- 
With Best Regards,
Andy Shevchenko
