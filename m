Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21944C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 12:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFF91217F4
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 12:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564747474;
	bh=/kpJla9WeKldYo1/lnDxbEjbR87vMoISXQQCgtBoZto=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DRdQsDqBTJmqHCtFkLNA1HVIIkR5Vi1JnzXGRDwoVUhu74ZyiltTeY8A4mNBGZhy3
	 hm04rS4NN4d7emKYI1rT0Ug3eglG0OkBp3dSLd9cr6Y0It/TuaO9iMvHnP9MMuvay3
	 O6srGoSWplUEDXIGRVhNX4ZonWFpFf2eaXSRBePA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392488AbfHBMEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 08:04:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:56168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731018AbfHBMEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 08:04:32 -0400
Received: from localhost (unknown [122.167.106.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45E7A217D4;
        Fri,  2 Aug 2019 12:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564747472;
        bh=/kpJla9WeKldYo1/lnDxbEjbR87vMoISXQQCgtBoZto=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g/mwuVlsLVM0vUEqCk5irj9rgOjuXDEHFRt70sok9NfzPYE89saMS9ajdKjpzmNXf
         oy0dUKtOmATPQVmufxiPXOZTHD80xcTwyYEQLH5gPBMjunhd+J6fy4rgGLITLZq8at
         2TNJkbx6rKu9M2bZ3VveQCdaTl27oq35R3rC3T8w=
Date:   Fri, 2 Aug 2019 17:33:19 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [RFC PATCH 09/40] soundwire: cadence_master: fix usage of
 CONFIG_UPDATE
Message-ID: <20190802120319.GL12733@vkoul-mobl.Dlink>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-10-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725234032.21152-10-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-07-19, 18:40, Pierre-Louis Bossart wrote:

>  int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns)
>  {
> -	int ret;
> -
>  	_cdns_enable_interrupt(cdns);
> -	ret = cdns_clear_bit(cdns, CDNS_MCP_CONFIG_UPDATE,
> -			     CDNS_MCP_CONFIG_UPDATE_BIT);
> -	if (ret < 0)
> -		dev_err(cdns->dev, "Config update timedout\n");

I was expecting cdns_update_config() to be invoked here??

>  
> -	return ret;
> +	return 0;

It would be better if we return a value here a not success always

> @@ -943,7 +953,10 @@ int sdw_cdns_init(struct sdw_cdns *cdns)
>  
>  	cdns_writel(cdns, CDNS_MCP_CONFIG, val);
>  
> -	return 0;
> +	/* commit changes */
> +	ret = cdns_update_config(cdns);
> +
> +	return ret;

return cdns_update_config()

-- 
~Vinod
