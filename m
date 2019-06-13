Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD3CC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 20:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D3FC20B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 20:13:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729681AbfFMUNY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 16:13:24 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33966 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727682AbfFMUNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 16:13:24 -0400
Received: by mail-lf1-f68.google.com with SMTP id y198so105517lfa.1;
        Thu, 13 Jun 2019 13:13:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WyzKJThMrvfYdU5AiRz/a/lZbGM/BDuNcJRJenL7TFM=;
        b=CKZJaXBb1KtJlFabyzzovT8D71vouF72S1FIqgt6UNEyaC4SE0HJYgbJ14gkYjE9Ga
         pB7O7uayoJuZlElJq021JyPoydU3wc2A8oahm57E+6iJ/lQ2fYignJzpxCuvlmJHD2+n
         9rsFppOnIWXEPvk234MeAALq1vHB1fa6tvfnTiU8D1FAM6KMri2B9u8SR9yGtBWjr1Sx
         0X6x9CU+drxkBJ57Gm/Rr7gAbqrgNxrM3EdYDJlBBIMIn+34L8LLAka8xDxZ4vxAP0JC
         k9JiN1zfqUCKC6nCJIjavBGmoGJ48Vf+gSuOJGeS1WBq2vjOAhiqfQiZDoWKOLYbacyP
         zAcw==
X-Gm-Message-State: APjAAAXV5D8BmPA2MWFSlYmca1hIgmytiF9DVu3vrGvBUYVEpYWMGW7y
        kiWHU49Ux6zQ73fh6GijWemYDVfa6nhqkJtw+60=
X-Google-Smtp-Source: APXvYqz0FHOGO7r59qR/V6uklYqF+Nt5DNTmVC4uhdi5vTG1EcR+FFpaX0vy5eaklu3BGnvQOrUHFKsK9/Q0h7NpaHY=
X-Received: by 2002:ac2:597c:: with SMTP id h28mr7020435lfp.90.1560456801790;
 Thu, 13 Jun 2019 13:13:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190613180824.6ajwjelzr5fmjnie@debie>
In-Reply-To: <20190613180824.6ajwjelzr5fmjnie@debie>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 13 Jun 2019 22:13:07 +0200
Message-ID: <CAMuHMdWVbPVRp3tFMVA6HLLESMBp3qdEFUftPGK=Sd8pF_GorA@mail.gmail.com>
Subject: Re: [PATCH] serial: sh-sci: fix uninitialized variable warning
To:     Charles <18oliveira.charles@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        rodrigosiqueiramelo@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Charles,

On Thu, Jun 13, 2019 at 8:09 PM Charles <18oliveira.charles@gmail.com> wrote:
> Avoid following compiler warning on uninitialized variable
>
> In file included from ./include/linux/rwsem.h:16:0,
>                  from ./include/linux/notifier.h:15,
>                  from ./include/linux/clk.h:17,
>                  from drivers/tty/serial/sh-sci.c:24:
> drivers/tty/serial/sh-sci.c: In function ‘sci_dma_rx_submit’:
> ./include/linux/spinlock.h:288:3: warning: ‘flags’ may be used
> uninitialized in this function [-Wmaybe-uninitialized]
>    _raw_spin_unlock_irqrestore(lock, flags); \
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/tty/serial/sh-sci.c:1353:16: note: ‘flags’ was declared here
>   unsigned long flags;
>                 ^~~~~
>
> Signed-off-by: Charles Oliveira <18oliveira.charles@gmail.com>

Thanks for your patch, but this is a false positive: the compiler is not
smart enough to realize that both initialization and use depend on
the same condition.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
