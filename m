Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0CBCC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 13:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD14D214C6
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 13:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbfHLNcn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 09:32:43 -0400
Received: from mga07.intel.com ([134.134.136.100]:8476 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728841AbfHLNcn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 09:32:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Aug 2019 06:32:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,377,1559545200"; 
   d="scan'208";a="375948963"
Received: from aferozpu-mobl2.amr.corp.intel.com (HELO [10.254.109.160]) ([10.254.109.160])
  by fmsmga006.fm.intel.com with ESMTP; 12 Aug 2019 06:32:41 -0700
Subject: Re: [alsa-devel] [PATCH 2/3] soundwire: cadence_master: add debugfs
 register dump
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        linux-kernel@vger.kernel.org, vkoul@kernel.org, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
References: <20190809224341.15726-1-pierre-louis.bossart@linux.intel.com>
 <20190809224341.15726-3-pierre-louis.bossart@linux.intel.com>
 <20190810070308.GB6896@kroah.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <ac9170fe-03bd-f9c4-6afb-f9978b8cd95d@linux.intel.com>
Date:   Mon, 12 Aug 2019 08:32:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190810070308.GB6896@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/10/19 2:03 AM, Greg KH wrote:
> On Fri, Aug 09, 2019 at 05:43:40PM -0500, Pierre-Louis Bossart wrote:
>> +/**
>> + * sdw_cdns_debugfs_init() - Cadence debugfs init
>> + * @cdns: Cadence instance
>> + * @root: debugfs root
>> + */
>> +void sdw_cdns_debugfs_init(struct sdw_cdns *cdns, struct dentry *root)
>> +{
>> +	debugfs_create_file("cdns-registers", 0400, root, cdns, &cdns_reg_fops);
>> +}
>> +EXPORT_SYMBOL_GPL(sdw_cdns_debugfs_init);
> 
> You create this function but never actually call it.  Don't add apis
> that no one uses :(

it is used in the follow-up patch.

+static void intel_debugfs_init(struct sdw_intel *sdw)
+{
+	struct dentry *root = sdw->cdns.bus.debugfs;
+
+	if (!root)
+		return;
+
+	sdw->fs = debugfs_create_dir("intel-sdw", root);
+
+	debugfs_create_file("intel-registers", 0400, sdw->fs, sdw,
+			    &intel_reg_fops);
+
+	sdw_cdns_debugfs_init(&sdw->cdns, sdw->fs); <<< HERE!
+}

The Cadence IP might be used by others so having a function that can be 
exported and used by others seems useful.
