Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A83C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 09:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95CCB229F9
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 09:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfGZJWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 05:22:18 -0400
Received: from mga07.intel.com ([134.134.136.100]:10099 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbfGZJWS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 05:22:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2019 02:22:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,310,1559545200"; 
   d="scan'208";a="175543512"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.251.89.116]) ([10.251.89.116])
  by orsmga006.jf.intel.com with ESMTP; 26 Jul 2019 02:22:12 -0700
Subject: Re: [RFC PATCH 01/40] soundwire: add debugfs support
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Sanyog Kale <sanyog.r.kale@intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-2-pierre-louis.bossart@linux.intel.com>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <35a3936d-12d5-d301-2c8e-9e90163dd86e@intel.com>
Date:   Fri, 26 Jul 2019 11:22:10 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190725234032.21152-2-pierre-louis.bossart@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-07-26 01:39, Pierre-Louis Bossart wrote:
> +static ssize_t sdw_slave_reg_read(struct file *file, char __user *user_buf,
> +				  size_t count, loff_t *ppos)
> +{
> +	struct sdw_slave *slave = file->private_data;
> +	unsigned int reg;
> +	char *buf;
> +	ssize_t ret;
> +	int i, j;
> +
> +	buf = kzalloc(RD_BUF, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	ret = scnprintf(buf, RD_BUF, "Register  Value\n");
> +	ret += scnprintf(buf + ret, RD_BUF - ret, "\nDP0\n");
> +
> +	for (i = 0; i < 6; i++)
> +		ret += sdw_sprintf(slave, buf, ret, i);

In most cases explicit reg macro is used, here it's implicit. Align with 
the rest?

> +
> +	ret += scnprintf(buf + ret, RD_BUF - ret, "Bank0\n");
> +	ret += sdw_sprintf(slave, buf, ret, SDW_DP0_CHANNELEN);
> +	for (i = SDW_DP0_SAMPLECTRL1; i <= SDW_DP0_LANECTRL; i++)
> +		ret += sdw_sprintf(slave, buf, ret, i);
> +
> +	ret += scnprintf(buf + ret, RD_BUF - ret, "Bank1\n");
> +	ret += sdw_sprintf(slave, buf, ret,
> +			SDW_DP0_CHANNELEN + SDW_BANK1_OFFSET);
> +	for (i = SDW_DP0_SAMPLECTRL1 + SDW_BANK1_OFFSET;
> +			i <= SDW_DP0_LANECTRL + SDW_BANK1_OFFSET; i++)
> +		ret += sdw_sprintf(slave, buf, ret, i);

I'd advice to revisit macros declarations first.
There should be SDW_DP0_SAMPLECTRL1_B(bank) declared. In general all 
macros for SDW should be "bank-less" (name wise). Additionally, 
SDW_BANK_OFFSET(bank) could be provided for convenience i.e.: return 0 
for bank0.
Yeah, there might be some speed loss in terms of operation count but in 
most cases it is negligible.

Would simplify this entire reg dump greatly.
const array on top with {0, 1} elements and replacing explicit "bank0/1" 
strings with "bank%d" gets code size reduced while not losing on 
readability.

> +
> +	ret += scnprintf(buf + ret, RD_BUF - ret, "\nSCP\n");
> +	for (i = SDW_SCP_INT1; i <= SDW_SCP_BANKDELAY; i++)
> +		ret += sdw_sprintf(slave, buf, ret, i);
> +	for (i = SDW_SCP_DEVID_0; i <= SDW_SCP_DEVID_5; i++)
> +		ret += sdw_sprintf(slave, buf, ret, i);
> +
> +	ret += scnprintf(buf + ret, RD_BUF - ret, "Bank0\n");
> +	ret += sdw_sprintf(slave, buf, ret, SDW_SCP_FRAMECTRL_B0);
> +	ret += sdw_sprintf(slave, buf, ret, SDW_SCP_NEXTFRAME_B0);
> +
> +	ret += scnprintf(buf + ret, RD_BUF - ret, "Bank1\n");
> +	ret += sdw_sprintf(slave, buf, ret, SDW_SCP_FRAMECTRL_B1);
> +	ret += sdw_sprintf(slave, buf, ret, SDW_SCP_NEXTFRAME_B1);
> +
> +	for (i = 1; i < 14; i++) {

Explicit valid slave addresses would be preferred.

> +		ret += scnprintf(buf + ret, RD_BUF - ret, "\nDP%d\n", i);
> +		reg = SDW_DPN_INT(i);
> +		for (j = 0; j < 6; j++)
> +			ret += sdw_sprintf(slave, buf, ret, reg + j);
> +
> +		ret += scnprintf(buf + ret, RD_BUF - ret, "Bank0\n");
> +		reg = SDW_DPN_CHANNELEN_B0(i);
> +		for (j = 0; j < 9; j++)
> +			ret += sdw_sprintf(slave, buf, ret, reg + j);
> +
> +		ret += scnprintf(buf + ret, RD_BUF - ret, "Bank1\n");
> +		reg = SDW_DPN_CHANNELEN_B1(i);
> +		for (j = 0; j < 9; j++)
> +			ret += sdw_sprintf(slave, buf, ret, reg + j);

Some sort of MAX_CHANNELS would be nice here too.

> +	}
> +
> +	ret = simple_read_from_buffer(user_buf, count, ppos, buf, ret);
> +	kfree(buf);
> +
> +	return ret;
> +}
> +
> +static const struct file_operations sdw_slave_reg_fops = {
> +	.open = simple_open,
> +	.read = sdw_slave_reg_read,
> +	.llseek = default_llseek,
> +};
> +
> +struct dentry *sdw_slave_debugfs_init(struct sdw_slave *slave)
> +{
> +	struct dentry *master;
> +	struct dentry *d;
> +	char name[32];
> +
> +	master = slave->bus->debugfs;
> +
> +	/* create the debugfs slave-name */
> +	snprintf(name, sizeof(name), "%s", dev_name(&slave->dev));
> +	d = debugfs_create_dir(name, master);
> +
> +	debugfs_create_file("registers", 0400, d, slave, &sdw_slave_reg_fops);

Pointer returned by _create_file gets completely ignored here. At least 
dbg msg would be nice if it fails.

> +	return d;
> +}
> +
