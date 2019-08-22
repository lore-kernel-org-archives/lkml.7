Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F6DC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 20:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F32823400
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 20:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392538AbfHVUFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 16:05:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36390 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731970AbfHVUFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 16:05:08 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A66DE10C696E;
        Thu, 22 Aug 2019 20:05:07 +0000 (UTC)
Received: from treble (ovpn-121-55.rdu2.redhat.com [10.10.121.55])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A737C1001947;
        Thu, 22 Aug 2019 20:05:06 +0000 (UTC)
Date:   Thu, 22 Aug 2019 15:05:04 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Raphael Gault <raphael.gault@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com,
        julien.thierry.kdev@gmail.com, raph.gault+kdev@gmail.com
Subject: Re: [RFC v4 09/18] gcc-plugins: objtool: Add plugin to detect switch
 table on arm64
Message-ID: <20190822200504.x4unrhw36buwvdmg@treble>
References: <20190816122403.14994-1-raphael.gault@arm.com>
 <20190816122403.14994-10-raphael.gault@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190816122403.14994-10-raphael.gault@arm.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.65]); Thu, 22 Aug 2019 20:05:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 01:23:54PM +0100, Raphael Gault wrote:
> This plugins comes into play before the final 2 RTL passes of GCC and

"plugin"

> detects switch-tables that are to be outputed in the ELF and writes
> information in an "objtool_data" section which will be used by objtool.

The section should probably have a ".discard" prefix
(.discard.objtool_data) so it gets discarded at link time.

Also, "objtool_data" is a bit generic.  How about
".discard.switch_tables" or something.

> 
> Signed-off-by: Raphael Gault <raphael.gault@arm.com>
> ---
>  scripts/Makefile.gcc-plugins                  |  2 +
>  scripts/gcc-plugins/Kconfig                   |  9 +++
>  .../arm64_switch_table_detection_plugin.c     | 58 +++++++++++++++++++
>  3 files changed, 69 insertions(+)
>  create mode 100644 scripts/gcc-plugins/arm64_switch_table_detection_plugin.c
> 
> diff --git a/scripts/Makefile.gcc-plugins b/scripts/Makefile.gcc-plugins
> index 5f7df50cfe7a..a56736df9dc2 100644
> --- a/scripts/Makefile.gcc-plugins
> +++ b/scripts/Makefile.gcc-plugins
> @@ -44,6 +44,8 @@ ifdef CONFIG_GCC_PLUGIN_ARM_SSP_PER_TASK
>  endif
>  export DISABLE_ARM_SSP_PER_TASK_PLUGIN
>  
> +gcc-plugin-$(CONFIG_GCC_PLUGIN_SWITCH_TABLES)	+= arm64_switch_table_detection_plugin.so
> +
>  # All the plugin CFLAGS are collected here in case a build target needs to
>  # filter them out of the KBUILD_CFLAGS.
>  GCC_PLUGINS_CFLAGS := $(strip $(addprefix -fplugin=$(objtree)/scripts/gcc-plugins/, $(gcc-plugin-y)) $(gcc-plugin-cflags-y))
> diff --git a/scripts/gcc-plugins/Kconfig b/scripts/gcc-plugins/Kconfig
> index d33de0b9f4f5..1daeffb55dce 100644
> --- a/scripts/gcc-plugins/Kconfig
> +++ b/scripts/gcc-plugins/Kconfig
> @@ -113,4 +113,13 @@ config GCC_PLUGIN_ARM_SSP_PER_TASK
>  	bool
>  	depends on GCC_PLUGINS && ARM
>  
> +config GCC_PLUGIN_SWITCH_TABLES
> +	bool "GCC Plugin: Identify switch tables at compile time"
> +	default y
> +	depends on STACK_VALIDATION && ARM64
> +	help
> +	  Plugin to identify switch tables generated at compile time and store
> +	  them in a .objtool_data section. Objtool will then use that section
> +	  to analyse the different execution path of the switch table.

This isn't something you want to ask the user about, as objtool for
arm64 requires it.  For the same reason, instead of
GCC_PLUGIN_SWITCH_TABLES depending on STACK_VALIDATION, arm64
HAVE_STACK_VALIDATION should depend on GCC_PLUGIN_SWITCH_TABLES.

-- 
Josh
