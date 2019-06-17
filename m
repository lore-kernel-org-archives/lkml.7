Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00CF2C31E44
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 04:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7B92205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 04:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="MMXvlchV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbfFQEnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 00:43:43 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43113 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbfFQEnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 00:43:43 -0400
Received: by mail-lf1-f67.google.com with SMTP id j29so5442863lfk.10
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2019 21:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QZYnY2hIUSm+INHACfGV3NJI8hXeyeTw8tvqjhCF464=;
        b=MMXvlchVs2Zgrzft62CDXTNlgYLYUhsdEmF5yBBfIzjcxXwgu+TFNl4ZoIwXwi/Cp5
         GZyWocmV8KqP7vfrpu1KZsUdWgrLDSd0gdy43lJi+LlqepOvPg3LRwzIW8VKsHP3Zyex
         nUl+DAZfb/HRyNan1Ndv+uAdskNAK0QOUFJS1qq8hxxYXWax7O1+84TlV70C14ekBJq6
         2Ld/EPFBUYKfF5DBrHjTwoqqpQ8o2NWQU/A8PIF+9etcSJjrhDveAIUKfa2rAObbsj+p
         xspUXSK+ZWwcak0Pe7L+Kb0TaWtpxbwnsJoIEHGhu7U1B34r930XYyfs5qAAq3I80GEW
         ESfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QZYnY2hIUSm+INHACfGV3NJI8hXeyeTw8tvqjhCF464=;
        b=AaraeUYhkRTKNQP2ByLualjDNgY39KVQh0H4ghwLVEQtdVRRdIZxo20Bm8xmd7U5E2
         GIB+VaWIzEft+qFppEnK7Iyo5UqIy4M70lKdbsSPnCLPZzjXxy1mnG3nwP4gFoGfrnlu
         ESv9Ex8BQLeeGDga7XbjRooLmaUGiY70lX0Y6+AoZPGBDKK95IwHWeTcr3z8MhwKlCkp
         tHuVkjBihpFJyG8dVsk5fz0CbjfWkN7LKRxMQBWXUhGhcoIoXIixEJIAtnALUnfi70oo
         +3oubJrIczRLR1mAUM6/FnTAOtIGlh8UhXNfX6tWQZWgfl7rkdj6GKAUCrFOp/JVnW0h
         znkQ==
X-Gm-Message-State: APjAAAUoNm2afF1ppOjKkP9GBcoNqDqIlMusgYn8wg935JyocxP2eg96
        3a/DifQ5L2JUgOE5hO30oLqAKq+VTDf2CxEmTlrMBw==
X-Google-Smtp-Source: APXvYqx5atfcvuI00s9Z4mXLRo48akZO/SgAq0T1wCjD9YxY4YsnaLJCxKSL3H3msuEwih+R7uGarFUy+Wtgrp1SkuE=
X-Received: by 2002:a19:5046:: with SMTP id z6mr6335117lfj.185.1560746621318;
 Sun, 16 Jun 2019 21:43:41 -0700 (PDT)
MIME-Version: 1.0
References: <1560745167-9866-1-git-send-email-yash.shah@sifive.com>
In-Reply-To: <1560745167-9866-1-git-send-email-yash.shah@sifive.com>
From:   Yash Shah <yash.shah@sifive.com>
Date:   Mon, 17 Jun 2019 10:13:05 +0530
Message-ID: <CAJ2_jOH2X6+CcNCruxX0aeCzPnjcGuv-X1Q4eESsY6PyW1LViA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Add macb support for SiFive FU540-C000
To:     David Miller <davem@davemloft.net>, devicetree@vger.kernel.org,
        netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        =?UTF-8?Q?Petr_=C5=A0tetiar?= <ynezz@true.cz>,
        Sachin Ghadi <sachin.ghadi@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 9:49 AM Yash Shah <yash.shah@sifive.com> wrote:
>
> On FU540, the management IP block is tightly coupled with the Cadence
> MACB IP block. It manages many of the boundary signals from the MACB IP
> This patchset controls the tx_clk input signal to the MACB IP. It
> switches between the local TX clock (125MHz) and PHY TX clocks. This
> is necessary to toggle between 1Gb and 100/10Mb speeds.
>
> Future patches may add support for monitoring or controlling other IP
> boundary signals.
>
> This patchset is mostly based on work done by
> Wesley Terpstra <wesley@sifive.com>
>
> This patchset is based on Linux v5.2-rc1 and tested on HiFive Unleashed
> board with additional board related patches needed for testing can be
> found at dev/yashs/ethernet branch of:

Correction in branch name: dev/yashs/ethernet_v2

> https://github.com/yashshah7/riscv-linux.git
>
> Change History:
> V2:
> - Change compatible string from "cdns,fu540-macb" to "sifive,fu540-macb"
> - Add "MACB_SIFIVE_FU540" in Kconfig to support SiFive FU540 in macb
>   driver. This is needed because on FU540, the macb driver depends on
>   SiFive GPIO driver.
> - Avoid writing the result of a comparison to a register.
> - Fix the issue of probe fail on reloading the module reported by:
>   Andreas Schwab <schwab@suse.de>
>
> Yash Shah (2):
>   macb: bindings doc: add sifive fu540-c000 binding
>   macb: Add support for SiFive FU540-C000
>
>  Documentation/devicetree/bindings/net/macb.txt |   3 +
>  drivers/net/ethernet/cadence/Kconfig           |   6 ++
>  drivers/net/ethernet/cadence/macb_main.c       | 129 +++++++++++++++++++++++++
>  3 files changed, 138 insertions(+)
>
> --
> 1.9.1
>
