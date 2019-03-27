Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E541C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D398F2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388519AbfC0TUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:20:30 -0400
Received: from foss.arm.com ([217.140.101.70]:34074 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727796AbfC0TU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 15:20:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 87995374;
        Wed, 27 Mar 2019 12:20:28 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 773E83F557;
        Wed, 27 Mar 2019 12:20:27 -0700 (PDT)
Date:   Wed, 27 Mar 2019 19:20:21 +0000
From:   Andre Przywara <andre.przywara@arm.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kbuild@vger.kernel.org,
        Vladimir Kondratiev <vladimir.kondratiev@linux.intel.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kbuild: do not overwrite .gitignore in output directory
Message-ID: <20190327192021.5d676019@donnerap.cambridge.arm.com>
In-Reply-To: <1553574418-21033-1-git-send-email-yamada.masahiro@socionext.com>
References: <1553574418-21033-1-git-send-email-yamada.masahiro@socionext.com>
Organization: ARM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Mar 2019 13:26:58 +0900
Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

Masahiro,

> Commit 3a51ff344204 ("kbuild: gitignore output directory") seemed to
> bother people who version-control output directories.

Thanks a lot for the patch, that works for me.

> Andre Przywara says:
> "Unfortunately this breaks my setup, because I keep a totally separate
> git repository in my build directories to track (various versions of)
> .config. So .gitignore there is carefully crafted to ignore most build
> artefacts, but not .config, for instance."
> 
> Link: https://lkml.org/lkml/2019/3/22/1819
> Reported-by: Andre Przywara <andre.przywara@arm.com>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Tested-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre.

> ---
> 
>  Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index 5fe5431..70fc778 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -499,7 +499,8 @@ outputmakefile:
>  ifneq ($(KBUILD_SRC),)
>  	$(Q)ln -fsn $(srctree) source
>  	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/mkmakefile $(srctree)
> -	$(Q){ echo "# this is build directory, ignore it"; echo "*"; } > .gitignore
> +	$(Q)test -e .gitignore || \
> +	{ echo "# this is build directory, ignore it"; echo "*"; } > .gitignore
>  endif
>  
>  ifneq ($(shell $(CC) --version 2>&1 | head -n 1 | grep clang),)

