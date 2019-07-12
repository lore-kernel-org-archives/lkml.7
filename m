Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2EDC742DD
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 22:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B9DF20989
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 22:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbfGLWUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 18:20:01 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:34138 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727245AbfGLWUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 18:20:00 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id EE2EC14E01AA6;
        Fri, 12 Jul 2019 15:19:59 -0700 (PDT)
Date:   Fri, 12 Jul 2019 15:19:59 -0700 (PDT)
Message-Id: <20190712.151959.494337984512463318.davem@davemloft.net>
To:     arnd@arndb.de
Cc:     ivan.khoronzhuk@linaro.org, grygorii.strashko@ti.com,
        andrew@lunn.ch, ilias.apalodimas@linaro.org,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [net-next] davinci_cpdma: don't cast dma_addr_t to
 pointer
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190710080106.24237-1-arnd@arndb.de>
References: <20190710080106.24237-1-arnd@arndb.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 12 Jul 2019 15:20:00 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 10 Jul 2019 10:00:33 +0200

> dma_addr_t may be 64-bit wide on 32-bit architectures, so it is not
> valid to cast between it and a pointer:
> 
> drivers/net/ethernet/ti/davinci_cpdma.c: In function 'cpdma_chan_submit_si':
> drivers/net/ethernet/ti/davinci_cpdma.c:1047:12: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
> drivers/net/ethernet/ti/davinci_cpdma.c: In function 'cpdma_chan_idle_submit_mapped':
> drivers/net/ethernet/ti/davinci_cpdma.c:1114:12: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
> drivers/net/ethernet/ti/davinci_cpdma.c: In function 'cpdma_chan_submit_mapped':
> drivers/net/ethernet/ti/davinci_cpdma.c:1164:12: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
> 
> Solve this by using two separate members in 'struct submit_info'.
> Since this avoids the use of the 'flag' member, the structure does
> not even grow in typical configurations.
> 
> Fixes: 6670acacd59e ("net: ethernet: ti: davinci_cpdma: add dma mapped submit")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied.
