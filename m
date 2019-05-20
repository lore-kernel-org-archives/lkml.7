Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C139CC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 18:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B00A205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 18:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BxbmteVs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbfETSxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 14:53:52 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34363 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbfETSxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 14:53:52 -0400
Received: by mail-pg1-f195.google.com with SMTP id c13so7209958pgt.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 11:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0Y5xZffcfxsczgqrBhOg+JS5L1UKxd5QP3P4VAHztac=;
        b=BxbmteVs6gOCm4H+YpOin+Uw106QfZfaAwAKPAr4vdWLRuXjkVm3gLBKwhpHLPa/Cb
         4RqnaoeeCkGSrD+7lcfiV8ZZsE5PVyvqD0NvZJJROf6X7+AoZTvGB63WliRwDXKIsHU+
         2tjAIVEsexMupLKj1VX0+eAts1ETa6L28Vv84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0Y5xZffcfxsczgqrBhOg+JS5L1UKxd5QP3P4VAHztac=;
        b=q7rc6QE4fyZ7PVcIwKiFGMT4IsH3pdr5V4KGGuJrVdkpJ4JDa0B/V+AGOANQpltTB2
         mxsEEHR9Zi/LokY4p1pTemW/YQZwGicDDj30l44mEyVG1WrFFy/39W0LZvcy+gHtTEfx
         5wx0TJh89js8ki2D7aHksJ6iB89XSieWMrqQyV8fpYUH/aFUP9+sIeFtbY5nu0nWfb4m
         IVI0sLrIsAhSxSDYFSfliaUqqEwYiFFDbXVzcgv+eLQwktyI8lOeR96OpW7mLgbiQGdW
         8vB0Q01Kda5GXBI474Xj2vla2yHH4sMFg1dUqa1mLUD0xb8Qjd+m6j7+DNHnH/47Zm1U
         N7Bg==
X-Gm-Message-State: APjAAAWpah81vQ4szxigYaggznCB5qLpeF/ltoX/MrzfgrgYKChf2Gkp
        d2kex00WDnsD8XIWuLkBoPd56g==
X-Google-Smtp-Source: APXvYqyH+hxDltRjdzsBXZgwMdnMVNatpks+Z1SrjeidOf8Nz3mq6Nb+a62W9o8wZM3W7vuPdUB10Q==
X-Received: by 2002:a63:4c54:: with SMTP id m20mr77503041pgl.316.1558378431815;
        Mon, 20 May 2019 11:53:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 129sm21444815pff.140.2019.05.20.11.53.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 May 2019 11:53:50 -0700 (PDT)
Date:   Mon, 20 May 2019 11:53:49 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Subject: Re: [BUG v5.2-rc1] ARM build broken
Message-ID: <201905201142.CF71598A@keescook>
References: <4DB08A04-D03A-4441-85DE-64A13E6D709C@goldelico.com>
 <201905200855.391A921AB@keescook>
 <D8F987B2-8F41-46DE-B298-89541D7A9774@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D8F987B2-8F41-46DE-B298-89541D7A9774@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Adding Chris and Ard, who might have more compiler versions that me...]

On Mon, May 20, 2019 at 07:08:39PM +0200, H. Nikolaus Schaller wrote:
> > Am 20.05.2019 um 17:59 schrieb Kees Cook <keescook@chromium.org>:
> > 
> > On Mon, May 20, 2019 at 05:15:02PM +0200, H. Nikolaus Schaller wrote:
> >> Hi,
> >> it seems as if ARM build is broken since ARM now hard enables CONFIG_HAVE_GCC_PLUGINS
> >> which indirectly enables CONFIG_GCC_PLUGIN_ARM_SSP_PER_TASK. Compiling this breaks
> >> on my system (Darwin build host) due to conflicts in system headers and Linux headers.
> >> 
> >> So how can I turn off all these GCC_PLUGINS?
> >> 
> >> The offending patch seems to be
> >> 
> >> 	security: Create "kernel hardening" config area
> >> 
> >> especially the new "default y" for GCC_PLUGINS. After removing that line from
> >> scripts/gcc-plugins/Kconfig makes my compile succeed.
> > 
> > The intention is to enable it _if_ the plugins are available as part of
> > the build environment. The "default y" on GCC_PLUGINS is mediated by:
> >        depends on HAVE_GCC_PLUGINS
> 
> HAVE_GCC_PLUGINS has the following description:
> 
> 	An arch should select this symbol if it supports building with
>           GCC plugins.
> 
> So an ARCH (ARM) selects it unconditionally of the build environment.
> 
> >        depends on PLUGIN_HOSTCC != ""
> 
> Well, we have it set to "g++" for ages and it was not a problem.
> So both conditions are true.

PLUGIN_HOSTCC should have passed the scripts/gcc-plugin.sh test, so
that's correct. And the result (CONFIG_GCC_PLUGINS) is correct: it
doesn't enable or disable anything itself.

What you want is to disable CONFIG_STACKPROTECTOR_PER_TASK, which
is the knob for the feature:

config STACKPROTECTOR_PER_TASK
        bool "Use a unique stack canary value for each task"
        depends on GCC_PLUGINS && STACKPROTECTOR && SMP && !XIP_DEFLATED_DATA
        select GCC_PLUGIN_ARM_SSP_PER_TASK
        default y

> Build error:
> 
>  HOSTCXX -fPIC scripts/gcc-plugins/arm_ssp_per_task_plugin.o - due to: scripts/gcc-plugins/gcc-common.h
> In file included from scripts/gcc-plugins/arm_ssp_per_task_plugin.c:3:0:
> scripts/gcc-plugins/gcc-common.h:153:0: warning: "__unused" redefined
> #define __unused __attribute__((__unused__))
> ^

Does the following patch fix your build? (I assume that line is just a
warning, but if not...)

diff --git a/scripts/gcc-plugins/gcc-common.h b/scripts/gcc-plugins/gcc-common.h
index 552d5efd7cb7..17f06079a712 100644
--- a/scripts/gcc-plugins/gcc-common.h
+++ b/scripts/gcc-plugins/gcc-common.h
@@ -150,8 +150,12 @@ void print_gimple_expr(FILE *, gimple, int, int);
 void dump_gimple_stmt(pretty_printer *, gimple, int, int);
 #endif
 
+#ifndef __unused
 #define __unused __attribute__((__unused__))
+#endif
+#ifndef __visible
 #define __visible __attribute__((visibility("default")))
+#endif
 
 #define DECL_NAME_POINTER(node) IDENTIFIER_POINTER(DECL_NAME(node))
 #define DECL_NAME_LENGTH(node) IDENTIFIER_LENGTH(DECL_NAME(node))

>  HOSTLLD -shared scripts/gcc-plugins/arm_ssp_per_task_plugin.so - due to target missing
> Undefined symbols for architecture x86_64:
>  "gen_reg_rtx(machine_mode)", referenced from:
>      (anonymous namespace)::arm_pertask_ssp_rtl_pass::execute() in arm_ssp_per_task_plugin.o

However, this part sounds more like what was fixed with
259799ea5a9a ("gcc-plugins: arm_ssp_per_task_plugin: Fix for older GCC < 6")

And maybe some additional fixes for 4.9 are needed?

> This is because CONFIG_GCC_PLUGIN_ARM_SSP_PER_TASK became automatically enabled and was never
> before. So the compiler may lack some library search path for building this plugin (which we
> did never miss).

Right -- maybe CONFIG_STACKPROTECTOR_PER_TASK doesn't work with old gcc
4.9.2? I'll see if I can find that compiler version...

-- 
Kees Cook
