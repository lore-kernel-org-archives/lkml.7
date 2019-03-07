Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BDC1C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 06:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BFF920851
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 06:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbfCGGrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 01:47:35 -0500
Received: from mga11.intel.com ([192.55.52.93]:49292 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbfCGGrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 01:47:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Mar 2019 22:47:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,450,1544515200"; 
   d="scan'208";a="280504930"
Received: from jxiao12-mobl1.ccr.corp.intel.com (HELO [10.239.201.138]) ([10.239.201.138])
  by orsmga004.jf.intel.com with ESMTP; 06 Mar 2019 22:47:32 -0800
Subject: Re: [PATCH] spi-pxa2xx.c: modify the chip selection timing when spi
 transfer
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>, daniel@zonque.org,
        haojian.zhuang@gmail.com, robert.jarzmik@free.fr,
        broonie@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        yanmin.zhang@intel.com
Cc:     "he, bo" <bo.he@intel.com>, jin.xiao@intel.com
References: <20190306030519.10746-1-jin.xiao@intel.com>
 <ed09063c-00cc-a1a5-2a93-2b3361d531bf@linux.intel.com>
From:   "Xiao, Jin" <jin.xiao@intel.com>
Message-ID: <8f83eb75-d557-13b0-b2d0-1efb98d6688d@intel.com>
Date:   Thu, 7 Mar 2019 14:47:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:66.0) Gecko/20100101
 Thunderbird/66.0
MIME-Version: 1.0
In-Reply-To: <ed09063c-00cc-a1a5-2a93-2b3361d531bf@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 3/6/2019 3:52 PM, Jarkko Nikula wrote:
> Hi
>
> On 3/6/19 5:05 AM, xiao jin wrote:
>> From: "he, bo" <bo.he@intel.com>
>>
>> We find spi can't work on board. More debug shows it's related
>> to the following patch that changed the chip selection assert and
>> deassert timing.
>>
> ^^ timing caught my attention. More below.
>
>> @@ -610,6 +596,7 @@ static void int_transfer_complete(struct 
>> driver_data *drv_data)
>>       if (!pxa25x_ssp_comp(drv_data))
>>           pxa2xx_spi_write(drv_data, SSTO, 0);
>>   +    cs_deassert(drv_data);
>>       spi_finalize_current_transfer(drv_data->master);
>
> This
>
>> @@ -1070,6 +1057,7 @@ static int pxa2xx_spi_transfer_one(struct 
>> spi_controller *master,
>>               pxa2xx_spi_write(drv_data, SSTO, chip->timeout);
>>       }
>>   +    cs_assert(drv_data);
>
> and this is not correct with core message loop. It will cause the chip 
> select is toggled with each transfer in PIO mode. If there is no 
> cs_change flag set then there shouldn't be CS toggling between the 
> transfers if SPI message consists of multiple transfers.
>
> More over this patch also will regress with DMA mode since there won't 
> be CS deassert at all.
>
> Timing reminded me I've seen two cases where there was a timing 
> related glitch in CS output:
>
> d0283eb2dbc1 ("spi: pxa2xx: Add output control for multiple Intel LPSS 
> chip selects")
> 7a8d44bc89e5 ("spi: pxa2xx: Fix too early chipselect deassert")
>
> Do you have a possibility to measure with an oscilloscope what goes 
> wrong with the CS after d5898e19c0d7 ("spi: pxa2xx: Use core message 
> processing loop")?
>
> Can you share your setup if I can reproduce it here? E.g. SPI clock 
> frequency, single or multiple CS, frequency of occurrence, etc
>
In our setup the pxa_ssp_type is LPSS_BXT_SSP.  With more debug we find 
that the problem is caused in the case of "restart the SSP" when 
pxa2xx_spi_transfer_one.

We will send another RFC patch.

Thanks.

