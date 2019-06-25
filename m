Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5074C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 12:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA8A42085A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 12:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="DZuLEnT0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729794AbfFYM4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 08:56:12 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35225 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbfFYM4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 08:56:11 -0400
Received: by mail-qk1-f195.google.com with SMTP id l128so12456889qke.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 05:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OurFPUo7gnihcYVub8SOQDvfLe3fR+6xdFiBUG/mGaU=;
        b=DZuLEnT0c3Anyy8jegKUBD1pB5R05zrrm6Hg1/EXMvo2Azh30aWlDVwzQ+RXchLRx4
         iC/YEH+9byL2b7UGpVIjBWH8xW/ZF3FPppaGwX4xwZn4cyZQAmeTD7xSQKyzUznHunVi
         5u+9r26kvl7UvtOw7HersgYkGjYPuhz+17TPW4xuKu47wTkBHPGGXaxe+sIVSE+ccI1Y
         Mca+ACVEJ5t1XQ2X7BDriCe3dTn7ZfiFxnlGjBD+nX/wcGAbV6ay2T28Sff6M3Zn3npM
         2Df0OM/lpjKtZxhLZeisUM3a5HsKxUjS8ix42mJ2sSIsulPxOBiAlsdIFQUFVnkRwn1k
         FRTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OurFPUo7gnihcYVub8SOQDvfLe3fR+6xdFiBUG/mGaU=;
        b=Rj00L3Re9s2B9B0shFHgOXRkE2dpEhKjphhJiKTuS0lzIORy7kceMuor5UJu3hVlia
         k+JEZAKhuWIjmAUyzhjIWiaBVFH1PlwS3v2EtTy4lnofqBXHls183KcMqJb0OdasGOIB
         FqJZX7dqw6r5IZmyZcQJ/Gy9phA0A0jVACs4fHXow3JvqVigBkkp54XW2xubloQEqbGm
         mIKqYA4NMTLJm8d8pnPAQyVnU8MjulKLy9Sxh0mUdy95w+WY4q773Rd/Z0uiRc55mld4
         BwbZQIl+DUqcDSA70zFCQkiykmJ8fWKyXuIQcyG/M2jC4yZKjOOKTAagWOjbCLyZQm8Y
         MLQQ==
X-Gm-Message-State: APjAAAUuijSJF4PLf/7b/qIY5Zei4B/3eqiDOyJjo28l96kTAsgmFNhV
        WzVNpTNWhY18zbGNOM1929WEfA==
X-Google-Smtp-Source: APXvYqwWcl7FHe5Q6JvWZnREmdhAYa+kjEanHdiJYtr/n0jOQquCki6IOPDpMJhUz8kj9KvU+BHsIA==
X-Received: by 2002:a05:620a:15c9:: with SMTP id o9mr84310245qkm.195.1561467371037;
        Tue, 25 Jun 2019 05:56:11 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id s130sm6740825qke.104.2019.06.25.05.56.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 05:56:10 -0700 (PDT)
Message-ID: <1561467369.5154.67.camel@lca.pw>
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
Date:   Tue, 25 Jun 2019 08:56:09 -0400
In-Reply-To: <e86774e4-7470-5cb2-fc3e-b7c1f529d253@arm.com>
References: <1561464964.5154.63.camel@lca.pw>
         <e86774e4-7470-5cb2-fc3e-b7c1f529d253@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-06-25 at 13:47 +0100, Vincenzo Frascino wrote:
> Hi Qian,
> 
> On 25/06/2019 13:16, Qian Cai wrote:
> > The linux-next commit "arm64: vdso: Substitute gettimeofday() with C
> > implementation" [1] breaks clang build.
> > 
> > error: invalid value 'tiny' in '-mcode-model tiny'
> > make[1]: *** [scripts/Makefile.build:279:
> > arch/arm64/kernel/vdso/vgettimeofday.o] Error 1
> > make[1]: *** Waiting for unfinished jobs....
> > make: *** [arch/arm64/Makefile:180: vdso_prepare] Error 2
> > 
> > [1] https://patchwork.kernel.org/patch/11009663/
> > 
> 
> I am not sure what does exactly break from your report. Could you please
> provide
> more details?

Here is the config to reproduce.

https://raw.githubusercontent.com/cailca/linux-mm/master/arm64.config

# make CC=clang -j $(nr_cpus)

I can get it working again by removing "-mcmodel=tiny" in
arch/arm64/kernel/vdso/Makefile

> 
> On my env:
> 
> $ make mrproper && make defconfig && make CC=clang HOSTCC=clang -j$(nproc)
> 
> ...
> 
> arch/arm64/Makefile:56: CROSS_COMPILE_COMPAT is clang, the compat vDSO will
> not
> be built
> 
> ...
> 
>   LDS     arch/arm64/kernel/vdso/vdso.lds
>   AS      arch/arm64/kernel/vdso/note.o
>   AS      arch/arm64/kernel/vdso/sigreturn.o
>   CC      arch/arm64/kernel/vdso/vgettimeofday.o
>   LD      arch/arm64/kernel/vdso/vdso.so.dbg
>   VDSOCHK arch/arm64/kernel/vdso/vdso.so.dbg
>   VDSOSYM include/generated/vdso-offsets.h
> 
> ...
> 
>   LD      vmlinux.o
>   MODPOST vmlinux.o
>   MODINFO modules.builtin.modinfo
>   KSYM    .tmp_kallsyms1.o
>   KSYM    .tmp_kallsyms2.o
>   LD      vmlinux
>   SORTEX  vmlinux
>   SYSMAP  System.map
>   Building modules, stage 2.
>   OBJCOPY arch/arm64/boot/Image
>   MODPOST 483 modules
> 
