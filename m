Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8903C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 20:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 805AD22CED
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 20:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfH1UdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 16:33:09 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:36522 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbfH1UdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 16:33:08 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B69FB1536B4CA;
        Wed, 28 Aug 2019 13:33:07 -0700 (PDT)
Date:   Wed, 28 Aug 2019 13:33:07 -0700 (PDT)
Message-Id: <20190828.133307.960183142304533364.davem@davemloft.net>
To:     weifeng.voon@intel.com
Cc:     mcoquelin.stm32@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, joabreu@synopsys.com,
        peppe.cavallaro@st.com, andrew@lunn.ch, alexandre.torgue@st.com,
        boon.leong.ong@intel.com
Subject: Re: [PATCH v1 net-next] net: stmmac: Add support for MDIO
 interrupts
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1566870320-9825-1-git-send-email-weifeng.voon@intel.com>
References: <1566870320-9825-1-git-send-email-weifeng.voon@intel.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 28 Aug 2019 13:33:08 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Voon Weifeng <weifeng.voon@intel.com>
Date: Tue, 27 Aug 2019 09:45:20 +0800

> From: "Chuah, Kim Tatt" <kim.tatt.chuah@intel.com>
> 
> DW EQoS v5.xx controllers added capability for interrupt generation
> when MDIO interface is done (GMII Busy bit is cleared).
> This patch adds support for this interrupt on supported HW to avoid
> polling on GMII Busy bit.
> 
> stmmac_mdio_read() & stmmac_mdio_write() will sleep until wake_up() is
> called by the interrupt handler.
> 
> Reviewed-by: Voon Weifeng <weifeng.voon@intel.com>
> Reviewed-by: Kweh, Hock Leong <hock.leong.kweh@intel.com>
> Reviewed-by: Ong Boon Leong <boon.leong.ong@intel.com>
> Signed-off-by: Chuah, Kim Tatt <kim.tatt.chuah@intel.com>
> Signed-off-by: Ong Boon Leong <boon.leong.ong@intel.com>
> Signed-off-by: Voon Weifeng <weifeng.voon@intel.com>

I know there are some design changes that will occur with this patch but
coding style wise:

> @@ -276,6 +284,10 @@ int stmmac_hwif_init(struct stmmac_priv *priv)
>  		mac->mode = mac->mode ? : entry->mode;
>  		mac->tc = mac->tc ? : entry->tc;
>  		mac->mmc = mac->mmc ? : entry->mmc;
> +		mac->mdio_intr_en = mac->mdio_intr_en ? : entry->mdio_intr_en;
> +
> +		if (mac->mdio_intr_en)
> +			init_waitqueue_head(&mac->mdio_busy_wait);

I'd say always unconditionally initialize wait queues, mutexes, etc.

> +static bool stmmac_mdio_intr_done(struct mii_bus *bus)
> +{
> +	struct net_device *ndev = bus->priv;
> +	struct stmmac_priv *priv = netdev_priv(ndev);
> +	unsigned int mii_address = priv->hw->mii.addr;

Reverse christmas tree here, please.

