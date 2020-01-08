Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9489DC282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 16:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CAFA20692
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 16:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578502346;
	bh=gr74FHTiieCttQT9nIGhGKdVo2KGuUdcTqpLjQlvpBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lF5qVEciaQJPh57FOLnUyM2J9z5I2r7O1rIbv9lcC5mKGIi3xJ5yzXbKAknVxr4ou
	 jKAt5b5sq02P4oAw6martp6FcUkQjlXZB0d10th0rtsHF0k5CpwvOfg9TwEylb+h6O
	 RC434w1D1HE4L4NM1LST8BhchaKhg2CNRUxnKnhs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729256AbgAHQwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 11:52:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:50368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727606AbgAHQwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 11:52:25 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2243420678;
        Wed,  8 Jan 2020 16:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578502344;
        bh=gr74FHTiieCttQT9nIGhGKdVo2KGuUdcTqpLjQlvpBk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OEWjaIOs21VxjS0qPRpVwIJHHcomsxWvOmWeG4EQLnBsTyzjCJ0+eyTseRpprZvd6
         IwFwDiEwPOScxfsmRACklwLKCzTZwunyD6+oZQdbxkErZeXygUyF0fTrqWm+ir1czK
         Biu5bvZgmTVwPxT9LUFyOCUTmDOqOJrn9/swa3gE=
Date:   Wed, 8 Jan 2020 16:52:15 +0000
From:   Will Deacon <will@kernel.org>
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, robh+dt@kernel.org,
        frowand.list@gmail.com, kexec@lists.infradead.org,
        james.morse@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/2] libfdt: include fdt_addresses.c
Message-ID: <20200108165214.GA19760@willie-the-truck>
References: <20191209030345.5735-1-takahiro.akashi@linaro.org>
 <20191209030345.5735-2-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209030345.5735-2-takahiro.akashi@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 09, 2019 at 12:03:44PM +0900, AKASHI Takahiro wrote:
> In the implementation of kexec_file_loaded-based kdump for arm64,
> fdt_appendprop_addrrange() will be needed.
> 
> So include fdt_addresses.c in making libfdt.
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> ---
>  lib/Makefile        | 2 +-
>  lib/fdt_addresses.c | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
>  create mode 100644 lib/fdt_addresses.c

I'd like to take this via arm64 and it looks like it follows what we do
for other fdt files under lib/.

Rob, Frank -- are you ok with me picking this up, please?

Will


> diff --git a/lib/Makefile b/lib/Makefile
> index 93217d44237f..c20b1debe9b4 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -223,7 +223,7 @@ KASAN_SANITIZE_stackdepot.o := n
>  KCOV_INSTRUMENT_stackdepot.o := n
>  
>  libfdt_files = fdt.o fdt_ro.o fdt_wip.o fdt_rw.o fdt_sw.o fdt_strerror.o \
> -	       fdt_empty_tree.o
> +	       fdt_empty_tree.o fdt_addresses.o
>  $(foreach file, $(libfdt_files), \
>  	$(eval CFLAGS_$(file) = -I $(srctree)/scripts/dtc/libfdt))
>  lib-$(CONFIG_LIBFDT) += $(libfdt_files)
> diff --git a/lib/fdt_addresses.c b/lib/fdt_addresses.c
> new file mode 100644
> index 000000000000..23610bcf390b
> --- /dev/null
> +++ b/lib/fdt_addresses.c
> @@ -0,0 +1,2 @@
> +#include <linux/libfdt_env.h>
> +#include "../scripts/dtc/libfdt/fdt_addresses.c"
> -- 
> 2.24.0
