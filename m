Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C96C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 05:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C9E72089E
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 05:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405570AbfHIFnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 01:43:55 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:56316 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405542AbfHIFnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 01:43:55 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 65A631449CBB2;
        Thu,  8 Aug 2019 22:43:54 -0700 (PDT)
Date:   Thu, 08 Aug 2019 22:43:53 -0700 (PDT)
Message-Id: <20190808.224353.2118603027227019314.davem@davemloft.net>
To:     huangfq.daxian@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: tundra: tsi108: use spin_lock_irqsave instead
 of spin_lock_irq in IRQ context
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190809053539.8341-1-huangfq.daxian@gmail.com>
References: <20190809053539.8341-1-huangfq.daxian@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 08 Aug 2019 22:43:54 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fuqian Huang <huangfq.daxian@gmail.com>
Date: Fri,  9 Aug 2019 13:35:39 +0800

> As spin_unlock_irq will enable interrupts.
> Function tsi108_stat_carry is called from interrupt handler tsi108_irq.
> Interrupts are enabled in interrupt handler.
> Use spin_lock_irqsave/spin_unlock_irqrestore instead of spin_(un)lock_irq
> in IRQ context to avoid this.
> 
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
> ---
> Changes in v2:
>   - Preserve reverse christmas tree ordering of local variables.

Applied, thanks.
