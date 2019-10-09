Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ACA1ECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 06:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E61620B7C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 06:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbfJIG4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 02:56:43 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43442 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfJIG4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 02:56:43 -0400
Received: by mail-oi1-f193.google.com with SMTP id t84so842680oih.10;
        Tue, 08 Oct 2019 23:56:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PU6pSC4rpDZQ3hpvHq0TdAZIyHq1I2BJFZ45k90UauQ=;
        b=aXGk+zTTZtNhTOqe5hG6l45X8ZAGAMnHpjwy2jCFfY7F+cOuD+spDH591CGuMRun35
         1o+hnr0KF7OM1BJTLX9TMyqJ7Rqr2/mBVqPhv9sTPMbtTA+rIZCrL+O9ZFxAbtU1O6Bc
         uL87Tf9HAwuq+k0eKbnhHX2hGCPJndBSKt/wdqEmJCssFFaWtvN4OVuBaqHQwCfWAhb0
         9zQtin41/iNwxhHM8ttgrSQ4ePKciHhWPQXwO1vzSSJXJMgQfkQfo0HnLEEcGZKEIAbv
         weUNEnafcauv1WcgirUTy6HtMC74BUo8C7KREbaCreo2gm70qfQy+v7S8G0v+G3sB+R6
         7Niw==
X-Gm-Message-State: APjAAAUJNeQ9B8/5QGzZgF6BM5jj6nQ8YV866qNsx5JCNgQOKkKZbWny
        T6dy8eFLv1FsJAW2QxP8IbY4nXDpSFDnoW3z/NM=
X-Google-Smtp-Source: APXvYqzk0JepZ+39323h3KeMWAoARy2zy0zvOEiZjj4NXFq1sVESz2FopGsJeLg/sq9NCFM5eUSSDs+5Dmi4PItkesg=
X-Received: by 2002:a05:6808:3b4:: with SMTP id n20mr1049904oie.131.1570604200276;
 Tue, 08 Oct 2019 23:56:40 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.9999.1910081606370.11044@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1910081606370.11044@viisi.sifive.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 9 Oct 2019 08:56:29 +0200
Message-ID: <CAMuHMdVdPFSU_3VEtO=P73kqLezV5Dmki=N3nxsKibzy-U5pBg@mail.gmail.com>
Subject: Re: [PATCH] Documentation: admin-guide: add earlycon documentation
 for the sifive serial driver
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Andreas Schwab <schwab@suse.de>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Wed, Oct 9, 2019 at 1:09 AM Paul Walmsley <paul.walmsley@sifive.com> wrote:
> Document earlycon usage for the SiFive serial port driver in the same
> fashion as for the other serial port IP blocks, since the SiFive
> serial port driver supports it.
>
> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> Reported-by: Andreas Schwab <schwab@suse.de>
> Cc: Christoph Hellwig <hch@lst.de>

Thanks for your patch!

Why do you need this?
I believe risc-v is DT-only, so if chosen/stdout-path is set up, just
passing "earlycon" (without any options) should work.

> ---
>  Documentation/admin-guide/kernel-parameters.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index c7ac2f3ac99f..90becb00221b 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1106,6 +1106,12 @@
>                         address must be provided, and the serial port must
>                         already be setup and configured.
>
> +               sifive,<addr>
> +                       Start an early, polled-mode console on a SiFive
> +                       serial port at the specified address.  The port must
> +                       already be setup and configured.  Options are not
> +                       yet supported.
> +
>         earlyprintk=    [X86,SH,ARM,M68k,S390]
>                         earlyprintk=vga
>                         earlyprintk=sclp

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
