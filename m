Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C61C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 17:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A0D521726
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 17:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G8clkpoA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbfH2RGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 13:06:10 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39647 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727675AbfH2RGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 13:06:09 -0400
Received: by mail-pf1-f193.google.com with SMTP id y200so2478948pfb.6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 10:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=i1DJmvd8voYWLbxEBUB8nLGj+ccKrfRNfMLOZPulnv0=;
        b=G8clkpoAG2wM7TmydjOjIMm7fNWG8ep55osvEJVVhpQe84OPg7U+DYdiZtLW5h+LER
         LVxlkBUao1QISYfuzi3UJEEIP+SH7ZlQj3OLcVbDv5XUxkhWXectWPf0MLd3w+TAdwvU
         Ugs/jNHjuICUeUS519629+GrUHSoAHF7v/aUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=i1DJmvd8voYWLbxEBUB8nLGj+ccKrfRNfMLOZPulnv0=;
        b=M4SPjdxbUfZROpxEbO5pqzJGZXXYJ49UlAE4Kmb25B4s3TaL+fTPaOApTSSjkIhi1V
         sQl/f4TaQu5JU1jBQMqOrsm66e/FdalhlVZTlN3t/apQOOMkAtCWYMHKuYRsmHJGN/VG
         d2xIIPv/Sq+kix3dtgdkLsuWirBlHnMhlNyeQPcPvUXROancUgMfu63X7DkZ0eRrNcdi
         xkUldPRoNHPreZIUZKNNQyqrP6x2Ngl//jY1y+6eo0/UxgeGAQj1a6wYwHAGJHzapz2w
         He76BKHSVO1dSrfZQt/w0ilJB1e5Arpt2Fs6fZua9LD2Grx2nbn9jDzRAXSo573BF+ag
         qjTw==
X-Gm-Message-State: APjAAAX3zZoWxcmk15cIEQhCd0bGukWT1bVp23V2rFz9SVkfgVWnQFJv
        2Hl3RtGYFABPRo0AEBN87Z49og==
X-Google-Smtp-Source: APXvYqz0wp9mb9x5mvRK0pA6+zC9B0EAIvxqn7uz8Hh6S3XZ5PoeZHkueVVQ/55Ag8IPJDeVG6h46w==
X-Received: by 2002:a63:2157:: with SMTP id s23mr9520562pgm.167.1567098368482;
        Thu, 29 Aug 2019 10:06:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v15sm3687506pfn.69.2019.08.29.10.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 10:06:07 -0700 (PDT)
Date:   Thu, 29 Aug 2019 10:06:06 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Tycho Andersen <tycho@tycho.ws>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alakesh Haloi <alakesh.haloi@gmail.com>
Subject: Re: [PATCH] selftests/seccomp: fix build on older kernels
Message-ID: <201908291003.005EB96606@keescook>
References: <20190826144302.7745-1-tycho@tycho.ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190826144302.7745-1-tycho@tycho.ws>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 08:43:02AM -0600, Tycho Andersen wrote:
> The seccomp selftest goes to some length to build against older kernel
> headers, viz. all the #ifdefs at the beginning of the file. 201766a20e30
> ("ptrace: add PTRACE_GET_SYSCALL_INFO request") introduces some additional
> macros, but doesn't do the #ifdef dance. Let's add that dance here to
> avoid:
> 
> gcc -Wl,-no-as-needed -Wall  seccomp_bpf.c -lpthread -o seccomp_bpf
> In file included from seccomp_bpf.c:51:
> seccomp_bpf.c: In function ‘tracer_ptrace’:
> seccomp_bpf.c:1787:20: error: ‘PTRACE_EVENTMSG_SYSCALL_ENTRY’ undeclared (first use in this function); did you mean ‘PTRACE_EVENT_CLONE’?
>   EXPECT_EQ(entry ? PTRACE_EVENTMSG_SYSCALL_ENTRY
>                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../kselftest_harness.h:608:13: note: in definition of macro ‘__EXPECT’
>   __typeof__(_expected) __exp = (_expected); \
>              ^~~~~~~~~
> seccomp_bpf.c:1787:2: note: in expansion of macro ‘EXPECT_EQ’
>   EXPECT_EQ(entry ? PTRACE_EVENTMSG_SYSCALL_ENTRY
>   ^~~~~~~~~
> seccomp_bpf.c:1787:20: note: each undeclared identifier is reported only once for each function it appears in
>   EXPECT_EQ(entry ? PTRACE_EVENTMSG_SYSCALL_ENTRY
>                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../kselftest_harness.h:608:13: note: in definition of macro ‘__EXPECT’
>   __typeof__(_expected) __exp = (_expected); \
>              ^~~~~~~~~
> seccomp_bpf.c:1787:2: note: in expansion of macro ‘EXPECT_EQ’
>   EXPECT_EQ(entry ? PTRACE_EVENTMSG_SYSCALL_ENTRY
>   ^~~~~~~~~
> seccomp_bpf.c:1788:6: error: ‘PTRACE_EVENTMSG_SYSCALL_EXIT’ undeclared (first use in this function); did you mean ‘PTRACE_EVENT_EXIT’?
>     : PTRACE_EVENTMSG_SYSCALL_EXIT, msg);
>       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../kselftest_harness.h:608:13: note: in definition of macro ‘__EXPECT’
>   __typeof__(_expected) __exp = (_expected); \
>              ^~~~~~~~~
> seccomp_bpf.c:1787:2: note: in expansion of macro ‘EXPECT_EQ’
>   EXPECT_EQ(entry ? PTRACE_EVENTMSG_SYSCALL_ENTRY
>   ^~~~~~~~~
> make: *** [Makefile:12: seccomp_bpf] Error 1
> 
> Signed-off-by: Tycho Andersen <tycho@tycho.ws>
> Fixes: 201766a20e30 ("ptrace: add PTRACE_GET_SYSCALL_INFO request")

Acked-by: Kees Cook <keescook@chromium.org>

Alakesh Haloi also sent a fix[1] for this. I prefer Tycho's solution
(one #ifndef and a Fixes line). Shuah, can you please apply this?

Thanks!

-Kees

[1] https://lore.kernel.org/lkml/20190822215823.GA11292@ip-172-31-44-144.us-west-2.compute.internal

> ---
>  tools/testing/selftests/seccomp/seccomp_bpf.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
> index 6ef7f16c4cf5..7f8b5c8982e3 100644
> --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
> +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
> @@ -199,6 +199,11 @@ struct seccomp_notif_sizes {
>  };
>  #endif
>  
> +#ifndef PTRACE_EVENTMSG_SYSCALL_ENTRY
> +#define PTRACE_EVENTMSG_SYSCALL_ENTRY	1
> +#define PTRACE_EVENTMSG_SYSCALL_EXIT	2
> +#endif
> +
>  #ifndef seccomp
>  int seccomp(unsigned int op, unsigned int flags, void *args)
>  {
> -- 
> 2.20.1
> 

-- 
Kees Cook
