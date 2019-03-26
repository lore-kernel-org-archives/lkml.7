Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB21C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7574D20857
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731303AbfCZKMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 06:12:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:50308 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726258AbfCZKMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 06:12:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0A2CDAE3D;
        Tue, 26 Mar 2019 10:12:30 +0000 (UTC)
Message-ID: <1553594441.2729.7.camel@suse.com>
Subject: Re: [PATCH] usb: cdc-acm: fix race during wakeup blocking TX traffic
From:   Oliver Neukum <oneukum@suse.com>
To:     Romain Izard <romain.izard.pro@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Date:   Tue, 26 Mar 2019 11:00:41 +0100
In-Reply-To: <20190322155302.28414-1-romain.izard.pro@gmail.com>
References: <20190322155302.28414-1-romain.izard.pro@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fr, 2019-03-22 at 16:53 +0100, Romain Izard wrote:
> When the kernel is compiled with preemption enabled, the URB completion
> handler can run in parallel with the work responsible for waking up the
> tty layer. If the URB handler sets the EVENT_TTY_WAKEUP bit during the
> call to tty_port_tty_wakeup() to signal that there is room for additional
> input, it will be cleared at the end of this call. As a result, TX traffic
> on the upper layer will be blocked.

Good catch.

> This can be seen with a kernel configured with CONFIG_PREEMPT, and a fast
> modem connected with PPP running over a USB CDC-ACM port.
> 
> Use test_and_clear_bit() instead, which ensures that each wakeup requested
> by the URB completion code will trigger a call to tty_port_tty_wakeup().
> 
> Fixes: 1aba579f3cf5 cdc-acm: handle read pipe errors
> Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
Acked-by: Oliver Neukum <oneukum@suse.com>
> ---
>  drivers/usb/class/cdc-acm.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
> index 739f8960811a..ec666eb4b7b4 100644
> --- a/drivers/usb/class/cdc-acm.c
> +++ b/drivers/usb/class/cdc-acm.c
> @@ -558,10 +558,8 @@ static void acm_softint(struct work_struct *work)
>  		clear_bit(EVENT_RX_STALL, &acm->flags);
>  	}
>  
> -	if (test_bit(EVENT_TTY_WAKEUP, &acm->flags)) {
> +	if (test_and_clear_bit(EVENT_TTY_WAKEUP, &acm->flags))
>  		tty_port_tty_wakeup(&acm->port);
> -		clear_bit(EVENT_TTY_WAKEUP, &acm->flags);
> -	}
>  }
>  
>  /*

