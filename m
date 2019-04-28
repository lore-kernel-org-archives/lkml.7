Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CAE4C43219
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 14:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0979D2067C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 14:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DskcGm1y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbfD1OXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 10:23:55 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38201 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbfD1OXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 10:23:55 -0400
Received: by mail-ot1-f67.google.com with SMTP id t20so6520106otl.5
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2019 07:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UrVxQZBuvnp3JOhkf+W+d2tzb7u+gX+IuPDYN/m+AHg=;
        b=DskcGm1yhQ+wgZj3J9uDOi1xhc54srpJ5DlAcq+k1+TC2hIto1nhunNNhgqELlMwqC
         RUe0nTqQ9rd6e/nIGf4xqV7u3j7IB62bUHbT/vC3TvwMdk0AcB6BuCWjUGSRvAqESGhl
         V1Xb+CY+Qjkr+YRmbQy5SxjmNrdUEdcBxjeq/Jt1iDJaWU7+lHio52Y6Il/FGZQomzXX
         zfQiaUXnupWikDhzGj5PrbbTdBIPSMuiuJncqrnMBpCMiZFQ+NO+Q0lzw3LtWj2+Gjcd
         7q0UnAEg+Kjtzy90AsbCSlfdjAmeg+j8vvfXB80eqpfMCFetGTZUzUqTL7agFZW0y0+a
         sM0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UrVxQZBuvnp3JOhkf+W+d2tzb7u+gX+IuPDYN/m+AHg=;
        b=J+eYe92GVQz8K3S0yeHC0FI5xM+YgJrt6L4QXYzSWdjMcVWruB9e/WRGchASWabAco
         MExrcQietaf50RRnEUG5P4yLOl3NzbAqhbwiAwXdUGRTzZ2dFwKTpkM7icQkUJKnmyz2
         lv3QKkvc7pMIxuBJwT8unl088IKWp5MgaxmicUo4+TNJT72bnxdKjgVW7b/MTfI537He
         vcXWyjclI6eZeNwBQomR1hafKYQJ8SKGq5rOKuXUaDZgR+SIXB2Nkdn84wObbduwA5cE
         J+4UgZq1YkEC/lG+dB8KoYH4++pBByC1wAmDLcNj4Jq8jS/KK04+5OVlOcs3NbLtyrLa
         /qjA==
X-Gm-Message-State: APjAAAXBlX/M4Wu/bT9MaEMY18RXDF5PmIq3HZoQMR81/gzLPj244duL
        pHGJbpTYVW2qMR4dK8nsiuBZdZXvc+5PdaFwZXY=
X-Google-Smtp-Source: APXvYqysWBYGF4Ebxi+XdneZ+kfNwVpgMHSSoctrVi+yfU7Mm/wvOqmYyRKBxEveUy+JobpgBqBeZUV/i0gFr7hRQsY=
X-Received: by 2002:a9d:7319:: with SMTP id e25mr1730932otk.279.1556461434231;
 Sun, 28 Apr 2019 07:23:54 -0700 (PDT)
MIME-Version: 1.0
References: <1556418804-10266-1-git-send-email-hofrat@osadl.org>
In-Reply-To: <1556418804-10266-1-git-send-email-hofrat@osadl.org>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Sun, 28 Apr 2019 10:23:43 -0400
Message-ID: <CAGngYiXMMKz2AesEAVO_wdXw0ixsnjNo0o920evZPL9CM0cdJQ@mail.gmail.com>
Subject: Re: [PATCH V2] staging: fieldbus: anybus-s: consolidate
 wait_for_completion_timeout return handling
To:     Nicholas Mc Guire <hofrat@osadl.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looking good, but see inline.

On Sat, Apr 27, 2019 at 10:39 PM Nicholas Mc Guire <hofrat@osadl.org> wrote:
>
> wait_for_completion_timeout() returns unsigned long (0 on timeout or
> remaining jiffies) not int - so rather than introducing an additional
> variable simply wrap the completion into an if().

Your commit message could be improved:

- the headline should make clear what this is, e.g. add functionality,
bugfix, shutting up sparse, etc. Using the verb 'fix' would be
good here.

- in case of a bugfix, it would make sense to write a short
paragraph about what can go wrong, followed by a short
paragraph outlining what the patch does to fix it.

>
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> ---
>
> Problem located with experimental API conformance checking cocci script
>
> V2: The original patch's logic was wrong as it was skipping the
>     fall-through if so using the fix proposed by Sven Van Asbroeck
>     <thesven73@gmail.com> - This solution also eliminates the need
>     to introduce an additional variable - Thanks !
>
> Patch was compile-tested with. x86_64_defconfig + FIELDBUS_DEV=m,
> HMS_ANYBUSS_BUS=m
> (with an unrelated sparse warnings (cast to restricted __be16))
>
> Patch is against 5.1-rc6 (localversion-next is next-20190426)
>
>  drivers/staging/fieldbus/anybuss/host.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/staging/fieldbus/anybuss/host.c b/drivers/staging/fieldbus/anybuss/host.c
> index e34d424..6227daf 100644
> --- a/drivers/staging/fieldbus/anybuss/host.c
> +++ b/drivers/staging/fieldbus/anybuss/host.c
> @@ -1325,11 +1325,11 @@ anybuss_host_common_probe(struct device *dev,
>          *   interrupt came in: ready to go !
>          */
>         reset_deassert(cd);
> -       ret = wait_for_completion_timeout(&cd->card_boot, TIMEOUT);
> -       if (ret == 0)
> +       if (!wait_for_completion_timeout(&cd->card_boot, TIMEOUT)) {
>                 ret = -ETIMEDOUT;
> -       if (ret < 0)
>                 goto err_reset;
> +       }
> +

Nit: why add a blank line here?

>         /*
>          * according to the anybus docs, we're allowed to read these
>          * without handshaking / reserving the area
> --
> 2.1.4
>
