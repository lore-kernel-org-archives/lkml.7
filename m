Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D20BC4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 21:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C25020700
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 21:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729795AbfJLVcU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 17:32:20 -0400
Received: from gloria.sntech.de ([185.11.138.130]:46566 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729169AbfJLVcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 17:32:20 -0400
Received: from ip5f5a6266.dynamic.kabel-deutschland.de ([95.90.98.102] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iJOzm-0000bP-6Y; Sat, 12 Oct 2019 23:32:14 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, Aditya Pakki <pakki001@umn.edu>,
        Kangjie Lu <kjlu@umn.edu>, Navid Emamdoost <emamd001@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>
Subject: Re: clk: rockchip: Checking a kmemdup() call in rockchip_clk_register_pll()
Date:   Sat, 12 Oct 2019 23:32:12 +0200
Message-ID: <5801053.xxhhKtLrcJ@diego>
In-Reply-To: <e96505a8-b554-f61e-3940-0b9e9c7850ff@web.de>
References: <e96505a8-b554-f61e-3940-0b9e9c7850ff@web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Markus,

Am Samstag, 12. Oktober 2019, 15:55:44 CEST schrieb Markus Elfring:
> I tried another script for the semantic patch language out.
> This source code analysis approach points out that the implementation
> of the function “rockchip_clk_register_pll” contains also a call
> of the function “kmemdup”.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/clk/rockchip/clk-pll.c?id=1c0cc5f1ae5ee5a6913704c0d75a6e99604ee30a#n913
> https://elixir.bootlin.com/linux/v5.4-rc2/source/drivers/clk/rockchip/clk-pll.c#L913
> 
> * Do you find the usage of the format string “%s: could not allocate
>   rate table for %s\n” still appropriate at this place?

If there is an internal "no-memory" output from inside kmemdup now,
I guess the one in the clock driver would be a duplicate and could go away.

> * Is there a need to adjust the error handling here?

There is no need for additional error handling. Like if the rate-table
could not be duplicated, the clock will still report the correct clockrate
you can just not set a new rate.

And for a system it's always better to have the clock driver present
than for all device-drivers to fail probing. Especially as this start as
core clock driver, so there is no deferring possible.

Heiko


