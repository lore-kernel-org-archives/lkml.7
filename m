Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49485C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 14:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22EBC205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 14:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729809AbfHMOxK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 10:53:10 -0400
Received: from mga12.intel.com ([192.55.52.136]:12037 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729670AbfHMOxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 10:53:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Aug 2019 07:53:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,381,1559545200"; 
   d="scan'208";a="170418266"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 13 Aug 2019 07:53:09 -0700
Received: from dalyrusx-mobl.amr.corp.intel.com (unknown [10.251.3.205])
        by linux.intel.com (Postfix) with ESMTP id 3C297580238;
        Tue, 13 Aug 2019 07:53:08 -0700 (PDT)
Subject: Re: [PATCH v2 1/5] soundwire: Add compute_params callback
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        vkoul@kernel.org, broonie@kernel.org
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, linux-kernel@vger.kernel.org,
        plai@codeaurora.org, lgirdwood@gmail.com, robh+dt@kernel.org,
        spapothi@codeaurora.org
References: <20190813083550.5877-1-srinivas.kandagatla@linaro.org>
 <20190813083550.5877-2-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <7e462330-a357-698a-b259-5ff136963a57@linux.intel.com>
Date:   Tue, 13 Aug 2019 09:34:37 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190813083550.5877-2-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/13/19 3:35 AM, Srinivas Kandagatla wrote:
> From: Vinod Koul <vkoul@kernel.org>
> 
> This callback allows masters to compute the bus parameters required.

This looks like a partial use of the patch ('soundwire: Add Intel 
resource management algorithm')? see comments below

> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>   drivers/soundwire/stream.c    | 10 ++++++++++
>   include/linux/soundwire/sdw.h |  2 ++
>   2 files changed, 12 insertions(+)
> 
> diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
> index a0476755a459..60bc2fe42928 100644
> --- a/drivers/soundwire/stream.c
> +++ b/drivers/soundwire/stream.c
> @@ -1483,6 +1483,16 @@ static int _sdw_prepare_stream(struct sdw_stream_runtime *stream)
>   		bus->params.bandwidth += m_rt->stream->params.rate *
>   			m_rt->ch_count * m_rt->stream->params.bps;
>   
> +		/* Compute params */
> +		if (bus->compute_params) {
> +			ret = bus->compute_params(bus);
> +			if (ret < 0) {
> +				dev_err(bus->dev, "Compute params failed: %d",
> +					ret);
> +				return ret;
> +			}
> +		}
> +

This would need to be duplicated for deprepare (as was done in the Intel 
patch).

>   		/* Program params */
>   		ret = sdw_program_params(bus);
>   		if (ret < 0) {
> diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
> index bea46bd8b6ce..aac68e879fae 100644
> --- a/include/linux/soundwire/sdw.h
> +++ b/include/linux/soundwire/sdw.h
> @@ -718,6 +718,7 @@ struct sdw_master_ops {
>    * Bit set implies used number, bit clear implies unused number.
>    * @bus_lock: bus lock
>    * @msg_lock: message lock
> + * @compute_params: points to Bus resource management implementation
>    * @ops: Master callback ops
>    * @port_ops: Master port callback ops
>    * @params: Current bus parameters
> @@ -739,6 +740,7 @@ struct sdw_bus {
>   	DECLARE_BITMAP(assigned, SDW_MAX_DEVICES);
>   	struct mutex bus_lock;
>   	struct mutex msg_lock;
> +	int (*compute_params)(struct sdw_bus *bus);

not sure I understand how it's set? We have a default in the Intel patch.

>   	const struct sdw_master_ops *ops;
>   	const struct sdw_master_port_ops *port_ops;
>   	struct sdw_bus_params params;
> 

