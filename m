Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAAFEC2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 21:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6D9D21582
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 21:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbgABVS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 16:18:26 -0500
Received: from mga14.intel.com ([192.55.52.115]:59540 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbgABVS0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 16:18:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jan 2020 13:18:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,388,1571727600"; 
   d="scan'208";a="224819822"
Received: from ybabin-mobl1.amr.corp.intel.com (HELO [10.252.139.105]) ([10.252.139.105])
  by fmsmga001.fm.intel.com with ESMTP; 02 Jan 2020 13:18:24 -0800
Subject: Re: [alsa-devel] [PATCH v5 08/17] soundwire: add initial definitions
 for sdw_master_device
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
References: <20191217210314.20410-1-pierre-louis.bossart@linux.intel.com>
 <20191217210314.20410-9-pierre-louis.bossart@linux.intel.com>
 <20191227071433.GL3006@vkoul-mobl>
 <1922c494-4641-8c40-192d-758b21014fbc@linux.intel.com>
 <20191228120930.GR3006@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <820dbbcd-1401-4382-f5a2-9cdba1d6fcd5@linux.intel.com>
Date:   Thu, 2 Jan 2020 11:36:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191228120930.GR3006@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>>> A parent (such as the Intel audio controller) would use sdw_md_add()
>>>> to create the device, passing a driver as a parameter. The
>>>> sdw_md_release() would be called when put_device() is invoked by the
>>>> parent. We use the shortcut 'md' for 'master device' to avoid very
>>>> long function names.
>>>
>>> I agree we should not have long name :) but md does not sound great. Can
>>> we drop the device and use sdw_slave and sdw_master for devices and
>>> append _driver when we are talking about drivers...
>>>
>>> we dont use sd for slave and imo this would gel well with existing names
>>
>> In SoundWire parlance, both 'Slave' and 'Master' are 'Devices', so yes we do
>> in the standard talk about 'Slave Devices' and 'Master Devices'.
>>
>> Then we have Linux 'Devices' which can be used for both.
>>
>> If we use 'sdw_slave', would we be referring to the actual physical part or
>> the Linux device?
>>
>> FWIW the Greybus example used 'Host Device' and 'hd' as shortcut.
> 
> But this messes up consistency in the naming of sdw objects. I am all for
> it, if we do sd for slave and name all structs and APIs accordingly. The key
> is consistency!
> 
> So it needs to be sd/md and so on or sdw_slave and sdw_master and so
> on... not a mix of both


Well the problem is that the existing code took a shortcut and only 
modeled the slave part, e.g.

struct sdw_slave *slave = dev_to_sdw_dev(dev);

so now it's difficult to add 'sdw_slave_device' and 'sdw_master_device' 
without quite a few changes.

Would this work for you if we used the following names:

sdw_slave (legacy shortcut for sdw_slave_device, which could be removed 
in a a future cleanup if desired).
sdw_slave_driver
sdw_master_device
sdw_master_driver

and all the 'md' replaced by the full 'master_device'.

