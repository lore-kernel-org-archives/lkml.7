Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 523D5C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 01:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ADD8206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 01:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553563379;
	bh=3Z1uZ3XUzfYDBl+FDHTCcEyZMDz7hTxOOUnuytSzMq8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WzUOtjzRgnCYqKsWq+mFA48nRd/HKnuK9nMkr3UhlmIdQJHZYj2W1bnpfeTlJqjdW
	 uoFCrEe+31mL/3DXjKgZ1Ami/bZIRS4TzsaRqDhPd4/awiAY1mPhaJZZa73s0iVitv
	 QIu7QVSMAsDtK3E5U7Ujqfdr2dPlCMIjjK+CUQrA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730456AbfCZBW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 21:22:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:56868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727412AbfCZBW5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 21:22:57 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CED3F20693;
        Tue, 26 Mar 2019 01:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553563376;
        bh=3Z1uZ3XUzfYDBl+FDHTCcEyZMDz7hTxOOUnuytSzMq8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JMFkgLZgA8eQtP9svYhvEJzhVHxSG9AlppY6LQuaJXmg7RPbBjm3rtJPqieSoPoIF
         KD23kbhLDboeNFwZlgR8zn00qLkVTrZnlDRgB6iKmyqz+3IVENrx9WZQL20gW44/z/
         78ZRe69y7YuywktxwBsFo/eJ0qbGUu0SBYGUYiXI=
Date:   Tue, 26 Mar 2019 10:08:31 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     stable@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Tobin C. Harding" <me@tobin.cc>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Julia Lawall <Julia.Lawall@lip6.fr>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [BACKPORT 4.4.y 01/25] mmc: pwrseq: constify mmc_pwrseq_ops
 structures
Message-ID: <20190326010831.GA29420@kroah.com>
References: <20190322154425.3852517-1-arnd@arndb.de>
 <20190322154425.3852517-2-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322154425.3852517-2-arnd@arndb.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 04:43:52PM +0100, Arnd Bergmann wrote:
> From: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> The mmc_pwrseq_ops structures are never modified, so declare them as const.
> 
> Done with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> (cherry picked from commit ffedbd2210f2f4cba490a9205adc11fd1b89a852)
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/mmc/core/pwrseq.h        | 2 +-
>  drivers/mmc/core/pwrseq_emmc.c   | 2 +-
>  drivers/mmc/core/pwrseq_simple.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/core/pwrseq.h b/drivers/mmc/core/pwrseq.h
> index 096da48c6a7e..133de0426687 100644
> --- a/drivers/mmc/core/pwrseq.h
> +++ b/drivers/mmc/core/pwrseq.h
> @@ -16,7 +16,7 @@ struct mmc_pwrseq_ops {
>  };
>  
>  struct mmc_pwrseq {
> -	struct mmc_pwrseq_ops *ops;
> +	const struct mmc_pwrseq_ops *ops;
>  };
>  
>  #ifdef CONFIG_OF
> diff --git a/drivers/mmc/core/pwrseq_emmc.c b/drivers/mmc/core/pwrseq_emmc.c
> index ad4f94ec7e8d..4a82bc77fe49 100644
> --- a/drivers/mmc/core/pwrseq_emmc.c
> +++ b/drivers/mmc/core/pwrseq_emmc.c
> @@ -51,7 +51,7 @@ static void mmc_pwrseq_emmc_free(struct mmc_host *host)
>  	kfree(pwrseq);
>  }
>  
> -static struct mmc_pwrseq_ops mmc_pwrseq_emmc_ops = {
> +static const struct mmc_pwrseq_ops mmc_pwrseq_emmc_ops = {
>  	.post_power_on = mmc_pwrseq_emmc_reset,
>  	.free = mmc_pwrseq_emmc_free,
>  };
> diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
> index d10538bb5e07..2b16263458af 100644
> --- a/drivers/mmc/core/pwrseq_simple.c
> +++ b/drivers/mmc/core/pwrseq_simple.c
> @@ -87,7 +87,7 @@ static void mmc_pwrseq_simple_free(struct mmc_host *host)
>  	kfree(pwrseq);
>  }
>  
> -static struct mmc_pwrseq_ops mmc_pwrseq_simple_ops = {
> +static const struct mmc_pwrseq_ops mmc_pwrseq_simple_ops = {
>  	.pre_power_on = mmc_pwrseq_simple_pre_power_on,
>  	.post_power_on = mmc_pwrseq_simple_post_power_on,
>  	.power_off = mmc_pwrseq_simple_power_off,

Why is this needed for a stable patch?  It doesn't fix a bug, it just
looks like it is a "nice thing" to have, right?  I don't think any later
patch in this series relies it it, or am I missing something?

thanks,

greg k-h
