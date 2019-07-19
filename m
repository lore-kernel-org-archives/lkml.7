Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C980C76195
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 09:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D345221849
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 09:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563527097;
	bh=LbVGXH/XWNMp43LaFpiFPDJOBFqru+hIpDqhFq9B+aw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=jvpiZWj26YgIAvl0KFHp9p+ey42nZUUlg+W7b/D6NPVUmfep//kTNzfuuXaewQzra
	 zlHSkKKLpEdVMBmy6XGPCG6dlZk1NXvDcwRDrneLjivq9vluqDUF/9C25iuFRMcHVK
	 CHZlWASgyvqHmCIoqgBWfBJXgpQlJuE2kJX/U6fU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfGSJE4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 05:04:56 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39732 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfGSJEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 05:04:55 -0400
Received: by mail-ot1-f67.google.com with SMTP id r21so25987658otq.6
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 02:04:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zd5faFZBJ3CISmgf2YB/YasKCKp9nVRBDG44ox519t8=;
        b=csiiPz5/Uln0OfQnpPhcGOOGBVEYApeU+fh3cy6Ql0ptW7nJe4CsMEZ1DFEni6Zc7m
         3tL8hDa9bkzxXFSCdUp0UuDjjg2rD+SPbbW1sAjWuCpbI7oYt7IZNKIxhtSEbO3u+vYT
         dM8YKJ58WmT8eCd5QtO2tocK5v0wK5M3UlwxqAynwenbSvWcCCCS/TFJygw9M+Futhes
         0p3ddc5I5cyvYkGzoDZNe7a8o13cgU0fN2ZXQrp57alTaLqqURWRid+VBw7GSdNX9xh9
         Dh2nbrIY+42Ff+UzEB3YXKAxuzwYLhYDxxoMEQHa75yUgR7i2nyNE4E3UMcrGsMxkSlp
         HC8w==
X-Gm-Message-State: APjAAAVHV1NteWfVPqVdTtTmwiAlg57GvnGLZ0qsdXYRnsFWpmyJKpme
        DX4DcoQ7F0+xC6CcPYyN/U+MLburhziVpHXEkAM=
X-Google-Smtp-Source: APXvYqw0sNqYa7A5oTLf6hn610byHPDW62S2UShb5afT+y/hmGYWKdmjwS/zkDlDyO/fgmeccIszVzI7OynEOTR2hqc=
X-Received: by 2002:a9d:6a4b:: with SMTP id h11mr14400070otn.266.1563527094864;
 Fri, 19 Jul 2019 02:04:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190718230215.18675-1-pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20190718230215.18675-1-pierre-louis.bossart@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 19 Jul 2019 11:04:43 +0200
Message-ID: <CAJZ5v0g5Hk9JYLvRXfLk5-o=n_RVPKtWD=QONpiimCWyQOFELQ@mail.gmail.com>
Subject: Re: [PATCH] soundwire: fix regmap dependencies and align with other
 serial links
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        jank@cadence.com,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 1:02 AM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
> The existing code has a mixed select/depend usage which makes no sense.
>
> config SOUNDWIRE_BUS
>        tristate
>        select REGMAP_SOUNDWIRE
>
> config REGMAP_SOUNDWIRE
>         tristate
>         depends on SOUNDWIRE_BUS
>
> Let's remove one layer of Kconfig definitions and align with the
> solutions used by all other serial links.
>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

No issues found:

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/base/regmap/Kconfig | 2 +-
>  drivers/soundwire/Kconfig   | 7 +------
>  drivers/soundwire/Makefile  | 2 +-
>  3 files changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/base/regmap/Kconfig b/drivers/base/regmap/Kconfig
> index 6ad5ef48b61e..8cd2ac650b50 100644
> --- a/drivers/base/regmap/Kconfig
> +++ b/drivers/base/regmap/Kconfig
> @@ -44,7 +44,7 @@ config REGMAP_IRQ
>
>  config REGMAP_SOUNDWIRE
>         tristate
> -       depends on SOUNDWIRE_BUS
> +       depends on SOUNDWIRE
>
>  config REGMAP_SCCB
>         tristate
> diff --git a/drivers/soundwire/Kconfig b/drivers/soundwire/Kconfig
> index 3a01cfd70fdc..f518273cfbe3 100644
> --- a/drivers/soundwire/Kconfig
> +++ b/drivers/soundwire/Kconfig
> @@ -4,7 +4,7 @@
>  #
>
>  menuconfig SOUNDWIRE
> -       bool "SoundWire support"
> +       tristate "SoundWire support"
>         help
>           SoundWire is a 2-Pin interface with data and clock line ratified
>           by the MIPI Alliance. SoundWire is used for transporting data
> @@ -17,17 +17,12 @@ if SOUNDWIRE
>
>  comment "SoundWire Devices"
>
> -config SOUNDWIRE_BUS
> -       tristate
> -       select REGMAP_SOUNDWIRE
> -
>  config SOUNDWIRE_CADENCE
>         tristate
>
>  config SOUNDWIRE_INTEL
>         tristate "Intel SoundWire Master driver"
>         select SOUNDWIRE_CADENCE
> -       select SOUNDWIRE_BUS
>         depends on X86 && ACPI && SND_SOC
>         help
>           SoundWire Intel Master driver.
> diff --git a/drivers/soundwire/Makefile b/drivers/soundwire/Makefile
> index fd99a831b92a..45b7e5001653 100644
> --- a/drivers/soundwire/Makefile
> +++ b/drivers/soundwire/Makefile
> @@ -5,7 +5,7 @@
>
>  #Bus Objs
>  soundwire-bus-objs := bus_type.o bus.o slave.o mipi_disco.o stream.o
> -obj-$(CONFIG_SOUNDWIRE_BUS) += soundwire-bus.o
> +obj-$(CONFIG_SOUNDWIRE) += soundwire-bus.o
>
>  #Cadence Objs
>  soundwire-cadence-objs := cadence_master.o
> --
> 2.20.1
>
