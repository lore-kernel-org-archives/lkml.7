Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F372AC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 09:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C56522171F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 09:53:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbfGZJxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 05:53:17 -0400
Received: from mga17.intel.com ([192.55.52.151]:12461 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbfGZJxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 05:53:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2019 02:53:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,310,1559545200"; 
   d="scan'208";a="175549339"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.251.89.116]) ([10.251.89.116])
  by orsmga006.jf.intel.com with ESMTP; 26 Jul 2019 02:53:10 -0700
Subject: Re: [RFC PATCH 09/40] soundwire: cadence_master: fix usage of
 CONFIG_UPDATE
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Sanyog Kale <sanyog.r.kale@intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-10-pierre-louis.bossart@linux.intel.com>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <980e074e-0736-1b17-266b-2ef0ae7d7823@intel.com>
Date:   Fri, 26 Jul 2019 11:53:09 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190725234032.21152-10-pierre-louis.bossart@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-07-26 01:40, Pierre-Louis Bossart wrote:
>   /*
>    * debugfs
>    */
> @@ -758,15 +774,9 @@ static int _cdns_enable_interrupt(struct sdw_cdns *cdns)
>    */
>   int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns)
>   {
> -	int ret;
> -
>   	_cdns_enable_interrupt(cdns);
> -	ret = cdns_clear_bit(cdns, CDNS_MCP_CONFIG_UPDATE,
> -			     CDNS_MCP_CONFIG_UPDATE_BIT);
> -	if (ret < 0)
> -		dev_err(cdns->dev, "Config update timedout\n");
>   
> -	return ret;
> +	return 0;
>   }
>   EXPORT_SYMBOL(sdw_cdns_enable_interrupt);

Rather than ignoring _cdns_enable_interrupt - despite said func always 
returning 0 - simply do: return _cnds_enable_interrupt(cdns) and flag 
caller with inline.

Afterwards, one can think if such encapsulation is even required - 
remove existing sdw_cdns_enable_interrupt and rename _cnds_enable_interrupt?
