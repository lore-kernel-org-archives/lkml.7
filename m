Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E32BC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 19:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF24B20830
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 19:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="VBhY9FFd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbfDATJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 15:09:58 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38465 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728733AbfDATJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 15:09:58 -0400
Received: by mail-qt1-f195.google.com with SMTP id d13so12258401qth.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 12:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zzf3za1lYhMZ8JEKdFgqOu4UePlOfwtg3lZQNSI5AFY=;
        b=VBhY9FFdvjcKHF9gFJ2KVnDdVugyr1NJTe4wm65AznX+jMCnytbGO10k11M+z0aONI
         XKrpA0Wl6C5ziqlhBxBjAxZKXFcvsQv97fOofoF6hdOmwcWuLnO481fKYzRS8GNq+dzz
         zfvuXZtnXbFdl0OFb7YzeP+GZKm6sEXyYnJwfqfSqU8ndi5abU1fJadoH426JATPWVZL
         gGi5bsxVl1GAWC2R951N54WgjUHtInhIy554c/KMlqI1xrl29SUIHyDr4OxWSZjQtpYy
         AEihg1PKhyLgJITnwhQBRT70RWiVkDfuu26VSjcW6Ibha+/dLfqMwJLH0xpMPwKCfN1B
         I/oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zzf3za1lYhMZ8JEKdFgqOu4UePlOfwtg3lZQNSI5AFY=;
        b=QSDHICvotqzkbKMeDpG3xqXK9TYsU9hBclLtOGbmzjZAPFcca4JOoDILjhvH1hoRiq
         xEDM62/LS9SrPmakF0RYXpnRCFsHxZCdPfvBJknqRukBQbKktxTrPM/NMNyJ0S8aNXqX
         fr9h8WwhnnymWgeJH0k+GrqhuL7M/okQcR8CP04ZbmlY6LqCjc+lmKC9kXUojn472wDj
         ponpaVpRJFoIPXBQpc3yFx8ysME3xIXFxfT5q4FGc9y7qyExP2vGMf8OZfYbQ6tC1Dfa
         bCz9sFZ4ZRzRLymgs/jKPGt2j/LWsazhMhyw6U9PY4431ufAi4wuHvfdQlZnuBlI5qIr
         vlGg==
X-Gm-Message-State: APjAAAVE3mugETyH3ApWU2iz6iD+1qVEEgHlv8auABnknc2O2Pj2gGu9
        5ooUXvM5AEey8Czszx9Y4/iInQ==
X-Google-Smtp-Source: APXvYqw5Y5vRGmK2TixWMTtIO/THi0ZH6SokwK26Mnq4hbW0FRUWM9P6guJ04K29ivm8d01F9nKRsA==
X-Received: by 2002:a0c:b14d:: with SMTP id r13mr49092645qvc.80.1554145796821;
        Mon, 01 Apr 2019 12:09:56 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id u16sm5765641qkj.50.2019.04.01.12.09.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 12:09:56 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hB2Jf-0006fZ-2N; Mon, 01 Apr 2019 16:09:55 -0300
Date:   Mon, 1 Apr 2019 16:09:55 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Phil Baker <baker1tex@gmail.com>,
        Craig Robson <craig@zhatt.com>,
        Laura Abbott <labbott@redhat.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Arnd Bergmann <arnd@arndb.de>, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v3] tpm: Actually fail on TPM errors during "get random"
Message-ID: <20190401190955.GJ6209@ziepe.ca>
References: <20190401190607.GA23795@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401190607.GA23795@beast>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 12:06:07PM -0700, Kees Cook wrote:
> A "get random" may fail with a TPM error, but those codes were returned
> as-is to the caller, which assumed the result was the number of bytes
> that had been written to the target buffer, which could lead to a kernel
> heap memory exposure and over-read.
> 
> This fixes tpm1_get_random() to mask positive TPM errors into -EIO, as
> before.
> 
> [   18.092103] tpm tpm0: A TPM error (379) occurred attempting get random
> [   18.092106] usercopy: Kernel memory exposure attempt detected from SLUB object 'kmalloc-64' (offset 0, size 379)!
> 
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=1650989
> Reported-by: Phil Baker <baker1tex@gmail.com>
> Reported-by: Craig Robson <craig@zhatt.com>
> Fixes: 7aee9c52d7ac ("tpm: tpm1: rewrite tpm1_get_random() using tpm_buf structure")
> Cc: Laura Abbott <labbott@redhat.com>
> Cc: Tomas Winkler <tomas.winkler@intel.com>
> Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> v3: fix never-succeed, limit checks to tpm cmd return (James, Jason)
> v2: also fix tpm2 implementation (Jason Gunthorpe)
>  drivers/char/tpm/tpm1-cmd.c | 7 +++++--
>  drivers/char/tpm/tpm2-cmd.c | 7 +++++--
>  2 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
> index 85dcf2654d11..faacbe1ffa1a 100644
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
> @@ -531,8 +531,11 @@ int tpm1_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
>  
>  		rc = tpm_transmit_cmd(chip, &buf, sizeof(out->rng_data_len),
>  				      "attempting get random");
> -		if (rc)
> +		if (rc) {
> +			if (rc > 0)
> +				rc = -EIO;
>  			goto out;
> +		}
>  
>  		out = (struct tpm1_get_random_out *)&buf.data[TPM_HEADER_SIZE];
>  
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index e74c5b7b64bf..8ffa6af61580 100644
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -301,7 +301,7 @@ struct tpm2_get_random_out {
>   *
>   * Return:
>   *   size of the buffer on success,
> - *   -errno otherwise
> + *   -errno otherwise ((positive TPM return codes are masked to -EIO)

Extra bracket, but otherwise looks fine to me

Jason
