Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D369C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 07:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 366F120833
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 07:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfDOH6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 03:58:30 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:35681 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbfDOH63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 03:58:29 -0400
Received: from webmail.gandi.net (webmail14.sd4.0x35.net [10.200.201.14])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPA id 8BA5440003;
        Mon, 15 Apr 2019 07:58:26 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 15 Apr 2019 09:58:26 +0200
From:   gregory.clement@bootlin.com
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] watchdog: pnx4008: readout watchdog state
In-Reply-To: <20190411191437.12173-1-alexandre.belloni@bootlin.com>
References: <20190411191437.12173-1-alexandre.belloni@bootlin.com>
Message-ID: <ed5f9278c1ca08662c8dae83f2ed60d1@bootlin.com>
X-Sender: gregory.clement@bootlin.com
User-Agent: Roundcube Webmail/1.3.8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-04-11 21:14, Alexandre Belloni wrote:
> Readout the enabled state so it is possible to get the pre-userspace
> handler working. Also, avoid disabling the watchdog to ensure it 
> continues
> working and triggers if there is an issue later in the boot or if 
> userspace
> fails to start.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Tested-by: Gregory CLEMENT <gregory.clement@bootlin.com>


> ---
>  drivers/watchdog/pnx4008_wdt.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/pnx4008_wdt.c 
> b/drivers/watchdog/pnx4008_wdt.c
> index 8e261799c84e..4ce0389d1442 100644
> --- a/drivers/watchdog/pnx4008_wdt.c
> +++ b/drivers/watchdog/pnx4008_wdt.c
> @@ -209,7 +209,8 @@ static int pnx4008_wdt_probe(struct platform_device 
> *pdev)
>  	watchdog_set_nowayout(&pnx4008_wdd, nowayout);
>  	watchdog_set_restart_priority(&pnx4008_wdd, 128);
> 
> -	pnx4008_wdt_stop(&pnx4008_wdd);	/* disable for now */
> +	if (readl(WDTIM_CTRL(wdt_base)) & COUNT_ENAB)
> +		set_bit(WDOG_HW_RUNNING, &pnx4008_wdd.status);
> 
>  	ret = watchdog_register_device(&pnx4008_wdd);
>  	if (ret < 0) {
