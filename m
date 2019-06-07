Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F58C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 12:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 055D621479
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 12:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729101AbfFGMcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 08:32:13 -0400
Received: from mga12.intel.com ([192.55.52.136]:41805 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728786AbfFGMcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 08:32:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jun 2019 05:32:12 -0700
X-ExtLoop1: 1
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 07 Jun 2019 05:32:11 -0700
Received: from kwong4-mobl.amr.corp.intel.com (unknown [10.252.203.122])
        by linux.intel.com (Postfix) with ESMTP id 04D3A58044F;
        Fri,  7 Jun 2019 05:32:10 -0700 (PDT)
Subject: Re: [alsa-devel] [RFC PATCH 3/6] soundwire: core: define SDW_MAX_PORT
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        broonie@kernel.org, vkoul@kernel.org
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org
References: <20190607085643.932-1-srinivas.kandagatla@linaro.org>
 <20190607085643.932-4-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <a4b527af-c999-829d-c4a0-41f0a6775b65@linux.intel.com>
Date:   Fri, 7 Jun 2019 07:31:59 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190607085643.932-4-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/19 3:56 AM, Srinivas Kandagatla wrote:
> This patch adds SDW_MAX_PORT so that other driver can use it.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>   include/linux/soundwire/sdw.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
> index aac68e879fae..80ca997e4e5d 100644
> --- a/include/linux/soundwire/sdw.h
> +++ b/include/linux/soundwire/sdw.h
> @@ -36,6 +36,7 @@ struct sdw_slave;
>   #define SDW_FRAME_CTRL_BITS		48
>   #define SDW_MAX_DEVICES			11
>   
> +#define SDW_MAX_PORTS	14

That's an ambiguous definition.
You can have 16 ports per the SoundWire spec, but DP0 is reserved for 
control and DP15 is an alias for all ports (same idea as device 15 for 
broadcast operations but limited to a single device), which leaves 14 
ports for audio usages.

In the MIPI specs, specifically the DisCo part, the difference is called 
about with the the DP0 and DPn notations, so this could be SDW_MAX_DPn. 
Alternatively you could use SDW_MAX_AUDIO_PORTS which is more 
self-explanatory and does not require in-depth familiarity with the spec.

>   #define SDW_VALID_PORT_RANGE(n)		((n) <= 14 && (n) >= 1)
>   
>   #define SDW_DAI_ID_RANGE_START		100
> 

