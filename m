Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 114AAC606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D90E721537
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="io4Hmy4B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390747AbfGHPjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:39:19 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35410 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390739AbfGHPjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:39:14 -0400
Received: by mail-lj1-f196.google.com with SMTP id x25so9653675ljh.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 08:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D+MqPDavG72JIJh+i7ydfVr+tFhEdIBsYuNF/SflY4s=;
        b=io4Hmy4BEIEFOl5wqrOg+jNWCZUftVq/uAlqqHmC8H9bJ2S5rVWY8hK0JE8NS5T0vr
         aCbjTA4Hj1cj5dlTQiT80zVJEs9qrLxBttCaYZnj4YNKDVu8+juFC5o5z4AJICqsS+zz
         uTbpSBiakCeD6b6B7FnRW2oRjOGCFy+4yYIRFEBFabVvraaWzJNOcxJsqDiy3qE3WhpN
         TnnmXtXegQjvH6mgUvTHd3fQLkWf62scQzJECSXPTDM+yiUpwWR+KmSh71rS2rKrW/YU
         96JRZYk/i8GLgfst1/CPaOJw/eW4bP0VBAsuPxQc0X8mBF2B8COTQH+VD9pXof91SbSq
         rSwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D+MqPDavG72JIJh+i7ydfVr+tFhEdIBsYuNF/SflY4s=;
        b=Xy6W/Fhm/jkDHdtTSBMu76cB49nRwOX/172pCe0Vn5LcgDBCHEsFwdbxVuui7yZeGl
         DIla1pbEGXgqoahiyv8hjs/8z2CYpPuZQJ59DemlwXLYrwpqpLsu/RYZa4XePMKYt6U3
         uirvRXugYpG/RO+o06uc9a/lkO9Xd84sTQ3LDzlyoEe9vugAVMgZYEPSovm5QXY8V/B2
         +piH3GN4KA5GuGG6sWJu/sARnl1GrdA0pKQMRepFe/7CgsngrGX6Dmo7DduxGF0l2Rkt
         qHLYrpCcn1KsC1GQXXr1VefHRt38xnoAIfsy9NMBpWoKeJ5YGp1/w+9RhmA1e7mFVWsH
         oH+A==
X-Gm-Message-State: APjAAAXz8xtobI7rayzoNSdi5hJfsocYYJ4qaqu2utSAcF5sOygADiNN
        uANrJKIDyj6f34wocd2fSqGaAQ==
X-Google-Smtp-Source: APXvYqzEx0jOXIVaLhPfITF9bzeu4HZ/KoZJiu7wenFGxHberguce7iX6HWLmFSF2s96U/hPTphqSg==
X-Received: by 2002:a2e:9dd7:: with SMTP id x23mr11243163ljj.160.1562600352121;
        Mon, 08 Jul 2019 08:39:12 -0700 (PDT)
Received: from jax (h-84-105.A175.priv.bahnhof.se. [79.136.84.105])
        by smtp.gmail.com with ESMTPSA id g4sm2832994lfb.31.2019.07.08.08.39.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Jul 2019 08:39:11 -0700 (PDT)
Date:   Mon, 8 Jul 2019 17:39:09 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, corbet@lwn.net,
        dhowells@redhat.com, jejb@linux.ibm.com,
        jarkko.sakkinen@linux.intel.com, zohar@linux.ibm.com,
        jmorris@namei.org, serge@hallyn.com, ard.biesheuvel@linaro.org,
        daniel.thompson@linaro.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org
Subject: Re: [RFC 3/7] tee: add private login method for kernel clients
Message-ID: <20190708153908.GA28253@jax>
References: <1560421833-27414-1-git-send-email-sumit.garg@linaro.org>
 <1560421833-27414-4-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1560421833-27414-4-git-send-email-sumit.garg@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sumit,

On Thu, Jun 13, 2019 at 04:00:29PM +0530, Sumit Garg wrote:
> There are use-cases where user-space shouldn't be allowed to communicate
> directly with a TEE device which is dedicated to provide a specific
> service for a kernel client. So add a private login method for kernel
> clients and disallow user-space to open-session using this login method.
> 
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  drivers/tee/tee_core.c   | 6 ++++++
>  include/uapi/linux/tee.h | 2 ++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> index 0f16d9f..4581bd1 100644
> --- a/drivers/tee/tee_core.c
> +++ b/drivers/tee/tee_core.c
> @@ -334,6 +334,12 @@ static int tee_ioctl_open_session(struct tee_context *ctx,
>  			goto out;
>  	}
>  
> +	if (arg.clnt_login == TEE_IOCTL_LOGIN_REE_KERNEL) {
TEE_IOCTL_LOGIN_REE_KERNEL is defined as 0x80000000 which is in the
range specified and implementation defined by the GP spec. I wonder if
we shouldn't filter the entire implementation defined range instead of
just this value.

> +		pr_err("login method not allowed for user-space client\n");
pr_debug(), if it's needed at all.

> +		rc = -EPERM;
> +		goto out;
> +	}
> +
>  	rc = ctx->teedev->desc->ops->open_session(ctx, &arg, params);
>  	if (rc)
>  		goto out;
> diff --git a/include/uapi/linux/tee.h b/include/uapi/linux/tee.h
> index 4b9eb06..f33c69c 100644
> --- a/include/uapi/linux/tee.h
> +++ b/include/uapi/linux/tee.h
> @@ -172,6 +172,8 @@ struct tee_ioctl_buf_data {
>  #define TEE_IOCTL_LOGIN_APPLICATION		4
>  #define TEE_IOCTL_LOGIN_USER_APPLICATION	5
>  #define TEE_IOCTL_LOGIN_GROUP_APPLICATION	6
> +/* Private login method for REE kernel clients */
It's worth noting that this is filtered by the TEE framework, compared
to everything else which is treated opaquely.

> +#define TEE_IOCTL_LOGIN_REE_KERNEL		0x80000000
>  
>  /**
>   * struct tee_ioctl_param - parameter
> -- 
> 2.7.4
> 

Thanks,
Jens
