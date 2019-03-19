Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDE9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 20:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 073242082F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 20:33:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbfCSUdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 16:33:46 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:53222 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbfCSUdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 16:33:46 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3B695146802B3;
        Tue, 19 Mar 2019 13:33:45 -0700 (PDT)
Date:   Tue, 19 Mar 2019 13:33:44 -0700 (PDT)
Message-Id: <20190319.133344.1485034729701481720.davem@davemloft.net>
To:     aaro.koskinen@iki.fi
Cc:     peppe.cavallaro@st.com, alexandre.torgue@st.com,
        joabreu@synopsys.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, aaro.koskinen@nokia.com
Subject: Re: [PATCH] net: stmmac: fix memory corruption with large MTUs
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190318213608.612-1-aaro.koskinen@iki.fi>
References: <20190318213608.612-1-aaro.koskinen@iki.fi>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 19 Mar 2019 13:33:45 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Mon, 18 Mar 2019 23:36:08 +0200

> From: Aaro Koskinen <aaro.koskinen@nokia.com>
> 
> When using 16K DMA buffers and ring mode, the DES3 refill is not working
> correctly as the function is using a bogus pointer for checking the
> private data. As a result stale pointers will remain in the RX descriptor
> ring, so DMA will now likely overwrite/corrupt some already freed memory.
> 
> As simple reproducer, just receive some UDP traffic:
 ...
> Fixes: 54139cf3bb33 ("net: stmmac: adding multiple buffers for rx")
> Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>

Applied and queued up for -stable, thank you.
