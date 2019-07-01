Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8C4C5B578
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 06:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03EAD2145D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 06:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561962381;
	bh=Z6vFclLDtr2AoU8Vp/xJdqBe4Z3jocZDSO6y16utDDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Yv/jTzLjcNTfoyzJAr3PNfZbgnhRfGzG/vX7AhPXyI496M83kmK2XT5Xduw4SlDyz
	 z4atr4gh9TZaQT4zi2m4vSLIuzftePSTeWMGDazvQdgO1boKwZhToF3AJSvz1lvgu3
	 OJZ9RKW7DY7V5Nm/vtkQ1LX/w2VKYDVYII3iFFus=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfGAG0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 02:26:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:59564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbfGAG0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 02:26:19 -0400
Received: from localhost (unknown [122.167.76.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D294208E4;
        Mon,  1 Jul 2019 06:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561962378;
        bh=Z6vFclLDtr2AoU8Vp/xJdqBe4Z3jocZDSO6y16utDDM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZIPCW9Z+lUgyeWItAJlvT0JsYrb1wgnMKoM3MFZTwidBNPr9O3AOh9rzBzlEfGeBG
         cg6N8LltVJu42futYsOGC9duSKK01q1ykbjoAyN6zy06EJ/jUz/KEn6ejCE5TYvEg3
         u7BesR045CuWo20adDyD1Mih+wylLxE+JpTKU9y8=
Date:   Mon, 1 Jul 2019 11:53:04 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     broonie@kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        bgoswami@quicinc.com
Subject: Re: [RFC PATCH 3/5] soundwire: add module_sdw_driver helper macro
Message-ID: <20190701062304.GL2911@vkoul-mobl>
References: <20190611104043.22181-1-srinivas.kandagatla@linaro.org>
 <20190611104043.22181-4-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611104043.22181-4-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-06-19, 11:40, Srinivas Kandagatla wrote:
> This Helper macro is for SoundWire drivers which do not do anything special in
> module init/exit. This eliminates a lot of boilerplate. Each module may only
> use this macro once, and calling it replaces module_init() and module_exit()

Applied, thanks

> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  include/linux/soundwire/sdw_type.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/include/linux/soundwire/sdw_type.h b/include/linux/soundwire/sdw_type.h
> index 9c756b5a0dfe..aaa7f4267c14 100644
> --- a/include/linux/soundwire/sdw_type.h
> +++ b/include/linux/soundwire/sdw_type.h
> @@ -16,4 +16,15 @@ void sdw_unregister_driver(struct sdw_driver *drv);
>  
>  int sdw_slave_modalias(const struct sdw_slave *slave, char *buf, size_t size);
>  
> +/**
> + * module_sdw_driver() - Helper macro for registering a Soundwire driver
> + * @__sdw_driver: soundwire slave driver struct
> + *
> + * Helper macro for Soundwire drivers which do not do anything special in
> + * module init/exit. This eliminates a lot of boilerplate. Each module may only
> + * use this macro once, and calling it replaces module_init() and module_exit()
> + */
> +#define module_sdw_driver(__sdw_driver) \
> +	module_driver(__sdw_driver, sdw_register_driver, \
> +			sdw_unregister_driver)
>  #endif /* __SOUNDWIRE_TYPES_H */
> -- 
> 2.21.0

-- 
~Vinod
