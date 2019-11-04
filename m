Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DD3CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 19:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8A862080F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 19:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729852AbfKDTdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 14:33:19 -0500
Received: from mga14.intel.com ([192.55.52.115]:54081 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728322AbfKDTdR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 14:33:17 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2019 11:33:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,268,1569308400"; 
   d="scan'208";a="376436010"
Received: from jleigh1-mobl.ger.corp.intel.com (HELO [10.251.83.74]) ([10.251.83.74])
  by orsmga005.jf.intel.com with ESMTP; 04 Nov 2019 11:33:10 -0800
Subject: Re: [PATCH 06/14] soundwire: add support for sdw_slave_type
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
References: <20191023212823.608-1-pierre-louis.bossart@linux.intel.com>
 <20191023212823.608-7-pierre-louis.bossart@linux.intel.com>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <71b50d6d-0000-340a-eb5d-6a63564dd2d6@intel.com>
Date:   Mon, 4 Nov 2019 20:33:08 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191023212823.608-7-pierre-louis.bossart@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-10-23 23:28, Pierre-Louis Bossart wrote:
> diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
> index 9a0fd3ee1014..5df095f4e12f 100644
> --- a/drivers/soundwire/bus_type.c
> +++ b/drivers/soundwire/bus_type.c
> @@ -49,9 +49,16 @@ int sdw_slave_modalias(const struct sdw_slave *slave, char *buf, size_t size)
>   
>   static int sdw_uevent(struct device *dev, struct kobj_uevent_env *env)
>   {
> -	struct sdw_slave *slave = to_sdw_slave_device(dev);
> +	struct sdw_slave *slave;
>   	char modalias[32];
>   
> +	if (is_sdw_slave(dev)) {
> +		slave = to_sdw_slave_device(dev);
> +	} else {
> +		dev_warn(dev, "uevent for unknown Soundwire type\n");
> +		return -EINVAL;
> +	}
> +
>   	sdw_slave_modalias(slave, modalias, sizeof(modalias));
>   
>   	if (add_uevent_var(env, "MODALIAS=%s", modalias))

Positive evaluation of is_sdw_slave() check is required for function to 
continue, thus you might as well do:

if (!is_sdw_slave(dev)) {
	dev_warn();
	return -EINVAL;
}

slave = to_sdw_slave_device(dev);
(...)

Czarek
