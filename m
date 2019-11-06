Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F29AC5DF65
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 17:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E88B02187F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 17:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jZSOsThW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732440AbfKFRCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 12:02:09 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39208 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728777AbfKFRCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 12:02:08 -0500
Received: by mail-wm1-f67.google.com with SMTP id t26so4268939wmi.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 09:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Td99yEjooCTjs2/PvMjZI2+HMS/tAjDRA3GPrGeVtEI=;
        b=jZSOsThWQQ2LwYctC8YcYPDbJ6oRY4DPiwyay5ZNoZNVDTtdmqyGYCfK7oviW4ZtcO
         JAXJxC2ftHojYtacL6taI2khb2bB84OqQd4AY+cdZJ+FS+WhNMuH3U8C0QpojuMzYC8J
         LCrBgAeDbCQrhM8h/6zogR/hXJ8oNqj8/mtlAAGRUoRzAhmaUxlAkmAqExkGpmzQ68fK
         zI5ZnHDs7yLpqxZ8Zcihf7Fh1iW3sL+Uwjl0iILXIArIbhigbYyggOc8zB0fO1DRUC/3
         0bwMkP2fDP2c+cJarcp3NwM2fagjkXnl4hCYx99vEIH+HrcpXAtN4CAWRqLjn+0bXOuo
         bH6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Td99yEjooCTjs2/PvMjZI2+HMS/tAjDRA3GPrGeVtEI=;
        b=gOZkKM+hMYSPyouL2+erEC8Kslq7HmIjlQMKVq2RnBMutXndSSXc6X/p3126Ho7GXj
         UIHa7/a6Ugh1xeTEM5tFinvp9UyfAXFC7WFgW7DIdcKBxyeuipbk/uxwgiHk44Z1wYbM
         lIuCyC0w/KianDVSUo/VMnk5y3J3wfO2CZ/3yHzVOQjxlm7rBDoGgldGlZsyLXZYB4UK
         XvryArMJw7uD2OYIb/P9N62T44+fFnUVE+hrgu6i7jk/frPYf4cgvqbcauWNIY61+6Iq
         Unc8766mtoN1yytwrmgzSTDYWuSvrQPaO7hh8uAs0WDS9USHAxVxzYdHlwLQG7TGZJwG
         FTGw==
X-Gm-Message-State: APjAAAWcNCerkmvBOEsvLHTLIw2VIvKPF6fDKaJvS0Nxgfi8LdEp0voE
        s9L89svzr/XpSOLcIbl+mho+xD2xC52urZsdQ+1msA==
X-Google-Smtp-Source: APXvYqwWWNQE9RlQ13ZOmh7HQWoRHEyqbaaMBYYVyKsS2AreAFalWLEQhhn/3Bmd7r7+YTDh7MBZtZ4hIFwtJyvXqIs=
X-Received: by 2002:a1c:64d6:: with SMTP id y205mr3227761wmb.136.1573059726914;
 Wed, 06 Nov 2019 09:02:06 -0800 (PST)
MIME-Version: 1.0
References: <1572931429-487-1-git-send-email-anshuman.khandual@arm.com>
In-Reply-To: <1572931429-487-1-git-send-email-anshuman.khandual@arm.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 6 Nov 2019 18:01:54 +0100
Message-ID: <CAKv+Gu-q16Z=tyeb3b5NnjBkw9cRoeEM6OQaT6dGe1i+9iJa9w@mail.gmail.com>
Subject: Re: [PATCH] efi: Return EFI_RESERVED_TYPE in efi_mem_type() for
 absent addresses
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Nov 2019 at 21:39, Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
> The function efi_mem_type() is expected (per documentation above) to return
> EFI_RESERVED_TYPE when a given physical address is not present in the EFI
> memory map. Even though EFI_RESERVED_TYPE is not getting checked explicitly
> anywhere in the callers, it is always better to return expected values.
>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: linux-efi@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

This reverts commit f99afd08a45fbbd9ce35a7624ffd1d850a1906c0.

Could you explain why it is better to fix the code than fix the comment?

> ---
>  drivers/firmware/efi/efi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 69f00f7453a3..bdda90a4601e 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -914,7 +914,7 @@ int efi_mem_type(unsigned long phys_addr)
>                                   (md->num_pages << EFI_PAGE_SHIFT))))
>                         return md->type;
>         }
> -       return -EINVAL;
> +       return EFI_RESERVED_TYPE;
>  }
>  #endif
>
> --
> 2.20.1
>
