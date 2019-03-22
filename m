Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A0CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D82321841
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:52:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbfCVPwS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:52:18 -0400
Received: from foss.arm.com ([217.140.101.70]:48104 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727257AbfCVPwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 11:52:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C9FD7A78;
        Fri, 22 Mar 2019 08:52:17 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.197.44])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD60A3F59C;
        Fri, 22 Mar 2019 08:52:16 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Vladimir Kondratiev <vladimir.kondratiev@linux.intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kbuild: gitignore output directory
Date:   Fri, 22 Mar 2019 15:52:12 +0000
Message-Id: <20190322155212.133029-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190203084840.6113-1-vladimir.kondratiev@intel.com>
References: <20190203084840.6113-1-vladimir.kondratiev@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> When compiling into output directory using O=, many files
> created under KBUILD_OUTPUT that git considers
> as new ones; git clients, ex. "git gui" lists it, and it clutters
> file list making it difficult to see what was really changed
> 
> Generate .gitignore in output directory that ignores all
> its content

just found this when testing -rc1.
Unfortunately this breaks my setup, because I keep a totally separate
git repository in my build directories to track (various versions of)
.config. So .gitignore there is carefully crafted to ignore most build
artefacts, but not .config, for instance.

I am not sure how git would interact with the build directory for you?
Do you build into a subdirectory of the kernel tree?

I was hoping that we would not overwrite unrelated files in directories
outside of the kernel tree. In case this is about a subdirectory of the
source tree, can we somehow check for this case?

Cheers,
Andre.

> 
> Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@linux.intel.com>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>  Makefile | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Makefile b/Makefile
> index 97ee0be24d52..d487fca342c4 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -483,10 +483,13 @@ PHONY += outputmakefile
>  # outputmakefile generates a Makefile in the output directory, if using a
>  # separate output directory. This allows convenient use of make in the
>  # output directory.
> +# At the same time when output Makefile generated, generate .gitignore to
> +# ignore whole output directory
>  outputmakefile:
>  ifneq ($(KBUILD_SRC),)
>  	$(Q)ln -fsn $(srctree) source
>  	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/mkmakefile $(srctree)
> +	$(Q){ echo "# this is build directory, ignore it"; echo "*"; } > .gitignore
>  endif
>  
>  ifneq ($(shell $(CC) --version 2>&1 | head -n 1 | grep clang),)
> -- 
> 2.17.1

