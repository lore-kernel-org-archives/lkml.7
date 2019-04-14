Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 698E7C10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 10:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38A9B218D3
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 10:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555238833;
	bh=Q/iW8KXrTCP1yOHKTs5MY3WThmjAYJS3G/J6OzgP1gU=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=Is3fqsNsymvWNaVddaa4A8zNezukq0yD6iOOKOqcHEyQAFmDZxzwwzHGisRF6xZT9
	 fgHftv5X6z4cH6v2+k+rs/0a1yfImdH5gUEV4COTVLTU3vfsSwJ4dPDogngLE6K6Dc
	 ZidKPq4rr02DQyQD40SZyHm33Lxqc78cQ6hPKt/c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfDNKrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 06:47:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:60034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725681AbfDNKrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 06:47:11 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDBA220848;
        Sun, 14 Apr 2019 10:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555238830;
        bh=Q/iW8KXrTCP1yOHKTs5MY3WThmjAYJS3G/J6OzgP1gU=;
        h=Date:From:To:Cc:Subject:From;
        b=qJbS/wbQGWOBdCaKCJxZYScVOLgN4Jt3D9ajCo7XIgie97i96TitrUE1sf+eHIbUT
         4/Tmts7nC/wPClRvvZmEek6FTCHKwrfAI8LP7MKrrTjbQVKbx6N7B0q+Kl8/FXQ4Wy
         BTi4E7W5jCG2H/Q1a6W4WsyUIlprXcMmMxOrnpKY=
Date:   Sun, 14 Apr 2019 19:47:05 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Stefan Agner <stefan@agner.ch>, Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Russell King <rmk+kernel@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, naresh.kamboju@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Kconfig dependency issue on function-graph tracer and frame pointer
 on arm
Message-Id: <20190414194705.2e10802aca2df36c8f27f349@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Recently, Naresh reported that the function-graph tracer on the latest
kernel crashes on arm. I could reproduce it and bisected. I finally found
the commit f9b58e8c7d03 ("ARM: 8800/1: use choice for kernel unwinders")
was the first bad commit.

Actually, this commit is just changing Kconfig for making kernel unwinder
choosable. However, as a side effect, this makes CONFIG_FRAME_POINTER=n
by default even if CONFIG_FUNCTION_GRAPH_TRACER=y.
(Note that function-graph tracer implementation on arm depends on
 FRAME_POINTER.)

This seems odd, because the commit introduced below code

+choice
+       prompt "Choose kernel unwinder"
+       default UNWINDER_ARM if AEABI && !FUNCTION_GRAPH_TRACER
+       default UNWINDER_FRAME_POINTER if !AEABI || FUNCTION_GRAPH_TRACER
+       help

So, it seems UNWINDER_FRAME_POINTER is used if FUNCTION_GRAPH_TRACER=y.
However, it seems not working. (I guess this is a wrong syntax for Kconfig)

Moreover, since this just setting default value, there seems no direct
dependency to FRAME_POINTER from FUNCTION_GRAPH_TRACER. I guess user can
change it...

I made a fix below (which I tested). This is ugly (arch specific dependency
in generic part) but works.
It enables both of FRAME_POINTER and UNWINDER_ARM.

However I still have some questions.

- Is above choice+default a correct syntax for Kconfig? (Masahiro?)
- Can UNWINDER_ARM work with FRAME_POINTER? (Arnd?)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 5e3de28c7677..f79c54680f3b 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -160,6 +160,7 @@ config FUNCTION_GRAPH_TRACER
        depends on HAVE_FUNCTION_GRAPH_TRACER
        depends on FUNCTION_TRACER
        depends on !X86_32 || !CC_OPTIMIZE_FOR_SIZE
+       select ARCH_WANT_FRAME_POINTERS if ARM
        default y
        help
          Enable the kernel to trace a function at both its return

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
