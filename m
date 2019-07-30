Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F12D5C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 15:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BABEA208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 15:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564501876;
	bh=+zIKgxWzgm9vej6ra4Vrdj4C+Vws8RdPp548Vt9jqJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=brDKEYtlTJJfVpJnmpnW30O9T0V7UujhKQeF98WfyHpfxF7cpF7N6kte8trru1I/W
	 BZIrB0e/ekXiNiecr/zdP2QHi0Ys2aMBsGJ/TQg9mHorml7KUYhdYjzME59KCfMEVS
	 7e1AOt3KD0pvDgYhMQVTWvlg7NPauh4njpAlO8CU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732644AbfG3PvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 11:51:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:36820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbfG3PvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 11:51:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 458572089E;
        Tue, 30 Jul 2019 15:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564501874;
        bh=+zIKgxWzgm9vej6ra4Vrdj4C+Vws8RdPp548Vt9jqJU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zRp7dl4N9C23i9nkZO/6b5gQnMGXnLsDBSGNsIuy6d/60n2Rmrj7tnHJ6aEtEG/bj
         HGJyiYRxytRdR7Y6nGrKEemnenN36Byyx4ohGe2l3fFqmaIYjBG1S8L//Kt7/ynOUV
         QUl+nXffUP+Nhlcu53dCEiyTxbcKSy6MDjYeDjeQ=
Date:   Tue, 30 Jul 2019 17:51:12 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-serial@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
        Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>,
        Chris Healy <cphealy@gmail.com>,
        Cory Tusar <cory.tusar@zii.aero>,
        Lucas Stach <l.stach@pengutronix.de>,
        Jiri Slaby <jslaby@suse.com>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/24] tty: serial: fsl_lpuart: Drop unnecessary
 sg_set_buf() call
Message-ID: <20190730155112.GA11837@kroah.com>
References: <20190729195226.8862-1-andrew.smirnov@gmail.com>
 <20190729195226.8862-7-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729195226.8862-7-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 12:52:08PM -0700, Andrey Smirnov wrote:
> Sg_init_one() will already call sg_set_buf(), so another explicit call
> right after it is unnecessary. Drop it.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Stefan Agner <stefan@agner.ch>
> Cc: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Cory Tusar <cory.tusar@zii.aero>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: linux-imx@nxp.com
> Cc: linux-serial@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/tty/serial/fsl_lpuart.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
> index 1b3f2a87e558..b600f591c8c2 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -1144,7 +1144,6 @@ static inline int lpuart_start_rx_dma(struct lpuart_port *sport)
>  		return -ENOMEM;
>  
>  	sg_init_one(&sport->rx_sgl, ring->buf, sport->rx_dma_rng_buf_len);
> -	sg_set_buf(&sport->rx_sgl, ring->buf, sport->rx_dma_rng_buf_len);
>  	nent = dma_map_sg(sport->port.dev, &sport->rx_sgl, 1, DMA_FROM_DEVICE);
>  
>  	if (!nent) {

This patch doesn't apply, is it already in the tree from someone else?

thanks,

greg k-h
