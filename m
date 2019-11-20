Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB700C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 02:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB6F022449
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 02:59:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbfKTC7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 21:59:48 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:49014 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727243AbfKTC7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 21:59:48 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id BE8F8146D0E9B;
        Tue, 19 Nov 2019 18:59:47 -0800 (PST)
Date:   Tue, 19 Nov 2019 18:59:47 -0800 (PST)
Message-Id: <20191119.185947.333064433426268053.davem@davemloft.net>
To:     hslester96@gmail.com
Cc:     fugang.duan@nxp.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4] net: fec: fix clock count mis-match
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191120012513.11161-1-hslester96@gmail.com>
References: <20191120012513.11161-1-hslester96@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 19 Nov 2019 18:59:47 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuhong Yuan <hslester96@gmail.com>
Date: Wed, 20 Nov 2019 09:25:13 +0800

> pm_runtime_put_autosuspend in probe will call runtime suspend to
> disable clks automatically if CONFIG_PM is defined. (If CONFIG_PM
> is not defined, its implementation will be empty, then runtime
> suspend will not be called.)
> 
> Therefore, we can call pm_runtime_get_sync to runtime resume it
> first to enable clks, which matches the runtime suspend. (Only when
> CONFIG_PM is defined, otherwise pm_runtime_get_sync will also be
> empty, then runtime resume will not be called.)
> 
> Then it is fine to disable clks without causing clock count mis-match.
> 
> Fixes: c43eab3eddb4 ("net: fec: add missed clk_disable_unprepare in remove")
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> ---
> Changes in v4:
>   - Fix some typos.

Applied, thanks.
