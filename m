Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7108C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 08:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B04B220700
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 08:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfC1IKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 04:10:18 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:38251 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbfC1IKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 04:10:17 -0400
Received: by mail-ua1-f68.google.com with SMTP id d4so6546446uap.5;
        Thu, 28 Mar 2019 01:10:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jRUgvZGmNWliE3jaTuWfhB/x9qfmX7QfxZz8gk2Gg5I=;
        b=OHSXR37qkJRRvoK1cd+hVvS9+6whNa+BDckwevJ3F940ceo0HK4zJiLa/obl/Knuz4
         h2cVw/7qP3N82ZRa/DbSM4433Qzm/SBSBX/AW3mHAJmE5DSOXQSTv+otbnfBODabMIrw
         qjsSfuhQ87wObrrvq++FnpIb1eBcBDuKVr/aKDCWZNMHJ6xi8i+P1UDWEOYYo6E0xB2X
         sigMJnII25eE8BNDbIZFdarDWd8gJin15gw9fV4bc7JamzIda+hFlIu8N//ln1PDprSF
         OaD9H8vVi6bZs6S+74TTW2v6YpCzp1/Gxv0n60FEdzwzwPqicVBvoXTVABy370kNO9tP
         A9Wg==
X-Gm-Message-State: APjAAAX2Z+TgTrggsCPiS9dh6l7dq6DQ5Q8RosXkGhdBfzTc7RnALbT0
        QRxBFvgsr4Tz5ZgTVmF4BM7DBNICHS+wk7FDq3lRdVoH
X-Google-Smtp-Source: APXvYqz9r3Gh7bqhhyIqSeKx56Zfi3q4bPl3CeVHfVgMQZ6Vvv4NssofolIX1PK2Zc+CffLJa89q5Snt+H7vqdnTQ7M=
X-Received: by 2002:a9f:3fce:: with SMTP id m14mr24440126uaj.96.1553760615463;
 Thu, 28 Mar 2019 01:10:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190327211256.17232-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20190327211256.17232-1-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 28 Mar 2019 09:10:02 +0100
Message-ID: <CAMuHMdVHWNcrjXGSPaK9XTTuGEaPPpwp6gzy8XD10_TYNF1PJQ@mail.gmail.com>
Subject: Re: [RFC PATCH] i2c: remove use of in_atomic()
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Linux I2C <linux-i2c@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

On Wed, Mar 27, 2019 at 10:13 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Commit cea443a81c9c ("i2c: Support i2c_transfer in atomic contexts")
> added in_atomic() to the I2C core. However, the use of in_atomic()
> outside of core kernel code is discouraged and was already[1] when this
> code was added in early 2008. The above commit was a preparation for
> b7a3670131c7 ("i2c-pxa: Add polling transfer"). Its commit message says
> explicitly it was added "for cases where I2C transactions have to occur
> at times interrups are disabled". So, the intention was 'disabled
> interrupts'. This matches the use cases for atomic I2C transfers I have
> seen so far: very late communication (mostly to a PMIC) to powerdown or
> reboot the system. For those cases, interrupts are disabled then. It
> doesn't seem that in_atomic() adds value.
>
> Note that only ~10 out of ~120 bus master drivers support atomic
> transfers, mostly by polling always when no irq is supplied. A generic
> I2C client driver cannot assume support for atomic transfers. This is
> currently a platform-dependent corner case.
>
> The I2C core will soon gain an extra callback into bus drivers
> especially for atomic transfers to make them more generic. The code
> deciding which transfer to use (atomic/non-atomic) should mimic the
> behaviour which locking to use (trylock/lock). Because I don't want to
> add more in_atomic() to the I2C core, this patch simply removes it.
>
> [1] https://lwn.net/Articles/274695/
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

LGTM, so:
Ackeded-by: Geert Uytterhoeven <geert+renesas@glider.be>

But please wait for Peter and/or Frederic to give their fiat, too.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
