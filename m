Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10EB4CA9EBD
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 00:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D929420867
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 00:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572048229;
	bh=UK03/4Om6Yc7jJxQYh608XTJEnEeySRuvdKSwVJv+xU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zfin7T8slkLOzHWggsI7tkbVbhGNQc2KoxJfY5R37DRxHvZvb5eMhpJeFqr7iF/rE
	 Q9xxHbCzcKNZW4EbjZRZhULcQBodbIxl3wLz0CZ+3sCFJadPcYOSgO6HZRRfkr2ZUC
	 9rIYT79cutxscf+nAR9z5DGerszQ8mzSOj5GgnIs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbfJZADs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 20:03:48 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40124 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfJZADs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 20:03:48 -0400
Received: by mail-ot1-f67.google.com with SMTP id d8so3219379otc.7;
        Fri, 25 Oct 2019 17:03:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rmR5t0ADsYfno5vVZm/vi2FgzFz346rAEYBMOAdK/VQ=;
        b=H/sUUkILyLwtjjcXwtqox/t+P55WUFqQc/lUt0+ycZdm20mZ0rAnX6t4IuC1Mrdl23
         Jt0T9zY2nSHJupYV0cCVACXp+9V4JAuIzWGylxy0AU8LjfaicytXzmUMCUDR0MNG9Y26
         eoWTBB33szC10QOgehJ9rduFzPnwp5VA2xcO4wJDLDqsalaFWvoMqD89SAVT3hfkoo6g
         /cYp9B5BOPtUnwiIfijTaPSyYtZatwE1j4JcsFh4sZkth3w54PMU7uZQRqg7X1mLPk1Y
         Qpw3jj11hz+MUgrvg3BbmNIZQdRG0Q8ZhjMgxDdwYpKzGJbz1AAU1bY6dPwvFpHxpWpM
         QoWg==
X-Gm-Message-State: APjAAAVIFVG5nlCKQm7jkjjK6q9k9BN7dtwaTSLxhgRsnTqgT6UsiLPd
        UGZvqQG1wTdy82VTvYDwXQ==
X-Google-Smtp-Source: APXvYqw87CDD0bRee7hVsxuQRLDcRAU/0dC/zIYeL8dLYeRlm7GMF3G4Bh9UpWtU5hXei9wl4VP/0Q==
X-Received: by 2002:a9d:66d:: with SMTP id 100mr4878305otn.302.1572048226729;
        Fri, 25 Oct 2019 17:03:46 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v6sm1031983oie.4.2019.10.25.17.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 17:03:46 -0700 (PDT)
Date:   Fri, 25 Oct 2019 19:03:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     Mateusz Holenko <mholenko@antmicro.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, Stafford Horne <shorne@gmail.com>,
        Karol Gugala <kgugala@antmicro.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Filip Kokosinski <fkokosinski@internships.antmicro.com>,
        Joel Stanley <joel@jms.id.au>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Maxime Ripard <mripard@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] litex: add common LiteX header
Message-ID: <20191026000345.GA10810@bogus>
References: <20191023114634.13657-0-mholenko@antmicro.com>
 <20191023114634.13657-2-mholenko@antmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023114634.13657-2-mholenko@antmicro.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 11:47:04AM +0200, Mateusz Holenko wrote:
> It provides helper CSR access functions used by all
> LiteX drivers.
> 
> Signed-off-by: Mateusz Holenko <mholenko@antmicro.com>
> ---
> This commit has been introduced in v2 of the patchset.
> 
>  MAINTAINERS           |  6 +++++
>  include/linux/litex.h | 59 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 65 insertions(+)
>  create mode 100644 include/linux/litex.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 296de2b51c83..eaa51209bfb2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9493,6 +9493,12 @@ F:	Documentation/misc-devices/lis3lv02d.rst
>  F:	drivers/misc/lis3lv02d/
>  F:	drivers/platform/x86/hp_accel.c
>  
> +LITEX PLATFORM
> +M:	Karol Gugala <kgugala@antmicro.com>
> +M:	Mateusz Holenko <mholenko@antmicro.com>
> +S:	Maintained
> +F:	include/linux/litex.h
> +
>  LIVE PATCHING
>  M:	Josh Poimboeuf <jpoimboe@redhat.com>
>  M:	Jiri Kosina <jikos@kernel.org>
> diff --git a/include/linux/litex.h b/include/linux/litex.h
> new file mode 100644
> index 000000000000..e793d2d7c881
> --- /dev/null
> +++ b/include/linux/litex.h
> @@ -0,0 +1,59 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Common LiteX header providing
> + * helper functions for accessing CSRs.
> + *
> + * Copyright (C) 2019 Antmicro <www.antmicro.com>
> + */
> +
> +#ifndef _LINUX_LITEX_H
> +#define _LINUX_LITEX_H
> +
> +#include <linux/io.h>
> +#include <linux/types.h>
> +#include <linux/compiler_types.h>
> +
> +#define LITEX_REG_SIZE             0x4
> +#define LITEX_SUBREG_SIZE          0x1
> +#define LITEX_SUBREG_SIZE_BIT      (LITEX_SUBREG_SIZE * 8)
> +
> +#ifdef __LITTLE_ENDIAN
> +# define LITEX_READ_REG(addr)                  ioread32(addr)
> +# define LITEX_READ_REG_OFF(addr, off)         ioread32(addr + off)
> +# define LITEX_WRITE_REG(val, addr)            iowrite32(val, addr)
> +# define LITEX_WRITE_REG_OFF(val, addr, off)   iowrite32(val, addr + off)
> +#else
> +# define LITEX_READ_REG(addr)                  ioread32be(addr)
> +# define LITEX_READ_REG_OFF(addr, off)         ioread32be(addr + off)
> +# define LITEX_WRITE_REG(val, addr)            iowrite32be(val, addr)
> +# define LITEX_WRITE_REG_OFF(val, addr, off)   iowrite32be(val, addr + off)

Defining custom accessors makes it harder for others to understand 
the code. The __raw_readl/writel accessors are native endian, so use 
those. One difference though is they don't have a memory barrier, but 
based on the below functions, you may want to do your own barrier 
anyways. And if DMA is not involved you don't need the barriers either.

The _OFF variants don't add anything. LITEX_READ_REG(addr + off) is just 
as easy to read if not easier than LITEX_READ_REG_OFF(addr, off).

> +#endif
> +
> +/* Helper functions for manipulating LiteX registers */
> +
> +static inline void litex_set_reg(void __iomem *reg, u32 reg_size, u32 val)
> +{
> +	u32 shifted_data, shift, i;
> +
> +	for (i = 0; i < reg_size; ++i) {
> +		shift = ((reg_size - i - 1) * LITEX_SUBREG_SIZE_BIT);
> +		shifted_data = val >> shift;
> +		LITEX_WRITE_REG(shifted_data, reg + (LITEX_REG_SIZE * i));
> +	}
> +}

The problem with this is it hides whether you need to do any locking. 
Normally, you would assume a register access is atomic when it's not 
here. You could add locking in this function, but then you're doing 
locking even when not needed.

It doesn't look like you actually use this in your series, so maybe 
remove until you do.

> +
> +static inline u32 litex_get_reg(void __iomem *reg, u32 reg_size)
> +{
> +	u32 shifted_data, shift, i;
> +	u32 result = 0;
> +
> +	for (i = 0; i < reg_size; ++i) {
> +		shifted_data = LITEX_READ_REG(reg + (LITEX_REG_SIZE * i));
> +		shift = ((reg_size - i - 1) * LITEX_SUBREG_SIZE_BIT);
> +		result |= (shifted_data << shift);
> +	}
> +
> +	return result;
> +}
> +
> +#endif /* _LINUX_LITEX_H */
> -- 
> 2.23.0
