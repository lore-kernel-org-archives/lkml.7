Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF258C5B578
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 22:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9013B20B7C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 22:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="b1pYdXjv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfGAWYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 18:24:43 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45379 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbfGAWYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 18:24:41 -0400
Received: by mail-io1-f68.google.com with SMTP id e3so32417248ioc.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 15:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XMyri1Kc2uUO6xCU2IcO24Tpe83UI0VvKrQ6KZuOhAU=;
        b=b1pYdXjvGR6IJz3r7vcZ/W10d9xEy0Q1egU4/nIpgqiWZSCQGbmC0Yj2PgA+Jj+bpk
         xourNJKMfRItRibpvw2EtaCtOQbu0FOHAJboaMi002paWpVJAnjCFZpnuE8CKKZilMs2
         Lo0iBT68D/W/toSa6E9HDhMCZFjL/m1FrSqqmabPVOyg2JqAQDA7EK66D5jvzklgtj5h
         0WFkjFOVDU5kRYDhqRhDcFkAlfg2TpVCKGyOLHEM4LM9Pd5PH2TAkgyj1shjYGPmHGEs
         8Vgv4Q3Wnpmqih2V29LcCNXhSb5YPBNp+9voq7pM3E52O1JLvLz05kLYFARm6Rcatk1/
         rC2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XMyri1Kc2uUO6xCU2IcO24Tpe83UI0VvKrQ6KZuOhAU=;
        b=d09YqNMPiHqlX6lP6IR3JCaaJpTbpKU7OMy/c+iJlt4CB1gbmiuRQDKkhoU8zjBqUo
         2hU2XQnBtD6OrAyI7UmhkXiGJsYcSu9RnPgAr5KMGnRHan82y+Sis3/x1W/pnfMPJgXF
         +UKq4LIIgvv3DBevhrmTrG3p+cuWNrEDLKfWnvK3zA6RD3mlgQ8/EZm8PTm9FuTOAV6t
         hzdCRR7ag3ouTYjY+sPJRT5Kae6FNgiEHTJSwRCBK0dyNi1n7vF8UWl3KZt9UKSAC1hC
         XVGjvswkDXyGsbFTez562PTsQuVO7JowsxvGH6IftFkHjjTgTTqphdm2Ne0kBwdoZvnM
         qqyQ==
X-Gm-Message-State: APjAAAUSpSTg1HUmuY0OX9qklEBt5bXgeSVNlM177ACYPJv236uBJtLX
        20O1xjfOfYJbVu8jV5i67omKTjNaYoN6D7NisqktCw==
X-Google-Smtp-Source: APXvYqy0De/UfjY18/K1X7cMzz6lbB+XBq2gow9/0FqRHaaXvxyzPvE5Fls4BG2oJGxMFbwvX3/fSGu32V+4cDt83OM=
X-Received: by 2002:a5d:915a:: with SMTP id y26mr20178482ioq.207.1562019880815;
 Mon, 01 Jul 2019 15:24:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190617130149.1782930-1-arnd@arndb.de> <7a96a4d2-25e7-f9cf-1109-23c5495325a8@oracle.com>
In-Reply-To: <7a96a4d2-25e7-f9cf-1109-23c5495325a8@oracle.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Mon, 1 Jul 2019 15:24:29 -0700
Message-ID: <CAOesGMi5urJPF3cKfF+UB_KrK50_VQw+MMS5w_UqKzEMYKeXFA@mail.gmail.com>
Subject: Re: [PATCH] soc: ti: fix irq-ti-sci link error
To:     Santosh Shilimkar <santosh.shilimkar@oracle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 1, 2019 at 10:36 AM <santosh.shilimkar@oracle.com> wrote:
>
> On 6/17/19 6:01 AM, Arnd Bergmann wrote:
> > The irqchip driver depends on the SoC specific driver, but we want
> > to be able to compile-test it elsewhere:
> >
> > WARNING: unmet direct dependencies detected for TI_SCI_INTA_MSI_DOMAIN
> >    Depends on [n]: SOC_TI [=n]
> >    Selected by [y]:
> >    - TI_SCI_INTA_IRQCHIP [=y] && TI_SCI_PROTOCOL [=y]
> >
> > drivers/irqchip/irq-ti-sci-inta.o: In function `ti_sci_inta_irq_domain_probe':
> > irq-ti-sci-inta.c:(.text+0x204): undefined reference to `ti_sci_inta_msi_create_irq_domain'
> >
> > Rearrange the Kconfig and Makefile so we build the soc driver whenever
> > its users are there, regardless of the SOC_TI option.
> >
> > Fixes: 49b323157bf1 ("soc: ti: Add MSI domain bus support for Interrupt Aggregator")
> > Fixes: f011df6179bd ("irqchip/ti-sci-inta: Add msi domain support")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> Thanks Arnd. Will you be able to add it to your fixes queue.
>
> FWIW, Acked-by: Santosh Shilimkar <ssantosh@kernle.org>

Cc:ing to arm@kernel.org is the best way to make sure it surfaces.

Also, please do Acked-by on separate line so the tools catch it next
time (also, check for typos. :)

Applying to fixes.


-Olof
