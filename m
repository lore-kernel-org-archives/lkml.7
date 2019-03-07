Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC58AC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 18:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9F5820675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 18:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfCGS7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 13:59:44 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:53206 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbfCGS7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 13:59:43 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 95CA7147BAE6B;
        Thu,  7 Mar 2019 10:59:42 -0800 (PST)
Date:   Thu, 07 Mar 2019 10:59:38 -0800 (PST)
Message-Id: <20190307.105938.496464522338008986.davem@davemloft.net>
To:     natechancellor@gmail.com
Cc:     peppe.cavallaro@st.com, alexandre.torgue@st.com,
        joabreu@synopsys.com, mcoquelin.stm32@gmail.com,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, ndesaulniers@google.com
Subject: Re: [PATCH v2] net: stmmac: Avoid sometimes uninitialized Clang
 warnings
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190307180027.6226-1-natechancellor@gmail.com>
References: <20190307162101.29204-1-natechancellor@gmail.com>
        <20190307180027.6226-1-natechancellor@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 07 Mar 2019 10:59:43 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>
Date: Thu,  7 Mar 2019 11:00:28 -0700

> When building with -Wsometimes-uninitialized, Clang warns:
> 
> drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:495:3: warning: variable 'ns' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
> drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:495:3: warning: variable 'ns' is used uninitialized whenever '&&' condition is false [-Wsometimes-uninitialized]
> drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:532:3: warning: variable 'ns' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
> drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:532:3: warning: variable 'ns' is used uninitialized whenever '&&' condition is false [-Wsometimes-uninitialized]
> drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:741:3: warning: variable 'sec_inc' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
> drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:741:3: warning: variable 'sec_inc' is used uninitialized whenever '&&' condition is false [-Wsometimes-uninitialized]
> 
> Clang is concerned with the use of stmmac_do_void_callback (which
> stmmac_get_timestamp and stmmac_config_sub_second_increment wrap),
> as it may fail to initialize these values if the if condition was ever
> false (meaning the callbacks don't exist). It's not wrong because the
> callbacks (get_timestamp and config_sub_second_increment respectively)
> are the ones that initialize the variables. While it's unlikely that the
> callbacks are ever going to disappear and make that condition false, we
> can easily avoid this warning by zero initialize the variables.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/384
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Applied.
