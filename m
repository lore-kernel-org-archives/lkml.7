Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A73C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 23:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6B2A2173E
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 23:11:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405585AbfHVXLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 19:11:09 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:50332 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405569AbfHVXLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 19:11:09 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 087661539127A;
        Thu, 22 Aug 2019 16:11:08 -0700 (PDT)
Date:   Thu, 22 Aug 2019 16:11:07 -0700 (PDT)
Message-Id: <20190822.161107.2184839851828646253.davem@davemloft.net>
To:     wenwen@cs.uga.edu
Cc:     rfontana@redhat.com, alexios.zavras@intel.com, allison@lohutok.net,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: pch_gbe: Fix memory leaks
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1566361206-5135-1-git-send-email-wenwen@cs.uga.edu>
References: <1566361206-5135-1-git-send-email-wenwen@cs.uga.edu>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 22 Aug 2019 16:11:08 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenwen Wang <wenwen@cs.uga.edu>
Date: Tue, 20 Aug 2019 23:20:05 -0500

> In pch_gbe_set_ringparam(), if netif_running() returns false, 'tx_old' and
> 'rx_old' are not deallocated, leading to memory leaks. To fix this issue,
> move the free statements to the outside of the if() statement.
> 
> Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>

Something still is not right here.

> diff --git a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_ethtool.c b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_ethtool.c
> index 1a3008e..cb43919 100644
> --- a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_ethtool.c
> +++ b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_ethtool.c
> @@ -340,12 +340,10 @@ static int pch_gbe_set_ringparam(struct net_device *netdev,
>  			goto err_setup_tx;
>  		pch_gbe_free_rx_resources(adapter, rx_old);
>  		pch_gbe_free_tx_resources(adapter, tx_old);
> -		kfree(tx_old);
> -		kfree(rx_old);
> -		adapter->rx_ring = rxdr;
> -		adapter->tx_ring = txdr;
>  		err = pch_gbe_up(adapter);
>  	}
> +	kfree(tx_old);
> +	kfree(rx_old);

If the if() condition ending here is not taken, you cannot just free these
two pointers.  You are then leaking the memory which would normally be
liberated by pch_gbe_free_rx_resources() and pch_gbe_free_tx_resources().

What's more, in this same situation, the rx_old->dma value is probably still
programmed into the hardware, and therefore the device still could potentially
DMA read/write to that memory.

I think the fix here is not simple, and you will need to do more extensive
research in order to fix this properly.

I'm not applying this, sorry.
