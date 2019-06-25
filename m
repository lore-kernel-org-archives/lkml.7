Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABE0C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 12:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD81E208CA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 12:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731748AbfFYMrc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 08:47:32 -0400
Received: from foss.arm.com ([217.140.110.172]:41102 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727217AbfFYMrc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 08:47:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D9B02B;
        Tue, 25 Jun 2019 05:47:31 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B20B3F71E;
        Tue, 25 Jun 2019 05:47:30 -0700 (PDT)
Subject: Re: "arm64: vdso: Substitute gettimeofday() with C implementation"
 breaks clang build
To:     Qian Cai <cai@lca.pw>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1561464964.5154.63.camel@lca.pw>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <e86774e4-7470-5cb2-fc3e-b7c1f529d253@arm.com>
Date:   Tue, 25 Jun 2019 13:47:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1561464964.5154.63.camel@lca.pw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qian,

On 25/06/2019 13:16, Qian Cai wrote:
> The linux-next commit "arm64: vdso: Substitute gettimeofday() with C
> implementation" [1] breaks clang build.
> 
> error: invalid value 'tiny' in '-mcode-model tiny'
> make[1]: *** [scripts/Makefile.build:279:
> arch/arm64/kernel/vdso/vgettimeofday.o] Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [arch/arm64/Makefile:180: vdso_prepare] Error 2
> 
> [1] https://patchwork.kernel.org/patch/11009663/
> 

I am not sure what does exactly break from your report. Could you please provide
more details?

On my env:

$ make mrproper && make defconfig && make CC=clang HOSTCC=clang -j$(nproc)

...

arch/arm64/Makefile:56: CROSS_COMPILE_COMPAT is clang, the compat vDSO will not
be built

...

  LDS     arch/arm64/kernel/vdso/vdso.lds
  AS      arch/arm64/kernel/vdso/note.o
  AS      arch/arm64/kernel/vdso/sigreturn.o
  CC      arch/arm64/kernel/vdso/vgettimeofday.o
  LD      arch/arm64/kernel/vdso/vdso.so.dbg
  VDSOCHK arch/arm64/kernel/vdso/vdso.so.dbg
  VDSOSYM include/generated/vdso-offsets.h

...

  LD      vmlinux.o
  MODPOST vmlinux.o
  MODINFO modules.builtin.modinfo
  KSYM    .tmp_kallsyms1.o
  KSYM    .tmp_kallsyms2.o
  LD      vmlinux
  SORTEX  vmlinux
  SYSMAP  System.map
  Building modules, stage 2.
  OBJCOPY arch/arm64/boot/Image
  MODPOST 483 modules

-- 
Regards,
Vincenzo
