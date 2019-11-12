Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC618C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 19:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B05D214E0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 19:13:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfKLTNT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 14:13:19 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:48020 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbfKLTNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 14:13:19 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B5670154CD36F;
        Tue, 12 Nov 2019 11:13:18 -0800 (PST)
Date:   Tue, 12 Nov 2019 11:13:18 -0800 (PST)
Message-Id: <20191112.111318.1764384720609728917.davem@davemloft.net>
To:     hslester96@gmail.com
Cc:     fugang.duan@nxp.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: fec: add a check for CONFIG_PM to avoid
 clock count mis-match
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191112112830.27561-1-hslester96@gmail.com>
References: <20191112112830.27561-1-hslester96@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 12 Nov 2019 11:13:18 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuhong Yuan <hslester96@gmail.com>
Date: Tue, 12 Nov 2019 19:28:30 +0800

> If CONFIG_PM is enabled, runtime pm will work and call runtime_suspend
> automatically to disable clks.
> Therefore, remove only needs to disable clks when CONFIG_PM is disabled.
> Add this check to avoid clock count mis-match caused by double-disable.
> 
> Fixes: c43eab3eddb4 ("net: fec: add missed clk_disable_unprepare in remove")
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>

I don't understand this at all.

The clk disables here match the unconditional clk enables in the probe
function.

And that is how this is supposed to work, probe enables match remove
disables.  And suspend disables match resume enables.

Why isn't the probe enable taking the correct count, which the remove
function must match with an appropriate disable?  There is no CONFIG_PM
guarding the probe time clk enables.
