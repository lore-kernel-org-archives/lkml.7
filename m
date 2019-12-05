Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15389C2D0BF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 12:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDB7024648
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 12:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575547993;
	bh=Vzy8R53ZVKTDj13WA/tyhafFPACRJeIQkz7cNZmXZWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AY3OGVJl0WgQS7fAxwacGB+AQrnuDgll20boetlIt1i7hCFgPpkkscY7BfSdS9edQ
	 Kla9tZ9lgf1/xuU9n/Lz6R0vKWRyh28SgRyOVmH3n7xBd0+qVqKd/9Bp5LfAeUusxj
	 iK2SQOEOfyNPfc9xxGtrfXoog2BvI29NtwiOX4Zo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729329AbfLEMNN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 07:13:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:55992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729048AbfLEMNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 07:13:12 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4EF424249;
        Thu,  5 Dec 2019 12:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575547992;
        bh=Vzy8R53ZVKTDj13WA/tyhafFPACRJeIQkz7cNZmXZWM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GWi89UGTyrmN3gyhSG7SUelx22s3kK+wT3tuZOiN4jfAJ2ZMWA99eqWzKHEyDwuIc
         rZpe/47XRDO4yRLWnzZEObL9ere1VR566vrbW/9LRASpN49DRMtE3uCCJE2ZSKdcvS
         jzzubV2C24ZRGOfbBC49/NFbHpX1+2SCycRZvzpc=
Date:   Thu, 5 Dec 2019 13:13:10 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     jslaby@suse.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, huawei.libin@huawei.com
Subject: Re: [PATCH] tty: omap-serial: remove set but unused variable
Message-ID: <20191205121310.GA389695@kroah.com>
References: <1575547476-51996-1-git-send-email-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1575547476-51996-1-git-send-email-wangxiongfeng2@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2019 at 08:04:36PM +0800, Xiongfeng Wang wrote:
> Fix the following warning:
> drivers/tty/serial/omap-serial.c: In function serial_omap_rlsi:
> drivers/tty/serial/omap-serial.c:496:16: warning: variable ch set but not used [-Wunused-but-set-variable]
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> ---
>  drivers/tty/serial/omap-serial.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
> index 6420ae5..54ee3ae 100644
> --- a/drivers/tty/serial/omap-serial.c
> +++ b/drivers/tty/serial/omap-serial.c
> @@ -493,10 +493,9 @@ static unsigned int check_modem_status(struct uart_omap_port *up)
>  static void serial_omap_rlsi(struct uart_omap_port *up, unsigned int lsr)
>  {
>  	unsigned int flag;
> -	unsigned char ch = 0;
>  
>  	if (likely(lsr & UART_LSR_DR))
> -		ch = serial_in(up, UART_RX);
> +		serial_in(up, UART_RX);

Shouldn't you be doing something with 'ch'?

