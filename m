Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA25C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 345FB20449
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbfGZN5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 09:57:32 -0400
Received: from mga17.intel.com ([192.55.52.151]:26086 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728369AbfGZN5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 09:57:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2019 06:57:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,311,1559545200"; 
   d="scan'208";a="322044954"
Received: from msmall-mobl.amr.corp.intel.com (HELO [10.251.154.62]) ([10.251.154.62])
  by orsmga004.jf.intel.com with ESMTP; 26 Jul 2019 06:57:29 -0700
Subject: Re: [alsa-devel] [RFC PATCH 01/40] soundwire: add debugfs support
To:     Cezary Rojewski <cezary.rojewski@intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Sanyog Kale <sanyog.r.kale@intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-2-pierre-louis.bossart@linux.intel.com>
 <35a3936d-12d5-d301-2c8e-9e90163dd86e@intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <1e0c8b9c-8e02-2735-df2d-7f82bdbb74a8@linux.intel.com>
Date:   Fri, 26 Jul 2019 08:57:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <35a3936d-12d5-d301-2c8e-9e90163dd86e@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the feedback Cezary.

>> +static ssize_t sdw_slave_reg_read(struct file *file, char __user 
>> *user_buf,
>> +                  size_t count, loff_t *ppos)
>> +{
>> +    struct sdw_slave *slave = file->private_data;
>> +    unsigned int reg;
>> +    char *buf;
>> +    ssize_t ret;
>> +    int i, j;
>> +
>> +    buf = kzalloc(RD_BUF, GFP_KERNEL);
>> +    if (!buf)
>> +        return -ENOMEM;
>> +
>> +    ret = scnprintf(buf, RD_BUF, "Register  Value\n");
>> +    ret += scnprintf(buf + ret, RD_BUF - ret, "\nDP0\n");
>> +
>> +    for (i = 0; i < 6; i++)
>> +        ret += sdw_sprintf(slave, buf, ret, i);
> 
> In most cases explicit reg macro is used, here it's implicit. Align with 
> the rest?

I don't see what you are referring to, or I need more coffee.
we use this function sdw_printf in a number of places. Or are you 
referring to the magic value 6? That should indeed be a macro.

>> +
>> +    ret += scnprintf(buf + ret, RD_BUF - ret, "Bank0\n");
>> +    ret += sdw_sprintf(slave, buf, ret, SDW_DP0_CHANNELEN);
>> +    for (i = SDW_DP0_SAMPLECTRL1; i <= SDW_DP0_LANECTRL; i++)
>> +        ret += sdw_sprintf(slave, buf, ret, i);
>> +
>> +    ret += scnprintf(buf + ret, RD_BUF - ret, "Bank1\n");
>> +    ret += sdw_sprintf(slave, buf, ret,
>> +            SDW_DP0_CHANNELEN + SDW_BANK1_OFFSET);
>> +    for (i = SDW_DP0_SAMPLECTRL1 + SDW_BANK1_OFFSET;
>> +            i <= SDW_DP0_LANECTRL + SDW_BANK1_OFFSET; i++)
>> +        ret += sdw_sprintf(slave, buf, ret, i);
> 
> I'd advice to revisit macros declarations first.
> There should be SDW_DP0_SAMPLECTRL1_B(bank) declared. In general all 
> macros for SDW should be "bank-less" (name wise). Additionally, 
> SDW_BANK_OFFSET(bank) could be provided for convenience i.e.: return 0 
> for bank0.
> Yeah, there might be some speed loss in terms of operation count but in 
> most cases it is negligible.
> 
> Would simplify this entire reg dump greatly.
> const array on top with {0, 1} elements and replacing explicit "bank0/1" 
> strings with "bank%d" gets code size reduced while not losing on 
> readability.

This could require a lot of changes in other parts of the code, and I 
don't want to do this just for debugfs. It's valid point that maybe the 
code can be simplified, but the changes are an across-the-board change 
to be done when we don't add new functionality. I'll keep this on the 
todo list.

> 
>> +
>> +    ret += scnprintf(buf + ret, RD_BUF - ret, "\nSCP\n");
>> +    for (i = SDW_SCP_INT1; i <= SDW_SCP_BANKDELAY; i++)
>> +        ret += sdw_sprintf(slave, buf, ret, i);
>> +    for (i = SDW_SCP_DEVID_0; i <= SDW_SCP_DEVID_5; i++)
>> +        ret += sdw_sprintf(slave, buf, ret, i);
>> +
>> +    ret += scnprintf(buf + ret, RD_BUF - ret, "Bank0\n");
>> +    ret += sdw_sprintf(slave, buf, ret, SDW_SCP_FRAMECTRL_B0);
>> +    ret += sdw_sprintf(slave, buf, ret, SDW_SCP_NEXTFRAME_B0);
>> +
>> +    ret += scnprintf(buf + ret, RD_BUF - ret, "Bank1\n");
>> +    ret += sdw_sprintf(slave, buf, ret, SDW_SCP_FRAMECTRL_B1);
>> +    ret += sdw_sprintf(slave, buf, ret, SDW_SCP_NEXTFRAME_B1);
>> +
>> +    for (i = 1; i < 14; i++) {
> 
> Explicit valid slave addresses would be preferred.

no, these are ports. we should use a macro instead of the magic 14 but 
it's fine to try and read all ports. As I explained it's a good way to 
figure out how many ports the Slave device supports even in the absence 
of documentation. This also helps figure out if the DisCo properties 
make sense.

> 
>> +        ret += scnprintf(buf + ret, RD_BUF - ret, "\nDP%d\n", i);
>> +        reg = SDW_DPN_INT(i);
>> +        for (j = 0; j < 6; j++)
>> +            ret += sdw_sprintf(slave, buf, ret, reg + j);
>> +
>> +        ret += scnprintf(buf + ret, RD_BUF - ret, "Bank0\n");
>> +        reg = SDW_DPN_CHANNELEN_B0(i);
>> +        for (j = 0; j < 9; j++)
>> +            ret += sdw_sprintf(slave, buf, ret, reg + j);
>> +
>> +        ret += scnprintf(buf + ret, RD_BUF - ret, "Bank1\n");
>> +        reg = SDW_DPN_CHANNELEN_B1(i);
>> +        for (j = 0; j < 9; j++)
>> +            ret += sdw_sprintf(slave, buf, ret, reg + j);
> 
> Some sort of MAX_CHANNELS would be nice here too.

Yes, need to use macros indeed.

>> +struct dentry *sdw_slave_debugfs_init(struct sdw_slave *slave)
>> +{
>> +    struct dentry *master;
>> +    struct dentry *d;
>> +    char name[32];
>> +
>> +    master = slave->bus->debugfs;
>> +
>> +    /* create the debugfs slave-name */
>> +    snprintf(name, sizeof(name), "%s", dev_name(&slave->dev));
>> +    d = debugfs_create_dir(name, master);
>> +
>> +    debugfs_create_file("registers", 0400, d, slave, 
>> &sdw_slave_reg_fops);
> 
> Pointer returned by _create_file gets completely ignored here. At least 
> dbg msg would be nice if it fails.
> 
>> +    return d;

I understood that Greg KH doesn't want us to depend on the result of 
debugfs calls, but a dev_dbg is likely ok.
