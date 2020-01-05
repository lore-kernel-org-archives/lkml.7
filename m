Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126D3C00523
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 23:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E05512085B
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 23:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbgAEXL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 18:11:26 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:42566 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbgAEXL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 18:11:26 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1c3::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id BD52C15714135;
        Sun,  5 Jan 2020 15:11:25 -0800 (PST)
Date:   Sun, 05 Jan 2020 15:11:25 -0800 (PST)
Message-Id: <20200105.151125.1541050812175137787.davem@davemloft.net>
To:     sboyd@kernel.org
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        nicolas.ferre@microchip.com, yash.shah@sifive.com,
        linux@roeck-us.net
Subject: Re: [PATCH] macb: Don't unregister clks unconditionally
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200104001921.225529-1-sboyd@kernel.org>
References: <20200104001921.225529-1-sboyd@kernel.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 05 Jan 2020 15:11:26 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Boyd <sboyd@kernel.org>
Date: Fri,  3 Jan 2020 16:19:21 -0800

> The only clk init function in this driver that register a clk is
> fu540_c000_clk_init(), and thus we need to unregister the clk when this
> driver is removed on that platform. Other init functions, for example
> macb_clk_init(), don't register clks and therefore we shouldn't
> unregister the clks when this driver is removed. Convert this
> registration path to devm so it gets auto-unregistered when this driver
> is removed and drop the clk_unregister() calls in driver remove (and
> error paths) so that we don't erroneously remove a clk from the system
> that isn't registered by this driver.
> 
> Otherwise we get strange crashes with a use-after-free when the
> devm_clk_get() call in macb_clk_init() calls clk_put() on a clk pointer
> that has become invalid because it is freed in clk_unregister().
> 
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Yash Shah <yash.shah@sifive.com>
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Fixes: c218ad559020 ("macb: Add support for SiFive FU540-C000")
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>

Applied and queued up for -stable, thanks.
