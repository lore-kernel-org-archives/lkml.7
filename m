Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3011C10F03
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB343208E4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbfCGRqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:46:06 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:52252 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbfCGRqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:46:01 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id DE70F1479C61D;
        Thu,  7 Mar 2019 09:46:00 -0800 (PST)
Date:   Thu, 07 Mar 2019 09:46:00 -0800 (PST)
Message-Id: <20190307.094600.334828809875646248.davem@davemloft.net>
To:     arnd@arndb.de
Cc:     f.fainelli@gmail.com, jakub.kicinski@netronome.com,
        jiri@mellanox.com, wang6495@umn.edu, mkubecek@suse.cz,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] ethtool: reduce stack usage with clang
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190307160017.3120362-1-arnd@arndb.de>
References: <20190307160017.3120362-1-arnd@arndb.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 07 Mar 2019 09:46:01 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Thu,  7 Mar 2019 16:58:35 +0100

> clang inlines the dev_ethtool() more aggressively than gcc does, leading
> to a larger amount of used stack space:
> 
> net/core/ethtool.c:2536:24: error: stack frame size of 1216 bytes in function 'dev_ethtool' [-Werror,-Wframe-larger-than=]
> 
> Marking the sub-functions that require the most stack space as
> noinline_for_stack gives us reasonable behavior on all compilers.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: don't annotate dev_ethtool itself, as pointed out by Michal Kubecek

I'll apply this, but as Michal said this is just papering over the problem,
the aggregate stack allocation is still the same and very large.
