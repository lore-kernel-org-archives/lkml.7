Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D91C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E60AB20661
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfCGRxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:53:16 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:52358 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbfCGRxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:53:16 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 64A11147F788E;
        Thu,  7 Mar 2019 09:53:15 -0800 (PST)
Date:   Thu, 07 Mar 2019 09:53:14 -0800 (PST)
Message-Id: <20190307.095314.717279119845244235.davem@davemloft.net>
To:     natechancellor@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, ndesaulniers@google.com
Subject: Re: [PATCH] net: atm: Use IS_ENABLED in atm_dev_ioctl
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190307165741.19870-1-natechancellor@gmail.com>
References: <20190307165741.19870-1-natechancellor@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 07 Mar 2019 09:53:15 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>
Date: Thu,  7 Mar 2019 09:57:42 -0700

> When building with -Wsometimes-uninitialized, Clang warns:
> 
> net/atm/resources.c:256:6: warning: variable 'number' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
> net/atm/resources.c:212:7: warning: variable 'iobuf_len' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
> 
> Clang won't realize that compat is 0 when CONFIG_COMPAT is not set until
> the constant folding stage, which happens after this semantic analysis.
> Use IS_ENABLED instead so that the zero is present at the semantic
> analysis stage, which eliminates this warning.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/386
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Applied, thanks.

 
