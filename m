Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B47CA9EB7
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16BF92064B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729870AbfJUQLR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 12:11:17 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:57309 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbfJUQLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 12:11:16 -0400
Received: from localhost (aclermont-ferrand-651-1-259-53.w86-207.abo.wanadoo.fr [86.207.98.53])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id EAA22200011;
        Mon, 21 Oct 2019 16:11:13 +0000 (UTC)
Date:   Mon, 21 Oct 2019 18:11:13 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH] rtc: report time-retrieval errors when updating alarm
Message-ID: <20191021161113.GZ3125@piout.net>
References: <20180521164222.149896-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180521164222.149896-1-briannorris@chromium.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Brian,

On 21/05/2018 09:42:22-0700, Brian Norris wrote:
> __rtc_read_time() can fail (e.g., if the RTC uses an unreliable medium).
> When it does, we don't report the error, but instead calculate a
> 1-second alarm based on the potentially-garbage 'tm' (in practice,
> __rtc_read_time() zeroes out the time first, so it's likely to still be
> all 0).
> 
> Let's propagate the error instead.
> 

I submitted
https://lore.kernel.org/linux-rtc/20191021155631.3342-2-alexandre.belloni@bootlin.com/T/#u
to solve this after looking at all the implication checking the return
value of __rtc_read_time had.

> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>  drivers/rtc/interface.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
> index 7cbdc9228dd5..a4bdd8b5fe2e 100644
> --- a/drivers/rtc/interface.c
> +++ b/drivers/rtc/interface.c
> @@ -555,7 +555,9 @@ int rtc_update_irq_enable(struct rtc_device *rtc, unsigned int enabled)
>  		struct rtc_time tm;
>  		ktime_t now, onesec;
>  
> -		__rtc_read_time(rtc, &tm);
> +		err = __rtc_read_time(rtc, &tm);
> +		if (err)
> +			goto out;
>  		onesec = ktime_set(1, 0);
>  		now = rtc_tm_to_ktime(tm);
>  		rtc->uie_rtctimer.node.expires = ktime_add(now, onesec);
> -- 
> 2.17.0.441.gb46fe60e1d-goog
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
