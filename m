Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6BAC48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 15:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A0052133F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 15:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="L9rn1V1S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732112AbfFYPRA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 11:17:00 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38464 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727485AbfFYPQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 11:16:59 -0400
Received: by mail-qk1-f194.google.com with SMTP id a27so12891367qkk.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 08:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4NtvWmE4JrZ5FShx6nRTt/UCFafrN+BqsW/lJlIwCwg=;
        b=L9rn1V1SG1l89CErBx/QIzYnWlycNIruF8cBoWG/I7PEdg3z5VU7d0DgoZe37hYsdu
         nuZeQQsxa0XI4WKzqjv+x4MeQnFneAT7WMuMT7VvAo30V0sd7icWLYuxRy4WnVsOLTBV
         gorl3Awk05rjv25Ig6snqGbQCayG0MoGPzRWmNEnpJQ6b8iwWoj5oltqGOCFe5hgo753
         Wxv5oX+ciJ9y0bcx+eVXRzc0HBphP9tuvzDw3tQOt2gDSE32cxYVs9LUNC7qaa25840c
         lhoOgYojT9eADOcLnJTqIO0J39WqClORBz4KRjHfYSclB7c04kd8cbun2KLDuJKagIRL
         00WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4NtvWmE4JrZ5FShx6nRTt/UCFafrN+BqsW/lJlIwCwg=;
        b=M4CK3KQsbWAu/FxarTjrDsPcJaTswVT9ICx0C3Vz24HR5I5wKAuEMfYw7OyxzYhC5M
         XdSQOB29bG3zBm/2kFFsl4NN8N3ShQ3swNqqHZdbTGuaqrrXwL/8bxLFGXL89HE8qib/
         XnODLCfBAPKTjmk6jXvURe9DcW1lLfj6m/AFTrnrfkpUmz3heq1lpkUdqgCD8qvr0eK6
         T2XWjExrUF18rRdjoS8j2A4J1xPRtx00QDw9rbW3r86dbR+mc6TaaFEvz6nSGS1CWrQb
         WRI2eWQrP8ZMsUNkRPSH3QnSRAJdWfpkX0zKxqthvIhLoA84tWUMcyzwZZBI8nNrQbxx
         O+7g==
X-Gm-Message-State: APjAAAV4TaQTlWOwzfBZU3fr35qIom8R6T91rhozFwTULOZ31Qu/5T6A
        3SOwXzIvQgN7gpO3dfBQPk6HCA==
X-Google-Smtp-Source: APXvYqwAuZMz53yNfyz8jpAMbNiqXkFJrTHz4aJO4jGKE1byxnKGVeNd4q+/3ws+yFco2KAJ2jSxkQ==
X-Received: by 2002:a37:ef18:: with SMTP id j24mr126326340qkk.293.1561475818759;
        Tue, 25 Jun 2019 08:16:58 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 16sm6911532qkl.100.2019.06.25.08.16.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 08:16:58 -0700 (PDT)
Message-ID: <1561475816.5154.75.camel@lca.pw>
Subject: Re: "arm64: vdso: Substitute gettimeofday() with C implementation"
 breaks clang build
From:   Qian Cai <cai@lca.pw>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        natechancellor@gmail.com, ndesaulniers@google.com
Date:   Tue, 25 Jun 2019 11:16:56 -0400
In-Reply-To: <668bbe72-b32b-8cee-ccad-d1f6110c6728@arm.com>
References: <1561464964.5154.63.camel@lca.pw>
         <e86774e4-7470-5cb2-fc3e-b7c1f529d253@arm.com>
         <1561467369.5154.67.camel@lca.pw>
         <00a78980-6b9c-5d5b-ed01-b28bb34be022@arm.com>
         <1561470705.5154.68.camel@lca.pw>
         <5113362e-1256-6712-6ce8-9599b1806cf1@arm.com>
         <1561472887.5154.72.camel@lca.pw>
         <668bbe72-b32b-8cee-ccad-d1f6110c6728@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-06-25 at 15:54 +0100, Vincenzo Frascino wrote:
> Hi Qian,
> 
> ...
> 
> > 
> > but clang 7.0 is still use in many distros by default, so maybe this commit
> > can
> > be fixed by adding a conditional check to use "small" if clang version <
> > 8.0.
> > 
> 
> Could you please verify that the patch below works for you?
> 
> Thanks,
> Vincenzo
> 
> --->8----
> 

It does not work unfortunately.

# make CC=clang -j 256 2>/tmp/warn3.txt
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/dtc/dtc.o
  HOSTCC  scripts/dtc/flattree.o
  HOSTCC  scripts/dtc/fstree.o
  HOSTCC  scripts/dtc/data.o
  HOSTCC  scripts/dtc/livetree.o
  HOSTCC  scripts/dtc/treesource.o
  HOSTCC  scripts/dtc/srcpos.o
  HOSTCC  scripts/dtc/checks.o
  HOSTCC  scripts/dtc/util.o
  LEX     scripts/dtc/dtc-lexer.lex.c
  YACC    scripts/dtc/dtc-parser.tab.h
  YACC    scripts/dtc/dtc-parser.tab.c
  HOSTCC  scripts/dtc/dtc-parser.tab.o
  HOSTCC  scripts/dtc/dtc-lexer.lex.o
  HOSTLD  scripts/dtc/dtc
  HOSTCC  scripts/kallsyms
  HOSTCC  scripts/recordmcount
  HOSTCC  scripts/sortextable
  DTC     arch/arm64/boot/dts/arm/foundation-v8.dtb
  DTC     arch/arm64/boot/dts/arm/foundation-v8-psci.dtb
  DTC     arch/arm64/boot/dts/arm/foundation-v8-gicv3.dtb
  DTC     arch/arm64/boot/dts/arm/foundation-v8-gicv3-psci.dtb
  DTC     arch/arm64/boot/dts/arm/juno.dtb
  DTC     arch/arm64/boot/dts/arm/juno-r1.dtb
  DTC     arch/arm64/boot/dts/arm/juno-r2.dtb
  DTC     arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dtb
  DTC     arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dtb
  DTC     arch/arm64/boot/dts/arm/fvp-base-revc.dtb
  DTC     arch/arm64/boot/dts/cavium/thunder2-99xx.dtb
  DTC     arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dtb
  DTC     arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dtb
  DTC     arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dtb
  DTC     arch/arm64/boot/dts/hisilicon/hi6220-hikey.dtb
  DTC     arch/arm64/boot/dts/hisilicon/hip05-d02.dtb
  DTC     arch/arm64/boot/dts/hisilicon/hip06-d03.dtb
  DTC     arch/arm64/boot/dts/hisilicon/hip07-d05.dtb
  HOSTCC  scripts/mod/mk_elfconfig
  CC      scripts/mod/devicetable-offsets.s
  CC      scripts/mod/empty.o
  MKELF   scripts/mod/elfconfig.h
  HOSTCC  scripts/mod/modpost.o
  HOSTCC  scripts/mod/file2alias.o
  HOSTCC  scripts/mod/sumversion.o
  HOSTLD  scripts/mod/modpost
  CC      kernel/bounds.s
  CALL    scripts/atomic/check-atomics.sh
  CC      arch/arm64/kernel/asm-offsets.s
  CALL    scripts/checksyscalls.sh
  LDS     arch/arm64/kernel/vdso/vdso.lds
  AS      arch/arm64/kernel/vdso/note.o
  AS      arch/arm64/kernel/vdso/sigreturn.o
  CC      arch/arm64/kernel/vdso/vgettimeofday.o
  LD      arch/arm64/kernel/vdso/vdso.so.dbg
  VDSOCHK arch/arm64/kernel/vdso/vdso.so.dbg
00000000000009d0 R_AARCH64_JUMP_SLOT  _mcount

arch/arm64/kernel/vdso/vdso.so.dbg: dynamic relocations are not supported
make[1]: *** [arch/arm64/kernel/vdso/Makefile:59:
arch/arm64/kernel/vdso/vdso.so.dbg] Error 1
make: *** [arch/arm64/Makefile:180: vdso_prepare] Error 2

