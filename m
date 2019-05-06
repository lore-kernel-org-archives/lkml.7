Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1412C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94ECC2053B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbfEFPAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 11:00:02 -0400
Received: from mga06.intel.com ([134.134.136.31]:47362 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728506AbfEFOmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:42:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 May 2019 07:42:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,438,1549958400"; 
   d="scan'208";a="137398978"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 06 May 2019 07:42:37 -0700
Received: from slaugust-mobl.amr.corp.intel.com (unknown [10.254.21.102])
        by linux.intel.com (Postfix) with ESMTP id 407C458010A;
        Mon,  6 May 2019 07:42:36 -0700 (PDT)
Subject: Re: [alsa-devel] [RFC PATCH 2/7] soundwire: add Slave sysfs support
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        linux-kernel@vger.kernel.org, liam.r.girdwood@linux.intel.com,
        vkoul@kernel.org, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com, joe@perches.com,
        Sanyog Kale <sanyog.r.kale@intel.com>
References: <20190504010030.29233-1-pierre-louis.bossart@linux.intel.com>
 <20190504010030.29233-3-pierre-louis.bossart@linux.intel.com>
 <20190504065444.GC9770@kroah.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <c675ea60-5bfa-2475-8878-c589b8d20b32@linux.intel.com>
Date:   Mon, 6 May 2019 09:42:35 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190504065444.GC9770@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> +static struct attribute_group sdw_slave_dev_attr_group = {
>> +	.attrs	= slave_dev_attrs,
>> +};
>> +
>> +const struct attribute_group *sdw_slave_dev_attr_groups[] = {
>> +	&sdw_slave_dev_attr_group,
>> +	NULL
>> +};
> 
> ATTRIBUTE_GROUP()?

yes.

> 
> 
>> +
>> +int sdw_sysfs_slave_init(struct sdw_slave *slave)
>> +{
>> +	struct sdw_slave_sysfs *sysfs;
>> +	unsigned int src_dpns, sink_dpns, i, j;
>> +	int err;
>> +
>> +	if (slave->sysfs) {
>> +		dev_err(&slave->dev, "SDW Slave sysfs is already initialized\n");
>> +		err = -EIO;
>> +		goto err_ret;
>> +	}
>> +
>> +	sysfs = kzalloc(sizeof(*sysfs), GFP_KERNEL);
> 
> Same question as patch 1, why a new device?

yes it's the same open. In this case, the slave devices are defined at a 
different level so it's also confusing to create a device to represent 
the slave properties. The code works but I am not sure the initial 
directions are correct.

