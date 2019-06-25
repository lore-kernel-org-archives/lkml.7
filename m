Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D693DC48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 14:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF21A2133F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 14:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="pNb4rfKc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730545AbfFYO2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 10:28:10 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41257 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729336AbfFYO2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 10:28:09 -0400
Received: by mail-qk1-f195.google.com with SMTP id c11so12738022qkk.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 07:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fZTSDA7Jm88O6VnwanikoTP6YNbKCMJ8649VNWkEmCA=;
        b=pNb4rfKcGRZeJnFUsfnXdhWA4zo3p+5+Aqc15gwpsJzcb88+TdhNtQHB7/JFqvk+be
         6BmDnzabEpDbh0BryRV18XSQSef7ncqNOVoirX/Pmr6jAKfksORHaVrSmHnKXsTSHnh7
         +uSavj8Vy6/gyC5j0arhGmWI8GtuC+FOxixyTyKgMGRjUj6hl9Kjvcf9/ShYuN5z5QxX
         0t8SV6BU9KQKncGPMT+F5j2dL+tkQhOcMmZ94pmoLg/EnOdcE7gwWAuGS+LpiiV+vKSA
         KhLkCYfW5LAmodi8RmnPs8D9uXgQoU4/cdfuFH08O/10crjGEl2nGBpJBeZKg5FircKB
         LVmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fZTSDA7Jm88O6VnwanikoTP6YNbKCMJ8649VNWkEmCA=;
        b=UhLBGvTUgG67+0J5eTn7HOW5OtNKbR7mV5SaN6wEh2YDHBOe2AxhoVhq8/oQwnf8fb
         zLIZhaagBWn25cMNc3cxAvQwQ7gBic5+mcILnaj+7mCp7aMha9L7vSKKHvO9lS5EiUa4
         B1ZKpKq4O/rLZgi7Xww4a45Hvu9gobd8pGY4TmaJyMCWEFom7xfxEjvdvvGtQlumNjvh
         g08u1epJqj/UiEORiyDlYUgfexCUiso95idbPJH+snnBXCNUAwIZFpehKbd+aBtbFl5t
         hKVRH8pouhrCd+98V0DPQ8AwOYTUsAcObEE7v1kzDK4KdhExQDJl9vuMHcLZny5Uv8qf
         W6pA==
X-Gm-Message-State: APjAAAXtgP+Ss7fcKf1RVtMql7LdacPjq2Rhf4mDlcBl93+VVWWA5j8d
        DhFw5N7ZRknHXHk8QtIAW7NysA==
X-Google-Smtp-Source: APXvYqzJwQVO95DigbWp2E0NeIqdMZbB34f+lQDS3CeMLe+WRHPUtwCWF+FX4mfgesfZTyf15w1UEQ==
X-Received: by 2002:a37:4d06:: with SMTP id a6mr2250109qkb.298.1561472888897;
        Tue, 25 Jun 2019 07:28:08 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id d26sm6923857qkl.97.2019.06.25.07.28.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 07:28:08 -0700 (PDT)
Message-ID: <1561472887.5154.72.camel@lca.pw>
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
Date:   Tue, 25 Jun 2019 10:28:07 -0400
In-Reply-To: <5113362e-1256-6712-6ce8-9599b1806cf1@arm.com>
References: <1561464964.5154.63.camel@lca.pw>
         <e86774e4-7470-5cb2-fc3e-b7c1f529d253@arm.com>
         <1561467369.5154.67.camel@lca.pw>
         <00a78980-6b9c-5d5b-ed01-b28bb34be022@arm.com>
         <1561470705.5154.68.camel@lca.pw>
         <5113362e-1256-6712-6ce8-9599b1806cf1@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-06-25 at 15:11 +0100, Vincenzo Frascino wrote:
> Hi Qian,
> 
> On 25/06/2019 14:51, Qian Cai wrote:
> > On Tue, 2019-06-25 at 14:40 +0100, Vincenzo Frascino wrote:
> > > On 25/06/2019 13:56, Qian Cai wrote:
> > > > On Tue, 2019-06-25 at 13:47 +0100, Vincenzo Frascino wrote:
> > > > > Hi Qian,
> > > > > 
> > > > > On 25/06/2019 13:16, Qian Cai wrote:
> > > > > > The linux-next commit "arm64: vdso: Substitute gettimeofday() with C
> > > > > > implementation" [1] breaks clang build.
> > > > > > 
> > > > > > error: invalid value 'tiny' in '-mcode-model tiny'
> > > > > > make[1]: *** [scripts/Makefile.build:279:
> > > > > > arch/arm64/kernel/vdso/vgettimeofday.o] Error 1
> > > > > > make[1]: *** Waiting for unfinished jobs....
> > > > > > make: *** [arch/arm64/Makefile:180: vdso_prepare] Error 2
> > > > > > 
> > > > > > [1] https://patchwork.kernel.org/patch/11009663/
> > > > > > 
> > > > > 
> > > > > I am not sure what does exactly break from your report. Could you
> > > > > please
> > > > > provide
> > > > > more details?
> > > > 
> > > > Here is the config to reproduce.
> > > > 
> > > > https://raw.githubusercontent.com/cailca/linux-mm/master/arm64.config
> > > > 
> > > > # make CC=clang -j $(nr_cpus)
> > > > 
> > > > I can get it working again by removing "-mcmodel=tiny" in
> > > > arch/arm64/kernel/vdso/Makefile
> > > > 
> > > 
> > > With your defconfig I can't still reproduce the problem. Which version of
> > > clang
> > > are you using?
> > 
> > Compiler: clang version 7.0.1 (tags/RELEASE_701/final)
> > 
> 
> I am using clang 8.0.0. Could you please try with it and see if the issue goes
> away?

Looks like the "tiny" was added since clang 8.0.

https://reviews.llvm.org/D49674

but clang 7.0 is still use in many distros by default, so maybe this commit can
be fixed by adding a conditional check to use "small" if clang version < 8.0.

> 
> Thanks,
> Vincenzo
> 
> > > 
> > > > > 
> > > > > On my env:
> > > > > 
> > > > > $ make mrproper && make defconfig && make CC=clang HOSTCC=clang
> > > > > -j$(nproc)
> > > > > 
> > > > > ...
> > > > > 
> > > > > arch/arm64/Makefile:56: CROSS_COMPILE_COMPAT is clang, the compat vDSO
> > > > > will
> > > > > not
> > > > > be built
> > > > > 
> > > > > ...
> > > > > 
> > > > >   LDS     arch/arm64/kernel/vdso/vdso.lds
> > > > >   AS      arch/arm64/kernel/vdso/note.o
> > > > >   AS      arch/arm64/kernel/vdso/sigreturn.o
> > > > >   CC      arch/arm64/kernel/vdso/vgettimeofday.o
> > > > >   LD      arch/arm64/kernel/vdso/vdso.so.dbg
> > > > >   VDSOCHK arch/arm64/kernel/vdso/vdso.so.dbg
> > > > >   VDSOSYM include/generated/vdso-offsets.h
> > > > > 
> > > > > ...
> > > > > 
> > > > >   LD      vmlinux.o
> > > > >   MODPOST vmlinux.o
> > > > >   MODINFO modules.builtin.modinfo
> > > > >   KSYM    .tmp_kallsyms1.o
> > > > >   KSYM    .tmp_kallsyms2.o
> > > > >   LD      vmlinux
> > > > >   SORTEX  vmlinux
> > > > >   SYSMAP  System.map
> > > > >   Building modules, stage 2.
> > > > >   OBJCOPY arch/arm64/boot/Image
> > > > >   MODPOST 483 modules
> > > > > 
> > > 
> > > 
> 
> 
