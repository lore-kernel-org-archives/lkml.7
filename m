Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 214DAC4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 09:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFF9B2086A
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 09:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FVNWQPg3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbfI2Ji0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 05:38:26 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:45889 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbfI2JiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 05:38:25 -0400
Received: by mail-vk1-f195.google.com with SMTP id q192so780706vka.12
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2019 02:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B5BtJyTNxtGZ22G3Jb6zuE0W1lHhxTdTz0pWDkvdX1M=;
        b=FVNWQPg370SVPwPIhCA60F46R5OG3O8jvNY8nYdoN6TpByRuFFCtTcrJdCVA3L0CrX
         agZ//n/120inZFpESF8rZwPHjoB680/AyQhIZRRLz9g3/U9uHVFtktqiksEkWz08xAfG
         fDuGlZhphQLzjBixqDj45SJLII0Xw4rcdMkxBVl+1B/vlFkLmMRLn+qESTi+KpAoDTEA
         Hq0q6qGzj5B7veYOOoH5RJmY7wJN2SB0IIGI36ri9dYTkKPGDjMYQ8E5BfIxDxBLSSPd
         ghHmRFxiHoGRgWyXytxwVidfpNrf9ZbW2tllmSI/MKlZ5hjc/jEoSnqNJoNcCO2LuB9x
         B7ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B5BtJyTNxtGZ22G3Jb6zuE0W1lHhxTdTz0pWDkvdX1M=;
        b=UfGUBdEz0n/zncRFYuT2xnYv2ek40S3QDwhiok8PxVQ9VG90SLODS3q6SIBAL3BB9t
         w9GUPvSAY+pF/QDkhnA/D0f48W0yiPvvhTRgad2LvL2M2yw2fgLOhPNbViS7tm0INMuQ
         wbUBPa9mnpv12Sf3vCK5cMNBgBbchYn50B/TT2/yW4YfQgQSC6EOYBwKNkrtMJE6bJAq
         R/PslDn5l4Mv+4J06xmnOAHtS/NwGiuqIJWC6s4GKGTifl+WN82c+3vSWwXaSmntZfjF
         EVBouMnU6jnxvhJxd9AnngZYabKK4EPWXPh3LEM2PBtRvQJy1D1QmWF9MwH3es5ILWwK
         pFCw==
X-Gm-Message-State: APjAAAW+OaNmj8Ba1C9F0vwTUOLiGDwj0jfTGyj6FZZnA4TOmH/0kDBH
        PjbN2E4ofkX1g/GFC3kjBz5Vv9Vp0/8e33+/XkY=
X-Google-Smtp-Source: APXvYqxYOpjf9JSynR+k9EGNKJJyQ6YGSPWcoaqsSVq+QDMRmL24WXxaoHv4dYNJYlvibotKx3YIjITOC14Xa1ixooQ=
X-Received: by 2002:a1f:3251:: with SMTP id y78mr2593821vky.68.1569749904456;
 Sun, 29 Sep 2019 02:38:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190928041804.41656-1-yuehaibing@huawei.com>
In-Reply-To: <20190928041804.41656-1-yuehaibing@huawei.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Sun, 29 Sep 2019 12:37:59 +0300
Message-ID: <CAFCwf101qKdfNtYEpb4PGw8CA02R+t80FKx-Lq9taff69L08bQ@mail.gmail.com>
Subject: Re: [PATCH -next] habanalabs: remove set but not used variable 'ctx'
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 28, 2019 at 7:18 AM YueHaibing <yuehaibing@huawei.com> wrote:
>
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/misc/habanalabs/device.c: In function hpriv_release:
> drivers/misc/habanalabs/device.c:45:17: warning: variable ctx set but not used [-Wunused-but-set-variable]
>
> It is never used since commit eb7caf84b029 ("habanalabs:
> maintain a list of file private data objects")
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/misc/habanalabs/device.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
> index 459fee7..2f5a4da 100644
> --- a/drivers/misc/habanalabs/device.c
> +++ b/drivers/misc/habanalabs/device.c
> @@ -42,12 +42,10 @@ static void hpriv_release(struct kref *ref)
>  {
>         struct hl_fpriv *hpriv;
>         struct hl_device *hdev;
> -       struct hl_ctx *ctx;
>
>         hpriv = container_of(ref, struct hl_fpriv, refcount);
>
>         hdev = hpriv->hdev;
> -       ctx = hpriv->ctx;
>
>         put_pid(hpriv->taskpid);
>
> --
> 2.7.4
>
>

This patch is:
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Applied to -next.
Thanks,
Oded
