Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B14FC28CC3
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 09:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34B43266CB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 09:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfEaJ26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 05:28:58 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:51252 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbfEaJ25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 05:28:57 -0400
Received: from 79.184.255.225.ipv4.supernova.orange.pl (79.184.255.225) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id 7f6a3cd91278b429; Fri, 31 May 2019 11:28:54 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH v2] drivers: base: power: Use of_clk_get_parent_count()
Date:   Fri, 31 May 2019 11:28:54 +0200
Message-ID: <11314269.jSQc6MYxeX@kreacher>
In-Reply-To: <20190527120535.176015-1-wangkefeng.wang@huawei.com>
References: <CAMuHMdX=o+gT6fbpZcj8jQbHi9LJci9CX72DG5j+DKYxuSkYvQ@mail.gmail.com> <20190527120535.176015-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, May 27, 2019 2:05:35 PM CEST Kefeng Wang wrote:
> Use of_clk_get_parent_count() instead of open coding.
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  drivers/base/power/clock_ops.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
> index 59d19dd64928..3e84e3085d43 100644
> --- a/drivers/base/power/clock_ops.c
> +++ b/drivers/base/power/clock_ops.c
> @@ -12,6 +12,7 @@
>  #include <linux/pm_clock.h>
>  #include <linux/clk.h>
>  #include <linux/clkdev.h>
> +#include <linux/of_clk.h>
>  #include <linux/slab.h>
>  #include <linux/err.h>
>  #include <linux/pm_domain.h>
> @@ -195,8 +196,7 @@ int of_pm_clk_add_clks(struct device *dev)
>  	if (!dev || !dev->of_node)
>  		return -EINVAL;
>  
> -	count = of_count_phandle_with_args(dev->of_node, "clocks",
> -					   "#clock-cells");
> +	count = of_clk_get_parent_count(dev->of_node);
>  	if (count <= 0)
>  		return -ENODEV;
>  
> 

Applied, thanks!




