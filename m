Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9F9C43215
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 13:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E8902082F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 13:10:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbfKYNKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 08:10:23 -0500
Received: from ns.iliad.fr ([212.27.33.1]:53878 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbfKYNKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 08:10:23 -0500
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id C272920C1C;
        Mon, 25 Nov 2019 14:10:21 +0100 (CET)
Received: from [192.168.108.51] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id ABD03206AB;
        Mon, 25 Nov 2019 14:10:21 +0100 (CET)
Subject: Re: [PATCH v1] clk: Add devm_clk_{prepare,enable,prepare_enable}
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <1d7a1b3b-e9bf-1d80-609d-a9c0c932b15a@free.fr>
 <34e32662-c909-9eb3-e561-3274ad0bf3cc@free.fr>
 <20191125125530.GP25745@shell.armlinux.org.uk>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <c7414301-da0d-cd4d-237d-34277f5ee1d2@free.fr>
Date:   Mon, 25 Nov 2019 14:10:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191125125530.GP25745@shell.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Mon Nov 25 14:10:21 2019 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/11/2019 13:55, Russell King - ARM Linux admin wrote:

> It's also worth reading https://lore.kernel.org/patchwork/patch/755667/
> and considering whether you really are using the clk_prepare() and
> clk_enable() APIs correctly.  Wanting these devm functions suggests
> you aren't...

In that older thread, you wrote:

> If you take the view that trying to keep clocks disabled is a good way
> to save power, then you'd have the clk_prepare() or maybe
> clk_prepare_enable() in your run-time PM resume handler, or maybe even
> deeper in the driver... the original design goal of the clk API was to
> allow power saving and clock control.
> 
> With that in mind, getting and enabling the clock together in the
> probe function didn't make sense.
> 
> I feel that aspect has been somewhat lost, and people now regard much
> of the clk API as a bit of a probe-time nuisance.

In the few drivers I've written, I call clk_prepare_enable() at probe.

And since clk_prepare_enable() is the only non-devm function in probe,
I need either a remove function, or an explicit registration step.

You seem to be saying I'm using the clk API in the wrong way?

Regards.
