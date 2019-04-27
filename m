Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6698C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 06:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B9562077B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 06:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gcHz3UKp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbfD0GRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 02:17:54 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42305 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfD0GRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 02:17:54 -0400
Received: by mail-ot1-f67.google.com with SMTP id f23so4498263otl.9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 23:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a5aMl4sodLMGUHxzMlxnPBZ2OA4JaFfsEYDHDmpQh20=;
        b=gcHz3UKpuq1SIRz7BN6bLePGzjlpYJfI0Gp9wENfs/Nt1PtNNPsixJwIqjPaKCKD8h
         Pr2UWt9uaYC/CYtDacufAEUf81ogUC4EigY+o2lv9kIXI3+fZf3kcRhgLrg85dje0Sjx
         eOQGp9ZcJX0sc/61pLNdNVYDrbntQH1detoXWHDr/QXu4mybq+Xbpn7gdebW7Ae0954t
         sk6d5ds2xbqwQL3GIvGfGJMDtTx5LgM4Kz2BgjtquGrJ8c3VIL/841Mq6ZwfJ1MgA+cO
         IkTvKzP9nkSTpnRe1u+P8AKMv2ty1uGf2OX8wmGlNgUdskTBO3q3+tRRf3HJEk1dTfc6
         +6RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a5aMl4sodLMGUHxzMlxnPBZ2OA4JaFfsEYDHDmpQh20=;
        b=rXholQEvLTj/GzDJoJRg9BOijveh3xFrl4uwidIulkHNJmYI2eoHCHBQ5mvrusB74J
         BmvAvuN35jGDLsSTrTPsl47Y2MBbSSmqUeiyzrDtJHPoVJaOiXW67F6skjtEtmaxC7vc
         cKGl646ATWN/k98sFHwc5DH2qxnpAdpvqdrxcK4VfL2lD4FdWkbiSrAkQ3D9yLCWwU0e
         dXXosDKVB5U6+wG+uwSF6LICMndke8X7ekRFQ6SRAWuq8TTHz2L9gPVZapHCk8V+aG7r
         CtXjC6DRrP7ywVAU+u5hRgYJW5+Ac4GMBBT8gp7ujJ8q9vAkl9zR77qUsjmcEJ4qbGBz
         iucA==
X-Gm-Message-State: APjAAAVq/2SVYrxVoZfkXFJd25FxtJ7UXeUlhXX9tYgXQ/VHMsVaPTZd
        EuE5Zc/Gc6EC1cUq2PZGo1dN9MvvmbhGLHBM7UY=
X-Google-Smtp-Source: APXvYqypOBAbfGJ7cAjyJIEkp/mJesKWo8rcX99MYO3XMHtqvudueD9nY5PZlARzVjMMs5yI7FYw+wRA8Slx5q7ud4Y=
X-Received: by 2002:a9d:6318:: with SMTP id q24mr17493106otk.95.1556345873275;
 Fri, 26 Apr 2019 23:17:53 -0700 (PDT)
MIME-Version: 1.0
References: <1556339208-7722-1-git-send-email-hofrat@osadl.org>
In-Reply-To: <1556339208-7722-1-git-send-email-hofrat@osadl.org>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Sat, 27 Apr 2019 02:17:42 -0400
Message-ID: <CAGngYiXBrNu7Jrk535=L89-mOSNx-6EfqL=1EwwG49Sf44R0Vg@mail.gmail.com>
Subject: Re: [PATCH RFC] staging: fieldbus: anybus-s: use proper type for wait_for_completion_timeout
To:     Nicholas Mc Guire <hofrat@osadl.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Nicholas, thank you for your contribution, I really appreciate it !
See inline comments below.

On Sat, Apr 27, 2019 at 12:32 AM Nicholas Mc Guire <hofrat@osadl.org> wrote:
>
> wait_for_completion_timeout() returns unsigned long (0 on timeout or
> remaining jiffies) not int.

Nice catch !

> thus there is no negative case to check for
> here.

The current code can only break if wait_for_completion_timeout()
returns an unsigned long large enough to make the "int ret" turn
negative. This could result in probe() returning a nonsensical error
value, even though the wait did not time out.

Fortunately that currently cannot happen, because TIMEOUT
(2*HZ) won't overflow an int.

That being said, this return value type mismatch should definitely
be fixed up.

>
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> ---
>
> Problem located with experimental API conformance checking cocci script
>
> Q: It is not really clear if the proposed fix is the right thing here or if
>    this should not be using wait_for_completion_interruptible - which would
>    return -ERESTARTSYS on interruption. Someone that knows the details of
>    this driver would need to check what condition should initiate the
>    goto err_reset; which was actually unreachable in the current code.

It's used in probe(), so no need for an interruptible wait, AFAIK.
It can stay as-is.

>
> Patch was compile-tested with. x86_64_defconfig + FIELDBUS_DEV=m,
> HMS_ANYBUSS_BUS=m
> (some unrelated sparse warnings (cast to restricted __be16))

That sounds interesting too. Could you provide more details?

<snip>

> -       ret = wait_for_completion_timeout(&cd->card_boot, TIMEOUT);
> -       if (ret == 0)
> +       time_left = wait_for_completion_timeout(&cd->card_boot, TIMEOUT);
> +       if (time_left == 0)
>                 ret = -ETIMEDOUT;
> -       if (ret < 0)
> -               goto err_reset;

NAK. This does not jump to err_reset on timeout.

May I suggest the following instead ? (manual formatting)

- ret = wait_for_completion_timeout(&cd->card_boot, TIMEOUT);
- if (ret == 0)
-         ret = -ETIMEDOUT;
- if (ret < 0)
-         goto err_reset;
+ if (!wait_for_completion_timeout(&cd->card_boot, TIMEOUT)) {
+         ret = -ETIMEDOUT;
+         goto err_reset;
+ }
