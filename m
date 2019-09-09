Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 709EBC4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 13:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49B2E218AF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 13:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730808AbfIINln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 09:41:43 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34720 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730097AbfIINlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 09:41:42 -0400
Received: by mail-qt1-f193.google.com with SMTP id j1so3426354qth.1;
        Mon, 09 Sep 2019 06:41:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SDsZ3GvRAcyIUFZLokzUq7LE+Tk9DdpyOBzKvaT0DcA=;
        b=KNWI68JfDOdc5qXiL8En5/ez2FXZj2E4TdRRdqolMXxn3umt1OMT0pec5iiVw194ee
         JvTACLyclYp13ZmKtT8XElNBuhpsyNNoqSkfjAufbdfWnhN6+ZjCaAg4b6zAWaKOyjWf
         QMcU0NvM0/CZS864OBvIN2gDQ9tSzcWnB94xDc43ZdgA0JI3k1qv51shYhLU4gmC3E/I
         tIeyXPGQkQov0De73lQoZI7PQeAEB+26W85Est9pN9UbrkGQOBcLAdoBYBzOBDYK2whO
         LWFkr6VN8sxwpngbjV5Yu0oNyhbHzQFrlqx2LeLeOS75y4YMPKo19wYB/mK0r2aHknVs
         8DlQ==
X-Gm-Message-State: APjAAAXp5pLGeSn9xj3hjzqL0ZAlGDn18/ZoIoMQDUvp2mfxK4fUx7zm
        K/XvAmlLEfW1DRGMeOnI5UCfW0g8Fgf5raWtIRU=
X-Google-Smtp-Source: APXvYqztw9yoFAktq4haAyRINAdunmh3DTRwfofdC/M2KAxhks4YcE64COGxATxqzbpKKrAUk9IYt0L30m58EvYBVs0=
X-Received: by 2002:ac8:5306:: with SMTP id t6mr23047010qtn.204.1568036501922;
 Mon, 09 Sep 2019 06:41:41 -0700 (PDT)
MIME-Version: 1.0
References: <1568020220-7758-1-git-send-email-talel@amazon.com>
 <1568020220-7758-3-git-send-email-talel@amazon.com> <CAK8P3a3UF7xPV1U3eW6Jdu754P1bzG208UxD9KUxEm1JjZudww@mail.gmail.com>
 <98f0028e-5653-3116-fdaa-1385ecdf0289@amazon.com>
In-Reply-To: <98f0028e-5653-3116-fdaa-1385ecdf0289@amazon.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 9 Sep 2019 15:41:25 +0200
Message-ID: <CAK8P3a1NVGwYa1bw_vjBatd1xe-i875X1Vq1M+2G_Zxd2Oqusg@mail.gmail.com>
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

On Mon, Sep 9, 2019 at 1:13 PM Shenhar, Talel <talel@amazon.com> wrote:
> On 9/9/2019 12:44 PM, Arnd Bergmann wrote:
> > On Mon, Sep 9, 2019 at 11:14 AM Talel Shenhar <talel@amazon.com> wrote:

> >> +       writel_relaxed(0, pos->mmio_base + AL_POS_ERROR_LOG_1);
> > Why do you require _relaxed() accessors here? Please add a comment
> > explaining that, or use the regular readl()/writel().
>
> I don't think commenting is needed here as there is nothing special in
> this type of access.
>
> I don't see this is common to comment the use of the _relaxed accessors.

I usually mention it in driver reviews, but most authors revert back
to the normal accessors when there is no difference.

> This driver is for SoC using arm64 cpu.
>
> If one uses the non-relaxed version of readl while running on arm64, he
> shall cause read barrier, which is then doing dsm(ld).. This barrier is
> not needed here, so we spare the use of the more heavy readl in favor of
> the less "harmful" one.
>
> Let me know what you think.

If the barrier causes no harm, just leave it in to keep the code more
readable. Most developers don't need to know the difference between
the two, so using the less common interface just makes the reader
curious about why it was picked.

Avoiding the barrier can make a huge performance difference in a
hot code path, but the downside is that it can behave in unexpected
ways if the same code is run on a different CPU architecture that
does not have the exact same rules about what _relaxed() means.

In fact, replacing a 'readl()' with 'readl_relaxed() + rmb()' can lead
to slower rather than faster code when the explicit barrier is heavier
than the implied one (e.g. on x86), or readl_relaxed() does not skip
the barrier.

The general rule with kernel interfaces when you have two versions
that both do what you want is to pick the one with the shorter name.
See spin_lock()/spin_lock_irqsave(),  ioremap()/ioremap_nocache(),
or ktime_get()/ktime_get_clocktai_ts64(). (yes, there are also
exceptions)

    Arnd
