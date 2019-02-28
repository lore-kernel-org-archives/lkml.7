Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F0EDC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EF7C218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387879AbfB1SeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 13:34:14 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:36504 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732847AbfB1SeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 13:34:13 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 2166614BA5DDD;
        Thu, 28 Feb 2019 10:34:13 -0800 (PST)
Date:   Thu, 28 Feb 2019 10:34:12 -0800 (PST)
Message-Id: <20190228.103412.1079788847751298444.davem@davemloft.net>
To:     maennich@google.com
Cc:     vyasevich@gmail.com, nhorman@tuxdriver.com,
        marcelo.leitner@gmail.com, linux-sctp@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sctp: chunk.c: correct format string for size_t in
 printk
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190228113652.55552-1-maennich@google.com>
References: <20190228113652.55552-1-maennich@google.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 28 Feb 2019 10:34:13 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Maennich <maennich@google.com>
Date: Thu, 28 Feb 2019 11:36:52 +0000

> According to Documentation/core-api/printk-formats.rst, size_t should be
> printed with %zu, rather than %Zu.
> 
> In addition, using %Zu triggers a warning on clang (-Wformat-extra-args):
> 
> net/sctp/chunk.c:196:25: warning: data argument not used by format string [-Wformat-extra-args]
>                                     __func__, asoc, max_data);
>                                     ~~~~~~~~~~~~~~~~^~~~~~~~~
> ./include/linux/printk.h:440:49: note: expanded from macro 'pr_warn_ratelimited'
>         printk_ratelimited(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
>         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~
> ./include/linux/printk.h:424:17: note: expanded from macro 'printk_ratelimited'
>                 printk(fmt, ##__VA_ARGS__);                             \
>                        ~~~    ^
> 
> Fixes: 5b5e0928f742 ("lib/vsprintf.c: remove %Z support")
> Link: https://github.com/ClangBuiltLinux/linux/issues/378
> Signed-off-by: Matthias Maennich <maennich@google.com>

Applied, thanks.
