Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4D2C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A77220449
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbfCKTOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 15:14:16 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:40526 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfCKTOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:14:15 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B15E3140F4EB3;
        Mon, 11 Mar 2019 12:14:14 -0700 (PDT)
Date:   Mon, 11 Mar 2019 12:14:12 -0700 (PDT)
Message-Id: <20190311.121412.1771390861732982560.davem@davemloft.net>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, isdn@linux-pingi.de, gustavo@embeddedor.com,
        baijiaju1990@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] isdn: hfcpci: fix potential NULL pointer dereference
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190311053436.10747-1-kjlu@umn.edu>
References: <20190311053436.10747-1-kjlu@umn.edu>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 11 Mar 2019 12:14:15 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kangjie Lu <kjlu@umn.edu>
Date: Mon, 11 Mar 2019 00:34:34 -0500

> In case ioremap fails, the fix releases resources and returns.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  drivers/isdn/hardware/mISDN/hfcpci.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/isdn/hardware/mISDN/hfcpci.c b/drivers/isdn/hardware/mISDN/hfcpci.c
> index ebb3fa2e1d00..d1d53c5de3c0 100644
> --- a/drivers/isdn/hardware/mISDN/hfcpci.c
> +++ b/drivers/isdn/hardware/mISDN/hfcpci.c
> @@ -2036,6 +2036,12 @@ setup_hw(struct hfc_pci *hc)
>  	       "HFC-PCI: defined at mem %#lx fifo %#lx(%#lx) IRQ %d HZ %d\n",
>  	       (u_long) hc->hw.pci_io, (u_long) hc->hw.fifos,
>  	       (u_long) hc->hw.dmahandle, hc->irq, HZ);
> +	if (unlikely(!hc->hw.pci_io)) {
> +		pci_free_consistent(hc->pdev, 0x8000, hc->hw.fifos,
> +				    hc->hw.dmahandle);
> +		return 1;
> +	}

The log message emitted before this new check reports detection of the
device, which you should not do if we are going to fail the probe.
