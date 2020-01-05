Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 237EBC3F68F
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 04:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEB2F218AC
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 04:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgAEESf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 23:18:35 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:51262 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbgAEESe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 23:18:34 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1c3::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A2822159F0B0A;
        Sat,  4 Jan 2020 20:18:33 -0800 (PST)
Date:   Sat, 04 Jan 2020 20:18:33 -0800 (PST)
Message-Id: <20200104.201833.91020607861340266.davem@davemloft.net>
To:     jiping.ma2@windriver.com
Cc:     peppe.cavallaro@st.com, alexandre.torgue@st.com,
        joabreu@synopsys.com, mcoquelin.stm32@gmail.com,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] stmmac: debugfs entry name is not be changed when udev
 rename device name.
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200102013544.19271-1-jiping.ma2@windriver.com>
References: <20200102013544.19271-1-jiping.ma2@windriver.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 04 Jan 2020 20:18:34 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiping Ma <jiping.ma2@windriver.com>
Date: Thu, 2 Jan 2020 09:35:44 +0800

> Add one notifier for udev changes net device name.
> 
> Signed-off-by: Jiping Ma <jiping.ma2@windriver.com>
> ---
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index b14f46a57154..3b05cb80eed7 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -4038,6 +4038,31 @@ static int stmmac_dma_cap_show(struct seq_file *seq, void *v)
>  }
>  DEFINE_SHOW_ATTRIBUTE(stmmac_dma_cap);
>  
> +/* Use network device events to rename debugfs file entries.
> + */
> +static int stmmac_device_event(struct notifier_block *unused,
> +			       unsigned long event, void *ptr)
> +{
> +	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
> +	struct stmmac_priv *priv = netdev_priv(dev);
> +
> +	switch (event) {
> +	case NETDEV_CHANGENAME:

This notifier gets called for every single netdevice in the entire
system.

You cannot just assume that the device that gets passed in here is
an stmmac device.

Look at how other drivers handle this to see how to do it correctly.

Thank you.
