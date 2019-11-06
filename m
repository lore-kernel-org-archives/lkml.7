Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D87C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 18:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53BD420869
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 18:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732570AbfKFSY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 13:24:27 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:52850 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727319AbfKFSY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 13:24:26 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 49FDF1537CE87;
        Wed,  6 Nov 2019 10:24:26 -0800 (PST)
Date:   Wed, 06 Nov 2019 10:24:25 -0800 (PST)
Message-Id: <20191106.102425.1829408448491863676.davem@davemloft.net>
To:     chenwandun@huawei.com
Cc:     ruxandra.radulescu@nxp.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dpaa2-ptp: fix compile error
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1572967232-96724-1-git-send-email-chenwandun@huawei.com>
References: <1572967232-96724-1-git-send-email-chenwandun@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 06 Nov 2019 10:24:26 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen Wandun <chenwandun@huawei.com>
Date: Tue, 5 Nov 2019 23:20:32 +0800

> From: Chenwandun <chenwandun@huawei.com>
> 
> phylink_set_port_modes will be compiled if CONFIG_PHYLINK enabled,
> dpaa2_mac_validate will be compiled if CONFIG_FSL_DPAA2_ETH enabled,
> it should select CONFIG_PHYLINK when dpaa2_mac_validate call
> phylink_set_port_modes
> 
> drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.o: In function `dpaa2_mac_validate':
> dpaa2-mac.c:(.text+0x3a1): undefined reference to `phylink_set_port_modes'
> drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.o: In function `dpaa2_mac_connect':
> dpaa2-mac.c:(.text+0x91a): undefined reference to `phylink_create'
> dpaa2-mac.c:(.text+0x94e): undefined reference to `phylink_of_phy_connect'
> dpaa2-mac.c:(.text+0x97f): undefined reference to `phylink_destroy'
> drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.o: In function `dpaa2_mac_disconnect':
> dpaa2-mac.c:(.text+0xa9f): undefined reference to `phylink_disconnect_phy'
> dpaa2-mac.c:(.text+0xab0): undefined reference to `phylink_destroy'
> make: *** [vmlinux] Error 1

You need to add a proper Signed-off-by: and Fixes: tag.
