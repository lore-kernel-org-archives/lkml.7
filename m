Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDDBC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 18:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D2C5218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 18:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfCOSj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 14:39:27 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:60330 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfCOSjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 14:39:25 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E22E614D9FA52;
        Fri, 15 Mar 2019 11:39:24 -0700 (PDT)
Date:   Fri, 15 Mar 2019 11:39:23 -0700 (PDT)
Message-Id: <20190315.113923.1281526892950673180.davem@davemloft.net>
To:     aaro.koskinen@iki.fi
Cc:     peppe.cavallaro@st.com, alexandre.torgue@st.com,
        joabreu@synopsys.com, thor.thayer@linux.intel.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        aaro.koskinen@nokia.com
Subject: Re: [PATCH 2/2] net: stmmac: fix jumbo frame sending with
 non-linear skbs
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190314194320.25566-2-aaro.koskinen@iki.fi>
References: <20190314194320.25566-1-aaro.koskinen@iki.fi>
        <20190314194320.25566-2-aaro.koskinen@iki.fi>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 15 Mar 2019 11:39:25 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Thu, 14 Mar 2019 21:43:20 +0200

> From: Aaro Koskinen <aaro.koskinen@nokia.com>
> 
> When sending non-linear skbs with jumbo frames, we set up the non-paged
> data and mark that as a last segment, although the paged fragments are
> also prepared. This will stall the TX queue and trigger a watchdog warning
> (a simple reproducer is to run an iperf client mode TCP test with a large
> MTU - networking fails instantly).
> 
> Fix by checking if the skb is non-linear.
> 
> Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>

Applied.
