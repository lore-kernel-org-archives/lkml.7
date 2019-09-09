Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB31C4740C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 15:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5DEC2196E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 15:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbfIIPRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 11:17:14 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37314 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbfIIPRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 11:17:13 -0400
Received: by mail-qt1-f196.google.com with SMTP id g13so16167100qtj.4;
        Mon, 09 Sep 2019 08:17:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KzvdCYJMc3jcRY8kC6B+9ojaAy4hLNLNsDWcIiJdsf0=;
        b=PY7CouA50Iz7CKDGalJa0mmP/1odJmBy34gBNthK//hj2p05RaMUs2IrgAMvyxCMT7
         bcAmZub6yqb3dj7VpXDPutuxCeMgDEzGzI8rnY3fLQdijOeBz//WvbWPU1UpemxUKMLC
         EMFmbcJBq6tS7ncb9Xnq9HWOSmFvOe0SMZfaU9NCjPwQT9z1EJLs+/rvKAD3oCQPM9d5
         gH7TNTGcHh1JJK825KafyFrkYPqn7QYABDZEr/ZLgbdkDWaQPeLaGTIJ7kfB6On2kAUN
         EPJFybi1tFh93//brTqW3NhwWVTaJU5f9oi4wBE+w3EmNesN908PKfSJP2SjqynnliDe
         oQIw==
X-Gm-Message-State: APjAAAWDRwOXt7uqgSJmYvk7Xcr7hmrklueutnVW33Lao8FihE7NhEeo
        4k9iDodvMe0fKvEDfOgMpfe5AMlh+HamzpIzxAw=
X-Google-Smtp-Source: APXvYqylECFPtzaWoRGJJ21CFA6Dl83bvtYMuTMRQbTeIMxr8YHGq6zdO6BvsdMD9Vg1HxNm8rA+F1PV06xkwvaeGL0=
X-Received: by 2002:ac8:342a:: with SMTP id u39mr23896297qtb.7.1568042232506;
 Mon, 09 Sep 2019 08:17:12 -0700 (PDT)
MIME-Version: 1.0
References: <1568020220-7758-1-git-send-email-talel@amazon.com>
 <1568020220-7758-3-git-send-email-talel@amazon.com> <CAK8P3a3UF7xPV1U3eW6Jdu754P1bzG208UxD9KUxEm1JjZudww@mail.gmail.com>
 <98f0028e-5653-3116-fdaa-1385ecdf0289@amazon.com> <CAK8P3a1NVGwYa1bw_vjBatd1xe-i875X1Vq1M+2G_Zxd2Oqusg@mail.gmail.com>
 <8f7840c3-a682-04a5-18bf-ac7a723725b0@amazon.com>
In-Reply-To: <8f7840c3-a682-04a5-18bf-ac7a723725b0@amazon.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 9 Sep 2019 17:16:56 +0200
Message-ID: <CAK8P3a1fbK-qoK+K1ZsWsU3rkxxZgZGaK8ywFAcM4va1GRn_FQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] soc: amazon: al-pos: Introduce Amazon's Annapurna
 Labs POS driver
To:     "Shenhar, Talel" <talel@amazon.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        David Miller <davem@davemloft.net>,
        gregkh <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Patrick Venture <venture@google.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        Maxime Ripard <mripard@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        paul.kocialkowski@bootlin.com, mjourdan@baylibre.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        hhhawa@amazon.com, ronenk@amazon.com, jonnyc@amazon.com,
        hanochu@amazon.com, barakw@amazon.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 9, 2019 at 4:11 PM Shenhar, Talel <talel@amazon.com> wrote:
> On 9/9/2019 4:41 PM, Arnd Bergmann wrote:
>
> In current implementation of v1, I am not doing any read barrier, Hence,
> using the non-relaxed will add unneeded memory barrier.
>
> I have no strong objection moving to the non-relaxed version and have an
> unneeded memory barrier, as this path is not "hot" one.

Ok, then please add it.

> Beside of avoiding the unneeded memory barrier, I would be happy to keep
> common behavior for our drivers:
>
> e.g.
>
> https://github.com/torvalds/linux/blob/master/drivers/irqchip/irq-al-fic.c#L49
>
>
> So what do you think we should go with? relaxed or non-relaxed?

The al_fic_set_trigger() function is clearly a slow-path and should use the
non-relaxed functions. In case of al_fic_irq_handler(), the extra barrier
might introduce a measurable overhead, but at the same time I'm
not sure if that one is correct without the barrier:

If you have an MSI-type interrupt for notifying a device driver of
a DMA completion, there might not be any other barrier between
the arrival of the MSI message and the CPU accessing the data.
Depending on how strict the hardware implements MSI and how
the IRQ is chained, this could lead to data corruption.

If the interrupt is only used for level or edge triggered interrupts,
this is ok since you already need another register read in
the driver before it can safely access a DMA buffer.

In either case, if you can prove that it's safe to use the relaxed
version here and you think that it may help, it would be good to
add a comment explaining the reasoning.

       Arnd
