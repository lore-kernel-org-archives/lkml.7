Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC780C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF0E22086C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="almaViIv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbfDASnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 14:43:42 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:45189 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728863AbfDASnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 14:43:41 -0400
Received: by mail-vs1-f68.google.com with SMTP id n14so6124312vsp.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 11:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2WfxtPO5jLSVJC5oVhxfQWbHSP3OSKpZFbErYYiYcAU=;
        b=almaViIvvoAiWHMNxFrLrvIN4wS6SJTGqsbdJxuDcqsarRmwAG34Oy0qsjKhKU4JCv
         Q4Htf+WogB8HEng7MfRgB+8dygHyRnK4o/5U4qzalKyjKjS4UME/ZJyvtw0zdOaZXtIq
         INwgxxs3V87kuVYPYBtFptJxO5Xx8tK+ZwSTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2WfxtPO5jLSVJC5oVhxfQWbHSP3OSKpZFbErYYiYcAU=;
        b=sj0JkDKixeY5QR3cmTcwFNz2Keu5/7fVcM9nrm2Pgcm2+E2mkcWAjQ81jx+PiSHH7I
         xJHJ4MzQXtkQ//1iOssx8xWX2QVoOYdHJO1wP9MqLK64ElFJllmqTvJOQ6B77Zm7RswW
         B4pPr7kZ8C0/CROCRlTZF32UWSB1glGg2aMHWwxpRGkGmQwIbOw+0UGNcKI1xlZCRSEW
         RzQtBaalERLEqioKdF9Yy8K1o3bIJVHWr0CWNJ8YoiwZ4HAjHJ59m+xAf4zUn/wlQtM+
         +KlRgKaC4Sz4Uup9EvqadLZcJVv8RO+OfV6GwuwKcFcg54tbmtqAIJa3SxCgFoGOvNBk
         Bk5g==
X-Gm-Message-State: APjAAAVcVvW7SJszzfD68gpGb/1qC1tCtUKm1Ikui1I59ySMpihKUjnB
        hKlQjabBu162tmTO6WiJgALp2pOuoJk=
X-Google-Smtp-Source: APXvYqzvx3PdoiEpgAEFAOlMbJKYEM5hfA5tsA3vWhWVcQeXg4TTcCmFR+gVxenzptdfWmII2Yo3ew==
X-Received: by 2002:a67:e45a:: with SMTP id n26mr33088993vsm.153.1554144219763;
        Mon, 01 Apr 2019 11:43:39 -0700 (PDT)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com. [209.85.221.173])
        by smtp.gmail.com with ESMTPSA id b186sm3811852vke.17.2019.04.01.11.43.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 11:43:39 -0700 (PDT)
Received: by mail-vk1-f173.google.com with SMTP id q189so2347456vkq.11
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 11:43:38 -0700 (PDT)
X-Received: by 2002:a1f:29c5:: with SMTP id p188mr38139432vkp.24.1554144218275;
 Mon, 01 Apr 2019 11:43:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190401183211.GA21228@beast> <20190401183953.GI6209@ziepe.ca>
In-Reply-To: <20190401183953.GI6209@ziepe.ca>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 1 Apr 2019 11:43:27 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJV4M4y=4OZ3Ph+ovmZbrjosjwb-tS=UEG66rzEdauv+w@mail.gmail.com>
Message-ID: <CAGXu5jJV4M4y=4OZ3Ph+ovmZbrjosjwb-tS=UEG66rzEdauv+w@mail.gmail.com>
Subject: Re: [PATCH] tpm: Actually fail on TPM errors during "get random"
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Phil Baker <baker1tex@gmail.com>,
        Craig Robson <craig@zhatt.com>,
        Laura Abbott <labbott@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        linux-integrity <linux-integrity@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 1, 2019 at 11:39 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Mon, Apr 01, 2019 at 11:32:11AM -0700, Kees Cook wrote:
> > A "get random" may fail with a TPM error, but those codes were returned
> > as-is to the caller, which assumed the result was the number of bytes
> > that had been written to the target buffer, which could lead to an kernel
> > heap memory exposure and over-read.
> >
> > This fixes tpm1_get_random() to mask positive TPM errors into -EIO, as
> > before.
> >
> > [   18.092103] tpm tpm0: A TPM error (379) occurred attempting get random
> > [   18.092106] usercopy: Kernel memory exposure attempt detected from SLUB object 'kmalloc-64' (offset 0, size 379)!
> >
> > Link: https://bugzilla.redhat.com/show_bug.cgi?id=1650989
> > Reported-by: Phil Baker <baker1tex@gmail.com>
> > Reported-by: Craig Robson <craig@zhatt.com>
> > Fixes: 7aee9c52d7ac ("tpm: tpm1: rewrite tpm1_get_random() using tpm_buf structure")
> > Cc: Laura Abbott <labbott@redhat.com>
> > Cc: Tomas Winkler <tomas.winkler@intel.com>
> > Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> >  drivers/char/tpm/tpm1-cmd.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
> > index 85dcf2654d11..faeb78ecf960 100644
> > +++ b/drivers/char/tpm/tpm1-cmd.c
> > @@ -510,7 +510,7 @@ struct tpm1_get_random_out {
> >   *
> >   * Return:
> >   * *  number of bytes read
> > - * * -errno or a TPM return code otherwise
> > + * * -errno (positive TPM return codes are masked to -EIO)
> >   */
> >  int tpm1_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
> >  {
> > @@ -524,7 +524,7 @@ int tpm1_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
> >
> >       rc = tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_GET_RANDOM);
> >       if (rc)
> > -             return rc;
> > +             goto fail;
>
> ?? Does tpm_buf_init() return positive?? Shouldn't..
>
> I think you actually want this:

I didn't check that, but it was tpm_transmit_cmd() that was failing
(and would be covered by the error path change I sent).

>
> diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
> index 85dcf2654d1102..a01e6fba1aacb6 100644
> --- a/drivers/char/tpm/tpm1-cmd.c
> +++ b/drivers/char/tpm/tpm1-cmd.c
> @@ -510,7 +510,7 @@ struct tpm1_get_random_out {
>   *
>   * Return:
>   * *  number of bytes read
> - * * -errno or a TPM return code otherwise
> + * * -errno
>   */
>  int tpm1_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
>  {
> @@ -531,8 +531,10 @@ int tpm1_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
>
>                 rc = tpm_transmit_cmd(chip, &buf, sizeof(out->rng_data_len),
>                                       "attempting get random");
> -               if (rc)
> +               if (rc) {
> +                       rc = -EIO
>                         goto out;
> +               }
>
>                 out = (struct tpm1_get_random_out *)&buf.data[TPM_HEADER_SIZE];
>
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index e74c5b7b64bfbd..9fa498b4cf8816 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -328,8 +328,10 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
>                                        offsetof(struct tpm2_get_random_out,
>                                                 buffer),
>                                        "attempting get random");
> -               if (err)
> +               if (err) {
> +                       rc = -EIO;
>                         goto out;
> +               }
>
>                 out = (struct tpm2_get_random_out *)
>                         &buf.data[TPM_HEADER_SIZE];

Eeks, I missed tpm2. In both cases, though a negative error would be
masked. I was trying to leave those as-is and only mask positive
errors.


-- 
Kees Cook
