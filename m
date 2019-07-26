Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2A5C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 092B42054F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389871AbfGZPem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 11:34:42 -0400
Received: from mga07.intel.com ([134.134.136.100]:30545 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389487AbfGZPek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 11:34:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2019 08:34:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,311,1559545200"; 
   d="scan'208";a="322067214"
Received: from msmall-mobl.amr.corp.intel.com (HELO [10.251.154.62]) ([10.251.154.62])
  by orsmga004.jf.intel.com with ESMTP; 26 Jul 2019 08:34:39 -0700
Subject: Re: [RFC PATCH 04/40] soundwire: intel: add debugfs register dump
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-5-pierre-louis.bossart@linux.intel.com>
 <20190726140635.GB8767@kroah.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <0dc45659-33cd-0dfb-946b-9303fe54ec1c@linux.intel.com>
Date:   Fri, 26 Jul 2019 10:34:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190726140635.GB8767@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> +static const struct file_operations intel_reg_fops = {
>> +	.open = simple_open,
>> +	.read = intel_reg_read,
>> +	.llseek = default_llseek,
>> +};
> 
> DEFINE_SIMPLE_ATTRIBUTE()?

yes

> 
>> +
>> +static void intel_debugfs_init(struct sdw_intel *sdw)
>> +{
>> +	struct dentry *root = sdw->cdns.bus.debugfs;
>> +
>> +	if (!root)
>> +		return;
>> +
>> +	sdw->fs = debugfs_create_dir("intel-sdw", root);
>> +	if (IS_ERR_OR_NULL(sdw->fs)) {
>> +		dev_err(sdw->cdns.dev, "debugfs root creation failed\n");
> 
> No, come on, don't do that.  I've been sweeping the kernel tree to
> remove this anti-pattern.
> 
> The debugfs core will print an error if you got something wrong, just
> call the function and move on, you NEVER need to check the return value
> of a debugfs call.

Yes, sorry to make your blood pressure go up... I missed this one in the 
cleanups yesterday. will fix.
