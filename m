Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67BB3C10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 09:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E3502084E
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 09:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555235063;
	bh=B4H8Q5QuxL7nl+IszEPdEPqQulj/Ysu1oi37Cp6gCxs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SfvURFw8MybkiwbSvsYZvnysLB6iIwsja1syKP0sNKgo/0g0XHcMWwjjuIsN5uwaJ
	 x3KHToFuRD7jeWNwxEGHR41SWLD6/80h/91Z14MtLzQzvXI8eMlCCq8hQMCPjQPIoT
	 1TG0nGMBaZPi+RsTv4Z6iezGS2CKtL2WkX/iCzM0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbfDNJoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 05:44:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:42160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbfDNJoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 05:44:20 -0400
Received: from localhost (unknown [106.199.53.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1362206B7;
        Sun, 14 Apr 2019 09:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555235060;
        bh=B4H8Q5QuxL7nl+IszEPdEPqQulj/Ysu1oi37Cp6gCxs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u22rs7iN5nCONPzlFrI3h9zrmWib4uI1hwmehbPIBawFuaYkya4++uc++48V1w68i
         s1IzM2k7RkzA2FIqsnzYUmRzmtaGXH0FIOiMraB7a1iQZodC+5x7ZvMUZhUexOLp3n
         mqsQyPl8F8SSjwyJJYP8gKbCs4bWQIUv/fd4+ynA=
Date:   Sun, 14 Apr 2019 15:14:08 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jan Kotas <jank@cadence.com>
Cc:     sanyog.r.kale@intel.com, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soundwire: cdns: Fix compilation error on arm64
Message-ID: <20190414094408.GF28103@vkoul-mobl>
References: <20190404081221.341-1-jank@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404081221.341-1-jank@cadence.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-04-19, 09:12, Jan Kotas wrote:
> On arm64 the cadence_master.c file doesn't compile.
> 
> readl and writel are undefined.
> This patch fixes that by including io.h.

And I cant verify that without hacking kconfig to force compile the lib.

> 
> Signed-off-by: Jan Kotas <jank@cadence.com>
> ---
>  drivers/soundwire/cadence_master.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
> index cb6a331f4..0b5bcc209 100644
> --- a/drivers/soundwire/cadence_master.c
> +++ b/drivers/soundwire/cadence_master.c
> @@ -9,6 +9,7 @@
>  #include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/interrupt.h>
> +#include <linux/io.h>

Why not add asm/io.h which is the header that actually defines
readl/writel?

>  #include <linux/module.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/soundwire/sdw_registers.h>
> -- 
> 2.15.0

-- 
~Vinod
