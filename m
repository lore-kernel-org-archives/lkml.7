Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C20C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 19:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFC7420825
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 19:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfEGT2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 15:28:51 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:33308 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfEGT2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 15:28:51 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d8])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 9A69014B79718;
        Tue,  7 May 2019 12:28:50 -0700 (PDT)
Date:   Tue, 07 May 2019 12:28:49 -0700 (PDT)
Message-Id: <20190507.122849.1270099594432351727.davem@davemloft.net>
To:     harini.katakam@xilinx.com
Cc:     nicolas.ferre@microchip.com, rafalo@cadence.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        michal.simek@xilinx.com, harinikatakamlinux@gmail.com
Subject: Re: [PATCH] net: macb: Change interrupt and napi enable order in
 open
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1557239350-4760-1-git-send-email-harini.katakam@xilinx.com>
References: <1557239350-4760-1-git-send-email-harini.katakam@xilinx.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 07 May 2019 12:28:50 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Harini Katakam <harini.katakam@xilinx.com>
Date: Tue, 7 May 2019 19:59:10 +0530

> Current order in open:
> -> Enable interrupts (macb_init_hw)
> -> Enable NAPI
> -> Start PHY
> 
> Sequence of RX handling:
> -> RX interrupt occurs
> -> Interrupt is cleared and interrupt bits disabled in handler
> -> NAPI is scheduled
> -> In NAPI, RX budget is processed and RX interrupts are re-enabled
> 
> With the above, on QEMU or fixed link setups (where PHY state doesn't
> matter), there's a chance macb RX interrupt occurs before NAPI is
> enabled. This will result in NAPI being scheduled before it is enabled.
> Fix this macb open by changing the order.
> 
> Fixes: ae1f2a56d273 ("net: macb: Added support for many RX queues")
> Signed-off-by: Harini Katakam <harini.katakam@xilinx.com>

Applied and queued up for -stable.
