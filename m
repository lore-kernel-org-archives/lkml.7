Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B537C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 046EC20665
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbfF1Jff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 05:35:35 -0400
Received: from foss.arm.com ([217.140.110.172]:43706 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726420AbfF1Jff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 05:35:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97EB928;
        Fri, 28 Jun 2019 02:35:34 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 27E9F3F718;
        Fri, 28 Jun 2019 02:35:32 -0700 (PDT)
Date:   Fri, 28 Jun 2019 10:35:30 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Miles Chen <miles.chen@mediatek.com>,
        James Morse <james.morse@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Jun Yao <yaojun8558363@gmail.com>, Yu Zhao <yuzhao@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v6 2/3] fdt: add support for rng-seed
Message-ID: <20190628093529.GB36437@lakrids.cambridge.arm.com>
References: <20190612043258.166048-1-hsinyi@chromium.org>
 <20190612043258.166048-3-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612043258.166048-3-hsinyi@chromium.org>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 12:33:00PM +0800, Hsin-Yi Wang wrote:
> Introducing a chosen node, rng-seed, which is an entropy that can be
> passed to kernel called very early to increase initial device
> randomness. Bootloader should provide this entropy and the value is
> read from /chosen/rng-seed in DT.

Could you please elaborate on this?

* What is this initial entropy used by, and why is this important? I
  assume that devices which can populate this will have a HW RNG that
  the kernel will eventually make use of.

* How much entropy is necessary or sufficient?

* Why is the DT the right mechanism for this?

Thanks,
Mark.

> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> ---
> change log v5->v6:
> * remove Documentation change
> ---
>  drivers/of/fdt.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 3d36b5afd9bd..369130dbd42c 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -24,6 +24,7 @@
>  #include <linux/debugfs.h>
>  #include <linux/serial_core.h>
>  #include <linux/sysfs.h>
> +#include <linux/random.h>
>  
>  #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
>  #include <asm/page.h>
> @@ -1052,6 +1053,7 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
>  {
>  	int l;
>  	const char *p;
> +	const void *rng_seed;
>  
>  	pr_debug("search \"chosen\", depth: %d, uname: %s\n", depth, uname);
>  
> @@ -1086,6 +1088,14 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
>  
>  	pr_debug("Command line is: %s\n", (char*)data);
>  
> +	rng_seed = of_get_flat_dt_prop(node, "rng-seed", &l);
> +	if (rng_seed && l > 0) {
> +		add_device_randomness(rng_seed, l);
> +
> +		/* try to clear seed so it won't be found. */
> +		fdt_nop_property(initial_boot_params, node, "rng-seed");
> +	}
> +
>  	/* break now */
>  	return 1;
>  }
> -- 
> 2.20.1
> 
