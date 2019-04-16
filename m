Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA542C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 03:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 782672086A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 03:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555385376;
	bh=S7524Hn0HsoZQxPZhKoDOVrUlWVDRrcs6YksGPq0Fro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bfgOl5pvEmmSeNHwu8iXO1YBlzbUCbMKC9iVUwMOfawzB+/nXaYXJeLoAaLQKZDog
	 kmTeS160X6Byb307kxibboCDWrJ84O0nnGNwXKNeJ3ZBYjHifJ68OIpLbneFmc/Xnl
	 gpzJnQ3x9QSJMOJD4V3yp1dMc0s1QIAqUdWh5VMw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfDPD3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 23:29:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:45522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725827AbfDPD3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 23:29:34 -0400
Received: from localhost (unknown [106.199.96.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0099E2075B;
        Tue, 16 Apr 2019 03:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555385374;
        bh=S7524Hn0HsoZQxPZhKoDOVrUlWVDRrcs6YksGPq0Fro=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=twvVivsM+f4tlLpdSvuu/8x7MMGC6Kugnthfs9+QFwy5Wunl3Gcvus0Rpce3g97A0
         FZmlMHnEZT/LqDSvwoKcUih+imKb2slQDAmBxKWxbUMcssU1cUcEEzXRtVcKI9IzyH
         Nt78Qq8ZZfo1yP9y7+UtUDYjsdrWLhgToLolgIyc=
Date:   Tue, 16 Apr 2019 08:59:23 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com,
        srinivas.kandagatla@linaro.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>
Subject: Re: [PATCH] ACPI / device_sysfs: change _ADR representation to 64
 bits
Message-ID: <20190416032923.GQ28103@vkoul-mobl>
References: <20190415151857.25531-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415151857.25531-1-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-04-19, 10:18, Pierre-Louis Bossart wrote:
> Standards such as the MIPI DisCo for SoundWire 1.0 specification
> assume the _ADR field is 64 bits.
> 
> _ADR is defined as an "Integer" represented as 64 bits since ACPI 2.0
> released in 2002. The low levels already use _ADR as 64 bits, e.g. in
> struct acpi_device_info.
> 
> This patch bumps the representation used for sysfs to 64 bits.
> 
> Example with a SoundWire device, the results show the complete
> vendorID and linkID which were omitted before:
> 
> Before:
> $ more /sys/bus/acpi/devices/device\:38/adr
> 0x5d070000
> After:
> $ more /sys/bus/acpi/devices/device\:38/adr
> 0x000010025d070000

This looks fine but the sysfs file is an ABI. Not sure if we can modify
the value returned this way.. Though it should not cause userspace
reading 32bits to break...


> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/acpi/device_sysfs.c | 3 +--
>  include/acpi/acpi_bus.h     | 2 +-
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
> index 8940054d6250..f8d73ae42529 100644
> --- a/drivers/acpi/device_sysfs.c
> +++ b/drivers/acpi/device_sysfs.c
> @@ -428,8 +428,7 @@ static ssize_t acpi_device_adr_show(struct device *dev,
>  {
>  	struct acpi_device *acpi_dev = to_acpi_device(dev);
>  
> -	return sprintf(buf, "0x%08x\n",
> -		       (unsigned int)(acpi_dev->pnp.bus_address));
> +	return sprintf(buf, "0x%016llx\n", acpi_dev->pnp.bus_address);
>  }
>  static DEVICE_ATTR(adr, 0444, acpi_device_adr_show, NULL);
>  
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index f7981751ac77..9075e28ea60a 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -230,7 +230,7 @@ struct acpi_device_dir {
>  /* Plug and Play */
>  
>  typedef char acpi_bus_id[8];
> -typedef unsigned long acpi_bus_address;
> +typedef u64 acpi_bus_address;
>  typedef char acpi_device_name[40];
>  typedef char acpi_device_class[20];
>  
> -- 
> 2.17.1

-- 
~Vinod
