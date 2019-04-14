Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7F6C10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 10:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6287218FC
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 10:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555236837;
	bh=dJeGzJuze8LMIBAsysbQjjq65Edts1pwJLXNHya4IDo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=H/Lfs9bjFYF2INgbfoE8liz0RO2W1503hi4S2CO+9sXOLcwYkIeK846+D3MaSHA3G
	 EK0S3RZ9EmeCYUqZpbleS1Z1HlFWeADxwwa9oAUc8Iz19YqjMc9wqbAh+5yynszo7q
	 LMUWSb+m3yISEL59pZSzPaNIcLxmSN+3gbTLj+/E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbfDNKN4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 06:13:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:33744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbfDNKNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 06:13:55 -0400
Received: from localhost (unknown [106.198.180.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D92D20848;
        Sun, 14 Apr 2019 10:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555236835;
        bh=dJeGzJuze8LMIBAsysbQjjq65Edts1pwJLXNHya4IDo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hBBNSIxUuYfMAQGnniVvZFxdP0ORrsQKM/dwXCuq1yBY+Fzl1WEcDwSKt7L0H8aks
         3wd1rhKAH68fmLHWZWDMuv20HnX9wjAnEvV8tMNfe+jlc/meJw7M4+3LQU5tZ2kDj6
         EuHE63VJ2ESs6ek0DzqCQahSFwjKTHBVhIgARhno=
Date:   Sun, 14 Apr 2019 15:43:47 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com,
        srinivas.kandagatla@linaro.org
Subject: Re: [PATCH 0/2] soundwire: fix Kconfig select/depend issues
Message-ID: <20190414101347.GJ28103@vkoul-mobl>
References: <20190411192814.10663-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411192814.10663-1-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-04-19, 14:28, Pierre-Louis Bossart wrote:
> 0-day/Kbuild starts complaining about missed module dependencies and
> compilation issues. Since codecs and soc drivers need to be compilable
> independently, let's fix this using the following model:

I have not seen a build report on this one, is this some internal Intel
report or on upstream tree?

> SOUNDWIRE_INTEL ---- select -----------
>                                       |
> 				      v
> REGMAP_SOUNDWIRE --- select ---> SOUNDWIRE_BUS
> 
> 
> Pierre-Louis Bossart (2):
>   regmap: soundwire: fix Kconfig select/depend issue
>   soundwire: fix SOUNDWIRE_BUS option
> 
>  drivers/base/regmap/Kconfig | 3 ++-
>  drivers/soundwire/Kconfig   | 1 -
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> -- 
> 2.17.1

-- 
~Vinod
