Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56708C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 22:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 129742177E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 22:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G+ogt7uk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfCLWzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 18:55:21 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35584 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbfCLWzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 18:55:21 -0400
Received: by mail-pf1-f194.google.com with SMTP id j5so2904969pfa.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 15:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UyJCz3/ignHV9qUFnpkZubkabXzIG/uZFa8r9jmzhd4=;
        b=G+ogt7ukYHrO1A/RZtRj/HL0/MI/3T9HLGvGaBGOiBq/J3RVRrLbDmCRDjMYzj6ISY
         H6B0XsNzUUzxqilgBC1ctEhE9TKBN7PD9NYarH+iS+50B+F8+90ST/+irlb95kF+e4v4
         NbRUXr7GM+5xCsxWw2uTTUMkT9qIXQXFzJ1QnkTUnpnu5S1yNlDiXLKpZwlcn+7CLxyY
         WKHtohxx7JP68bXF69UWy19+YKV2+OC6/K2qw1OGRiVxdBP3dHqIZrGsIF8AKP8Xi7Yp
         kk+mvglWBmF6emIeJrgyb/j12TWs66aCMEUW9caufpTQ11V6RFnhx9isiJlGuSBAf1xr
         lgwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UyJCz3/ignHV9qUFnpkZubkabXzIG/uZFa8r9jmzhd4=;
        b=k1isN/E2bmtH9zEnAjDHaSEggVlt208WaRwqsi1nD7+kU3Bk/KaLdI0+xmkgIwzMZ8
         wfMZwGyGYv2VSk6Wwv5wYTDTkDgSfzw+4ucNak7LlxyJUg6qiHCp53mTzk10jrGrHdIL
         +SrNJVVJWPKn36EQtKeDxSICFOmPjr/JT9cRiLCYa8CU6YA22bGKyym2ROIoA8l7poO6
         BtrexeLEdQ0U4mVgPKX+JYAicrCHeLi6FWwBXWhXB4oJN9cxepH1MzSf9DGnrn3mtaeK
         3LVFCOvA6e56tKR4d42dkMrvvdkrvySmeCupuTaazwX4FIOUJAKMDcNetrv67MHONZzv
         Istg==
X-Gm-Message-State: APjAAAXnxBmxOhysMJzsQsJDI4QkZKes9mo+YHTCnvWpb4zdFAoufDF4
        k/oHXo8+8Xwyo/a7bn0qCjYhNkXUVdEdfeBBZ58BHw==
X-Google-Smtp-Source: APXvYqyMkAyZ1zMrqjjIC6XlW0hyaHJIF8CE4QxQ/Bk4r2FXOZAoUFHfAR6H+vKbR9pN9NL61/EJD4bTyiISoyt0OcM=
X-Received: by 2002:a62:f20d:: with SMTP id m13mr40442517pfh.174.1552431320196;
 Tue, 12 Mar 2019 15:55:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190312215203.27643-1-natechancellor@gmail.com>
In-Reply-To: <20190312215203.27643-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 12 Mar 2019 15:55:09 -0700
Message-ID: <CAKwvOdmVWrrVWeuh6efnwreS4kp1L_kJ-FbKVGux8ZdiqvYCDA@mail.gmail.com>
Subject: Re: [PATCH] Makefile: Add '-fno-builtin-bcmp' to CLANG_FLAGS
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        James Y Knight <jyknight@google.com>,
        clang-built-linux@googlegroups.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 2:53 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> After LLVM revision r355672 [1], all known working kernel configurations
> fail to link [2]:
>
> ld: init/do_mounts.o: in function `prepare_namespace':
> do_mounts.c:(.init.text+0x5ca): undefined reference to `bcmp'
> ld: do_mounts.c:(.init.text+0x5e6): undefined reference to `bcmp'
> ld: init/initramfs.o: in function `do_header':
> initramfs.c:(.init.text+0x6e0): undefined reference to `bcmp'
> ld: initramfs.c:(.init.text+0x6f8): undefined reference to `bcmp'
> ld: arch/x86/kernel/setup.o: in function `setup_arch':
> setup.c:(.init.text+0x21d): undefined reference to `bcmp'
>
> Commit 6edfba1b33c7 ("[PATCH] x86_64: Don't define string functions to
> builtin") removed '-ffreestanding' globally and the kernel doesn't
> provide a bcmp definition so the linker cannot find a reference to it.
>
> Fix this by explicitly telling LLVM through Clang not to emit bcmp
> references. This flag does not need to be behind 'cc-option' because all
> working versions of Clang support this flag.
>
> [1]: https://github.com/llvm/llvm-project/commit/8e16d73346f8091461319a7dfc4ddd18eedcff13
> [2]: https://travis-ci.com/ClangBuiltLinux/continuous-integration/builds/104027249
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/416
> Link: https://bugs.llvm.org/show_bug.cgi?id=41035
> Cc: stable@vger.kernel.org
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Thanks for this patch.  Can the maintainers please consider this an
emergency patch; without it, the recent change to LLVM has caused ALL
of our CI targets to go red.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>


> ---
>  Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Makefile b/Makefile
> index 9ef547fc7ffe..6645a274b6e3 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -501,6 +501,7 @@ ifneq ($(GCC_TOOLCHAIN),)
>  CLANG_FLAGS    += --gcc-toolchain=$(GCC_TOOLCHAIN)
>  endif
>  CLANG_FLAGS    += -no-integrated-as
> +CLANG_FLAGS    += -fno-builtin-bcmp
>  KBUILD_CFLAGS  += $(CLANG_FLAGS)
>  KBUILD_AFLAGS  += $(CLANG_FLAGS)
>  export CLANG_FLAGS
> --
> 2.21.0
>


--
Thanks,
~Nick Desaulniers
