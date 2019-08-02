Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B498C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 17:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A2C121773
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 17:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404608AbfHBRUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 13:20:55 -0400
Received: from mga09.intel.com ([134.134.136.24]:2727 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388134AbfHBRUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 13:20:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Aug 2019 10:20:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,338,1559545200"; 
   d="scan'208";a="191888588"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 02 Aug 2019 10:20:54 -0700
Received: from cwhanson-mobl.amr.corp.intel.com (unknown [10.252.133.191])
        by linux.intel.com (Postfix) with ESMTP id EC81358046F;
        Fri,  2 Aug 2019 10:20:52 -0700 (PDT)
Subject: Re: [RFC PATCH 19/40] soundwire: bus: improve dynamic debug comments
 for enumeration
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-20-pierre-louis.bossart@linux.intel.com>
 <20190802170041.GW12733@vkoul-mobl.Dlink>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <db5b56ff-c6e1-32a8-628c-13b42379c4cb@linux.intel.com>
Date:   Fri, 2 Aug 2019 12:20:52 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190802170041.GW12733@vkoul-mobl.Dlink>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/19 12:00 PM, Vinod Koul wrote:
> On 25-07-19, 18:40, Pierre-Louis Bossart wrote:
>> update comments to provide better understanding of enumeration flows.
>>
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> ---
>>   drivers/soundwire/bus.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
>> index bca378806d00..2354675ef104 100644
>> --- a/drivers/soundwire/bus.c
>> +++ b/drivers/soundwire/bus.c
>> @@ -483,7 +483,8 @@ static int sdw_assign_device_num(struct sdw_slave *slave)
>>   
>>   	ret = sdw_write(slave, SDW_SCP_DEVNUMBER, dev_num);
>>   	if (ret < 0) {
>> -		dev_err(&slave->dev, "Program device_num failed: %d\n", ret);
>> +		dev_err(&slave->dev, "Program device_num %d failed: %d\n",
>> +			dev_num, ret);
>>   		return ret;
>>   	}
>>   
>> @@ -540,6 +541,7 @@ static int sdw_program_device_num(struct sdw_bus *bus)
>>   	do {
>>   		ret = sdw_transfer(bus, &msg);
>>   		if (ret == -ENODATA) { /* end of device id reads */
>> +			dev_dbg(bus->dev, "No more devices to enumerate\n");
>>   			ret = 0;
>>   			break;
>>   		}
>> @@ -982,6 +984,7 @@ int sdw_handle_slave_status(struct sdw_bus *bus,
>>   	int i, ret = 0;
>>   
>>   	if (status[0] == SDW_SLAVE_ATTACHED) {
>> +		dev_err(bus->dev, "Slave attached, programming device number\n");
> 
> This should be debug level

yes, good catch, will fix.

