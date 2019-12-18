Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59762C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 19:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2931B2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 19:58:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbfLRT62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 14:58:28 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:55624 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbfLRT62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 14:58:28 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1c3::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 1AE2E153CA105;
        Wed, 18 Dec 2019 11:58:27 -0800 (PST)
Date:   Wed, 18 Dec 2019 11:58:24 -0800 (PST)
Message-Id: <20191218.115824.2176259916744178647.davem@davemloft.net>
To:     baijiaju1990@gmail.com
Cc:     gregkh@linuxfoundation.org, tglx@linutronix.de,
        allison@lohutok.net, alexios.zavras@intel.com,
        alexandru.ardelean@analog.com, albin_yang@163.com,
        dan.carpenter@oracle.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: nfc: nci: fix a possible sleep-in-atomic-context
 bug in nci_uart_tty_receive()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191218092155.5030-1-baijiaju1990@gmail.com>
References: <20191218092155.5030-1-baijiaju1990@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 18 Dec 2019 11:58:27 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jia-Ju Bai <baijiaju1990@gmail.com>
Date: Wed, 18 Dec 2019 17:21:55 +0800

> The kernel may sleep while holding a spinlock.
> The function call path (from bottom to top) in Linux 4.19 is:
> 
> net/nfc/nci/uart.c, 349: 
> 	nci_skb_alloc in nci_uart_default_recv_buf
> net/nfc/nci/uart.c, 255: 
> 	(FUNC_PTR)nci_uart_default_recv_buf in nci_uart_tty_receive
> net/nfc/nci/uart.c, 254: 
> 	spin_lock in nci_uart_tty_receive
> 
> nci_skb_alloc(GFP_KERNEL) can sleep at runtime.
> (FUNC_PTR) means a function pointer is called.
> 
> To fix this bug, GFP_KERNEL is replaced with GFP_ATOMIC for
> nci_skb_alloc().
> 
> This bug is found by a static analysis tool STCheck written by myself.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

Applied and queued up for -stable, thanks.
