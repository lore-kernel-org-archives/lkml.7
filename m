Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19EC5C388F3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 12:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFCC42133F
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 12:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387747AbfJAMSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 08:18:50 -0400
Received: from mga05.intel.com ([192.55.52.43]:17533 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732719AbfJAMSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 08:18:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2019 05:18:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,571,1559545200"; 
   d="scan'208";a="194510097"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.170]) ([10.237.72.170])
  by orsmga003.jf.intel.com with ESMTP; 01 Oct 2019 05:18:47 -0700
Subject: Re: [PATCH v1 4/4] usb: host: xhci-tegra: Switch to use %ptT
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
References: <20190104193009.30907-1-andriy.shevchenko@linux.intel.com>
 <20190104193009.30907-4-andriy.shevchenko@linux.intel.com>
 <20191001115640.GJ32742@smile.fi.intel.com>
From:   Mathias Nyman <mathias.nyman@intel.com>
Message-ID: <99fa90e8-3188-6781-dcbd-89e29e8509eb@intel.com>
Date:   Tue, 1 Oct 2019 15:20:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191001115640.GJ32742@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1.10.2019 14.56, Andy Shevchenko wrote:
> On Fri, Jan 04, 2019 at 09:30:09PM +0200, Andy Shevchenko wrote:
>> Use %ptT instead of open coded variant to print content of
>> time64_t type in human readable format.
> 
> Any comments on this?

Untested, but looks ok to me.

xhci-tegra.c is written by Thierry Reding, so its more up to him

> 
>>
>> Cc: Mathias Nyman <mathias.nyman@intel.com>
>> Cc: Thierry Reding <thierry.reding@gmail.com>
>> Cc: Jonathan Hunter <jonathanh@nvidia.com>
>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> ---
>>   drivers/usb/host/xhci-tegra.c | 6 +-----
>>   1 file changed, 1 insertion(+), 5 deletions(-)
>>
>> diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
>> index 938ff06c0349..ed3eea3876e2 100644
>> --- a/drivers/usb/host/xhci-tegra.c
>> +++ b/drivers/usb/host/xhci-tegra.c
>> @@ -820,7 +820,6 @@ static int tegra_xusb_load_firmware(struct tegra_xusb *tegra)
>>   	const struct firmware *fw;
>>   	unsigned long timeout;
>>   	time64_t timestamp;
>> -	struct tm time;
>>   	u64 address;
>>   	u32 value;
>>   	int err;
>> @@ -925,11 +924,8 @@ static int tegra_xusb_load_firmware(struct tegra_xusb *tegra)
>>   	}
>>   
>>   	timestamp = le32_to_cpu(header->fwimg_created_time);
>> -	time64_to_tm(timestamp, 0, &time);
>>   
>> -	dev_info(dev, "Firmware timestamp: %ld-%02d-%02d %02d:%02d:%02d UTC\n",
>> -		 time.tm_year + 1900, time.tm_mon + 1, time.tm_mday,
>> -		 time.tm_hour, time.tm_min, time.tm_sec);
>> +	dev_info(dev, "Firmware timestamp: %ptT UTC\n", &timestamp);
>>   
>>   	return 0;
>>   }
>> -- 
>> 2.19.2
>>
> 

