Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40881C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E4B8205ED
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfF1Jm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 05:42:57 -0400
Received: from foss.arm.com ([217.140.110.172]:43844 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbfF1Jm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 05:42:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5FEC628;
        Fri, 28 Jun 2019 02:42:56 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E4B553F718;
        Fri, 28 Jun 2019 02:42:53 -0700 (PDT)
Date:   Fri, 28 Jun 2019 10:42:51 +0100
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
Subject: Re: [PATCH v6 3/3] arm64: kexec_file: add rng-seed support
Message-ID: <20190628094251.GC36437@lakrids.cambridge.arm.com>
References: <20190612043258.166048-1-hsinyi@chromium.org>
 <20190612043258.166048-4-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612043258.166048-4-hsinyi@chromium.org>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 12:33:02PM +0800, Hsin-Yi Wang wrote:
> Adding "rng-seed" to dtb. It's fine to add this property if original
> fdt doesn't contain it. Since original seed will be wiped after
> read, so use a default size 128 bytes here.

Why is 128 bytes the default value?

I didn't see an update to Documentation/devicetree/bindings/chosen.txt,
so it's not clear to me precisely what we expect.

> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> ---
> change log v5->v6:
> * no change
> ---
>  arch/arm64/kernel/machine_kexec_file.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
> index 58871333737a..d40fde72a023 100644
> --- a/arch/arm64/kernel/machine_kexec_file.c
> +++ b/arch/arm64/kernel/machine_kexec_file.c
> @@ -27,6 +27,8 @@
>  #define FDT_PROP_INITRD_END	"linux,initrd-end"
>  #define FDT_PROP_BOOTARGS	"bootargs"
>  #define FDT_PROP_KASLR_SEED	"kaslr-seed"
> +#define FDT_PROP_RNG_SEED	"rng-seed"
> +#define RNG_SEED_SIZE		128
>  
>  const struct kexec_file_ops * const kexec_file_loaders[] = {
>  	&kexec_image_ops,
> @@ -102,6 +104,23 @@ static int setup_dtb(struct kimage *image,
>  				FDT_PROP_KASLR_SEED);
>  	}
>  
> +	/* add rng-seed */
> +	if (rng_is_initialized()) {
> +		void *rng_seed = kmalloc(RNG_SEED_SIZE, GFP_ATOMIC);

For 128 bytes, it would be better to use a buffer on the stack. That
avoids the possibility of the allocation failing.

> +		get_random_bytes(rng_seed, RNG_SEED_SIZE);
> +
> +		ret = fdt_setprop(dtb, off, FDT_PROP_RNG_SEED, rng_seed,
> +				RNG_SEED_SIZE);
> +		kfree(rng_seed);
> +
> +		if (ret)
> +			goto out;

If the RNG wasn't initialised, we'd carry on with a warning. Why do we
follow a different policy here?

Thanks,
Mark.

> +
> +	} else {
> +		pr_notice("RNG is not initialised: omitting \"%s\" property\n",
> +				FDT_PROP_RNG_SEED);
> +	}
> +
>  out:
>  	if (ret)
>  		return (ret == -FDT_ERR_NOSPACE) ? -ENOMEM : -EINVAL;
> @@ -110,7 +129,8 @@ static int setup_dtb(struct kimage *image,
>  }
>  
>  /*
> - * More space needed so that we can add initrd, bootargs and kaslr-seed.
> + * More space needed so that we can add initrd, bootargs, kaslr-seed, and
> + * rng-seed.
>   */
>  #define DTB_EXTRA_SPACE 0x1000
>  
> -- 
> 2.20.1
> 
