Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B630C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 19:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D92D72064A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 19:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aJiRP98z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387979AbfG3TQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 15:16:10 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42809 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfG3TQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 15:16:10 -0400
Received: by mail-ed1-f67.google.com with SMTP id v15so63548570eds.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 12:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dsk8ZydsUhALc559Eoh2HiqlRDNFYGUSysH9tXyKuOA=;
        b=aJiRP98zViobaSTaZiXjGOvOTKc8CYMZWMp41PMBiw4wA+jXZVKuk+B2yflzE6trDY
         7hSQYvjfGvZPNIZd1w9dCfUAgpkBhEM/4PfkSuyQJe9LQ/11js0JTCryijJrqk/55a4O
         lrYi0meSGVBbHfSSibcbAgyQhhtSJl1zt1TBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dsk8ZydsUhALc559Eoh2HiqlRDNFYGUSysH9tXyKuOA=;
        b=GBTvqjrXuwKaDXM5b1pEw7PE+sCvg4xeGzRBFttarHxjpEGcV1FiTEhzoF7ZIepGnr
         qqHx7jp0ABAFIiUVXabaLpoYBEVh9FqkYp+XlPNAkYFD5E5ZCHL8dPd6cHAAVlzWa6gk
         URLCCVZ9EWp3UUN2j0Fx7+WDdZ+420vCsPrmyIXr678c52lr4aF3rCq7WsUxonXwlAtw
         ePCLPKzni8FJeHHtKsnn3Rk2ZPqZW4ldGllistp2froGSID1uIiwMGLvsn246YkrrOK5
         oVi6yz2Rn5/W7h2XdF3FV8mDx1XRQ6JDjpkLEc64FPqKFH0VP4MqvtkhgQHLdoZDhAQr
         ODfg==
X-Gm-Message-State: APjAAAUg/Cn9blUreXhVLuwyXK39LSuoVaPXhFhh7hKCYv0bt6p9w0xk
        VI2/ZgsDWOCk94EJBnOE+zxi/2kBc70=
X-Google-Smtp-Source: APXvYqx6CfbNMdbEqeuAPUMtl8y2irfLCcBMjmcmSAiZESvaH8I/4TuwMABDEVYlfeCO+aFoMTzeUw==
X-Received: by 2002:a17:906:4bcb:: with SMTP id x11mr92033398ejv.1.1564514168393;
        Tue, 30 Jul 2019 12:16:08 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id f26sm8540269ejo.25.2019.07.30.12.16.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 12:16:08 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id p17so66938957wrf.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 12:16:08 -0700 (PDT)
X-Received: by 2002:a5d:528d:: with SMTP id c13mr45696619wrv.247.1564513794356;
 Tue, 30 Jul 2019 12:09:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190708174913.123308-1-thgarnie@chromium.org> <201907301100.90BB865078@keescook>
In-Reply-To: <201907301100.90BB865078@keescook>
From:   Thomas Garnier <thgarnie@chromium.org>
Date:   Tue, 30 Jul 2019 12:09:42 -0700
X-Gmail-Original-Message-ID: <CAJcbSZEZNk-YoE-dH=N1QpAeUdzm9wGpEqU644bO30WmYcnCtQ@mail.gmail.com>
Message-ID: <CAJcbSZEZNk-YoE-dH=N1QpAeUdzm9wGpEqU644bO30WmYcnCtQ@mail.gmail.com>
Subject: Re: [PATCH v8 00/11] x86: PIE support to extend KASLR randomization
To:     Kees Cook <keescook@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Alok Kataria <akataria@vmware.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Nadav Amit <namit@vmware.com>, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Feng Tang <feng.tang@intel.com>,
        Maran Wilson <maran.wilson@oracle.com>,
        Enrico Weigelt <info@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 11:01 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Jul 08, 2019 at 10:48:53AM -0700, Thomas Garnier wrote:
> > Splitting the previous series in two. This part contains assembly code
> > changes required for PIE but without any direct dependencies with the
> > rest of the patchset.
> >
> > Changes:
> >  - patch v8 (assembly):
> >    - Fix issues in crypto changes (thanks to Eric Biggers).
> >    - Remove unnecessary jump table change.
> >    - Change author and signoff to chromium email address.
>
> With -rc2 done, is this a good time for this to land in -tip? Are there
> more steps needed for review?

I have a minor feedback and rebase that I am about to send (v9). It
seems like a good one to send to tip if there is no major feedback.

>
> Thanks!
>
> -Kees
>
> >  - patch v7 (assembly):
> >    - Split patchset and reorder changes.
> >  - patch v6:
> >    - Rebase on latest changes in jump tables and crypto.
> >    - Fix wording on couple commits.
> >    - Revisit checkpatch warnings.
> >    - Moving to @chromium.org.
> >  - patch v5:
> >    - Adapt new crypto modules for PIE.
> >    - Improve per-cpu commit message.
> >    - Fix xen 32-bit build error with .quad.
> >    - Remove extra code for ftrace.
> >  - patch v4:
> >    - Simplify early boot by removing global variables.
> >    - Modify the mcount location script for __mcount_loc intead of the address
> >      read in the ftrace implementation.
> >    - Edit commit description to explain better where the kernel can be located.
> >    - Streamlined the testing done on each patch proposal. Always testing
> >      hibernation, suspend, ftrace and kprobe to ensure no regressions.
> >  - patch v3:
> >    - Update on message to describe longer term PIE goal.
> >    - Minor change on ftrace if condition.
> >    - Changed code using xchgq.
> >  - patch v2:
> >    - Adapt patch to work post KPTI and compiler changes
> >    - Redo all performance testing with latest configs and compilers
> >    - Simplify mov macro on PIE (MOVABS now)
> >    - Reduce GOT footprint
> >  - patch v1:
> >    - Simplify ftrace implementation.
> >    - Use gcc mstack-protector-guard-reg=%gs with PIE when possible.
> >  - rfc v3:
> >    - Use --emit-relocs instead of -pie to reduce dynamic relocation space on
> >      mapped memory. It also simplifies the relocation process.
> >    - Move the start the module section next to the kernel. Remove the need for
> >      -mcmodel=large on modules. Extends module space from 1 to 2G maximum.
> >    - Support for XEN PVH as 32-bit relocations can be ignored with
> >      --emit-relocs.
> >    - Support for GOT relocations previously done automatically with -pie.
> >    - Remove need for dynamic PLT in modules.
> >    - Support dymamic GOT for modules.
> >  - rfc v2:
> >    - Add support for global stack cookie while compiler default to fs without
> >      mcmodel=kernel
> >    - Change patch 7 to correctly jump out of the identity mapping on kexec load
> >      preserve.
> >
> > These patches make some of the changes necessary to build the kernel as
> > Position Independent Executable (PIE) on x86_64. Another patchset will
> > add the PIE option and larger architecture changes.
> >
> > The patches:
> >  - 1, 3-11: Change in assembly code to be PIE compliant.
> >  - 2: Add a new _ASM_MOVABS macro to fetch a symbol address generically.
> >
> > diffstat:
> >  crypto/aegis128-aesni-asm.S         |    6 +-
> >  crypto/aegis128l-aesni-asm.S        |    8 +--
> >  crypto/aegis256-aesni-asm.S         |    6 +-
> >  crypto/aes-x86_64-asm_64.S          |   45 ++++++++++------
> >  crypto/aesni-intel_asm.S            |    8 +--
> >  crypto/aesni-intel_avx-x86_64.S     |    3 -
> >  crypto/camellia-aesni-avx-asm_64.S  |   42 +++++++--------
> >  crypto/camellia-aesni-avx2-asm_64.S |   44 ++++++++--------
> >  crypto/camellia-x86_64-asm_64.S     |    8 +--
> >  crypto/cast5-avx-x86_64-asm_64.S    |   50 ++++++++++--------
> >  crypto/cast6-avx-x86_64-asm_64.S    |   44 +++++++++-------
> >  crypto/des3_ede-asm_64.S            |   96 ++++++++++++++++++++++++------------
> >  crypto/ghash-clmulni-intel_asm.S    |    4 -
> >  crypto/glue_helper-asm-avx.S        |    4 -
> >  crypto/glue_helper-asm-avx2.S       |    6 +-
> >  crypto/morus1280-avx2-asm.S         |    4 -
> >  crypto/morus1280-sse2-asm.S         |    8 +--
> >  crypto/morus640-sse2-asm.S          |    6 +-
> >  crypto/sha256-avx2-asm.S            |   18 ++++--
> >  entry/entry_64.S                    |   16 ++++--
> >  include/asm/alternative.h           |    6 +-
> >  include/asm/asm.h                   |    1
> >  include/asm/paravirt_types.h        |   25 +++++++--
> >  include/asm/pm-trace.h              |    2
> >  include/asm/processor.h             |    6 +-
> >  kernel/acpi/wakeup_64.S             |   31 ++++++-----
> >  kernel/head_64.S                    |   16 +++---
> >  kernel/relocate_kernel_64.S         |    2
> >  power/hibernate_asm_64.S            |    4 -
> >  29 files changed, 306 insertions(+), 213 deletions(-)
> >
> > Patchset is based on next-20190708.
> >
> >
>
> --
> Kees Cook
