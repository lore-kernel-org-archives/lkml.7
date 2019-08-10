Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 639B1C32751
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 07:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33E1F217D7
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 07:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565420505;
	bh=Lpl1tv0ZPmCHKs7Wm3c2RiDk3aHvcWbSYtNcAGiA+0U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=atCItTUgIG1jnh4f3N8Ency2dzvuOSfzAutGxTNnvoyZBCCK41pcPFaWDB6EvpaTf
	 F8BLStTYPH13FaDwWouJ7vn3DZg944BoL/KLk5BLVQMenUZpW93tT7+um5nomWGbx3
	 Md4Tp/n3xlPbOpI4+QvtybeGIchyEB+OHHPspM5I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbfHJHBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 03:01:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:47208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbfHJHBn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 03:01:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C6D4208C3;
        Sat, 10 Aug 2019 07:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565420502;
        bh=Lpl1tv0ZPmCHKs7Wm3c2RiDk3aHvcWbSYtNcAGiA+0U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zMKgCX6LTZ31whgaOUfHvBf9ZWrBfv2zLYsXsSblyjUxKJebQYh8KYYTWI3UOV7qt
         dzN6g7/4eqEWD5AaZlC2GiaVjFV59uIBtJp2uRvAOJzsB9uRE+/j6+rniM6EHu3Azz
         V+l4x6Nd7uKQ16n5stC3fHQb2+ixMWY4Znv5M2v4=
Date:   Sat, 10 Aug 2019 09:01:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [PATCH 1/3] soundwire: add debugfs support
Message-ID: <20190810070139.GA6896@kroah.com>
References: <20190809224341.15726-1-pierre-louis.bossart@linux.intel.com>
 <20190809224341.15726-2-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809224341.15726-2-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2019 at 05:43:39PM -0500, Pierre-Louis Bossart wrote:
> Add base debugfs mechanism for SoundWire bus by creating soundwire
> root and master-N and slave-x hierarchy.
> 
> Also add SDW Slave SCP, DP0 and DP-N register debug file.
> 
> Registers not implemented will print as "XX"
> 
> Credits: this patch is based on an earlier internal contribution by
> Vinod Koul, Sanyog Kale, Shreyas Nc and Hardik Shah.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/Makefile    |   5 ++
>  drivers/soundwire/bus.c       |   6 ++
>  drivers/soundwire/bus.h       |  24 ++++++
>  drivers/soundwire/bus_type.c  |   3 +
>  drivers/soundwire/debugfs.c   | 151 ++++++++++++++++++++++++++++++++++
>  drivers/soundwire/slave.c     |   1 +
>  include/linux/soundwire/sdw.h |   4 +
>  7 files changed, 194 insertions(+)
>  create mode 100644 drivers/soundwire/debugfs.c
> 
> diff --git a/drivers/soundwire/Makefile b/drivers/soundwire/Makefile
> index fd99a831b92a..05d4cb9ef7d6 100644
> --- a/drivers/soundwire/Makefile
> +++ b/drivers/soundwire/Makefile
> @@ -5,6 +5,11 @@
>  
>  #Bus Objs
>  soundwire-bus-objs := bus_type.o bus.o slave.o mipi_disco.o stream.o
> +
> +ifdef CONFIG_DEBUG_FS
> +soundwire-bus-objs += debugfs.o
> +endif
> +
>  obj-$(CONFIG_SOUNDWIRE_BUS) += soundwire-bus.o
>  
>  #Cadence Objs
> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
> index 49f64b2115b9..89d5f1537d9b 100644
> --- a/drivers/soundwire/bus.c
> +++ b/drivers/soundwire/bus.c
> @@ -49,6 +49,8 @@ int sdw_add_bus_master(struct sdw_bus *bus)
>  		}
>  	}
>  
> +	bus->debugfs = sdw_bus_debugfs_init(bus);
> +

It's "nicer" to just put that assignment into sdw_bus_debugfs_init().

That way you just call the function, no need to return anything.

>  	/*
>  	 * Device numbers in SoundWire are 0 through 15. Enumeration device
>  	 * number (0), Broadcast device number (15), Group numbers (12 and
> @@ -109,6 +111,8 @@ static int sdw_delete_slave(struct device *dev, void *data)
>  	struct sdw_slave *slave = dev_to_sdw_dev(dev);
>  	struct sdw_bus *bus = slave->bus;
>  
> +	sdw_slave_debugfs_exit(slave->debugfs);

Same here, just pass in slave:
	sdw_slave_debugfs_exit(slave);
and have that function remove the debugfs entry in the structure.  That
way, if you are really paranoid about size, you could even drop the
debugfs structure member from non-debugfs builds without any changes to
bus.c or other non-debugfs files.

thanks,

greg k-h
