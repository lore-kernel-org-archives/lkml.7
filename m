Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB62C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34F812083E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfDLKOW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 06:14:22 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:47449 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbfDLKOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 06:14:21 -0400
X-Originating-IP: 109.213.223.232
Received: from localhost (alyon-652-1-80-232.w109-213.abo.wanadoo.fr [109.213.223.232])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 019A7C0019;
        Fri, 12 Apr 2019 10:14:18 +0000 (UTC)
Date:   Fri, 12 Apr 2019 12:14:18 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc:     Joshua Kinard <kumba@gentoo.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] rtc: ds1685: disable interrupts when moving work to
 work queue
Message-ID: <20190412101418.GV3578@piout.net>
References: <20190411143323.20945-1-tbogendoerfer@suse.de>
 <20190411143323.20945-3-tbogendoerfer@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411143323.20945-3-tbogendoerfer@suse.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/04/2019 16:33:23+0200, Thomas Bogendoerfer wrote:
> Handling of extended interrupts (kickstart, wake-up, ram-clear) is
> moved off to a work queue, but the interrupts aren't acknowledged
> in the interrupt handler. This leads to a deadlock, if driver
> is used with interrupts. To fix this we now disable in irq handler
> and re-enable it after work queue is done.
> 

The correct fix to that seems to switch to a threaded interrupt handler.
Can you do that?

> Fixes: aaaf5fbf56f1 ("rtc: add driver for DS1685 family of real time clocks")
> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> ---
>  drivers/rtc/rtc-ds1685.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/rtc/rtc-ds1685.c b/drivers/rtc/rtc-ds1685.c
> index 929f28375b87..5dabfa57bd2a 100644
> --- a/drivers/rtc/rtc-ds1685.c
> +++ b/drivers/rtc/rtc-ds1685.c
> @@ -635,6 +635,7 @@ ds1685_rtc_irq_handler(int irq, void *dev_id)
>  			 * to be minimized.  Schedule them into a workqueue
>  			 * and inform the RTC core that the IRQs were handled.
>  			 */
> +			disable_irq_nosync(rtc->irq_num);
>  			spin_unlock(&rtc->lock);
>  			schedule_work(&rtc->work);
>  			rtc_update_irq(rtc->dev, 0, 0);
> @@ -741,6 +742,7 @@ ds1685_rtc_work_queue(struct work_struct *work)
>  	ds1685_rtc_switch_to_bank0(rtc);
>  
>  	mutex_unlock(rtc_mutex);
> +	enable_irq(rtc->irq_num);
>  }
>  /* ----------------------------------------------------------------------- */
>  
> -- 
> 2.13.7
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
