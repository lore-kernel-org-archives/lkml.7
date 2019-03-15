Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21569C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 18:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F09FB218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 18:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfCOSjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 14:39:20 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:60310 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbfCOSjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 14:39:20 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 178B314D9FA51;
        Fri, 15 Mar 2019 11:39:19 -0700 (PDT)
Date:   Fri, 15 Mar 2019 11:39:18 -0700 (PDT)
Message-Id: <20190315.113918.418776680846022851.davem@davemloft.net>
To:     aaro.koskinen@iki.fi
Cc:     peppe.cavallaro@st.com, alexandre.torgue@st.com,
        joabreu@synopsys.com, thor.thayer@linux.intel.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        aaro.koskinen@nokia.com
Subject: Re: [PATCH 1/2] net: stmmac: don't set own bit too early for jumbo
 frames
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190314194320.25566-1-aaro.koskinen@iki.fi>
References: <20190314194320.25566-1-aaro.koskinen@iki.fi>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 15 Mar 2019 11:39:19 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Thu, 14 Mar 2019 21:43:19 +0200

> From: Aaro Koskinen <aaro.koskinen@nokia.com>
> 
> Commit 0e80bdc9a72d ("stmmac: first frame prep at the end of xmit
> routine") overlooked jumbo frames when re-ordering the code, and as a
> result the own bit was not getting set anymore for the first jumbo frame
> descriptor. Commit 487e2e22ab79 ("net: stmmac: Set OWN bit for jumbo
> frames") tried to fix this, but now the bit is getting set too early and
> the DMA may start while we are still setting up the remaing descriptors.
> And with the chain mode the own bit remains still unset.
> 
> Fix by setting the own bit at the end of xmit also with jumbo frames.
> 
> Fixes: 0e80bdc9a72d ("stmmac: first frame prep at the end of xmit routine")
> Fixes: 487e2e22ab79 ("net: stmmac: Set OWN bit for jumbo frames")
> Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>

Applied with the "remaining" typo fixed.
