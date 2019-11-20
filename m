Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FAKE_REPLY_C,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E104C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 17:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9E2720B7C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 17:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVk03sKh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbfKTRXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 12:23:06 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45169 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbfKTRXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 12:23:05 -0500
Received: by mail-qk1-f196.google.com with SMTP id q70so440698qke.12;
        Wed, 20 Nov 2019 09:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=a2MLfSrel+mRbxxitJdDU9cMLj6K94x+FsaIqj+3XoA=;
        b=kVk03sKhpt3/+dqXQtuziwe4bJdEAf5+wrwdw/CxuHNquxkGvNbQedmk8WkwGaUKu0
         pvGC62kzAfnBWQXONvd06bPTbn779MGgDSauYuXIl38eaMzh5Vmmi9cnOsi83/zhUTVc
         evVyqeZqg92u4yYJWQMqM9XbHfkKiLBai8DgQHr4ywS9VIwObn2Dy7CppDQW8T9iHUe1
         ZF2KSRyhNAkRvCIzsV/QCH+hNI9weKXmQ5br+FiPf8IiD/LUAJCb+oOa5H/XJd/lcraM
         qvSkOidCT+nS7kUhRA3mIM5CJjJsyWk2N6qrtTLE1kuifybbAGfpIL93yPUNXa7P/qZ4
         bjAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a2MLfSrel+mRbxxitJdDU9cMLj6K94x+FsaIqj+3XoA=;
        b=izkwSkhaAZfPgdZTbZiMGzXfNny4OML8Hq08SemEqB4bbWLoWYpVLMZye/8x1h9huK
         yKg/ZtQsC/uVJtTgGS4yOqlvysHELvXeUAksc2htJyXMCTg+EUFefK3xGp7tFmIHCVZY
         bdCIg/gmkwUYu+XTYM8RmZFk4Yb7wLxpNyAPD9iaZTDxfc9P4YBP5sbuCkKPiFarnkZk
         gaUtcQP+eRcq1Mk3Px37rpt+kV0u1fFNqf0Nm47xkTZ/+sUxMAzC0PgOjCv4mpHtB5yW
         wV5hW7hohPQT9GF3CI9IsTFyf/zRS5FfhGvtrB3ivbMIGHOwYahfNPHBzcQM9BpW6xfS
         aSyw==
X-Gm-Message-State: APjAAAVn4nWKgdpdT/3Ao8VzCNl+m1gmn8vJkarWKmR3Xin8qIOBuP1V
        QqMOVzfrbqg1XaEpagk4rvg=
X-Google-Smtp-Source: APXvYqwb9wufFRBn5GO5lmPejLWii5Ic9r2KTSz1VDSv5ZsPXpV+JoOsPGzb+dpBJtOjPyA0w73ieQ==
X-Received: by 2002:ae9:e00f:: with SMTP id m15mr3463410qkk.217.1574270584266;
        Wed, 20 Nov 2019 09:23:04 -0800 (PST)
Received: from hedwig.ini.cmu.edu (HEDWIG.INI.CMU.EDU. [128.2.16.51])
        by smtp.gmail.com with ESMTPSA id b10sm11909098qkh.69.2019.11.20.09.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 09:23:03 -0800 (PST)
Date:   Wed, 20 Nov 2019 12:23:00 -0500
From:   "Gabriel L. Somlo" <gsomlo@gmail.com>
To:     Mateusz Holenko <mholenko@antmicro.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, Stafford Horne <shorne@gmail.com>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
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
Message-ID: <20191120172300.GA15391@hedwig.ini.cmu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023114634.13657-2-mholenko@antmicro.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Please be aware that LiteX supports "LITEX_SUBREG_SIZE" of up to 4,
and might go even as far as 8 in the near future. Hard coding this
here might be short sighted.

A good alternative might be to have "litex_subreg_size" or
"mmio-dw-bytes" passed in via a DT property of the SoC node, as
illustrated here:

https://github.com/litex-hub/linux-on-litex-vexriscv/pull/60

Thanks,
--Gabriel

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
