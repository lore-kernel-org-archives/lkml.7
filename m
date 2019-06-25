Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1FEC48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 13:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF30C2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 13:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="WPqJuEaz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbfFYNvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 09:51:48 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36862 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbfFYNvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 09:51:48 -0400
Received: by mail-qt1-f195.google.com with SMTP id p15so18450166qtl.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 06:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wjkKzUFIVPJ1j5aV88KU9VWmlhLQMASp3kVIWO/a6pA=;
        b=WPqJuEazkr5JEFJTFgEo9lRY4Kq9gTotdEE27bIGpXyHnXuDkSKC8LuHNBL6Ypi3bv
         I8fL0UjUwYmZHUFqppz0btsTL01C1gK2GcuKZfCT0ODqMgML06fRgY0M0sj9X9PiJGsg
         bLxZSr6Y6dEI6lYHuxq0kyHSNDTnanI/YuP8iOwviWMNmgjjFtZpP8xxO3xH5Z/F/f+T
         uuy6TBD82zFYDZxdcddV2/FMPxKkYCUI6COsJuSm51tOvDG5+WsAMFbukDLFcpxwlQHK
         jPQtTSp3Ys/zuuCF9nXkwHwJyxWbE8Ffhvmgno2kJ5bvdLHTS7DwoDfvGOltUDgnGLH6
         WdYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wjkKzUFIVPJ1j5aV88KU9VWmlhLQMASp3kVIWO/a6pA=;
        b=rK7qfQT5hFb7epoxW7YdoYjQQTBVe90Dnxjvc7ouACyF3kbpl8N52I5mzoYOBZ9FPi
         OJJkl7QjGmxHiM6czr0sk1S+KrEBOrKFokS3jQC8NJO3AGbxY9BVo80xL09jKHblT5no
         CU6fj2shRFMriZ7ARz0I4tkIlJpXG7LWxVjbetZsokXt6s8jKt+hsLqdI/OT84f5nI+w
         e7X4cL4QFZOHHwnFIZ+UrG8/jBTCum6DJZII6uUoobn6OTTlfrO/j28DngEy0WgbGPyW
         afFNbY3+WS1CrXBz7in1G8HfRcCic+4raevKhoDMCQbmW9eYZWXsY6cWY59EKQNyEPfI
         vpUg==
X-Gm-Message-State: APjAAAWtLYfquzRTECJI9rVvz01J+ug2jehnogHJOEGcpqiU6aAUqGvX
        2VP8r8rebxSf4xPHG1GWxv/4nTF6TAw=
X-Google-Smtp-Source: APXvYqwx9tviP/RsZnNZPrM2hgYzH7eQ8kOq7UPdXGLrRfUBtTHfxw03I3E1v3nHFtzJZyMMtcm4DQ==
X-Received: by 2002:ad4:46f1:: with SMTP id h17mr30472101qvw.109.1561470707055;
        Tue, 25 Jun 2019 06:51:47 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id u7sm11765933qtc.25.2019.06.25.06.51.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 06:51:46 -0700 (PDT)
Message-ID: <1561470705.5154.68.camel@lca.pw>
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
Date:   Tue, 25 Jun 2019 09:51:45 -0400
In-Reply-To: <00a78980-6b9c-5d5b-ed01-b28bb34be022@arm.com>
References: <1561464964.5154.63.camel@lca.pw>
         <e86774e4-7470-5cb2-fc3e-b7c1f529d253@arm.com>
         <1561467369.5154.67.camel@lca.pw>
         <00a78980-6b9c-5d5b-ed01-b28bb34be022@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-06-25 at 14:40 +0100, Vincenzo Frascino wrote:
> On 25/06/2019 13:56, Qian Cai wrote:
> > On Tue, 2019-06-25 at 13:47 +0100, Vincenzo Frascino wrote:
> > > Hi Qian,
> > > 
> > > On 25/06/2019 13:16, Qian Cai wrote:
> > > > The linux-next commit "arm64: vdso: Substitute gettimeofday() with C
> > > > implementation" [1] breaks clang build.
> > > > 
> > > > error: invalid value 'tiny' in '-mcode-model tiny'
> > > > make[1]: *** [scripts/Makefile.build:279:
> > > > arch/arm64/kernel/vdso/vgettimeofday.o] Error 1
> > > > make[1]: *** Waiting for unfinished jobs....
> > > > make: *** [arch/arm64/Makefile:180: vdso_prepare] Error 2
> > > > 
> > > > [1] https://patchwork.kernel.org/patch/11009663/
> > > > 
> > > 
> > > I am not sure what does exactly break from your report. Could you please
> > > provide
> > > more details?
> > 
> > Here is the config to reproduce.
> > 
> > https://raw.githubusercontent.com/cailca/linux-mm/master/arm64.config
> > 
> > # make CC=clang -j $(nr_cpus)
> > 
> > I can get it working again by removing "-mcmodel=tiny" in
> > arch/arm64/kernel/vdso/Makefile
> > 
> 
> With your defconfig I can't still reproduce the problem. Which version of
> clang
> are you using?

Compiler: clang version 7.0.1 (tags/RELEASE_701/final)

> 
> > > 
> > > On my env:
> > > 
> > > $ make mrproper && make defconfig && make CC=clang HOSTCC=clang -j$(nproc)
> > > 
> > > ...
> > > 
> > > arch/arm64/Makefile:56: CROSS_COMPILE_COMPAT is clang, the compat vDSO
> > > will
> > > not
> > > be built
> > > 
> > > ...
> > > 
> > >   LDS     arch/arm64/kernel/vdso/vdso.lds
> > >   AS      arch/arm64/kernel/vdso/note.o
> > >   AS      arch/arm64/kernel/vdso/sigreturn.o
> > >   CC      arch/arm64/kernel/vdso/vgettimeofday.o
> > >   LD      arch/arm64/kernel/vdso/vdso.so.dbg
> > >   VDSOCHK arch/arm64/kernel/vdso/vdso.so.dbg
> > >   VDSOSYM include/generated/vdso-offsets.h
> > > 
> > > ...
> > > 
> > >   LD      vmlinux.o
> > >   MODPOST vmlinux.o
> > >   MODINFO modules.builtin.modinfo
> > >   KSYM    .tmp_kallsyms1.o
> > >   KSYM    .tmp_kallsyms2.o
> > >   LD      vmlinux
> > >   SORTEX  vmlinux
> > >   SYSMAP  System.map
> > >   Building modules, stage 2.
> > >   OBJCOPY arch/arm64/boot/Image
> > >   MODPOST 483 modules
> > > 
> 
> 
