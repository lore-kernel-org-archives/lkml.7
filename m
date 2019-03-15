Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F360DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 21:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8BEB21871
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 21:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfCOVEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 17:04:02 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45116 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfCOVEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 17:04:01 -0400
Received: by mail-qk1-f193.google.com with SMTP id z76so6373560qkb.12;
        Fri, 15 Mar 2019 14:04:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LPgywXAI2USLfwsIGf4EsTgHNdAQM/NZddlktBZmI8A=;
        b=b8n4JHBibw/VihF2ejEJHJzq5ZbgToGyXVvdU8To3I7W6fadL62FsmJtAhg1q3AuaP
         QBBUPaCiYNReqsfT6mpYbOEJeBr0d7aBNeFVT9Wo1M/C94O+xsDrkv74Z9+kynkagUtW
         20lJK2WROka+fR9qPnPE+rWERty3JfdVyqoF6NabpuWy0LUp0sBz18RzR3pwjVT1Xcb4
         p64Rp6lRgi+u5bBlINU3Pi6wFKQ9CkbGimG9RUxZFaD8XGdj1HYs8kofg5i2hdCOmRPd
         r68qUoRdijuA0+xt4QSiDheFm6TYKsTXJ3ezX6kxgnHmkSQ6tyN+7AL3vQ9tIBw9wt7G
         SB7A==
X-Gm-Message-State: APjAAAWjB0IOy0WSim4wFP76Hb20cr56UR2l941kNoA65KSBFUP7bz3U
        HjiqbeoLspcJWIxbPl2sZEc44w/yBJlAfq4RC3oxGQ==
X-Google-Smtp-Source: APXvYqxSEEOekYuksufJGob6hv4NC5TWRfMJOG66mQMs4bVAu8faWYC+yUGzY9zHAR3C+Ij4rL53DUecSJE9pRKGPoU=
X-Received: by 2002:ae9:e10d:: with SMTP id g13mr4241441qkm.343.1552683840781;
 Fri, 15 Mar 2019 14:04:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a3MV=0BbOpjwM+2q+7Oehc=4B+u0hka1YdBnJmikfqCig@mail.gmail.com>
 <20190313230137.GA12529@agluck-desk> <CAK8P3a0aDdEt323i=z4BGuh71ntPqm-L33U4q+FiQOdMUin6wg@mail.gmail.com>
 <20190314110413.GA32277@zn.tnic> <20190314215952.GA303@agluck-desk>
 <20190315094341.GA12523@zn.tnic> <20190315155718.GA17775@agluck-desk>
 <20190315173720.GC12523@zn.tnic> <20190315174956.GA20831@agluck-desk>
 <20190315180206.GD12523@zn.tnic> <20190315181108.GA21111@agluck-desk>
In-Reply-To: <20190315181108.GA21111@agluck-desk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 15 Mar 2019 22:03:43 +0100
Message-ID: <CAK8P3a2CFyF5wExbZPb20E56sJ=3DpsP+0m2Px6D5Sw_L3pKXA@mail.gmail.com>
Subject: Re: [PATCH] EDAC, {skx|i10nm}_edac: Fix randconfig build error
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>, linux-edac@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 7:11 PM Luck, Tony <tony.luck@intel.com> wrote:
>
> On Fri, Mar 15, 2019 at 07:02:06PM +0100, Borislav Petkov wrote:
> > On Fri, Mar 15, 2019 at 10:49:56AM -0700, Luck, Tony wrote:
> > > Yes - Qiuxu did that already ... patch reposted below.
> >
> > ... to which Arnd said that it were fragile because it might break if it
> > includes a THIS_MODULE reference. So I'd say we won't do that then. And
> > keep it strictly a library.
> >
> > Right?
>
> What is your definition of "library"?
>
> fsl_ddr_edac.c seems to have the same potential for breakage
> if someone makes a change to that, then it will hit the same
> problem.

I think they are a bit safer because CONFIG_EDAC_LAYERSCAPE and
CONFIG_EDAC_MPC85XX are mutually exclusive (one is only
on powerpc, the other is only on ARM). It would break though if
one were to make them build with CONFIG_COMPILE_TEST,
or if another driver gets added that for ARM.

I just thought about a possible Kconfig solution some more, and
had this idea:

diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 47eb4d13ed5f..70080926329f 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -235,6 +235,7 @@ config EDAC_SKX
        depends on ACPI_NFIT || !ACPI_NFIT # if ACPI_NFIT=m, EDAC_SKX can't be y
        select DMI
        select ACPI_ADXL
+       select EDAC_SKX_COMMON
        help
          Support for error detection and correction the Intel
          Skylake server Integrated Memory Controllers. If your
@@ -247,12 +248,20 @@ config EDAC_I10NM
        depends on ACPI_NFIT || !ACPI_NFIT # if ACPI_NFIT=m,
EDAC_I10NM can't be y
        select DMI
        select ACPI_ADXL
+       select EDAC_SKX_COMMON
        help
          Support for error detection and correction the Intel
          10nm server Integrated Memory Controllers. If your
          system has non-volatile DIMMs you should also manually
          select CONFIG_ACPI_NFIT.

+config EDAC_SKX_COMMON
+       tristate
+       help
+         This is an internal helper symbol to ensure that all variants
+         of the EDAC_SKX driver are either built-in or modular, as mixing
+         the two causes link time problems.
+
 config EDAC_PND2
        tristate "Intel Pondicherry2"
        depends on PCI && X86_64 && X86_MCE_INTEL
diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index 89ad4a84a0f6..01134051f5bf 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -58,10 +58,14 @@ layerscape_edac_mod-y                       :=
fsl_ddr_edac.o layerscape_edac.o
 obj-$(CONFIG_EDAC_LAYERSCAPE)          += layerscape_edac_mod.o

 skx_edac-y                             := skx_common.o skx_base.o
-obj-$(CONFIG_EDAC_SKX)                 += skx_edac.o
+ifdef CONFIG_EDAC_SKX
+obj-$(CONFIG_EDAC_SKX_COMMON)          += skx_edac.o
+endif

 i10nm_edac-y                           := skx_common.o i10nm_base.o
+ifdef CONFIG_EDAC_I10NM
 obj-$(CONFIG_EDAC_SKX_COMMON)           += i10nm_edac.o
+endif

 obj-$(CONFIG_EDAC_MV64X60)             += mv64x60_edac.o
 obj-$(CONFIG_EDAC_CELL)                        += cell_edac.o

Basically I cheat Kconfig, so if one driver is built-in and
the other is a loadable module, we compile both as built-in.


        Arnd
