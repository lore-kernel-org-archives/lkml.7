Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 721B1C5ED68
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0AEC24748
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbfLMPyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 10:54:20 -0500
Received: from mga04.intel.com ([192.55.52.120]:34227 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727948AbfLMPyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 10:54:19 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Dec 2019 07:54:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,309,1571727600"; 
   d="scan'208";a="246170754"
Received: from dbmoens-mobl1.amr.corp.intel.com ([10.255.228.102])
  by fmsmga002.fm.intel.com with ESMTP; 13 Dec 2019 07:54:17 -0800
Subject: Re: [alsa-devel] [PATCH v4 07/15] soundwire: slave: move uevent
 handling to slave
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
References: <20191213050409.12776-1-pierre-louis.bossart@linux.intel.com>
 <20191213050409.12776-8-pierre-louis.bossart@linux.intel.com>
 <20191213072231.GE1750354@kroah.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <032e6505-22b6-45bb-ff04-87db1f8d8be9@linux.intel.com>
Date:   Fri, 13 Dec 2019 09:11:27 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191213072231.GE1750354@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/19 1:22 AM, Greg KH wrote:
> On Thu, Dec 12, 2019 at 11:04:01PM -0600, Pierre-Louis Bossart wrote:
>> Currently the code deals with uevents at the bus level, but we only care
>> for Slave events
> 
> What does this mean?  I can't understand it, can you please provide more
> information on what you are doing here?

In the earlier versions of the patch, the code looks like this and there 
was an open on what to do with a master-specific event.

  static int sdw_uevent(struct device *dev, struct kobj_uevent_env *env)
  {
+	struct sdw_master_device *md;
  	struct sdw_slave *slave;
  	char modalias[32];

-	if (is_sdw_slave(dev)) {
+	if (is_sdw_md(dev)) {
+		md = to_sdw_master_device(dev);
+		/* TODO: do we need to call add_uevent_var() ? */
+	} else if (is_sdw_slave(dev)) {
  		slave = to_sdw_slave_device(dev);
+
+		sdw_slave_modalias(slave, modalias, sizeof(modalias));
+
+		if (add_uevent_var(env, "MODALIAS=%s", modalias))
+			return -ENOMEM;
  	} else {
  		dev_warn(dev, "uevent for unknown Soundwire type\n");
  		return -EINVAL;
  	}

Vinod suggested this was not needed and suggested the code for uevents 
be moved to be slave-specific, which is what this patch does.
>> diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
>> index c87267f12a3b..014c3ece1f17 100644
>> --- a/drivers/soundwire/slave.c
>> +++ b/drivers/soundwire/slave.c
>> @@ -17,6 +17,7 @@ static void sdw_slave_release(struct device *dev)
>>   struct device_type sdw_slave_type = {
>>   	.name =		"sdw_slave",
>>   	.release =	sdw_slave_release,
>> +	.uevent = sdw_uevent,
> 
> Align this with the other ones?
> 
> does this cause any different functionality?

As mentioned above, this move was suggested by Vinod. I don't have a 
specific need for uevents for the master and there's no functionality 
limitation, that said this is way beyond my comfort zone so I will 
follow recommendations, if any.

