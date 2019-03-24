Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AEEEC10F00
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 13:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11D1D222D6
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 13:39:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728745AbfCXNji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 09:39:38 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:42595 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbfCXNji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 09:39:38 -0400
Received: from localhost (lfbn-lyo-1-149-219.w86-202.abo.wanadoo.fr [86.202.231.219])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 95527100004;
        Sun, 24 Mar 2019 13:39:34 +0000 (UTC)
Date:   Sun, 24 Mar 2019 14:39:34 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Eddie Huang <eddie.huang@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "moderated list:ARM/Mediatek RTC DRIVER" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek RTC DRIVER" 
        <linux-mediatek@lists.infradead.org>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" 
        <linux-rtc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mfd: mt6397: Don't call irq_dispose_mapping.
Message-ID: <20190324133934.GH30105@piout.net>
References: <20190311075540.26117-1-pihsun@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311075540.26117-1-pihsun@chromium.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/03/2019 15:55:40+0800, Pi-Hsun Shih wrote:
> The IRQ mapping was changed to not being created in the rtc-mt6397
> driver, so the irq_dispose_mapping is no longer needed.
> Also the dev_id passed to free_irq should be the same as the last
> argument passed to request_threaded_irq.
> This prevents a "Trying to free already-free IRQ 274" warning when
> unbinding the driver.
> 
> Fixes: e695d3a0b3b3 ("mfd: mt6397: Create irq mappings in mfd core driver")
> Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
> 
> ---
>  drivers/rtc/rtc-mt6397.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
