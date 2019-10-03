Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45024C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 00:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 211DC222C0
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 00:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728864AbfJCAWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 20:22:15 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:38664 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbfJCAWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 20:22:15 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 4A6B415527ED1;
        Wed,  2 Oct 2019 17:22:14 -0700 (PDT)
Date:   Wed, 02 Oct 2019 17:22:13 -0700 (PDT)
Message-Id: <20191002.172213.1475260023258384833.davem@davemloft.net>
To:     thierry.reding@gmail.com
Cc:     joabreu@synopsys.com, alexandre.torgue@st.com,
        peppe.cavallaro@st.com, f.fainelli@gmail.com, bbiswas@nvidia.com,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: stmmac: Avoid deadlock on suspend/resume
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191002144946.176976-1-thierry.reding@gmail.com>
References: <20191002144946.176976-1-thierry.reding@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 02 Oct 2019 17:22:14 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <thierry.reding@gmail.com>
Date: Wed,  2 Oct 2019 16:49:46 +0200

> From: Thierry Reding <treding@nvidia.com>
> 
> The stmmac driver will try to acquire its private mutex during suspend
> via phylink_resolve() -> stmmac_mac_link_down() -> stmmac_eee_init().
> However, the phylink configuration is updated with the private mutex
> held already, which causes a deadlock during suspend.
> 
> Fix this by moving the phylink configuration updates out of the region
> of code protected by the private mutex.
> 
> Fixes: 19e13cb27b99 ("net: stmmac: Hold rtnl lock in suspend/resume callbacks")
> Suggested-by: Bitan Biswas <bbiswas@nvidia.com>
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Applied.
