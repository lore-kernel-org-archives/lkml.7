Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB4BCA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 21:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 665C121A4A
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 21:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="l5F5PrtU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407543AbfJWVez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 17:34:55 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44925 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392045AbfJWVey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 17:34:54 -0400
Received: by mail-lf1-f66.google.com with SMTP id g3so5115374lfb.11
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 14:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rGPwK2qvLOHHeiShwuNhPOMbtWTnBcRhDfAqRa9bPnI=;
        b=l5F5PrtU2t9i18n6xfCjgMWrG874CPae8jsguMum6ERhJNmTCZL1Sf8mB3QrUPdOqX
         6/28YdH4nbJZ9kZ6IWZM9t8zgUYYNaebbCGj2J7sLm0b9g1girH70KAcc51l0SGd3FY1
         NxmQlBVu639C8YXA96OdQo+udlfgBsZ+ZoEYqqEYijugS0PRDl5V614TDT1jsw4dCxZZ
         BN8PInrbqRfRa/ncPI0Vd1wy7Ruo97EphkvQIr/cd5q0wHUp9VuVIb0MpJyj/PdjfBs3
         el8VXIDpssMYJnyr8VNuzOgz74qbu67jwNnncZcgNydym3v716T9unVN0w6ES1MwuJ5S
         Go2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rGPwK2qvLOHHeiShwuNhPOMbtWTnBcRhDfAqRa9bPnI=;
        b=B+sEwY+ltnWrMblOjYN+PgdtWjRnm13hGC0+8dlMnhgswaODeUfizvSjeulIWvewra
         woiTxNnBekR1Nrk1kEN37vbqlcqhMRn32odfgxcqVyTFsNuT2G+22i3P+T6n6PRXqBIE
         tw15UK9yWj/p8OeqoKdzKX//HdaoJi9CBPTwBeW5Src6xwTuIUxNDgWUEx6HJXv4POb1
         /Sy/bDqr7gLLfKvgfQkbKyYepBVAQo7rkLuVSGqf/n/B42P470ew1GyqoC3ESzj7TKZT
         lXLGq28yMHgnasmghi/10fwwwYbrttYaUdNnTTDENFDlVWQftmfngbyi6sy//TJF3trC
         F1Rw==
X-Gm-Message-State: APjAAAWH7dWH9FEM4XExCiaGVr25ewj1bJAj02MQqJQGNeUpISgxDfiU
        3gBeedIxnIwAmJr25z6e0lY/KVI2HTjkvl5xqzbf6Q==
X-Google-Smtp-Source: APXvYqxklwi8yCUDuyoen0TIoT0yvGecablQ+JGHeUfmD0h/tYBf6OcxZkVpOTSwjlMub9h3JNNau7T9OpBwuNpEf48=
X-Received: by 2002:ac2:447b:: with SMTP id y27mr13253233lfl.135.1571866492629;
 Wed, 23 Oct 2019 14:34:52 -0700 (PDT)
MIME-Version: 1.0
References: <1571847755-20388-1-git-send-email-alan.mikhak@sifive.com> <alpine.DEB.2.21.9999.1910231152580.16536@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1910231152580.16536@viisi.sifive.com>
From:   Alan Mikhak <alan.mikhak@sifive.com>
Date:   Wed, 23 Oct 2019 14:34:41 -0700
Message-ID: <CABEDWGzeTLk7POWUkU1vJfyxGwjzOzWK-1_RAq7rR1wRh5hTFg@mail.gmail.com>
Subject: Re: [PATCH] irqchip: Skip contexts other supervisor in plic_init()
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        tglx@linutronix.de, jason@lakedaemon.net, maz@kernel.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 11:54 AM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>
> + hch
>
> On Wed, 23 Oct 2019, Alan Mikhak wrote:
>
> > From: Alan Mikhak <alan.mikhak@sifive.com>
> >
> > Modify plic_init() to skip .dts interrupt contexts other
> > than supervisor external interrupt.
>
> Might be good to explain the motivation here.

The .dts entry for plic may specify multiple interrupt contexts. For example,
it may assign two entries IRQ_M_EXT and IRQ_S_EXT, in that order, to
the same interrupt controller. This patch modifies plic_init() to skip the
IRQ_M_EXT context since IRQ_S_EXT is currently the only supported
context.

If IRQ_M_EXT is not skipped, plic_init() will report "handler already
present for context" when it comes across the IRQ_S_EXT context
in the next iteration of its loop.

Without this patch, .dts would have to be edited to replace the
value of IRQ_M_EXT with -1 for it to be skipped.

I will add the above explanation in a v2 patch description, if it
sounds reasonable.

>
> >
> > Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
> > ---
> >  drivers/irqchip/irq-sifive-plic.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> > index c72c036aea76..5f2a773d5669 100644
> > --- a/drivers/irqchip/irq-sifive-plic.c
> > +++ b/drivers/irqchip/irq-sifive-plic.c
> > @@ -251,8 +251,8 @@ static int __init plic_init(struct device_node *node,
> >                       continue;
> >               }
> >
> > -             /* skip context holes */
> > -             if (parent.args[0] == -1)
> > +             /* skip contexts other than supervisor external interrupt */
> > +             if (parent.args[0] != IRQ_S_EXT)
> >                       continue;
>
> Will this need to change for RISC-V M-mode Linux support?
>
> https://lore.kernel.org/linux-riscv/20191017173743.5430-1-hch@lst.de/
>
>
> - Paul
>
>
