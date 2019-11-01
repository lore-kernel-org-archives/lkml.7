Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC79CA9EC9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 04:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C38BA2085B
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 04:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d20dfeMU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbfKAECR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 00:02:17 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38401 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbfKAECR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 00:02:17 -0400
Received: by mail-pg1-f193.google.com with SMTP id j30so2127637pgn.5
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 21:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BAe1ln5Hx2gY8GJiVnbrjacBTRiF8zYUc3i9OMgoBV4=;
        b=d20dfeMUMO7iAV+Fn0SFBoJceIxy/S9eCh9MpKcU+8Svi9/nIYjbdD5L/UkHZhnzix
         JkU7VA7dyGF/sNbCwHD80C0s1IhuF/GjsyEtDZet5D5R19m1YB1nTHn4RH8s+keb8EXh
         TN5h9u8K3SVZV7Ba8Rr1S3a6ZJ8AbVBGmjB00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BAe1ln5Hx2gY8GJiVnbrjacBTRiF8zYUc3i9OMgoBV4=;
        b=hL97CqILMPJb4ZZL1oOrdAVuyWOeHXGNMPH/gfGZNgA1VSseNwUMmTN0e7jggP0ug1
         M6VvHwIxehmVTTIMawHjZTRMzhbwDgi8QAHWC8/LTZs+Jn9qr8ugm63rgZ7Jec1mNsk2
         YL0+T13RwUZAUkT54ywj/0ITvdQhYNZZryKVA9Ata9q4L6xM0fRVjthSy10eDOxQiu6T
         Nz2Ex7LF1S8FOxL2WrigUXvPtASSK8jduCdWj3eLbqTGwkTsy6QsY0rrLCnVgFh5/MSq
         ytnQhgIIvkka0P/6pCzVvOfUpYdnrrontbhKXjtoa3J+hn90qDGAq5315oBAySBC0t+L
         F7DA==
X-Gm-Message-State: APjAAAV7BP8ixh7wQcIjMHF9hVALR/EUTWmF/+35IV5wvq+TzXuWtq0r
        TYoL6CZ1oVffBfNig9Sin2WJBA==
X-Google-Smtp-Source: APXvYqyPHiOd3taHNtWSlPaVTh8guZzdREmzdQBPCQtoOfjQY9wgtCAJXeLozcbxVyvdbHL+RNqt5g==
X-Received: by 2002:a62:b616:: with SMTP id j22mr10383274pff.201.1572580936603;
        Thu, 31 Oct 2019 21:02:16 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e5sm6101564pfa.110.2019.10.31.21.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 21:02:15 -0700 (PDT)
Date:   Thu, 31 Oct 2019 21:02:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     samitolvanen@google.com
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 16/17] arm64: disable SCS for hypervisor code
Message-ID: <201910312101.2A014A8F@keescook>
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191031164637.48901-1-samitolvanen@google.com>
 <20191031164637.48901-17-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031164637.48901-17-samitolvanen@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 09:46:36AM -0700, samitolvanen@google.com wrote:
> Filter out CC_FLAGS_SCS for code that runs at a different exception
> level.
> 
> Suggested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

(Does it make any sense to merge all of these "disable under SCS"
patches? I guess not, since they're each different areas...)

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/arm64/kvm/hyp/Makefile | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/kvm/hyp/Makefile b/arch/arm64/kvm/hyp/Makefile
> index ea710f674cb6..17ea3da325e9 100644
> --- a/arch/arm64/kvm/hyp/Makefile
> +++ b/arch/arm64/kvm/hyp/Makefile
> @@ -28,3 +28,6 @@ GCOV_PROFILE	:= n
>  KASAN_SANITIZE	:= n
>  UBSAN_SANITIZE	:= n
>  KCOV_INSTRUMENT	:= n
> +
> +# remove the SCS flags from all objects in this directory
> +KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_SCS), $(KBUILD_CFLAGS))
> -- 
> 2.24.0.rc0.303.g954a862665-goog
> 

-- 
Kees Cook
