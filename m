Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5960C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96367206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBLlj7QM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbfC1RTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 13:19:35 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:38674 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726235AbfC1RTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 13:19:35 -0400
Received: by mail-yw1-f68.google.com with SMTP id m207so6281838ywd.5;
        Thu, 28 Mar 2019 10:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WQ87d/GuSsWiqz7wsRpRdGNX/3V6XiBVfMQ4WOhh/Pc=;
        b=CBLlj7QM/GTMmzd2/M9Xrsd0iVZKEH8sG0mMixMpOwzxNmedbGCLvfbddUZJeF0nuA
         gex/+A/Q9IgQt5yhjsDUNccjn5o0jTqKZqG6Hc+ItsL7yNoTRaZrx7Ceb8bGwV0/Fbp8
         feoddE1j3YJnGCX4en5iRVIBPvxgkmzQGjkU9kSBVOln9Rlch/X37LCCC+hqZdcTMMDg
         uXvBiLALzTkNBo6vTK7UxQGzKzMjVVTfD4Q41M6TkCFXLZVv19OPlrScM6L0e+m9w338
         MU53htOkAv/fszYj6lgFtJ3u5LG+30sog6ahPYNuz8GGwJ8qLyZKqDaF7J60BEibPWxW
         EgVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=WQ87d/GuSsWiqz7wsRpRdGNX/3V6XiBVfMQ4WOhh/Pc=;
        b=jnR+jXt5veB+7NqmeR3QBXgaPKEwIv9c6cZyx9L9XSlwSe9nYC8v8o7JAEJ8bmVuzY
         tuAVEMeAtiMYW3ymwtp8pOXUGNIDt0xLKurJQFuWkFBX7W18EUzlQ0Qblv3oVs0BS+/w
         OMYuIGTwJspR69RqWNZfeVoAu7AR+ovGOjvRrdSmiu4km48swANddsHLLmwt9Qm+8G2l
         H8BwftMFOvQkLSiwa5rFj3rKKp96fJWX1DQOC1XOoKro27/yUkspNV8RqpkKMcS+XkPH
         jtr9ChwUnvtidGd03VygyQgannf9o0dvQEY2A3AnsrvQ2rqcKwS8nKrypftR9x1gRbWh
         1gmg==
X-Gm-Message-State: APjAAAXiNfxZFPp89U8nFtH7DEYPErK22wt6VdTxdGSGAvawZuiCH6He
        OQavTheJoHXhSBDrT9XX7Tc=
X-Google-Smtp-Source: APXvYqzrOweucTnr518KqxIPEqSjlGFWNSIfmXeMH9WanONcWQqZeFIjP17a2igimoHTrsvK6seLpA==
X-Received: by 2002:a81:2183:: with SMTP id h125mr29049696ywh.455.1553793574328;
        Thu, 28 Mar 2019 10:19:34 -0700 (PDT)
Received: from dumbo ([83.137.6.243])
        by smtp.gmail.com with ESMTPSA id l123sm9030422ywe.85.2019.03.28.10.19.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 10:19:33 -0700 (PDT)
Date:   Thu, 28 Mar 2019 18:19:26 +0100
From:   Domenico Andreoli <domenico.andreoli@linux.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, pauldzim@gmail.com,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: turn on TPM on suspend for TPM 1.x
Message-ID: <20190328171926.4luwqofh67uwgt5e@dumbo>
References: <20190322105120.8441-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322105120.8441-1-jarkko.sakkinen@linux.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 12:51:20PM +0200, Jarkko Sakkinen wrote:
> tpm_chip_start/stop() should be also called for TPM 1.x devices on
> suspend. Add that functionality back. Do not lock the chip because
> it is unnecessary as there are no multiple threads using it when
> doing the suspend.
> 
> Fixes: a3fbfae82b4c ("tpm: take TPM chip power gating out of tpm_transmit()")
> Reported-by: Paul Zimmerman <pauldzim@gmail.com>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
>  drivers/char/tpm/tpm-interface.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index 83ece5639f86..ae1030c9b086 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -402,15 +402,13 @@ int tpm_pm_suspend(struct device *dev)
>  	if (chip->flags & TPM_CHIP_FLAG_ALWAYS_POWERED)
>  		return 0;
>  
> -	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> -		mutex_lock(&chip->tpm_mutex);
> -		if (!tpm_chip_start(chip)) {
> +	if (!tpm_chip_start(chip)) {
> +		if (chip->flags & TPM_CHIP_FLAG_TPM2)
>  			tpm2_shutdown(chip, TPM2_SU_STATE);
> -			tpm_chip_stop(chip);
> -		}
> -		mutex_unlock(&chip->tpm_mutex);
> -	} else {
> -		rc = tpm1_pm_suspend(chip, tpm_suspend_pcr);
> +		else
> +			rc = tpm1_pm_suspend(chip, tpm_suspend_pcr);
> +
> +		tpm_chip_stop(chip);
>  	}
>  
>  	return rc;

Tested-by: Domenico Andreoli <domenico.andreoli@linux.com>

-- 
3B10 0CA1 8674 ACBA B4FE  FCD2 CE5B CF17 9960 DE13
