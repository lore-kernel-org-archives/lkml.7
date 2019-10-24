Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D79CA9EBC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 21:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FB7621BE5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 21:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="En/E4jkL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729192AbfJXV1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 17:27:01 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44688 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729108AbfJXV1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 17:27:01 -0400
Received: by mail-pg1-f195.google.com with SMTP id e10so68901pgd.11;
        Thu, 24 Oct 2019 14:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kUkEbegezOtNGv0tUZu87phHyx71IxZmkeyn60SQnOg=;
        b=En/E4jkLnZHZy+mU0n+xYo6A5B2QCPZA7Q5Kl1DQ+zCBV2Hc9wujaBMWBIae6tUFs4
         tIcWnJGOEas0Od0B5sk2Ti3COX9G44JnBiYC282/0jlx7tOc0tenD0sXLtqAmoB6CNS9
         6SgVrQwFsaaOX+qnA/Byep1ttXDrnwRjv2jfKA2naIWKz5oHetekopM1VVPsAxLJOkCQ
         oKnBFocH6OnRolWm3MB9T2WRI3+VyYB5OjJWz1D4Of8d64k+zNXQmcbnMaCNgv56F+Jj
         /9dVAMeY3RoPG/51PUPpwCYtvWiTBP3lgfy9NRiLwmV+4DEmHcgi8u4A1rjlGptiuU83
         JABA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kUkEbegezOtNGv0tUZu87phHyx71IxZmkeyn60SQnOg=;
        b=ZYonQvr89ElLPmnGuKZGBloXlS2oWE4JyvWToVobMRmjsMAK+CxQIdebqK/ZGgIZDO
         rE7brCKyhr/7+JoCrUMMuVvSTf34S/q50eFC5elKP9NHmY6O/FqVxpYOUs/mbpqzxAVL
         URyqdbn3892Hz24s5t58NpauN4rtWFKBskLNH8FbSzsLnxJe03JAX7PPPI9O3dMOpO+o
         gIXoCMdfxo9MPd5xgG2l2bty6iussAFnIK8fmEAKcrHRvaE9VafQ8aOCBfulc7tbgTCK
         gL68vBz8BP4LKYS4k/nz4lW+VDDnjN/hbEVU2ZkchPT6idwuCUi/aC4BMZ3kI2MvHWMG
         Tv3g==
X-Gm-Message-State: APjAAAVOS0Gxw25DR0IXLvVgNICRwLVA7s9KOq9pYRGQVpu7g29dMF9z
        ww25Wbq4vOPj856HMtMB8Vs=
X-Google-Smtp-Source: APXvYqy6D+C9a9cPHnf7c33gGSyEGcOdFs+7BB5wTPvhaC/RYI6SU99fdnydvmpO1wCIr8aRTVKUTQ==
X-Received: by 2002:a65:5503:: with SMTP id f3mr106651pgr.351.1571952418762;
        Thu, 24 Oct 2019 14:26:58 -0700 (PDT)
Received: from localhost (g143.222-224-150.ppp.wakwak.ne.jp. [222.224.150.143])
        by smtp.gmail.com with ESMTPSA id y17sm41661514pfo.171.2019.10.24.14.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 14:26:58 -0700 (PDT)
Date:   Fri, 25 Oct 2019 06:26:55 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Mateusz Holenko <mholenko@antmicro.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org, Karol Gugala <kgugala@antmicro.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Filip Kokosinski <fkokosinski@internships.antmicro.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH 1/1] openrisc: add support for LiteX
Message-ID: <20191024212655.GJ24874@lianli.shorne-pla.net>
References: <20191023115427.23684-0-mholenko@antmicro.com>
 <20191023115427.23684-1-mholenko@antmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023115427.23684-1-mholenko@antmicro.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Oct 23, 2019 at 11:54:44AM +0200, Mateusz Holenko wrote:
> From: Filip Kokosinski <fkokosinski@internships.antmicro.com>
> 
> This adds support for a basic LiteX-based SoC with a mor1kx soft CPU.

Thanks for getting these patches ready.
 
> Signed-off-by: Filip Kokosinski <fkokosinski@internships.antmicro.com>
> Signed-off-by: Mateusz Holenko <mholenko@antmicro.com>
> ---
>  MAINTAINERS                               |  1 +
>  arch/openrisc/boot/dts/or1klitex.dts      | 49 +++++++++++++++++++++++
>  arch/openrisc/configs/or1klitex_defconfig | 18 +++++++++
>  3 files changed, 68 insertions(+)
>  create mode 100644 arch/openrisc/boot/dts/or1klitex.dts
>  create mode 100644 arch/openrisc/configs/or1klitex_defconfig
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c24a37833e78..e84b2cb4c186 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9500,6 +9500,7 @@ S:	Maintained
>  F:	include/linux/litex.h
>  F:	Documentation/devicetree/bindings/*/litex,*.yaml
>  F:	drivers/tty/serial/liteuart.c
> +F:	arch/openrisc/boot/dts/or1klitex.dts
>  
>  LIVE PATCHING
>  M:	Josh Poimboeuf <jpoimboe@redhat.com>
> diff --git a/arch/openrisc/boot/dts/or1klitex.dts b/arch/openrisc/boot/dts/or1klitex.dts
> new file mode 100644
> index 000000000000..63399398002d
> --- /dev/null
> +++ b/arch/openrisc/boot/dts/or1klitex.dts
> @@ -0,0 +1,49 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * LiteX-based System on Chip
> + *
> + * Copyright (C) 2019 Antmicro Ltd <www.antmicro.com>
> + */
> +
> +/dts-v1/;
> +/ {
> +	compatible = "opencores,or1ksim";
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	interrupt-parent = <&pic>;
> +
> +	aliases {
> +		serial0 = &serial0;
> +	};
> +
> +	chosen {
> +		bootargs = "console=liteuart";

As this depents on litex uart I will wait to queue this until it looks like the
uart patches are accepted for 5.5 merge window.

> +	};
> +
> +	memory@0 {
> +		device_type = "memory";
> +		reg = <0x00000000 0x10000000>;
> +	};
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		cpu@0 {
> +			compatible = "opencores,or1200-rtlsvn481";
> +			reg = <0>;
> +			clock-frequency = <100000000>;
> +		};
> +	};
> +
> +	pic: pic {
> +		compatible = "opencores,or1k-pic";
> +		#interrupt-cells = <1>;
> +		interrupt-controller;
> +	};
> +
> +	serial0: serial@e0001800 {
> +		device_type = "serial";
> +		compatible = "litex,liteuart";
> +		reg = <0xe0001800 0x100>;
> +	};
> +};
> diff --git a/arch/openrisc/configs/or1klitex_defconfig b/arch/openrisc/configs/or1klitex_defconfig
> new file mode 100644
> index 000000000000..0e4c2e74451c
> --- /dev/null
> +++ b/arch/openrisc/configs/or1klitex_defconfig
> @@ -0,0 +1,18 @@
> +CONFIG_BLK_DEV_INITRD=y
> +CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
> +CONFIG_BUG_ON_DATA_CORRUPTION=y
> +CONFIG_CC_OPTIMIZE_FOR_SIZE=y
> +CONFIG_CROSS_COMPILE="or32-linux-"

We use or1k-linux- now.  Is this what you really use?

> +CONFIG_DEVTMPFS=y
> +CONFIG_DEVTMPFS_MOUNT=y
> +CONFIG_EMBEDDED=y
> +CONFIG_HZ_100=y
> +CONFIG_INITRAMFS_SOURCE="openrisc-rootfs.cpio.gz"
> +CONFIG_OF_OVERLAY=y
> +CONFIG_OPENRISC_BUILTIN_DTB="or1klitex"
> +CONFIG_PANIC_ON_OOPS=y
> +CONFIG_PRINTK_TIME=y
> +CONFIG_SERIAL_LITEUART=y
> +CONFIG_SERIAL_LITEUART_CONSOLE=y

Note, Litex uart dependency lookds fine nere.

> +CONFIG_SOFTLOCKUP_DETECTOR=y
> +CONFIG_TTY_PRINTK=y
> -- 
> 2.23.0
> 

-Stafford
