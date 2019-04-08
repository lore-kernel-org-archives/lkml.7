Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A43C10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57E2221473
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbfDHO6l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 10:58:41 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:47325 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbfDHO6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 10:58:41 -0400
X-Originating-IP: 109.213.33.177
Received: from localhost (alyon-652-1-42-177.w109-213.abo.wanadoo.fr [109.213.33.177])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 3FA6220007;
        Mon,  8 Apr 2019 14:58:35 +0000 (UTC)
Date:   Mon, 8 Apr 2019 16:58:34 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        netdev@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH 4/6] MIPS: SGI-IP27: fix readb/writeb addressing
Message-ID: <20190408145834.GO7480@piout.net>
References: <20190408142100.27618-1-tbogendoerfer@suse.de>
 <20190408142100.27618-5-tbogendoerfer@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190408142100.27618-5-tbogendoerfer@suse.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/04/2019 16:20:56+0200, Thomas Bogendoerfer wrote:
> diff --git a/drivers/rtc/rtc-m48t35.c b/drivers/rtc/rtc-m48t35.c
> index 0cf6507de3c7..05f0d91366af 100644
> --- a/drivers/rtc/rtc-m48t35.c
> +++ b/drivers/rtc/rtc-m48t35.c
> @@ -24,6 +24,16 @@
>  
>  struct m48t35_rtc {
>  	u8	pad[0x7ff8];    /* starts at 0x7ff8 */
> +#ifdef CONFIG_SGI_IP27
> +	u8	hour;
> +	u8	min;
> +	u8	sec;
> +	u8	control;
> +	u8	year;
> +	u8	month;
> +	u8	date;
> +	u8	day;
> +#else

I'm not sure why the RTC driver has to know about that. Shouldn't your
accessors be fixing that?


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
