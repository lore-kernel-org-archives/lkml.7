Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63866C606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 04:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35AEA2166E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 04:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Lv0JlsOW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbfGIEY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 00:24:29 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43761 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbfGIEY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 00:24:28 -0400
Received: by mail-pf1-f196.google.com with SMTP id i189so8621667pfg.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 21:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F+Oin8y+EIH8ELQCYmC4I4So1tZyUi3NnGz7vhdeqmo=;
        b=Lv0JlsOW1n2ZicN2jgqiK9kzHhsTVUcMz/W/h7SJ8+gc7qVRFBeXyVKv9fK+/Gb7/G
         D8kFkTzNmn2hn8QX/87Yg07PdDAVs30Gu+viVV80EZac8e4cUE3UlBn+1l2yXmNjvGMn
         SryK7pbSfTzRtCXNsKquOOgrkZ99BMjsrST8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F+Oin8y+EIH8ELQCYmC4I4So1tZyUi3NnGz7vhdeqmo=;
        b=iFoVunxgsx8eAodNfmtzWzgTQV6r1kSNZrVs+E6fowZlT6cdNniIrc9ai2G1WfR+cf
         YRXKOMlSxcaoBLJoNKVWXG+d3ph4s2c82RrMBcaK9qC4wy0V/QVjGs2e06Q/GXxkpbro
         ZTF49yS5RWBtuPZ7yVP3B5PVbc5JWfyN74hrogP9B+OYO0XoYQpZTxyURDxt1w4IhTQo
         GC5mDn+1U8CTp8kFRZWHUIplw4Q/0mu9Nfzs/5YRPhXi1Da5DzI2aDx+xBZ/1IAxqNPU
         JeN5h5ZkSvKQWQ1wtflV585e5Jz8JAoANoGLp6ZSbZYyh/ufm1iVScnbFVx9CCrppQrX
         9I/w==
X-Gm-Message-State: APjAAAX8PTeUQSbyhYTAc1X9D8/GcepBQzC6XoXWdL05wi1rQGRq/kj1
        fA0r4eOGpi/RuKZvAprWPPVqcA==
X-Google-Smtp-Source: APXvYqyVa/GzCt+39N/LJAhpraRBJZSq8cFfRC98o721wKHP4dmb7d5TC7WEleMmLOHLQc/bZMyvlg==
X-Received: by 2002:a63:2264:: with SMTP id t36mr22286321pgm.87.1562646268174;
        Mon, 08 Jul 2019 21:24:28 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x67sm20209337pfb.21.2019.07.08.21.24.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Jul 2019 21:24:27 -0700 (PDT)
Date:   Mon, 8 Jul 2019 21:24:26 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        kbuild test robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@01.org
Subject: Re: [PATCH] selftests/seccomp/seccomp_bpf: update for
 PTRACE_GET_SYSCALL_INFO
Message-ID: <201907082124.F358ED0@keescook>
References: <20190708090627.GO17490@shao2-debian>
 <20190708182904.GA12332@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190708182904.GA12332@altlinux.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 08, 2019 at 09:29:04PM +0300, Dmitry V. Levin wrote:
> The syscall entry/exit is now exposed via PTRACE_GETEVENTMSG,
> update the test accordingly.

Oh yes, thank you!

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> 
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> ---
>  tools/testing/selftests/seccomp/seccomp_bpf.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
> index dc66fe852768..6ef7f16c4cf5 100644
> --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
> +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
> @@ -1775,13 +1775,18 @@ void tracer_ptrace(struct __test_metadata *_metadata, pid_t tracee,
>  	unsigned long msg;
>  	static bool entry;
>  
> -	/* Make sure we got an empty message. */
> +	/*
> +	 * The traditional way to tell PTRACE_SYSCALL entry/exit
> +	 * is by counting.
> +	 */
> +	entry = !entry;
> +
> +	/* Make sure we got an appropriate message. */
>  	ret = ptrace(PTRACE_GETEVENTMSG, tracee, NULL, &msg);
>  	EXPECT_EQ(0, ret);
> -	EXPECT_EQ(0, msg);
> +	EXPECT_EQ(entry ? PTRACE_EVENTMSG_SYSCALL_ENTRY
> +			: PTRACE_EVENTMSG_SYSCALL_EXIT, msg);
>  
> -	/* The only way to tell PTRACE_SYSCALL entry/exit is by counting. */
> -	entry = !entry;
>  	if (!entry)
>  		return;
>  
> -- 
> ldv

-- 
Kees Cook
