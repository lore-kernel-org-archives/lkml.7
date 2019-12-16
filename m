Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D35C2D0BF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BEB021582
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="p7BYUMz7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729204AbfLPSo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:44:27 -0500
Received: from vern.gendns.com ([98.142.107.122]:51676 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728628AbfLPR6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 12:58:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=w47QjhKrBXMUdp+l8T2SAsW2mwp1Jabl/ePLzslA7oA=; b=p7BYUMz76ycJJFM3PClg9odYJf
        SgvrkJ5BfYZW7V3Lzd8rK6fgMjQYElnaiWcwSmo16INTSxJC6nWrzOGgqJHi46jBRRJN3ivOrjaP2
        gsTwxdgz8r1UrDc7Wm56HXRBdiK0avDd0TyiG+RP8/ZInhDv1z9poSReXBXqzhyp38F8W7rpCAqug
        8ZdDVftdTAtEMNTb3jx8cEfpLZEY9VNlaOYogRszpur4JlSgtH0dJms0iKDzwL/6cfuGmbSzdJ2kB
        Eu6JW5VO5OPNQtnZUROQMd5/FmUV3BRWHJPgmyY4241Iap9jj9gcxKRSkvXChFOpW9NVSB1uVmWXJ
        2eyHfc8g==;
Received: from [2600:1700:4830:165f::fb2] (port=50142)
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <david@lechnology.com>)
        id 1igudd-00082q-GU; Mon, 16 Dec 2019 12:58:33 -0500
Subject: Re: [PATCH 1/3] clocksource: davinci: work around a clocksource
 problem on dm365 SoC
To:     Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kevin Hilman <khilman@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20191213162453.15691-1-brgl@bgdev.pl>
 <20191213162453.15691-2-brgl@bgdev.pl>
From:   David Lechner <david@lechnology.com>
Message-ID: <b9a28314-4fce-ebbd-be20-b0ffa2f1f15f@lechnology.com>
Date:   Mon, 16 Dec 2019 11:58:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191213162453.15691-2-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/19 10:24 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> The DM365 platform has a strange quirk (only present when using ancient
> u-boot - mainline u-boot v2013.01 and later works fine) where if we
> enable the second half of the timer in periodic mode before we do its
> initialization - the time won't start flowing and we can't boot.
> 
> When using more recent u-boot, we can enable the timer, then reinitialize
> it and all works fine.
> 
> I've been unable to figure out why that is, but a workaround for this
> is straightforward - just cache the enable bits for tim34.


I had a hard time groking this code. See suggested changes below for
something that would make the intention more clear (to me at least).


> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>   drivers/clocksource/timer-davinci.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clocksource/timer-davinci.c b/drivers/clocksource/timer-davinci.c
> index 62745c962049..1c22443acaeb 100644
> --- a/drivers/clocksource/timer-davinci.c
> +++ b/drivers/clocksource/timer-davinci.c
> @@ -64,6 +64,8 @@ static struct {
>   	unsigned int tim_off;
>   } davinci_clocksource;
>   
> +static unsigned int davinci_clocksource_tim32_mode;

static unsigned bool davinci_clocksource_initialized;

> +
>   static struct davinci_clockevent *
>   to_davinci_clockevent(struct clock_event_device *clockevent)
>   {
> @@ -94,7 +96,7 @@ static void davinci_tim12_shutdown(void __iomem *base)
>   	 * halves. In this case TIM34 runs in periodic mode and we must
>   	 * not modify it.
>   	 */
> -	tcr |= DAVINCI_TIMER_ENAMODE_PERIODIC <<
> +	tcr |= davinci_clocksource_tim32_mode <<
>   		DAVINCI_TIMER_ENAMODE_SHIFT_TIM34;

	if (davinci_clocksource_initialized)
		tcr |= DAVINCI_TIMER_ENAMODE_PERIODIC <<
			DAVINCI_TIMER_ENAMODE_SHIFT_TIM34;

>   
>   	writel_relaxed(tcr, base + DAVINCI_TIMER_REG_TCR);
> @@ -107,7 +109,7 @@ static void davinci_tim12_set_oneshot(void __iomem *base)
>   	tcr = DAVINCI_TIMER_ENAMODE_ONESHOT <<
>   		DAVINCI_TIMER_ENAMODE_SHIFT_TIM12;
>   	/* Same as above. */
> -	tcr |= DAVINCI_TIMER_ENAMODE_PERIODIC <<
> +	tcr |= davinci_clocksource_tim32_mode <<
>   		DAVINCI_TIMER_ENAMODE_SHIFT_TIM34;

	if (davinci_clocksource_initialized)
		tcr |= DAVINCI_TIMER_ENAMODE_PERIODIC <<
			DAVINCI_TIMER_ENAMODE_SHIFT_TIM34;

>   
>   	writel_relaxed(tcr, base + DAVINCI_TIMER_REG_TCR);
> @@ -206,6 +208,8 @@ static void davinci_clocksource_init_tim34(void __iomem *base)
>   	writel_relaxed(0x0, base + DAVINCI_TIMER_REG_TIM34);
>   	writel_relaxed(UINT_MAX, base + DAVINCI_TIMER_REG_PRD34);
>   	writel_relaxed(tcr, base + DAVINCI_TIMER_REG_TCR);
> +
> +	davinci_clocksource_tim32_mode = DAVINCI_TIMER_ENAMODE_PERIODIC;


	davinci_clocksource_initialized  = true;

>   }
>   
>   /*
> 
