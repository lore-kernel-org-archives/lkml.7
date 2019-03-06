Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911D9C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 07:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69D172064A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 07:52:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729538AbfCFHwS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 02:52:18 -0500
Received: from mga07.intel.com ([134.134.136.100]:29627 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727133AbfCFHwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 02:52:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2019 23:52:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,446,1544515200"; 
   d="scan'208";a="121392893"
Received: from mylly.fi.intel.com (HELO [10.237.72.57]) ([10.237.72.57])
  by orsmga006.jf.intel.com with ESMTP; 05 Mar 2019 23:52:14 -0800
Subject: Re: [PATCH] spi-pxa2xx.c: modify the chip selection timing when spi
 transfer
To:     xiao jin <jin.xiao@intel.com>, daniel@zonque.org,
        haojian.zhuang@gmail.com, robert.jarzmik@free.fr,
        broonie@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        yanmin.zhang@intel.com
Cc:     "he, bo" <bo.he@intel.com>
References: <20190306030519.10746-1-jin.xiao@intel.com>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <ed09063c-00cc-a1a5-2a93-2b3361d531bf@linux.intel.com>
Date:   Wed, 6 Mar 2019 09:52:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190306030519.10746-1-jin.xiao@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 3/6/19 5:05 AM, xiao jin wrote:
> From: "he, bo" <bo.he@intel.com>
> 
> We find spi can't work on board. More debug shows it's related
> to the following patch that changed the chip selection assert and
> deassert timing.
> 
^^ timing caught my attention. More below.

> @@ -610,6 +596,7 @@ static void int_transfer_complete(struct driver_data *drv_data)
>   	if (!pxa25x_ssp_comp(drv_data))
>   		pxa2xx_spi_write(drv_data, SSTO, 0);
>   
> +	cs_deassert(drv_data);
>   	spi_finalize_current_transfer(drv_data->master);

This

> @@ -1070,6 +1057,7 @@ static int pxa2xx_spi_transfer_one(struct spi_controller *master,
>   			pxa2xx_spi_write(drv_data, SSTO, chip->timeout);
>   	}
>   
> +	cs_assert(drv_data);

and this is not correct with core message loop. It will cause the chip 
select is toggled with each transfer in PIO mode. If there is no 
cs_change flag set then there shouldn't be CS toggling between the 
transfers if SPI message consists of multiple transfers.

More over this patch also will regress with DMA mode since there won't 
be CS deassert at all.

Timing reminded me I've seen two cases where there was a timing related 
glitch in CS output:

d0283eb2dbc1 ("spi: pxa2xx: Add output control for multiple Intel LPSS 
chip selects")
7a8d44bc89e5 ("spi: pxa2xx: Fix too early chipselect deassert")

Do you have a possibility to measure with an oscilloscope what goes 
wrong with the CS after d5898e19c0d7 ("spi: pxa2xx: Use core message 
processing loop")?

Can you share your setup if I can reproduce it here? E.g. SPI clock 
frequency, single or multiple CS, frequency of occurrence, etc

-- 
Jarkko
