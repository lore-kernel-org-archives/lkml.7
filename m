Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DD9C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 18:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3487208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 18:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfDZS5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 14:57:20 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:43247 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfDZS5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 14:57:19 -0400
X-Originating-IP: 90.66.53.80
Received: from localhost (lfbn-1-3034-80.w90-66.abo.wanadoo.fr [90.66.53.80])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 5C8E340009;
        Fri, 26 Apr 2019 18:57:17 +0000 (UTC)
Date:   Fri, 26 Apr 2019 20:57:17 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: 88pm860x: prevent use-after-free on device remove
Message-ID: <20190426185717.GV14604@piout.net>
References: <20190426183635.9477-1-TheSven73@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426183635.9477-1-TheSven73@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/04/2019 14:36:35-0400, Sven Van Asbroeck wrote:
> The device's remove() attempts to shut down the delayed_work scheduled
> on the kernel-global workqueue by calling flush_scheduled_work().
> 
> Unfortunately, flush_scheduled_work() does not prevent the delayed_work
> from re-scheduling itself. The delayed_work might run after the device
> has been removed, and touch the already de-allocated info structure.
> This is a potential use-after-free.
> 
> Fix by calling cancel_delayed_work_sync() during remove(): this ensures
> that the delayed work is properly cancelled, is no longer running, and
> is not able to re-schedule itself.
> 
> This issue was detected with the help of Coccinelle.
> 
> Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
> ---
>  drivers/rtc/rtc-88pm860x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
