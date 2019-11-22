Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30BACC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 12:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0CD220715
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 12:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dEr2jjn9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbfKVM20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 07:28:26 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38925 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727825AbfKVM20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 07:28:26 -0500
Received: by mail-lj1-f195.google.com with SMTP id p18so7159794ljc.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 04:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Sb0l5wZZ4x3uEUBJJPu8/Qg1fPjfMYDDa2uRl9Za+6g=;
        b=dEr2jjn9fgOjdiaDJE2cZkZfXprKxiCesiH6JGQ81KlVLsOAGLk2zI3vm3VTxAW/Dt
         ZAWD9BggBEV7m9WWyDmoJLJQLBLAb655y6NgNk/WDLD6uEI/O8S08ynaATwcY9j91g/X
         oz6jR2QHAF05zYR4+HVWmCa5e4flLcECiB+55HYKL/QYKAUVUIgkRwnch+WdQq8HQQeX
         wKKBM4IOSVLQf4ztqRZ0MjhDejiodCApagsb6m9creQc3gJ83j5p+55dvpS01vvlXDsE
         /HJ54qBLHQD9VnBEpRVhFG/r3OLcZpVj7BTpKPDCMJV9fuFmPgFiiNrbj/+bvDGzfw1v
         ZjwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Sb0l5wZZ4x3uEUBJJPu8/Qg1fPjfMYDDa2uRl9Za+6g=;
        b=P+zcTIsWaSI2PktdZC6PdtamTXlCbAzRYIAoBMXN576EnsTCiUd08LIG9HQIpBRMBr
         oq3q1FgPpxM8z78vgZeElQFQDaa3/aJvBJ9Bd19KZhXH3FOzqE/60Si/MPkGkgJNkJY5
         IsvbNF+4aime7aDX/6Fcc6CI4VzzAiLAIzjkAZbS4aYGkWjF5WHDl6Oh8jvlkR/9znOx
         fqwrLdtr8YxJnfoZZjJYB3ZhAVld8f6/yAtsiuQfDZ6UM5v/Byxxae73YdH4AYEimmor
         fABo7+epTwYQeOdd5u4pSpnkkyvTVVq/ePIO2g7fq7DfqkgZFs3geUML1AWdBZVK8qqE
         DZ9A==
X-Gm-Message-State: APjAAAWMKreEKoAk00OK8SweE73TehIxTWqLpgc7NKx60aOdhKUm/s3T
        oZSneSrUaKBhcWQIvq+C4MPIMkd4mWLzT5FawZh4ng==
X-Google-Smtp-Source: APXvYqyEr875KK6+Z3AoTFLNHg9GG1Nc70IgJCEP8t2ZeLuj4RGoP4v/mkCP2LZsVpBsQMxyu52/73Y3stYR9or4KTU=
X-Received: by 2002:a2e:9699:: with SMTP id q25mr12078801lji.251.1574425704107;
 Fri, 22 Nov 2019 04:28:24 -0800 (PST)
MIME-Version: 1.0
References: <1573560684-48104-1-git-send-email-yash.shah@sifive.com>
 <1573560684-48104-4-git-send-email-yash.shah@sifive.com> <CAMpxmJWcuV7goPWxOWv_Og9GwzGrioF62SfS1LCiHf9eDX=vdw@mail.gmail.com>
 <CH2PR13MB33680443C101511E66ECADF08C4D0@CH2PR13MB3368.namprd13.prod.outlook.com>
 <CAMpxmJU+P=nWe9fpp45Jw=GwX3+V0sVVshRcE7AD1Kyz_F0qJQ@mail.gmail.com>
 <CACRpkdb9KKPsu7dkjVmHbgQcdo1Zx9uC_jtd6HFwM+RO2EA4nw@mail.gmail.com> <CAMpxmJXFK4VLgJU+P0ZMNkduGfFxAeQ_NguRHtedf7cRPav7LQ@mail.gmail.com>
In-Reply-To: <CAMpxmJXFK4VLgJU+P0ZMNkduGfFxAeQ_NguRHtedf7cRPav7LQ@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 22 Nov 2019 13:28:12 +0100
Message-ID: <CACRpkdaDmd+0809wmiNwSRbsdHaDNzpbOaxCcx6bEfYuyzPNQg@mail.gmail.com>
Subject: Re: [PATCH 3/4] gpio: sifive: Add GPIO driver for SiFive SoCs
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Yash Shah <yash.shah@sifive.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "Paul Walmsley ( Sifive)" <paul.walmsley@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "maz@kernel.org" <maz@kernel.org>,
        "bmeng.cn@gmail.com" <bmeng.cn@gmail.com>,
        "atish.patra@wdc.com" <atish.patra@wdc.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sachin Ghadi <sachin.ghadi@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2019 at 5:42 PM Bartosz Golaszewski
<bgolaszewski@baylibre.com> wrote:
> wt., 19 lis 2019 o 16:03 Linus Walleij <linus.walleij@linaro.org> napisa=
=C5=82(a):
> > On Mon, Nov 18, 2019 at 11:15 AM Bartosz Golaszewski
> > <bgolaszewski@baylibre.com> wrote:

> > > pon., 18 lis 2019 o 11:03 Yash Shah <yash.shah@sifive.com> napisa=C5=
=82(a):
> > Is it really so? The bgpio_lock does protect the registers used
> > by regmap-mmio but unless the interrupt code is also using the
> > same registers it is fine to have a different lock for those.
> >
> > Is the interrupt code really poking into the very same registers
> > as passed to bgpio_init()?
> >
> > Of course it could be seen as a bit dirty to poke around in the
> > same memory space with regmap and the bgpio_* accessors
> > but in practice it's no problem if they never touch the same
> > things.
> >
> > Yours,
> > Linus Walleij
>
> I'm wondering if it won't cause any inconsistencies when for example
> interrupts are being triggered on input lines while we're also reading
> their values? Seems to me it's just more clear to use a single lock
> for a register range. Most drivers using gpio-mmio do just that in
> their irq-related routines.

OK good point. Just one lock for the whole thing is likely
more maintainable even if it works with two different locks.

> Anyway: even without using bgpio_lock this code is inconsistent: if
> we're using regmap for interrupt registers, we should either decide to
> rely on locking provided by regmap or disable it and use a locally
> defined lock.

OK makes sense, let's say we use the bgpio_lock everywhere
for this.

Yash: are you OK with this? (Haven't read the new patch set
yet, maybe it is already fixed...)

> Also: if we're using regmap, then let's use it
> everywhere, not only when it's convenient for updating registers.

I think what you are saying is that we should extend gpio-mmio.c
with some optional regmap API (or create a separate MMIO library
for regmap consumers) which makes sense, but it feels a bit
heavy task to toss at contributors.

We could add it to the TODO file, where I already have some
item like this for port-mapped I/O.

Yours,
Linus Walleij
