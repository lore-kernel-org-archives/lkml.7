Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4EACC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 06:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8475822CF7
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 06:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566542734;
	bh=RD4wwXaEVvl7Pb39QxEhxwdKqJW6ucyEsdVbg5nBR2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QM6F8jNJ0j/X/8P1m7mbtLTIthRm8NND/Igdb0zGD9yY1M0R402F0qYjkvv1VgLs5
	 O93wkrcRpmL7V12M+ZyJADLyP7IxnIV89O/BijNiLWkV8etxQoZ4WSbbUK5W2emokY
	 MDrM2elG6Td92KjOpJp7g2Jl+xgUEorsm1IAEa5s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392377AbfHWGpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 02:45:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:50542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389682AbfHWGp3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 02:45:29 -0400
Received: from localhost (unknown [106.200.210.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9173322CEC;
        Fri, 23 Aug 2019 06:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566542729;
        bh=RD4wwXaEVvl7Pb39QxEhxwdKqJW6ucyEsdVbg5nBR2o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U8wyb94oGuWbzdpNGDHD8XaYCk4UupJKP10qYmx2SysXXRrC6pbbUHvwJY1BMrFcd
         WdlOLeEWFloEy1ew41PYSwLf3IqqL9qy8E6tOMxVbFDKsYCHVayob2I3P837Mp9wCi
         xPOQUplW+tvNOrPOkkXZ2u4UiAtUkVet2IeUT3q4=
Date:   Fri, 23 Aug 2019 12:14:17 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     sanyog.r.kale@intel.com, pierre-louis.bossart@linux.intel.com,
        ladis@linux-mips.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 -next] soundwire: Fix -Wunused-function warning
Message-ID: <20190823064417.GC2672@vkoul-mobl>
References: <20190816141409.49940-1-yuehaibing@huawei.com>
 <20190822145408.76272-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822145408.76272-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-08-19, 22:54, YueHaibing wrote:
> If CONFIG_ACPI is not set, gcc warning this:
> 
> drivers/soundwire/slave.c:16:12: warning:
>  'sdw_slave_add' defined but not used [-Wunused-function]
> 
> Now all code in slave.c is only used on ACPI enabled,
> so compiles it while CONFIG_ACPI is set.

Sorry YueHaibing as I have said to other patch doing this, this slave.c
is acpi specific but Srini has already send DT support for this so it
doesn't become acpi only and this warn also goes away. We should get the
DT support soon

> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Suggested-by: Ladislav Michl <ladis@linux-mips.org>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
> v2: use obj-$(CONFIG_ACPI) += slave.o
> ---
>  drivers/soundwire/Makefile | 3 ++-
>  drivers/soundwire/slave.c  | 3 ---
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/soundwire/Makefile b/drivers/soundwire/Makefile
> index 45b7e50..a28bf3e 100644
> --- a/drivers/soundwire/Makefile
> +++ b/drivers/soundwire/Makefile
> @@ -4,8 +4,9 @@
>  #
>  
>  #Bus Objs
> -soundwire-bus-objs := bus_type.o bus.o slave.o mipi_disco.o stream.o
> +soundwire-bus-objs := bus_type.o bus.o mipi_disco.o stream.o
>  obj-$(CONFIG_SOUNDWIRE) += soundwire-bus.o
> +obj-$(CONFIG_ACPI) += slave.o
>  
>  #Cadence Objs
>  soundwire-cadence-objs := cadence_master.o
> diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
> index f39a581..0dc188e 100644
> --- a/drivers/soundwire/slave.c
> +++ b/drivers/soundwire/slave.c
> @@ -60,7 +60,6 @@ static int sdw_slave_add(struct sdw_bus *bus,
>  	return ret;
>  }
>  
> -#if IS_ENABLED(CONFIG_ACPI)
>  /*
>   * sdw_acpi_find_slaves() - Find Slave devices in Master ACPI node
>   * @bus: SDW bus instance
> @@ -110,5 +109,3 @@ int sdw_acpi_find_slaves(struct sdw_bus *bus)
>  
>  	return 0;
>  }
> -
> -#endif
> -- 
> 2.7.4
> 

-- 
~Vinod
