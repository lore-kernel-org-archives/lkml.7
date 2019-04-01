Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F5AC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50D112084B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sF1KYh2j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbfDAKRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 06:17:55 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37620 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfDAKRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 06:17:54 -0400
Received: by mail-pf1-f195.google.com with SMTP id 8so4340105pfr.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 03:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=UPRhm3omSaVNFemdAfNQiISqlFDbD6hL/jo7caq619M=;
        b=sF1KYh2jVu/FjM3FlDh4a/Q+J5rhOLfr9fvw9r1Sb3abmtGf4gfGNjrXVa99oFd/Ip
         kaarpb2NYsC/OxSfOcM9JeILond9aZwY/oZAdrhhtBjO4dR9uV0Z8U5aVnIPKCe3oMuS
         2VZfP7j2lZwNyEH/NqJIHNKTmtUP0h95qYrMttBMnrY1S0WBz6AeH1pne2K16s5C7sDe
         OekpdB7rlNR5/neeN3j1+vxhy/ut1FGZzhR1ZZ/v6w6Xi2cE6hOHU5LdfB3nhWiEHNdS
         wPAMekIbZOJDwmwh9tatRJqB0fS0CaVF7j2aHKxYbuJ+hZc3mCg1dEgIzlZb3j7c/Did
         7ycg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=UPRhm3omSaVNFemdAfNQiISqlFDbD6hL/jo7caq619M=;
        b=hKF8qrTS+i7JWY67xFU4BryAo9JX8f2qIRcdiT8t711gDwKuzotLlZ/m/LtljWbIt2
         gXAPowmrLcquvKi+1ivI/PK1MDJ/Zs/QwFZy9lp2OZc0T73zJCNE5jr4n+GELxCDDKMb
         oBLs42wXoSHf1zTDm5UaD3Sr/m7jhxVSGxJ9Ed1yhYzGPKj5MY8u2aGVgDfYW58Z0E8S
         G31E5RQkmZXTiJc9wTIvw3vLYHvbTnWuSFc/WJdvd+3VpaCTlo6jkNXcN4c3HLpfydgW
         nwN3+ybtJG3s1G+hDJ/pnW3JvDZKLNnqYOd6FeQrJlUdMm3g6H7EzyeraL49sSRPcs19
         ISeA==
X-Gm-Message-State: APjAAAWb9qb2zE8+LluWa+dv1cYeChREB5IXoZGzisN9a7kv9KxL1McT
        rejnIAh88jA964zlzyjWjPDIyg==
X-Google-Smtp-Source: APXvYqzsp4yOzv3fP3RN1fkyIdu/EBi9l7KYqju89RcY+EjYs0wS9IePMgLnvam+UvZG9v597Sp4Dg==
X-Received: by 2002:a63:e402:: with SMTP id a2mr51380371pgi.268.1554113873707;
        Mon, 01 Apr 2019 03:17:53 -0700 (PDT)
Received: from dell ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id n82sm16514162pfi.63.2019.04.01.03.17.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 03:17:53 -0700 (PDT)
Date:   Mon, 1 Apr 2019 11:17:48 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Morris Ku <saumah@gmail.com>
Cc:     linux-kernel@vger.kernel.org, morris_ku@sunix.com, lkml@metux.net
Subject: Re: [PATCH] Respond:Patch 0004-Add-support-for-SUNIX-parallel-card
Message-ID: <20190401101748.GB4187@dell>
References: <20190329112511.9087-1-saumah@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190329112511.9087-1-saumah@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Mar 2019, Morris Ku wrote:

> Hi,
> Thanks for review, my replies are inline:

I literally have no idea what this is!

It's a reply to a diff of a reply to a patch AFAICS!

I think the best I can do is point you to:

  Documentation/process/submitting-patches.rst

> Signed-off-by: Morris Ku <saumah@gmail.com>
> ---
> @@ -0,0 +1,255 @@
> +
> +On 19.03.19 13:08, Morris Ku wrote:
> +
> +> diff --git a/mfd/sunix/snx_ieee1284_ops.c b/mfd/sunix/snx_ieee1284_ops.c
> +> new file mode 100644
> +> index 00000000..2dac03fd
> +> --- /dev/null
> +
> +<snip>
> +
> +> +size_t sunix_parport_ieee1284_read_nibble(struct snx_parport *port,
> +> +void *buffer, size_t len, int flags)
> +> +{
> +> +     return 0;
> +> +}
> +> +
> +> +size_t sunix_parport_ieee1284_read_byte(struct snx_parport *port,
> +> +void *buffer, size_t len, int flags)
> +> +{
> +> +     return 0;
> +> +}
> +> +
> +> +size_t sunix_parport_ieee1284_ecp_write_data(struct snx_parport *port,
> +> +const void *buffer, size_t len, int flags)
> +> +{
> +> +     return 0;
> +> +}
> +> +
> +> +size_t sunix_parport_ieee1284_ecp_read_data(struct snx_parport *port,
> +> +void *buffer, size_t len, int flags)
> +> +{
> +> +     return 0;
> +> +}
> +> +
> +> +size_t sunix_parport_ieee1284_ecp_write_addr(struct snx_parport *port,
> +> +const void *buffer, size_t len, int flags)
> +> +{
> +> +     return 0;
> +> +}
> +
> +Why are these all no-ops ?
> +
> +i will fix it.
> +
> +> diff --git a/mfd/sunix/snx_lp.c b/mfd/sunix/snx_lp.c
> +> new file mode 100644
> +> index 00000000..f2478447
> +> --- /dev/null
> +> +++ b/mfd/sunix/snx_lp.c
> +
> +<snip>
> +
> +> +#undef SNX_LP_STATS
> +
> +what is this ?
> +
> +i will fix it.
> +
> +> +static int SNX_PAL_MAJOR;
> +> +
> +> +#define SNX_LP_NO SNX_PAR_TOTAL_MAX
> +> +#undef SNX_CONFIG_LP_CONSOLE
> +
> +and this ?
> +
> +i will fix it.
> +
> +> +#ifdef SNX_CONFIG_PARPORT_1284
> +
> +dont do #define in the middle of the code.
> +
> +i will fix it.
> +
> +> +static const struct file_operations snx_lp_fops = {
> +> +     .owner          = THIS_MODULE,
> +> +     .write          = snx_lp_write,
> +> +     .open           = snx_lp_open,
> +> +     .release        = snx_lp_release,
> +> +#ifdef SNX_CONFIG_PARPORT_1284
> +> +     .read           = snx_lp_read,
> +> +#endif
> +> +};
> +
> +dont reimplement existing standard functionality your own weird way.
> +use the partport subsystem. see: Documentation/parport-lowlevel.txt
> +
> +i will fix it.
> +
> +> +static struct snx_parport_driver snx_lp_driver = {
> +> +     .name = "lx",
> +> +     .attach = snx_lp_attach,
> +> +     .detach = snx_lp_detach,
> +> +};
> +
> +yet another case of duplication of some standard struct and hard-
> +typecasting ? use struct parport_driver here.
> +
> +i will use standard struct(struct lp_driver) , about struct snx_parport driver,
> +i will keep current format , because add a list for store device informations.    
> +
> +> +     SNX_PAL_MAJOR = register_chrdev(0, "lx", &snx_lp_fops);
> +
> +dont register your own chardev - use the parport subsystem.
> +
> +i will fix it.
> +
> +> diff --git a/mfd/sunix/snx_parallel.c b/mfd/sunix/snx_parallel.c
> +> new file mode 100644
> +> index 00000000..461ea4cc
> +> --- /dev/null
> +
> +<snip>
> +
> +> +struct snx_parport *sunix_parport_pc_probe_port(struct sunix_par_port *priv)
> +> +{
> +> +     struct snx_parport_ops *ops = NULL;
> +> +     struct snx_parport *p = NULL;
> +> +     struct resource *base_res;
> +> +     struct resource *ecr_res = NULL;
> +> +
> +> +     if (!priv)
> +> +             goto out1;
> +> +
> +> +     ops = kmalloc(sizeof(struct snx_parport_ops), GFP_KERNEL);
> +
> +why not kzmalloc ?
> +
> +i will fix it.
> +
> +> diff --git a/mfd/sunix/snx_ppdev.c b/mfd/sunix/snx_ppdev.c
> +> new file mode 100644
> +> index 00000000..9482ed9f
> +> --- /dev/null
> +> +++ b/mfd/sunix/snx_ppdev.c
> +
> +<snip>
> +
> +> +static const struct file_operations snx_pp_fops = {
> +> +     .owner          = THIS_MODULE,
> +> +     .llseek         = no_llseek,
> +> +     .read           = snx_pp_read,
> +> +     .write          = snx_pp_write,
> +> +     .poll           = snx_pp_poll,
> +> +     .unlocked_ioctl = snx_dump_par_ioctl,
> +> +
> +> +     .open           = snx_pp_open,
> +> +     .release        = snx_pp_release,
> +> +};
> +
> +don't reimplement existing standard functionality - use the parport
> +subsystem.
> +
> +i will fix it. 
> +
> +> diff --git a/mfd/sunix/snx_ppdev.h b/mfd/sunix/snx_ppdev.h
> +> new file mode 100644
> +> index 00000000..0dfec064
> +> --- /dev/null
> +> +++ b/mfd/sunix/snx_ppdev.h
> +> @@ -0,0 +1,15 @@
> +> +/* SPDX-License-Identifier: GPL-2.0 */
> +> +#include "snx_common.h"
> +> +
> +> +#define SNX_PP_IOCTL 'p'
> +> +
> +> +#define SNX_PP_FASTWRITE     (1<<2)
> +> +#define SNX_PP_FASTREAD              (1<<3)
> +> +#define SNX_PP_W91284PIC     (1<<4)
> +
> +use the BIT() macro
> +
> +i will use BIT() macro for bits definition. (DONE)
> +
> +> diff --git a/mfd/sunix/snx_share.c b/mfd/sunix/snx_share.c
> +> new file mode 100644
> +> index 00000000..ba6f86a2
> +> --- /dev/null
> +> +++ b/mfd/sunix/snx_share.c
> +> @@ -0,0 +1,629 @@
> +> +// SPDX-License-Identifier: GPL-2.0
> +> +#include "snx_common.h"
> +> +#define SNX_PARPORT_DEFAULT_TIMESLICE        (HZ/5)
> +> +
> +> +unsigned long sunix_parport_default_timeslice = SNX_PARPORT_DEFAULT_TIMESLICE;
> +> +int sunix_parport_default_spintime = DEFAULT_SPIN_TIME;
> +> +
> +> +static LIST_HEAD(snx_portlist);
> +> +static DEFINE_SPINLOCK(snx_full_list_lock);
> +> +
> +> +static DEFINE_SPINLOCK(snx_parportlist_lock);
> +> +
> +> +static LIST_HEAD(snx_all_ports);
> +> +static LIST_HEAD(snx_drivers);
> +> +
> +> +static DEFINE_SEMAPHORE(snx_registration_lock);
> +> +
> +> +static void sunix_dead_write_lines(
> +> +struct snx_parport *p, unsigned char b)
> +> +{}
> +> +static unsigned char sunix_dead_read_lines(
> +> +struct snx_parport *p)
> +> +{ return 0; }
> +> +static unsigned char sunix_dead_frob_lines(
> +> +struct snx_parport *p, unsigned char b, unsigned char c)
> +> +{ return 0; }
> +> +static void sunix_dead_onearg(struct snx_parport *p)
> +> +{}
> +> +static void sunix_dead_initstate(
> +> +struct snx_pardevice *d, struct snx_parport_state *s)
> +> +{}
> +> +static void sunix_dead_state(
> +> +struct snx_parport *p, struct snx_parport_state *s)
> +> +{}
> +> +static size_t sunix_dead_write(
> +> +struct snx_parport *p, const void *b, size_t l, int f)
> +> +{ return 0; }
> +> +static size_t sunix_dead_read(
> +> +struct snx_parport *p, void *b, size_t l, int f)
> +> +{ return 0; }
> +> +
> +> +
> +> +static struct snx_parport_ops        sunix_dead_ops = {
> +> +     .write_data                     = sunix_dead_write_lines,
> +> +     .read_data                      = sunix_dead_read_lines,
> +> +     .write_control          = sunix_dead_write_lines,
> +> +     .read_control           = sunix_dead_read_lines,
> +> +     .frob_control           = sunix_dead_frob_lines,
> +> +     .read_status            = sunix_dead_read_lines,
> +> +     .enable_irq                     = sunix_dead_onearg,
> +> +     .disable_irq            = sunix_dead_onearg,
> +> +     .data_forward           = sunix_dead_onearg,
> +> +     .data_reverse           = sunix_dead_onearg,
> +> +     .init_state                     = sunix_dead_initstate,
> +> +     .save_state                     = sunix_dead_state,
> +> +     .restore_state          = sunix_dead_state,
> +> +     .epp_write_data         = sunix_dead_write,
> +> +     .epp_read_data          = sunix_dead_read,
> +> +     .epp_write_addr         = sunix_dead_write,
> +> +     .epp_read_addr          = sunix_dead_read,
> +> +     .ecp_write_data         = sunix_dead_write,
> +> +     .ecp_read_data          = sunix_dead_read,
> +> +     .ecp_write_addr         = sunix_dead_write,
> +> +     .compat_write_data      = sunix_dead_write,
> +> +     .nibble_read_data       = sunix_dead_read,
> +> +     .byte_read_data         = sunix_dead_read,
> +> +     .owner                          = NULL,
> +> +};
> +
> +
> +don't reimplement existing standard functionality. use the parport
> +subsystem.
> +
> +can i drop it ? it seems that it has no effect when port gone away.
> +
> +--mtx

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
