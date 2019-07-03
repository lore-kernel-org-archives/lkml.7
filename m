Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31061C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 17:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07AC121882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 17:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562174762;
	bh=lxYyl+A0IAWOAgK39yCb7roVLH41SjjTjki8EWP00eU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=M1BIv79hRK57x+Pdsv/9cyO+dWDaiMsxaUFG54GMXUlT8cOAOB3YL+tM7MJaCVR2e
	 OY3w4kWxLw+o4eeFFm2wg8o7ulrLKdxfc0TfHEH1mLFcflQhS0ilx5zAJRzzRBpDzP
	 WGsqfnMz1kHFXibEq0G9tGnGJKSeqJBDly3x4lIA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfGCR0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 13:26:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:42156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726430AbfGCRZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 13:25:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81E4F21882;
        Wed,  3 Jul 2019 17:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562174757;
        bh=lxYyl+A0IAWOAgK39yCb7roVLH41SjjTjki8EWP00eU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AYS+IKynoqAI09h6gRL3UJ/G0xw0wi1J+6dLoAWNGeSHZ9ZhVsJq9HQsEjxFIBc6h
         mqlFTaYlaATTtrTAzhsBnjEDooptMmZbgIxeZSJ7L3Ck25jNhLl8HfybTvHna6oVXa
         dO/adH/MvoDphKrg4N7Ap7c27bI5uHwTuMkpJHck=
Date:   Wed, 3 Jul 2019 19:25:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     jeyentam <je.yen.tam@ni.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] serial/8250: Add support for NI-Serial PXI/PXIe+485
 devices.
Message-ID: <20190703172554.GA27719@kroah.com>
References: <20190702032323.28967-1-je.yen.tam@ni.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702032323.28967-1-je.yen.tam@ni.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2019 at 08:23:23PM -0700, jeyentam wrote:
> Add support for NI-Serial PXIe-RS232, PXI-RS485 and PXIe-RS485 devices.
> 
> Signed-off-by: jeyentam <je.yen.tam@ni.com>
> ---
>  drivers/tty/serial/8250/8250_pci.c | 879 +++++++++++++++++++----------
>  1 file changed, 582 insertions(+), 297 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
> index df41397de478..0a711b895b33 100644
> --- a/drivers/tty/serial/8250/8250_pci.c
> +++ b/drivers/tty/serial/8250/8250_pci.c
> @@ -1,10 +1,10 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - *  Probe module for 8250/16550-type PCI serial ports.
> + *	Probe module for 8250/16550-type PCI serial ports.
>   *
> - *  Based on drivers/char/serial.c, by Linus Torvalds, Theodore Ts'o.
> + *	Based on drivers/char/serial.c, by Linus Torvalds, Theodore Ts'o.
>   *
> - *  Copyright (C) 2001 Russell King, All Rights Reserved.
> + *	Copyright (C) 2001 Russell King, All Rights Reserved.
>   */

Why are you changing comments for no reason?

