Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C196AC2D0C3
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 13:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96D0B21582
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 13:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Dd8yzJbf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfLRNpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 08:45:16 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38800 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbfLRNpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 08:45:16 -0500
Received: by mail-qk1-f194.google.com with SMTP id k6so1569823qki.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 05:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C4ntQvciQzVGbr4/WEhkSDFzmYZWWBqD5uxngUjOBow=;
        b=Dd8yzJbfYhuzey0d0UWujCUQkz0PCjyl+HSrTDFSBJVPYv9jrH4IP3eKn0xaWYwE4C
         au/dkZzJoc8xHC7T64qBT/VyV6Hfo0O3sq1FaLwvrTxeKAAfiNFX043RhLwb0GRkhU9a
         xhXpLjuiFo2Fafci4oS2ibyur5E6hetSYnwf01xTJdjgSg9g+kjZcASPSvrGvANmzJN3
         NGB45DkJ5QmhtWHfC5HGtZWBylowj3VK8bKla7TckqbI6HfxEuaLB7u3Bu2F5zRfEoMc
         qll3sMQMy+TrhTRl57jjm8savvbPzL1JC6MPxeBIuybiHX2u/GkiNWUSXHoHB/ixTExX
         onpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C4ntQvciQzVGbr4/WEhkSDFzmYZWWBqD5uxngUjOBow=;
        b=I1PI+RK5QEs+P2w4I2Lx5IIJc9wN2TjBXAWpXq2iRHFRI5a4yYiQAbGJgRydVkxAhR
         KFpxuPm1W+0QZ6jDhOtXaTNJ4ztyIlFoLp+AcQYYTVmCVvtjwQymN1xeNtr69IHfCz/k
         k+AYjrPLrhG0TE6ZUfDGPPR3UwHU7f9VdMg/QROfnsQXSoDjnX52ryjR5v+DDkXT7HW+
         pZlX2iONh7JY7cmPglh3h+R5TYoUdy+sK0zBLc0PV+dzGw+mUHt64qXDDrbmcz4qzwJL
         DqzQ5woUWDnJ14VLLbDJCjieogOJ78dSvx3axLpjMDj+y/NrqFX8F3XwfpMScvGOeS5S
         Iz7Q==
X-Gm-Message-State: APjAAAXSpTzYCQ4vO5pxFMdouC7L3gxzFxW7eIrIJgPlws6V4d215cDm
        Frk4OYFbgQc8Ri0DL9FXAwA8pQ==
X-Google-Smtp-Source: APXvYqxKR+OvOVDgF3lNL/dBSAkb0u6QiN+0z3MaDkJ/DaaeoIYdHPk2y5sfSExH2I8XHxhlWtvQmw==
X-Received: by 2002:a37:a18b:: with SMTP id k133mr2560191qke.83.1576676714706;
        Wed, 18 Dec 2019 05:45:14 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id i90sm736223qtd.49.2019.12.18.05.45.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Dec 2019 05:45:14 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1ihZdZ-0007bb-Ls; Wed, 18 Dec 2019 09:45:13 -0400
Date:   Wed, 18 Dec 2019 09:45:13 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm/ppi: replace assertion code with recovery in
 tpm_eval_dsm
Message-ID: <20191218134513.GE17227@ziepe.ca>
References: <20191215182314.32208-1-pakki001@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191215182314.32208-1-pakki001@umn.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 15, 2019 at 12:23:14PM -0600, Aditya Pakki wrote:
> In tpm_eval_dsm, BUG_ON on ppi_handle is used as an assertion.
> By returning NULL to the callers, instead of crashing, the error
> can be better handled.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
>  drivers/char/tpm/tpm_ppi.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm_ppi.c b/drivers/char/tpm/tpm_ppi.c
> index b2dab941cb7f..4b6f6a9c0b48 100644
> +++ b/drivers/char/tpm/tpm_ppi.c
> @@ -42,7 +42,9 @@ static inline union acpi_object *
>  tpm_eval_dsm(acpi_handle ppi_handle, int func, acpi_object_type type,
>  	     union acpi_object *argv4, u64 rev)
>  {
> -	BUG_ON(!ppi_handle);
> +	if (!ppi_handle)
> +		return NULL;

If it can't happen the confusing if should either be omitted entirely
or written as 

if (WARN_ON(!ppi_handle))
       return NULL;

Leaving it as apparently operational code just creates confusion for
the reader that now has the task to figure out why ppi_handle can be
null.

I favour not including tests for impossible conditions. The kernel
will crash immediately if ppi_handle is null anyhow.

Jason
