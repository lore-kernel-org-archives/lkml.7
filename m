Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A8AC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 07:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DD012081B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 07:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbfCHH2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 02:28:14 -0500
Received: from mga12.intel.com ([192.55.52.136]:47671 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbfCHH2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 02:28:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Mar 2019 23:28:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,455,1544515200"; 
   d="scan'208";a="326682403"
Received: from jxiao12-mobl1.ccr.corp.intel.com (HELO [10.239.201.138]) ([10.239.201.138])
  by fmsmga005.fm.intel.com with ESMTP; 07 Mar 2019 23:28:11 -0800
Subject: Re: [PATCH] [RFC] spi: pxa2xx: Do cs if restart the SSP during
 pxa2xx_spi_transfer_one()
To:     Mark Brown <broonie@kernel.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     daniel@zonque.org, haojian.zhuang@gmail.com,
        robert.jarzmik@free.fr, linux-arm-kernel@lists.infradead.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        yanmin.zhang@intel.com, bo.he@intel.com, jin.xiao@intel.com
References: <20190307072424.18820-1-jin.xiao@intel.com>
 <cf5b89b6-e081-5ba2-2837-7d3cfde779ae@linux.intel.com>
 <20190307160924.GE6529@sirena.org.uk>
From:   "Xiao, Jin" <jin.xiao@intel.com>
Message-ID: <11f165e9-ef53-edb9-cec2-e30ad2b440b5@intel.com>
Date:   Fri, 8 Mar 2019 15:28:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:66.0) Gecko/20100101
 Thunderbird/66.0
MIME-Version: 1.0
In-Reply-To: <20190307160924.GE6529@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 3/8/2019 12:09 AM, Mark Brown wrote:
> On Thu, Mar 07, 2019 at 05:26:53PM +0200, Jarkko Nikula wrote:
>> On 3/7/19 9:24 AM, xiao jin wrote:
>>> The patch is to do cs again if spi-pxa2xx restar the SSP during
>>> pxa2xx_spi_transfer_one()
>> Hmm.. please correct me if I'm wrong but pxa2xx_spi_unprepare_transfer() is
>> called always when there is no more messages pending and the spi core should
>> have deasserted the CS already?
> Yes.

I try to describe the situation in more detail.

             cpu0                         cpu1

     => spi_transfer_one_message

     => __spi_pump_messages

     => __spi_sync

     => spi_sync

     => spi_sync_transfer.constprop.2

     => spi_write

     => fm1388_spi_burst_write

     => fm1388_fw_loaded

     => request_firmware_work_func

     => process_one_work

                 => pxa2xx_spi_unprepare_transfer

                 => spi_pump_messages

                 => kthread_worker_fn

Yes, the spi core has de-asserted the CS before the 
pxa2xx_spi_unprepare_transfer(). The problem on my side is that the new 
transfer will restart the SSP in pxa2xx_spi_transfer_one(). The spi core 
has asserted the CS again before restart the SSP.  In my test the CS 
assert before the restart SSP can't ensure the spi transfer working 
correctly.

>>> @@ -1056,6 +1057,11 @@ static int pxa2xx_spi_transfer_one(struct spi_controller *master,
>>>    	if ((pxa2xx_spi_read(drv_data, SSCR0) != cr0)
>>>    	    || (pxa2xx_spi_read(drv_data, SSCR1) & change_mask)
>>>    	    != (cr1 & change_mask)) {
>>> +		/* It needs to deassert the chip selection
>>> +		 * firstly before restart the SPP */
>>> +		need_cs_change = true;
>>> +		cs_deassert(spi);
>> I think code comes here at the beginning of each transfer so will be hit
>> multiple times before pxa2xx_spi_unprepare_transfer() if SPI message
>> consists of multiple transfers.
>> This makes me wondering if the device driver setting up the "struct
>> spi_transfer" is maybe missing the cs_change flag set for transfers before
>> last one in case HW needs CS toggling between transfers? For instance what
>> following drivers are doing with the cs_change flag:
>> drivers/char/tpm/tpm_tis_spi.c: tpm_tis_spi_transfer()
>> drivers/input/touchscreen/ad7877.c: ad7877_read(), ad7877_read_adc()
> Right, this really feels like it's fixing the wrong thing.

I check the cs_change flag in the spi_transfer_one_message(). The 
cs_change flag is used in two cases. If the transfer is the last one it 
is used to keep the CS assert. If the transfer is not the last one it's 
used to generate the 10us pulse and then de-assert the CS. In my case 
the transfer is the last one and it can work correctly if I re-assert 
the CS after restart the SSP in the pxa2xx_spi_transfer_one() which is 
called from spi_transfer_one_message(). From my experiments both 
cs_change flag cases in the spi_transfer_one_message() can't help the 
problem. I am not sure if I fully understand your point.

