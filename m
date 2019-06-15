Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E64C31E47
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 12:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 748DD21473
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 12:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKwaqUZx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfFOMND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Jun 2019 08:13:03 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:43446 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbfFOMND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 08:13:03 -0400
Received: by mail-ua1-f68.google.com with SMTP id o2so1847518uae.10
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2019 05:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M+fcWa0RF3atnyomc+tzHvLdKdAoWbr83oMmY7V9PB4=;
        b=dKwaqUZxbjJZ57Y2LOI2bdMvnmhtKZRnjgjTNdY8s/yoY3Rv2rRwikdDtlCI2fNdSN
         r+enr2a8LcP+iuBaX7Ae7nBBdggpNiVgfKFipOj9eEoApUkkxnlcCCbfsjrO/7TQNeCa
         rEte4KPXGPMQvUR4CmpHM3aEEsJLxKBHfGdDKDVVq3wt215eEecbOY8/hroHhCz48xj6
         9q4meSJUf6n1ku3YUDLoU+BawyFK5BAa5S48ZsLn5jKCWWeEZ/w41jFMF2tbYnoW17/Q
         VdSbq5tHzKa/RCRrFss4AhMvEsf0ZDSY2UvHw6ihNUIEweT26QZBtHd9oRVEgfvZhw4+
         fkVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M+fcWa0RF3atnyomc+tzHvLdKdAoWbr83oMmY7V9PB4=;
        b=MHQmu4gWr8RlyDmRsQ0olDbixWcpHgqdkUJ8f0Sx7OMtanJ6aQMZZQH0bd5QbIAwvF
         cvrsUQd7+6ZCviQqn5f48oEE68FXw8xhSM0jDAabJyzmPbvGLrUrA93z7KEqjNVi6ijl
         YPtns9L41uhNajy4eDzRXx1SuJElHXvP2RcvNP5OP/Hc6rBomthwE5IFNNV+aB5q39wg
         rvRM6lEcZ9y07K6slxL4mQtsTTCgf7x4rEJvijGvTg1jhJuoSzYW3ed1Rw6pSYHvEWa2
         ENfsQouL/QB5veq/z1Ef4jwUlQ5G74ywGA+fuCYjHWjAhQgWmUj4WTtH+k2ohklkhuMM
         DL7g==
X-Gm-Message-State: APjAAAWwAvwmZ3E3fOafLOa3eTPsYchBLLCEkXF/5LDzLvem5soy/t5A
        yIQMJ7q+V4kF3GhuNcNlTVPgfO5IT0DX81lYGZmQ02tJ5f1LWQ==
X-Google-Smtp-Source: APXvYqz+kxr5iPOCLRAYmpM+duFjh8lUNzm9J+lDsoNqanqnZH95yoGkMasUtCibJ6T2tZeFnjoRxEiw70JLQ5ZCu9c=
X-Received: by 2002:ab0:4a55:: with SMTP id r21mr34963888uae.133.1560600781930;
 Sat, 15 Jun 2019 05:13:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190611092144.11194-1-oded.gabbay@gmail.com> <20190611095857.GB24058@kroah.com>
 <20190611151753.GA11404@infradead.org> <20190611152655.GA3972@kroah.com>
In-Reply-To: <20190611152655.GA3972@kroah.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Sat, 15 Jun 2019 15:12:36 +0300
Message-ID: <CAFCwf11DKi+pfvvGR2zN4jvwTQZ9-Lm=OXBs+ZU=E-eFfJOi7A@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] habanalabs: enable 64-bit DMA mask in POWER9
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 6:26 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jun 11, 2019 at 08:17:53AM -0700, Christoph Hellwig wrote:
> > On Tue, Jun 11, 2019 at 11:58:57AM +0200, Greg KH wrote:
> > > That feels like a big hack.  ppc doesn't have any "what arch am I
> > > running on?" runtime call?  Did you ask on the ppc64 mailing list?  I'm
> > > ok to take this for now, but odds are you need a better fix for this
> > > sometime...
> >
> > That isn't the worst part of it.  The whole idea of checking what I'm
> > running to set a dma mask just doesn't make any sense at all.
>
> Oded, I thought I asked if there was a dma call you should be making to
> keep this type of check from being needed.  What happened to that?  As
> Christoph points out, none of this should be needed, which is what I
> thought I originally said :)
>
> thanks,
>
> greg k-h

Hi Greg,
So after the dust has settled a bit, do you think it is reasonable to
add this patch upstream ?

As Benjamin and Oliver mentioned, there is no better-looking/standard
way to solve this, considering my device's limitations.
AFAICS, the only way is either this hack, or the kernel module parameter method.

I'll of course monitor the PPC code upstream and if they will manage
to push a fix to their current DMA mask limitation (that will allow
setting dma mask of 48 bits and without setting bit 59 in outbound
transactions), I will modify my code accordingly and then this hack
won't be necessary. But for now, it is what it is.

What do you think ?

Oded
