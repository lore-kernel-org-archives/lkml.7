Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2ADC10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 13:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FF912084E
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 13:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="HC1f8zfJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbfDNNf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 09:35:29 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:58342 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbfDNNf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 09:35:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XRxwwo7XkDY2FwoD3XpK8KII1drhGl4PvR7q7TcOm7M=; b=HC1f8zfJW6LI6Fn53dl0M7pnm
        O7BYOaGM6Lfxlmuax8ieq09asiLoeF5HPlJkUtvYZFUk5Vw4J3e33IDAh6fvcASx2m3y0CWvUtP6u
        rJT7zd+I4OwU0JftAE3ZLMkDopm96tkdjuAWA6MJ1KKkFjLDWx42djcnAaGSB8Vot9dI9AR0durx3
        YV85kxGwIr6UDreTDwRR7xAJYCh7O4WA36y0V6chSzunmv6YvjaRe2IYqCi6fdqG3I+Cc58PrXlN2
        qVv2/UsfhgNek1VNBGjxBe3bx18O31ZciTKFdZMJL6l/1PT56g/R102IZ/t1SnnBh5rdArniZVL4W
        xLGIqLs9w==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:55456)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1hFfHn-00074U-VQ; Sun, 14 Apr 2019 14:35:08 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1hFfHe-0006em-SF; Sun, 14 Apr 2019 14:34:58 +0100
Date:   Sun, 14 Apr 2019 14:34:58 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Stefan Agner <stefan@agner.ch>, Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-arm-kernel@lists.infradead.org, naresh.kamboju@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: Kconfig dependency issue on function-graph tracer and frame
 pointer on arm
Message-ID: <20190414133458.zxdekgx6qwd562qa@shell.armlinux.org.uk>
References: <20190414194705.2e10802aca2df36c8f27f349@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190414194705.2e10802aca2df36c8f27f349@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 14, 2019 at 07:47:05PM +0900, Masami Hiramatsu wrote:
> Hello,
> 
> Recently, Naresh reported that the function-graph tracer on the latest
> kernel crashes on arm. I could reproduce it and bisected. I finally found
> the commit f9b58e8c7d03 ("ARM: 8800/1: use choice for kernel unwinders")
> was the first bad commit.

I don't think that littering the rest of the kernel Kconfig with ARM
specific stuff is really a viable solution to this.

If we examine the current situation, we have:

- THUMB2_KERNEL selecting ARM_UNWIND when enabled.
- UNWINDER_FRAME_POINTER disabled if THUMB2_KERNEL is enabled, provided
  we're not using Clang.  This leaves UNWINDER_ARM as the only choice,
  which also selects ARM_UNWIND.
- The default choice is dependent on the settings of AEABI and
  FUNCTION_GRAPH_TRACER.
- HAVE_FUNCTION_GRAPH_TRACER is disabled if THUMB2_KERNEL is enabled.

which seems to be _way_ too messy.

Looking back before this commit, the function graph tracer never had a
strong dependence on frame pointers being enabled in the kernel, but it
seems the code relies upon them (see ftrace_return_to_handler() in
kernel/trace/ and return_to_handler in arch/arm/kernel/entry-frace.S).
There is also the __ftrace_graph_caller macro which seems to rely on it.

Since Clang does not support frame pointers, we shouldn't even offer
the function graph tracer for Clang compilers, so let's do that with
the first hunk of the patch below.

The subsequent hunks remove the defaulting of the choice according to
the function graph tracer - this is not a "hint" where the user can
still choose either option irrespective of the state of the function
graph tracer.  They should only be able to select the frame pointer
option in that case.

Another way forward would be for someone to put the work in to making
the function graph tracer work without frame pointers.

So, how about this:

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 850b4805e2d1..9aed25a6019b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -73,7 +73,7 @@ config ARM
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS if (CPU_V6 || CPU_V6K || CPU_V7) && MMU
 	select HAVE_EXIT_THREAD
 	select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
-	select HAVE_FUNCTION_GRAPH_TRACER if !THUMB2_KERNEL
+	select HAVE_FUNCTION_GRAPH_TRACER if !THUMB2_KERNEL && !CC_IS_CLANG
 	select HAVE_FUNCTION_TRACER if !XIP_KERNEL
 	select HAVE_GCC_PLUGINS
 	select HAVE_HW_BREAKPOINT if PERF_EVENTS && (CPU_V6 || CPU_V6K || CPU_V7)
diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 6d6e0330930b..e388af4594a6 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -47,8 +47,8 @@ config DEBUG_WX
 
 choice
 	prompt "Choose kernel unwinder"
-	default UNWINDER_ARM if AEABI && !FUNCTION_GRAPH_TRACER
-	default UNWINDER_FRAME_POINTER if !AEABI || FUNCTION_GRAPH_TRACER
+	default UNWINDER_ARM if AEABI
+	default UNWINDER_FRAME_POINTER if !AEABI
 	help
 	  This determines which method will be used for unwinding kernel stack
 	  traces for panics, oopses, bugs, warnings, perf, /proc/<pid>/stack,
@@ -65,7 +65,7 @@ config UNWINDER_FRAME_POINTER
 
 config UNWINDER_ARM
 	bool "ARM EABI stack unwinder"
-	depends on AEABI
+	depends on AEABI && !FUNCTION_GRAPH_TRACER
 	select ARM_UNWIND
 	help
 	  This option enables stack unwinding support in the kernel

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
