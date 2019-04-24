Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6A2C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EF8C21773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbfDXOMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:12:23 -0400
Received: from muru.com ([72.249.23.125]:47102 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727377AbfDXOMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:12:22 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 13E6C8102;
        Wed, 24 Apr 2019 14:12:36 +0000 (UTC)
Date:   Wed, 24 Apr 2019 07:12:17 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Stefan Agner <stefan@agner.ch>
Cc:     arnd@arndb.de, arm@kernel.org, linux@armlinux.org.uk,
        ard.biesheuvel@linaro.org, robin.murphy@arm.com,
        nicolas.pitre@linaro.org, f.fainelli@gmail.com, rjui@broadcom.com,
        sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        kgene@kernel.org, krzk@kernel.org, robh@kernel.org,
        ssantosh@kernel.org, jason@lakedaemon.net, andrew@lunn.ch,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        marc.w.gonzalez@free.fr, mans@mansr.com, ndesaulniers@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] ARM: use arch_extension directive instead of arch
 argument
Message-ID: <20190424141217.GC8007@atomide.com>
References: <f48c245e7e2b432f6771a5f97ff9f4b5bedc5089.1554968922.git.stefan@agner.ch>
 <2f3d0fa7ba599f46960ad3e7419477fd@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f3d0fa7ba599f46960ad3e7419477fd@agner.ch>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Stefan Agner <stefan@agner.ch> [190423 20:20]:
> On 11.04.2019 09:54, Stefan Agner wrote:
> > The LLVM Target parser currently does not allow to specify the security
> > extension as part of -march (see also LLVM Bug 40186 [0]). When trying
> > to use Clang with LLVM's integrated assembler, this leads to build
> > errors such as this:
> >   clang-8: error: the clang compiler does not support '-Wa,-march=armv7-a+sec'
> > 
> > Use ".arch_extension sec" to enable the security extension in a more
> > portable fasion. Also make sure to use ".arch armv7-a" in case a v6/v7
> > multi-platform kernel is being built.
> > 
> > Note that this is technically not exactly the same as the old code
> > checked for availabilty of the security extension by calling as-instr.
> > However, there are already other sites which use ".arch_extension sec"
> > unconditionally, hence de-facto we need an assembler capable of
> > ".arch_extension sec" already today (arch/arm/mm/proc-v7.S). The
> > arch extension "sec" is available since binutils 2.21 according to
> > its documentation [1].
> > 
> > [0] https://bugs.llvm.org/show_bug.cgi?id=40186
> > [1] https://sourceware.org/binutils/docs-2.21/as/ARM-Options.html
> > 
> > Signed-off-by: Stefan Agner <stefan@agner.ch>
> > Acked-by: Mans Rullgard <mans@mansr.com>
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> Arnd, Tony,
> 
> Patch 3 and 4 got merged by Gregory. I think the other two patches are
> ready to be merged too. I think they should go in together to avoid
> merge conflicts. Tony, if you agree, can you Ack patch 2 so they can get
> merged through arm-soc?

Sure I just acked it for you.

Thanks,

Tony
