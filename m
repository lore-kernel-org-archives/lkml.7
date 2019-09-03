Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8421C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 18:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85AC122CED
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 18:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OyE3pxgc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbfICSsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 14:48:23 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46254 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfICSsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 14:48:23 -0400
Received: by mail-pf1-f196.google.com with SMTP id q5so3463855pfg.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 11:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IEYeijqNBx8FKsQCqztccyibS69/cramAhDtz2iOU7k=;
        b=OyE3pxgc7aeDvUAkSmCMjkF82tfwOvEd6uR6WwP8Y27TMiWd6UxOGWlzMn+hdx4Lyv
         rpIVbvfseTf6gbuZaAzdJniutKEjgVfg09dgi50K11LcjfEFIwdURoBmHyOkKq1ZsQDD
         vMZsxocGWcH2DwAMUDoMsv+Sj+8jZ8ecnR1Dw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IEYeijqNBx8FKsQCqztccyibS69/cramAhDtz2iOU7k=;
        b=CCZ8ukH4pSwRLLyL5S1ut4zfAITz9gfH811X/Oaj1Ovb5MGFEg6RVfPZfQ4IDNLwPH
         XbAuI35miwSoj9VTjjbKQLyeWWSyhuZoZmHJxsCTtkUmBPHfC5pUej3ZvrmifedVymOd
         5fTQBTfsxaQy7qv+H3BUGxcSD9SCeOeM4+VK3ad+GWTlXWc7hK4+/gxm/AHLVZE4zhXt
         nd9Y3XoDUPzIZ9knn740blMQ/cUvxNJmYuZoFmoQZOaiBQ82ozmOfifosAzK0kF8/tOV
         m+k4CCKfJNVfTVwVaJRZozV7jtEUCal3YsGd9KFKtdaN2lPq19UHGT18JGRpNmNUUEW2
         J6hQ==
X-Gm-Message-State: APjAAAWT5/epLrqG9mJ8iE12cif1GDWQ9WYYmGnZmfZmYy0WVA6aVDcM
        JKq2s0oxkPNpef89sZGOEmG3Jg==
X-Google-Smtp-Source: APXvYqzX++xeelL0zbZVBt9i8AsSwDpC4wmYT9xqvVJMc0+k+GzPp/aiQiH3XMrvni+m2rj6xGSltg==
X-Received: by 2002:a63:1310:: with SMTP id i16mr31163370pgl.187.1567536502419;
        Tue, 03 Sep 2019 11:48:22 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id q4sm6220900pfh.115.2019.09.03.11.48.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2019 11:48:21 -0700 (PDT)
Date:   Tue, 3 Sep 2019 11:48:16 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH v2] ARM: Emit __gnu_mcount_nc when using Clang 10.0.0 or
 newer
Message-ID: <20190903184816.GF70797@google.com>
References: <20190829062635.45609-1-natechancellor@gmail.com>
 <20190831060530.43082-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190831060530.43082-1-natechancellor@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 11:05:31PM -0700, Nathan Chancellor wrote:
> Currently, multi_v7_defconfig + CONFIG_FUNCTION_TRACER fails to build
> with clang:
> 
> arm-linux-gnueabi-ld: kernel/softirq.o: in function `_local_bh_enable':
> softirq.c:(.text+0x504): undefined reference to `mcount'
> arm-linux-gnueabi-ld: kernel/softirq.o: in function `__local_bh_enable_ip':
> softirq.c:(.text+0x58c): undefined reference to `mcount'
> arm-linux-gnueabi-ld: kernel/softirq.o: in function `do_softirq':
> softirq.c:(.text+0x6c8): undefined reference to `mcount'
> arm-linux-gnueabi-ld: kernel/softirq.o: in function `irq_enter':
> softirq.c:(.text+0x75c): undefined reference to `mcount'
> arm-linux-gnueabi-ld: kernel/softirq.o: in function `irq_exit':
> softirq.c:(.text+0x840): undefined reference to `mcount'
> arm-linux-gnueabi-ld: kernel/softirq.o:softirq.c:(.text+0xa50): more undefined references to `mcount' follow
> 
> clang can emit a working mcount symbol, __gnu_mcount_nc, when
> '-meabi gnu' is passed to it. Until r369147 in LLVM, this was
> broken and caused the kernel not to boot with '-pg' because the
> calling convention was not correct. Always build with '-meabi gnu'
> when using clang but ensure that '-pg' (which is added with
> CONFIG_FUNCTION_TRACER and its prereq CONFIG_HAVE_FUNCTION_TRACER)
> cannot be added with it unless this is fixed (which means using
> clang 10.0.0 and newer).
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/35
> Link: https://bugs.llvm.org/show_bug.cgi?id=33845
> Link: https://github.com/llvm/llvm-project/commit/16fa8b09702378bacfa3d07081afe6b353b99e60
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Reviewed-by: Stefan Agner <stefan@agner.ch>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
