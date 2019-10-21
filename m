Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4853CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 11:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F093206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 11:08:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbfJULIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 07:08:00 -0400
Received: from mga06.intel.com ([134.134.136.31]:62078 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727433AbfJULIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 07:08:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Oct 2019 04:07:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,323,1566889200"; 
   d="scan'208";a="203306715"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Oct 2019 04:07:58 -0700
Received: from atirumal-mobl1.amr.corp.intel.com (unknown [10.251.26.228])
        by linux.intel.com (Postfix) with ESMTP id 899C858029D;
        Mon, 21 Oct 2019 04:07:57 -0700 (PDT)
Subject: Re: [alsa-devel] [PATCH v2 2/5] soundwire: cadence_master: add
 hw_reset capability in debugfs
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        jank@cadence.com, slawomir.blauciak@intel.com,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>
References: <20190916190952.32388-1-pierre-louis.bossart@linux.intel.com>
 <20190916190952.32388-3-pierre-louis.bossart@linux.intel.com>
 <20191021040458.GX2654@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <96f5b446-ae02-afd6-9e5c-12e3507567f3@linux.intel.com>
Date:   Mon, 21 Oct 2019 05:20:27 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191021040458.GX2654@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/19 11:04 PM, Vinod Koul wrote:
> On 16-09-19, 14:09, Pierre-Louis Bossart wrote:
>> Provide debugfs capability to kick link and devices into hard-reset
>> (as defined by MIPI). This capability is really useful when some
>> devices are no longer responsive and/or to check the software handling
>> of resynchronization.
>>
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> ---
>>   drivers/soundwire/cadence_master.c | 20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>>
>> diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
>> index e3d06330d125..5f900cf2acb9 100644
>> --- a/drivers/soundwire/cadence_master.c
>> +++ b/drivers/soundwire/cadence_master.c
>> @@ -340,6 +340,23 @@ static int cdns_reg_show(struct seq_file *s, void *data)
>>   }
>>   DEFINE_SHOW_ATTRIBUTE(cdns_reg);
>>   
>> +static int cdns_hw_reset(void *data, u64 value)
>> +{
>> +	struct sdw_cdns *cdns = data;
>> +	int ret;
>> +
>> +	if (value != 1)
>> +		return -EINVAL;
>> +
>> +	ret = sdw_cdns_exit_reset(cdns);
> 
> So we are performing reset of the device behind the kernel, so I think
> it makes sense to mark the kernel as tainted.

This is a bit ironic. This reset is the only way to prove that the 
enumeration is done right and that all the subsystem fully recovers, and 
yet we'd mark the kernel as 'untrustworthy' and all bug reports would be 
ignored.

I don't mind doing this but we'd have to agree on a code. The only one I 
see relevant is "taint requested by userspace application", which is not 
exactly super useful.

> 
>> +
>> +	dev_dbg(cdns->dev, "link hw_reset done: %d\n", ret);
>> +
>> +	return ret;
> 
> We may want to get rid of the debug and do:
>          return sdw_cdns_exit_reset();

this debug line is useful, it marks the start of the reset sequence and 
that's valuable information. Remove it and you've lost the ability to 
analyze the dmesg logs. It's even more useful if we mark the kernel as 
tainted as you suggested above.

> 
>> +}
>> +
>> +DEFINE_DEBUGFS_ATTRIBUTE(cdns_hw_reset_fops, NULL, cdns_hw_reset, "%llu\n");
>> +
>>   /**
>>    * sdw_cdns_debugfs_init() - Cadence debugfs init
>>    * @cdns: Cadence instance
>> @@ -348,6 +365,9 @@ DEFINE_SHOW_ATTRIBUTE(cdns_reg);
>>   void sdw_cdns_debugfs_init(struct sdw_cdns *cdns, struct dentry *root)
>>   {
>>   	debugfs_create_file("cdns-registers", 0400, root, cdns, &cdns_reg_fops);
>> +
>> +	debugfs_create_file("cdns-hw-reset", 0200, root, cdns,
>> +			    &cdns_hw_reset_fops);
>>   }
>>   EXPORT_SYMBOL_GPL(sdw_cdns_debugfs_init);
>>   
>> -- 
>> 2.20.1
> 

