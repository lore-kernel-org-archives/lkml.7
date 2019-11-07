Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80EDBC5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 05:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E6282166E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 05:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UE+pDLh8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbfKGFL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 00:11:59 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39368 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfKGFL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 00:11:59 -0500
Received: by mail-lf1-f67.google.com with SMTP id 195so532352lfj.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 21:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r0OOkUsjxCUYtLmAPLLgt2l0dG9hyrlf7+4skyMeXEQ=;
        b=UE+pDLh8LWppVS2Pe9lH+YlK3AHf7m8j4dN7vWiHUoov11X198Km89WzVDjvZT1r+8
         FtXNkSCwbRu8As4nZqyQcRihyTZnUD+4nwebsA2zaJ+cOr6FaoECt82rwLPDE4JrLfD5
         tsAGSiAAw+1G8xIrobZjzvXf+CCjou9KihddjOlC31oIaDqo4kY0aVoVdX6dSKiK6n8I
         kaZh+R4Oklqm2U+H9963U5tuUU16umTc9LD8cE6hjAjf3cHlqIO4IcXlncOQDqvaQSRp
         1EHhGSkRAZCcTL/ljsKblmAWGnoTezp92VPoNA0VjsW358rluwW+VmS7ShO5aymqh3cj
         BstQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r0OOkUsjxCUYtLmAPLLgt2l0dG9hyrlf7+4skyMeXEQ=;
        b=H/UA1tYktecfLO7vSSch3W9SPQZYD8pf+3O3tAahSk38+g268Zor4+E5ibPxmQTpdg
         T6vwJMVzDy0FtXTwU2X2K0SPZIcLa7TFlkG10oV6WE5tQZsETYbiLl0R3HWYPr/eQgsF
         2lYb/b5t5sAMj6SSgBCbxwhIHNKqCJvqwxPtbNvR+4B/OzhJI5yzAxrnIhHwGruY8pSk
         d1NpEk5jDl6m/C7FLirdvsBubyrER0zC4+FAGIBpo+J94ysp/o0vx51QGoEjrcHaSfOq
         Jq9jcewSQY/9kZdn2C15fkKnP4ja9F2ZjtqI6LND+JEJQ780fJ/yPikTrDaG+ZtTSgOQ
         NEPg==
X-Gm-Message-State: APjAAAVsY6UTyyi3RwlXtcEPXm3Ab/rugXj+zDcPsyALfCbXGY90Eoku
        1ixMPSFRdtwrDUxW/w3Kf8L7xQqEQmrFW0gJt8XV5Q==
X-Google-Smtp-Source: APXvYqzrIU0XwhPrjxbqFZQJcpq5ITRWmgKpPGRWjqVw0VNKYwAzlWe/P03xiYh/AIWZx1psx8xjBIV63cxT4vEeank=
X-Received: by 2002:ac2:561b:: with SMTP id v27mr898331lfd.186.1573103517378;
 Wed, 06 Nov 2019 21:11:57 -0800 (PST)
MIME-Version: 1.0
References: <20191106155538.5618-1-jens.wiklander@linaro.org>
In-Reply-To: <20191106155538.5618-1-jens.wiklander@linaro.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 7 Nov 2019 10:41:46 +0530
Message-ID: <CAFA6WYMZRk_Ls7GhHTRKqstCgDOyOD+Obwv9JNS8_=8_dn8dbw@mail.gmail.com>
Subject: Re: [PATCH] tee: optee: fix device enumeration error handling
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        Victor Chong <victor.chong@linaro.org>,
        Jerome Forissier <jerome@forissier.org>,
        Etienne Carriere <etienne.carriere@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Nov 2019 at 21:25, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> Prior to this patch in optee_probe() when optee_enumerate_devices() was
> called the struct optee was fully initialized. If
> optee_enumerate_devices() returns an error optee_probe() is supposed to
> clean up and free the struct optee completely, but will at this late
> stage need to call optee_remove() instead. This isn't done and thus
> freeing the struct optee prematurely.
>
> With this patch the call to optee_enumerate_devices() is done after
> optee_probe() has returned successfully and in case
> optee_enumerate_devices() fails everything is cleaned up with a call to
> optee_remove().
>
> Fixes: c3fa24af9244 ("tee: optee: add TEE bus device enumeration support")
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  drivers/tee/optee/core.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> index 1854a3db7345..b830e0a87fba 100644
> --- a/drivers/tee/optee/core.c
> +++ b/drivers/tee/optee/core.c
> @@ -643,11 +643,6 @@ static struct optee *optee_probe(struct device_node *np)
>         if (optee->sec_caps & OPTEE_SMC_SEC_CAP_DYNAMIC_SHM)
>                 pr_info("dynamic shared memory is enabled\n");
>
> -       rc = optee_enumerate_devices();
> -       if (rc)
> -               goto err;
> -
> -       pr_info("initialized driver\n");
>         return optee;
>  err:
>         if (optee) {
> @@ -702,9 +697,10 @@ static struct optee *optee_svc;
>
>  static int __init optee_driver_init(void)
>  {
> -       struct device_node *fw_np;
> -       struct device_node *np;
> -       struct optee *optee;
> +       struct device_node *fw_np = NULL;
> +       struct device_node *np = NULL;
> +       struct optee *optee = NULL;
> +       int rc = 0;
>
>         /* Node is supposed to be below /firmware */
>         fw_np = of_find_node_by_name(NULL, "firmware");
> @@ -723,6 +719,14 @@ static int __init optee_driver_init(void)
>         if (IS_ERR(optee))
>                 return PTR_ERR(optee);
>
> +       rc = optee_enumerate_devices();
> +       if (rc) {
> +               optee_remove(optee);
> +               return rc;
> +       }
> +
> +       pr_info("initialized driver\n");
> +
>         optee_svc = optee;
>
>         return 0;
> --
> 2.17.1
>
