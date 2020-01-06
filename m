Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 057A1C32767
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 05:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD56D20848
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 05:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ee8gnuGL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgAFFxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 00:53:52 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37263 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgAFFxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 00:53:51 -0500
Received: by mail-ot1-f67.google.com with SMTP id k14so70202421otn.4
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jan 2020 21:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BQszsIlQqsooj5gDAGmY6RU64iOnhfI7B772izNBsYM=;
        b=ee8gnuGL69ozRuwZUJpSr4P6/DsEbehVpg4t432EFwemYqGGmlTb0iEdTOJmBVFpqp
         hFp1pQTG5THio9gam+tEfphxOt7f07ndimYZ2YwRz/ZmY3sg/pApil4/ADDJeo8ldFcR
         ZjcNeHD2cwIMauayBpfJOLip/orBSkK1pItTPLQIFIzaiCrPVbQG7TJyiqcvoV9Ndo0W
         KHHbbmsHkoA/jg+Aakp6SGBlkhLiRmq17t11KZb4Q12IjoSmBxBD7tAWhVYgOfe9MUQS
         ZSEipdwYIyfI7+fO/xa2fEZw3tWIRFIFGZc1c7tG0MGzCMiCdoJmOPJseJlEmHxZuY5b
         /MnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BQszsIlQqsooj5gDAGmY6RU64iOnhfI7B772izNBsYM=;
        b=HNdSaxxSuim0awDDfF+xA+EAZYJoq7yiZuIe8Orv48QxtxHC8B8gsuyso8lqeRCznp
         zsr1D2APi5i1+diLl0jan9RODpXTOqlXmi42aIqtzVEsU+IAiqc1uIwAk5s/2gA7zc/E
         cvjTUUD7hllAPE45bq5BoqLr5EYrJMsV8FtEbGGdjVhzrYCz6M63GlDLqHfWHK6GbBr6
         2PweocJCh2Npj/CUjSQ5cEB9rnz+lKYZOKsL0Bk6zUUdSPwfMiK1frkFUjc/3SELR+3y
         5LCFk6IJxStCNq8fiWfreU2kt9fQe3ohGfqF8wlgkD7kOxtRU24wC2xo/IKG83kA8Dml
         vhRQ==
X-Gm-Message-State: APjAAAVnPl2loPgx2t7RWZNL7IMStx32fjLrBAKw6bJRcqi3PSJ8foBC
        uUHud4BajwemuFfXdJJtrXKy4rVuQ/+nEe7Dz1IcHLrA
X-Google-Smtp-Source: APXvYqwvEfu/W18MHjO0KaiXTWnKIy6C6TWOpJ0TQ+nCHQFMUhA7Ex6gzMAlw40UpiBvZRzdtntBkOGHZbT6lSYDXYk=
X-Received: by 2002:a05:6830:2009:: with SMTP id e9mr62849528otp.160.1578290030741;
 Sun, 05 Jan 2020 21:53:50 -0800 (PST)
MIME-Version: 1.0
References: <20200105090537.19979-1-oshpigelman@habana.ai> <20200105090537.19979-2-oshpigelman@habana.ai>
In-Reply-To: <20200105090537.19979-2-oshpigelman@habana.ai>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Mon, 6 Jan 2020 07:53:43 +0200
Message-ID: <CAFCwf13-WW2FkLRF9NzGB4CYUi0U6nD1zzAXcnQUYSG+GM4a-g@mail.gmail.com>
Subject: Re: [PATCH 2/2] habanalabs: do not halt Coresight during hard reset
To:     Omer Shpigelman <oshpigelman@habana.ai>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 5, 2020 at 11:05 AM Omer Shpigelman <oshpigelman@habana.ai> wrote:
>
> During hard reset we must not write to the device.
> Hence avoid halting Coresight during user context close if it is done
> during hard reset.
> In addition, we must not reenable clock gating afterwards as it was
> deliberately disabled in the beginning of the hard reset flow.
>
> Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
> ---
>  drivers/misc/habanalabs/device.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
> index 166883b64725..b680b0caa69b 100644
> --- a/drivers/misc/habanalabs/device.c
> +++ b/drivers/misc/habanalabs/device.c
> @@ -598,7 +598,9 @@ int hl_device_set_debug_mode(struct hl_device *hdev, bool enable)
>                         goto out;
>                 }
>
> -               hdev->asic_funcs->halt_coresight(hdev);
> +               if (!hdev->hard_reset_pending)
> +                       hdev->asic_funcs->halt_coresight(hdev);
> +
>                 hdev->in_debug = 0;
>
>                 goto out;
> --
> 2.17.1
>
Both patches are:
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Applied to -next
Thanks,
Oded
