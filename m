Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4E1C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 16:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC40A208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 16:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cMT8vG86"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbfFYQZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 12:25:06 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45786 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbfFYQZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 12:25:06 -0400
Received: by mail-io1-f65.google.com with SMTP id e3so834201ioc.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 09:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9MBXjiD979h+FiHJN8+t7NOeVh1GY/H389vrTRT+gaM=;
        b=cMT8vG86Hg6neVu4tnHP4RQWf7KrqRGjMRZpr6M4IqNH71xoA2wOv6pWVSAMl9MEvv
         jQ3jtKXoZUg0yBUD+miNwpnAzUXJj6MdM7QOrrpjJj2j2EQ/XjCLnWxCtUazzaOMGT8V
         xMo7N7953TL1jVcw1m9EgimE5cBbiSix2UErpzX9Q4qJx5blYFlpv+RyjiMpfVFfR03C
         kTz3LjQsPv8foYG9mPl7xGZ4SwrqDkXrmaB2LHCgqcUS105Yjz17GhaUqlgI9mX8Nhi4
         qzhTHqG5AXUinw6GuCti0de80izSdiZih2WbfUANmI/0QZAsnaG+McztDmIWHRKIZfx/
         l7iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9MBXjiD979h+FiHJN8+t7NOeVh1GY/H389vrTRT+gaM=;
        b=fhseudJqx9+hmOWd3kxrY17R6Q5KtZhClif9/4BvY82S5IN+xyboImWXM7eKpeT/wC
         zFD+LGYqG0tn8kr3sIUTv8j2ce3jmJ4BF65bgh2GEGEMHhbGbXpTy3DaCZTvsGbNAqyk
         kqYojKvXOfvQNYruTR7pl4jgQTVQmpSC8+RiUGLZkuv/m2afHLvEy5Z5gYUw4fPZvUgb
         Olrg/a4tx0PaDOnJeTWJhSv3b+DW4Yjoygi6jNZUwQscHyuaXw+Xo1zSKSdGmxlzrR+O
         okVn83wnaNEBGND/zWIVTdJfE4pv3U4GnsC2Mu0o2hKTYTHygsWrhaeXDpGS2Y0SNyr0
         CELg==
X-Gm-Message-State: APjAAAUxNvjAcIDQEl3bxlg4+pPBEfMcz/fBOa3Wi6vLNwHfjiFokEEa
        SaSyjjke0NJf/syMa74SRrvqaevyF+XO1csjNLhAiQ==
X-Google-Smtp-Source: APXvYqy/1yx6pCml0+o4hg0PH5iRgFbi5lBDtqd5gF0EH2yP5Hk/kC1hI6M/XU+t5NixF+fW5eWMOsVGyDE8QL2GR+E=
X-Received: by 2002:a5e:820a:: with SMTP id l10mr43998333iom.283.1561479904800;
 Tue, 25 Jun 2019 09:25:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190620003244.261595-1-ndesaulniers@google.com>
 <20190620074640.GA27228@brain-police> <CAKv+Gu_KCFCVxw_zAfzUf8DjD4DmhvaJEoqBsX_SigOse_NwYw@mail.gmail.com>
 <CAKwvOdmQ+WdD8nvLz_VB_5atDi56fv485Xsn+mHJZKnyj6L-JA@mail.gmail.com>
 <20190624095749.wasjfrgcda7ygdr5@willie-the-truck> <CAKv+Gu8G2GQGxmcAAy1XQ5gkN-2fJSWAKCQQm9T4skYdh5cT3Q@mail.gmail.com>
 <20190625153918.GA53763@arrakis.emea.arm.com> <CAKv+Gu8Kz8fN-xKoEqPBiKWaEza6wUkbGxbKPPZxe14QzYLbJQ@mail.gmail.com>
 <20190625160350.GC53763@arrakis.emea.arm.com>
In-Reply-To: <20190625160350.GC53763@arrakis.emea.arm.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 25 Jun 2019 18:24:53 +0200
Message-ID: <CAKv+Gu_DqkptEW8pN_XGcOGhBFqD=d-6NeC1OL==UvVb-+vbVQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: defconfig: update and enable CONFIG_RANDOMIZE_BASE
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Olof Johansson <olof@lixom.net>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jun 2019 at 18:03, Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Tue, Jun 25, 2019 at 05:42:49PM +0200, Ard Biesheuvel wrote:
> > On Tue, 25 Jun 2019 at 17:39, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > On Mon, Jun 24, 2019 at 12:06:18PM +0200, Ard Biesheuvel wrote:
> > > > On Mon, 24 Jun 2019 at 11:57, Will Deacon <will@kernel.org> wrote:
> > > > > Thanks for having a look. It could be that we've fixed the issue Catalin was
> > > > > running into in the past -- he was going to see if the problem persists with
> > > > > mainline, since it was frequent enough that it was causing us to ignore the
> > > > > results from our testing infrastructure when RANDOMIZE_BASE=y.
> > > >
> > > > I had no idea this was the case. I can look into it if we are still
> > > > seeing failures.
> > >
> > > I've seen the panic below with 5.2-rc1, defconfig + RANDOMIZE_BASE=y in
> > > a guest on TX2. It takes a few tries to trigger just with kaslr,
> > > enabling lots of other DEBUG_* options makes the failures more
> > > deterministic. I can't really say it's kaslr's fault here, only that I
> > > used to consistently get it in this configuration. For some reason, I
> > > can no longer reproduce it on arm64 for-next/core (or maybe it just
> > > takes more tries and my script doesn't catch this).
> > >
> > > The fault is in the ip_tables module, the __this_cpu_read in
> > > xt_write_recseq_begin() inlined in ipt_do_table(). The disassembled
> > > sequence in my build:
> > >
> > > 0000000000000188 <ipt_do_table>:
> > > ...
> > >      258:       d538d080        mrs     x0, tpidr_el1
> > >      25c:       aa1303f9        mov     x25, x19
> > >      260:       b8606b34        ldr     w20, [x25, x0]
> >
> > This was fixed recently by
> >
> > arm64/kernel: kaslr: reduce module randomization range to 2 GB
> >
> > (and arm64/module: deal with ambiguity in PRELxx relocation ranges to
> > some extent)
>
> Thanks. This explains it.
>
> And another weird case that triggers only with 64K pages, KASan and
> KASLR combination (guest on TX2). My test script modprobes all the
> modules it finds installed (including some test kernel modules like lock
> torture). At some point during modprobing, vmalloc trips over the
> WARN_ON(!pte_none(*pte)) in vmap_pte_range():
>

When KASAN and KASLR are both enabled, modules are allocated in the
dedicated module window, since the vmalloc space is already shadowed
by KASAN zero pages and so the modules must be kept out of it. since
they have their own real shadow pages that are allocated on demand.

Looking at the backtrace, it seems like the failure may be due to the
shadow space clashing, probably because the top of the module region
exceeds MODULES_END.

Does the below help at all? (patch soup courtesy of gmail, apologies)


diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
index f713e2fc4d75..7e94e1f948c9 100644
--- a/arch/arm64/kernel/module.c
+++ b/arch/arm64/kernel/module.c
@@ -32,6 +32,7 @@

 void *module_alloc(unsigned long size)
 {
+       u64 module_alloc_end = module_alloc_base + MODULES_VSIZE;
        gfp_t gfp_mask = GFP_KERNEL;
        void *p;

@@ -39,9 +40,11 @@ void *module_alloc(unsigned long size)
        if (IS_ENABLED(CONFIG_ARM64_MODULE_PLTS))
                gfp_mask |= __GFP_NOWARN;

+       if (IS_ENABLED(CONFIG_KASAN))
+               module_alloc_end = MODULES_END;
+
        p = __vmalloc_node_range(size, MODULE_ALIGN, module_alloc_base,
-                               module_alloc_base + MODULES_VSIZE,
-                               gfp_mask, PAGE_KERNEL_EXEC, 0,
+                               module_alloc_end, gfp_mask, PAGE_KERNEL_EXEC, 0,
                                NUMA_NO_NODE, __builtin_return_address(0));

        if (!p && IS_ENABLED(CONFIG_ARM64_MODULE_PLTS) &&
