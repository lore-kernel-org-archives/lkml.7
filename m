Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA141C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 07:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7C872070D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 07:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NJcwxYel"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729418AbfDBHfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 03:35:40 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46673 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbfDBHfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 03:35:39 -0400
Received: by mail-pf1-f195.google.com with SMTP id 9so5905032pfj.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 00:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/+CIpKJJox4EkuvzaMU0mH8JnfDNrkf5xJ/FuG90arQ=;
        b=NJcwxYel4CSGRJDydgzvH0wwBuSbkhLKck2BfOiRigsn3TC+5KFQ9ysCQz3R1KzGPo
         357mqh9AFFu49sEpFmcChbG3PqnsWZHlBS2Ag/VMZQ7Mmtl42qscWyruhOwi/eZepSkx
         B3srudRgD1R79hCoFIYblhKuweNrsvdcET5jx/jKXx4h45gUQcWZWLrwRFobMgcwf5JH
         H9OiShVHDoDDPisGg2qOdAVfD0wZFGNn+9a6itvN+1WACRzs+ghOGrsLPzECg9CXgMRD
         abhzyD6y6x+nNQ9RKtqWKTeQeTs0Q6IFQ4qrl/zcKPcp38MRGt495ii4fEeBUWpxJUQE
         eb4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/+CIpKJJox4EkuvzaMU0mH8JnfDNrkf5xJ/FuG90arQ=;
        b=TC2poWzu4fOdHSmvzpAqq5wcqMtacGtYDN+Z7FAklqgGkE2zda2SYN7wR7t95chAfi
         1zIYSXBrPiy+aN7oLIQsbLhkSyY5vcpCMnGRXVkMLPlAvSXoZFWTNQCj5I7Pl5A5XVNO
         b+Y8cUgjmVDBet7hTWQmilXF5NYd5sm8FBfJtfKa79B4lbwaUC0eDokQ1XN5rcKl1Fn9
         YU9GPEdzA6xzKSTI1RcucOY1J2RcZVoRanWTAfXdnTkqCxTjWZlGmW/oNtt+dDc/CgQz
         gx2jCVCIeVxnfIUszBjL9LDO7MVMhWOalYX/d0kW/yD9I3IJZUA9TmlG898hGUlVNGz3
         abLA==
X-Gm-Message-State: APjAAAVO4po/RvGUaanoqe+LZsmqKuuoDBbxRjyuCfh0Q4lRQCIdUD9e
        ij59DtWO429vmsPkZ4N/Hq3lpA==
X-Google-Smtp-Source: APXvYqyo94FuoocpnD+hj1r6YcD7kcciDAIXDVscitLXSZhFT1ugv+iflEbLizOeoF9L6Y5VN3noTQ==
X-Received: by 2002:a63:195f:: with SMTP id 31mr55032834pgz.116.1554190538811;
        Tue, 02 Apr 2019 00:35:38 -0700 (PDT)
Received: from centauri ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id e126sm10694721pfh.35.2019.04.02.00.35.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 00:35:36 -0700 (PDT)
Date:   Tue, 2 Apr 2019 09:35:31 +0200
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Gaurav Kohli <gkohli@codeaurora.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2] nvmem: core: Set no-read-write provider to avoid
 userspace read/write
Message-ID: <20190402073531.GA25959@centauri>
References: <1552831940-7327-1-git-send-email-gkohli@codeaurora.org>
 <48a71861-c60b-7fe7-d4af-5269cd7c20eb@linaro.org>
 <5f11070f-bf9b-c313-9a78-e412a2fb2908@codeaurora.org>
 <865519b5-62c9-3eb3-3855-eebf98bded85@linaro.org>
 <68755fdb-b2c6-ac25-a786-7593a692a173@codeaurora.org>
 <cfa22512-2abe-f0db-0576-e6d0cd1eee9c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfa22512-2abe-f0db-0576-e6d0cd1eee9c@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 03:02:11PM +0000, Srinivas Kandagatla wrote:
> 
> 
> On 20/03/2019 17:50, Gaurav Kohli wrote:
> > 
> > > Is root only option not helping you in this case?
> > Yes we want to protect at root level as well, i mean it is better if we
> > can avoid exposing to userspace at all.
> Can you try below patch!
> 
> > > 
> > > We could go down the route of adding new config option something
> > > like CONFIG_NVMEM_NO_SYSFS_ENTRY to prevent adding nvmem entry in
> > > userspace.
> > > 
> > > Let me know if you are happy to create a patch for this change?
> > 
> > I am happy with either way config option or dt binding(seems easy),
> > please let me know we will post new patch for the same.
> DT way is totally NAK.
> 
> 
> --------------------------->cut<-----------------------------------
> 
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Date: Wed, 20 Mar 2019 16:15:21 +0000
> Subject: [PATCH] nvmem: core: add support to NVMEM_NO_SYSFS_ENTRY
> 
> Some users might not want to expose nvmem entry to sysfs and
> only intend to use kernel interface so add such provision.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  Documentation/ABI/stable/sysfs-bus-nvmem |  2 ++
>  drivers/nvmem/Kconfig                    |  5 +++++
>  drivers/nvmem/core.c                     | 11 ++++++-----
>  3 files changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/ABI/stable/sysfs-bus-nvmem
> b/Documentation/ABI/stable/sysfs-bus-nvmem
> index 5923ab4620c5..12aab0a85fea 100644
> --- a/Documentation/ABI/stable/sysfs-bus-nvmem
> +++ b/Documentation/ABI/stable/sysfs-bus-nvmem
> @@ -6,6 +6,8 @@ Description:
>  		This file allows user to read/write the raw NVMEM contents.
>  		Permissions for write to this file depends on the nvmem
>  		provider configuration.
> +		Note: This file is not present if CONFIG_NVMEM_NO_SYSFS_ENTRY
> +		is enabled
> 
>  		ex:
>  		hexdump /sys/bus/nvmem/devices/qfprom0/nvmem
> diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
> index 0a7a470ee859..6ab3276d287c 100644
> --- a/drivers/nvmem/Kconfig
> +++ b/drivers/nvmem/Kconfig
> @@ -192,4 +192,9 @@ config SC27XX_EFUSE
>  	  This driver can also be built as a module. If so, the module
>  	  will be called nvmem-sc27xx-efuse.
> 
> +config NVMEM_NO_SYSFS_ENTRY
> +	bool "No nvmem sysfs entry"
> +
> +	help
> +		Say Yes if you do not want to add nvmem entry to sysfs.
>  endif

Hello Srini,

doesn't it make sense to instead have a CONFIG_NVMEM_SYSFS,
maked as default y, that way the default behavior will be the same,
and people not wanting it can explicitly disable it.

This also aligns with how it's done in other drivers:

$ grep  SYSFS .config
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_SYSFS_SYSCALL=y
# CONFIG_DMI_SYSFS is not set
# CONFIG_FW_CFG_SYSFS is not set
# CONFIG_ISCSI_BOOT_SYSFS is not set
# CONFIG_GPIO_SYSFS is not set
# CONFIG_WATCHDOG_SYSFS is not set
CONFIG_EDAC_LEGACY_SYSFS=y
CONFIG_RTC_INTF_SYSFS=y
CONFIG_CROS_EC_SYSFS=m
# CONFIG_IIO_SYSFS_TRIGGER is not set
CONFIG_PWM_SYSFS=y
CONFIG_SYSFS=y


Kind regards,
Niklas

> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index b9a0270883a0..c70f183fe379 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -216,7 +216,7 @@ static const struct attribute_group nvmem_bin_rw_group =
> {
>  	.attrs		= nvmem_attrs,
>  };
> 
> -static const struct attribute_group *nvmem_rw_dev_groups[] = {
> +static const __maybe_unused struct attribute_group *nvmem_rw_dev_groups[] =
> {
>  	&nvmem_bin_rw_group,
>  	NULL,
>  };
> @@ -240,7 +240,7 @@ static const struct attribute_group nvmem_bin_ro_group =
> {
>  	.attrs		= nvmem_attrs,
>  };
> 
> -static const struct attribute_group *nvmem_ro_dev_groups[] = {
> +static const __maybe_unused struct attribute_group *nvmem_ro_dev_groups[] =
> {
>  	&nvmem_bin_ro_group,
>  	NULL,
>  };
> @@ -265,7 +265,7 @@ static const struct attribute_group
> nvmem_bin_rw_root_group = {
>  	.attrs		= nvmem_attrs,
>  };
> 
> -static const struct attribute_group *nvmem_rw_root_dev_groups[] = {
> +static const __maybe_unused struct attribute_group
> *nvmem_rw_root_dev_groups[] = {
>  	&nvmem_bin_rw_root_group,
>  	NULL,
>  };
> @@ -289,7 +289,7 @@ static const struct attribute_group
> nvmem_bin_ro_root_group = {
>  	.attrs		= nvmem_attrs,
>  };
> 
> -static const struct attribute_group *nvmem_ro_root_dev_groups[] = {
> +static const __maybe_unused struct attribute_group
> *nvmem_ro_root_dev_groups[] = {
>  	&nvmem_bin_ro_root_group,
>  	NULL,
>  };
> @@ -688,6 +688,7 @@ struct nvmem_device *nvmem_register(const struct
> nvmem_config *config)
>  	nvmem->read_only = device_property_present(config->dev, "read-only") |
>  			   config->read_only;
> 
> +#if !defined(CONFIG_NVMEM_NO_SYSFS_ENTRY)
>  	if (config->root_only)
>  		nvmem->dev.groups = nvmem->read_only ?
>  			nvmem_ro_root_dev_groups :
> @@ -696,7 +697,7 @@ struct nvmem_device *nvmem_register(const struct
> nvmem_config *config)
>  		nvmem->dev.groups = nvmem->read_only ?
>  			nvmem_ro_dev_groups :
>  			nvmem_rw_dev_groups;
> -
> +#endif
>  	device_initialize(&nvmem->dev);
> 
>  	dev_dbg(&nvmem->dev, "Registering nvmem device %s\n", config->name);
> -- 
> 2.21.0
> 
> --------------------------->cut<-----------------------------------
