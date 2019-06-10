Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7AFC468BC
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 04:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80E6120833
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 04:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560141464;
	bh=EKzU35L2jhiqeTXyzxUrkdzKzSyRcaAAK+9gRjhGQYk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vn/J494w9weoZkHhwTep79FloujxxP42eEolkSW7zyZMZTiNgVqGQAs7ye0ZJ0ZMu
	 5dMN2+YQPefDt/ZrCauPMHkbhX0uW5HZle4DuZy+3oYwqofisZ2M+rK/3JoePbk5it
	 1wXJGmIp74F64Zt6q7u10nn1lGa8422JYPRxG4ek=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387447AbfFJEhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 00:37:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:51238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725320AbfFJEhn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 00:37:43 -0400
Received: from localhost (unknown [122.182.223.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFC14206C3;
        Mon, 10 Jun 2019 04:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560141462;
        bh=EKzU35L2jhiqeTXyzxUrkdzKzSyRcaAAK+9gRjhGQYk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EdMNpnY+toLzZqX2HubcFOhFtq3zNekbZgGctW72IRWT4ALy41oAFS4WIbzpqHVOh
         G7hZsFF4fbgBZHNuNCbxocR0Nwmocu9EB2WWN5vzFjedgcQlc4BFGmQf8d9njT6Hnb
         1eXT++xxUIZF1uHkyqlV8XfN/ChAfFUJxIgCAJvU=
Date:   Mon, 10 Jun 2019 10:04:32 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     broonie@kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/6] ASoC: core: add support to
 snd_soc_dai_get_sdw_stream()
Message-ID: <20190610043432.GI9160@vkoul-mobl.Dlink>
References: <20190607085643.932-1-srinivas.kandagatla@linaro.org>
 <20190607085643.932-2-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607085643.932-2-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-06-19, 09:56, Srinivas Kandagatla wrote:
> On platforms which have smart speaker amplifiers connected via
> soundwire and modeled as aux devices in ASoC, in such usecases machine
> driver should be able to get sdw master stream from dai so that it can
> use the runtime stream to setup slave streams.
> 
> soundwire already as a set function, get function would provide more
> flexibility to above configurations.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  include/sound/soc-dai.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
> index f5d70041108f..9f90b936fd9a 100644
> --- a/include/sound/soc-dai.h
> +++ b/include/sound/soc-dai.h
> @@ -177,6 +177,7 @@ struct snd_soc_dai_ops {
>  
>  	int (*set_sdw_stream)(struct snd_soc_dai *dai,
>  			void *stream, int direction);
> +	void *(*get_sdw_stream)(struct snd_soc_dai *dai, int direction);

So who would be calling this API? Machine or someone else?

-- 
~Vinod
