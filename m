Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F3AC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 205BE2086C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="JxNudvRu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729136AbfDASwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 14:52:25 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:34776 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729056AbfDASwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 14:52:23 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 624F68EE12C;
        Mon,  1 Apr 2019 11:52:22 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id m_V6JpWY5juF; Mon,  1 Apr 2019 11:52:22 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id B35718EE0CD;
        Mon,  1 Apr 2019 11:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1554144742;
        bh=T/NKeFg77h83qXnntr52YuorgzIRcsJNlC20Q0OwuB4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=JxNudvRuhN9MpiERgjXF3DNZdFqEv+P9IFczRyxbltqdBZBUp/atAvGPnzhdW8OTG
         Kx2CGq5BaAYUUTNJI+bR4jwHEWUtnlPLCLojBMdqdtkZNspzE0wQYfJS+RcAso7gdM
         dv3MOe0YHDYE5M//ObLwaBGc9ys7UmM730FuuWco=
Message-ID: <1554144741.3029.18.camel@HansenPartnership.com>
Subject: Re: [PATCH] tpm: Actually fail on TPM errors during "get random"
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Kees Cook <keescook@chromium.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Tomas Winkler <tomas.winkler@intel.com>
Cc:     Phil Baker <baker1tex@gmail.com>, Craig Robson <craig@zhatt.com>,
        Laura Abbott <labbott@redhat.com>,
        linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        linux-integrity@vger.kernel.org
Date:   Mon, 01 Apr 2019 11:52:21 -0700
In-Reply-To: <20190401183211.GA21228@beast>
References: <20190401183211.GA21228@beast>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-04-01 at 11:32 -0700, Kees Cook wrote:
[...]
> --- a/drivers/char/tpm/tpm1-cmd.c
> +++ b/drivers/char/tpm/tpm1-cmd.c
> @@ -510,7 +510,7 @@ struct tpm1_get_random_out {
>   *
>   * Return:
>   * *  number of bytes read
> - * * -errno or a TPM return code otherwise
> + * * -errno (positive TPM return codes are masked to -EIO)
>   */
>  int tpm1_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
>  {
> @@ -524,7 +524,7 @@ int tpm1_get_random(struct tpm_chip *chip, u8
> *dest, size_t max)
>  
>  	rc = tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND,
> TPM_ORD_GET_RANDOM);
>  	if (rc)
> -		return rc;
> +		goto fail;
>  
>  	do {
>  		tpm_buf_append_u32(&buf, num_bytes);
> @@ -559,7 +559,10 @@ int tpm1_get_random(struct tpm_chip *chip, u8
> *dest, size_t max)
>  	rc = total ? (int)total : -EIO;
>  out:
>  	tpm_buf_destroy(&buf);
> -	return rc;

You can't remove this otherwise the only return will ever be a failure.

I think what you're trying to catch is tpm_transmit_cmd returning a
positive failure, So you need to check the output of tpm_transmit_cmd
as well and goto failure leaving the above return in place.

James


> +fail:
> +	if (rc < 0)
> +		return rc;
> +	return -EIO;
>  }
>  
>  #define TPM_ORD_PCRREAD 21
> -- 
> 2.17.1
> 
> 

