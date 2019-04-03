Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C140C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 509A9206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="akTNQy9T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbfDCIkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 04:40:11 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37999 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfDCIkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 04:40:10 -0400
Received: by mail-io1-f65.google.com with SMTP id v4so13375535ioj.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 01:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HY0jHOs4R0jG9qXTPfUn1bzB6wZ72lVP8wBuOgvgubA=;
        b=akTNQy9Tg3McxpPEtOSD3thA5yBhYEk4BYKr3SOlLutARVkpxsvC7Zi4San8LYaY+x
         CJKW1KGOg76mPzo4+Doln1HwXtVzWUFP4ZzgbVr1uVcD35kSHfeZMS3/yPdGi02hyPQ+
         tyLdfpC7tvxgzxXg3JuTIKHT0TwD9UQRaDx8kDj0YdpH1daRvNAblNonKS73RDKtVA3N
         mblj5Dgc7tggww2t7EQ3q/NsC6e/bpjYygxRonbOnLJWTakvWQTR9as1iBYnWqGTs4q/
         3vNt0f1gCcCorGX/P6hCrDIXWytO1C4G7PSg2qKo3NxDNsAWbsT4J33fxkuuKvsIgVJk
         AKVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HY0jHOs4R0jG9qXTPfUn1bzB6wZ72lVP8wBuOgvgubA=;
        b=gM1hs7AOuHx8MDi5bvG/5UEzwLLum9IWt0egTkogeXZloX+g1HT1yhvRv5nEK5Nxk6
         q+BjkYQobktuxmaE+9ip4acyRivY6OJoW9mOw9Twe1yriky5Nm5qqLzbOK5ISz9QJ8cZ
         FS7uvBggoilYwIsIgS/HFL8Em6U1VmaS0syJK8MBb568VdFWhyNuTMI5ixXpbznWboOP
         tlfIYkyczufUM/vSSIv2F7MYAaraL/ChhsAY322szgf43e7iObKe3WgPH41OQo+EJavL
         BzpiNQCOZD7paHsW2aEAkGh0hdZSP71j1oOPXK9QsjGyLsDsBDxhFwteH7LXbdjTkutL
         Ng6w==
X-Gm-Message-State: APjAAAXbD+Ml2bNQ2GpIZNvadDq+sJrrhXmUP97S+XLBCoiDhyahCGUX
        fVNX8tDix+tu2gS2vb6Goec1sib2qnP9Oly42mlxsg==
X-Google-Smtp-Source: APXvYqyKz2tFsFN5oKSg8pKKWfo639Q4KbRnoX4HTjlkBUzXUq4UktxheM0F/iXcSXalg/7xHW6WQRJqtDaPdE6Qba4=
X-Received: by 2002:a6b:4e17:: with SMTP id c23mr3267974iob.212.1554280810140;
 Wed, 03 Apr 2019 01:40:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190403083902.3975-1-brgl@bgdev.pl>
In-Reply-To: <20190403083902.3975-1-brgl@bgdev.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 3 Apr 2019 10:39:59 +0200
Message-ID: <CAMRc=MdBVwYiHLPRAJFVaS2OKx-006+P8R8VEfe+x6W_3uq37w@mail.gmail.com>
Subject: Re: [RESEND PATCH 0/4] um: build and irq fixes
To:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-um@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 3 kwi 2019 o 10:39 Bartosz Golaszewski <brgl@bgdev.pl> napisa=C5=
=82(a):
>
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> I've previously sent these patches separately. I still don't see them
> in next and I don't know what the policy is for picking up uml patches
> but I thought I'd resend them rebased together on top of v5.1-rc3.
>

And of course I forgot to pick up acks from Anton...

> Bartosz Golaszewski (4):
>   um: remove unused variable
>   um: remove uses of variable length arrays
>   um: define set_pte_at() as a static inline function, not a macro
>   um: irq: don't set the chip for all irqs
>
>  arch/um/include/asm/pgtable.h |  7 ++++++-
>  arch/um/kernel/irq.c          |  2 +-
>  arch/um/kernel/skas/uaccess.c |  1 -
>  arch/um/os-Linux/umid.c       | 36 ++++++++++++++++++++++++++---------
>  4 files changed, 34 insertions(+), 12 deletions(-)
>
> --
> 2.21.0
>
