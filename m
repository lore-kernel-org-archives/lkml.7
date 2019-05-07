Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2342C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 12:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD5AA20989
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 12:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557232219;
	bh=5PjezRR4ACN28UQLqzd7/AWsEoOwlOjfNJzwth+nV/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CqD5GTtY+Ev8s2+JOcOQBZevwCavxGqyHI3ylTQ2S1hccAxMPKo+lopeTswXA80P+
	 wvCugTH++TyZPEPMN0QI+5il8bHXfLH1huFgkC97usUBe3Aq8IwzIyiY1BZYLm8i3S
	 QA+VQqnL1Cndzxjp5/CvDtt9htJz7VgeWE5JyxSk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbfEGMaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 08:30:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:56898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbfEGMaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 08:30:18 -0400
Received: from localhost (unknown [106.200.210.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 864A8206A3;
        Tue,  7 May 2019 12:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557232217;
        bh=5PjezRR4ACN28UQLqzd7/AWsEoOwlOjfNJzwth+nV/Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gVMCQO/x0F4P0YZfwHz4SyHNE7Kaggo0cOKuQVId/VhCq3SjhxqxtL0sXTcAxF2jB
         P9T13HJ/m7zJLoRtkdnKvonYQ10ZA3a+R88EQ9TFEA9Y1fHGnr6oNnDUmDN+riEkMe
         zJ2XOeYj5+cO0sbZ75Fflz+gzk+NR3080e+r83K0=
Date:   Tue, 7 May 2019 18:00:11 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com,
        srinivas.kandagatla@linaro.org,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [PATCH 3/8] soundwire: mipi_disco: expose sdw_slave_read_dpn as
 symbol
Message-ID: <20190507123011.GP16052@vkoul-mobl>
References: <20190504002926.28815-1-pierre-louis.bossart@linux.intel.com>
 <20190504002926.28815-4-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190504002926.28815-4-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-05-19, 19:29, Pierre-Louis Bossart wrote:
> sdw_slave_read_dpn was so far a static function, which prevented
> codec drivers from using it. Expose as non-static function and add symbol
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/mipi_disco.c | 7 ++++---
>  include/linux/soundwire/sdw.h  | 3 +++
>  2 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/soundwire/mipi_disco.c b/drivers/soundwire/mipi_disco.c
> index 6df68584c963..4995554bd6b6 100644
> --- a/drivers/soundwire/mipi_disco.c
> +++ b/drivers/soundwire/mipi_disco.c
> @@ -161,9 +161,9 @@ static int sdw_slave_read_dp0(struct sdw_slave *slave,
>  	return 0;
>  }
>  
> -static int sdw_slave_read_dpn(struct sdw_slave *slave,
> -			      struct sdw_dpn_prop *dpn, int count, int ports,
> -			      char *type)
> +int sdw_slave_read_dpn(struct sdw_slave *slave,
> +		       struct sdw_dpn_prop *dpn, int count, int ports,
> +		       char *type)
>  {
>  	struct fwnode_handle *node;
>  	u32 bit, i = 0;
> @@ -283,6 +283,7 @@ static int sdw_slave_read_dpn(struct sdw_slave *slave,
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL(sdw_slave_read_dpn);

Fine to export but would be great to accompany user with it. In
general do not add a API without user.

-- 
~Vinod
