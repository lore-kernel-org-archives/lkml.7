Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD493C48BD9
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88A1D2133F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ED6KNsTN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfF0Rad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 13:30:33 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37768 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbfF0Rac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 13:30:32 -0400
Received: by mail-pg1-f195.google.com with SMTP id 25so1332452pgy.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 10:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eLjiElcIrr/gAInf06fm8bbikHcRrP8CNp2uS8ewyvs=;
        b=ED6KNsTN985VbG6hvh7Xy4UCl2qCYKzTLsAECkj/EZYA8w5c/+NCAqAjQamlQqOPs+
         d1mZlSMJAnAlGfq45URngF1P0rojyfJj+efR53D96pydqFi5WNIKrrLxj1jIOJvJIyWL
         ieCeaQmWhYKmAme/KTRrchpXiyYh+O5lgRWgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eLjiElcIrr/gAInf06fm8bbikHcRrP8CNp2uS8ewyvs=;
        b=kjb3YUW1IsdJyDbgGTPdOOBy+TvLnjE1dD48myVTjc147eYGfFUIBJPVlThQybqiAb
         nzjPnlIG3i0OL6qmwAAEw0SRqHwStK4WC7oqpAUSgo5ZqMz6j4tnpYeOUIj0R8zSDnzz
         GXV+7z3x2EZtl4Ld/i0T2TidxCIY1yyWcWPMMqdbtYZKl6FNYumTG/V8/m51kaKep/io
         vS//SUbAhYdhik0N/MrlM2gcVoCYVKbPSuggb/ul+icte058rp2UfJE3Vracd1ROVRKk
         Npt9lgmzgzZ77lc3Y3iIe53c4eI6F0zIwWgk+XeLOlSBPOArGSCyLeOcCx9qIJvjoK4i
         mTBQ==
X-Gm-Message-State: APjAAAWo2iKhd30VIU/ieX0G5j3yQT9HZSToQv6C3dmqz1dlbwCa8Bj1
        omlF1DcjExJ76Xb3MxRPw4YcSA==
X-Google-Smtp-Source: APXvYqzVejbbFNo9eifizJmuuUidCiqQFhiRyhjt8MdYUCNlxaffalUIrGmuZ9oy52d/Pjg8H8sVcQ==
X-Received: by 2002:a63:480e:: with SMTP id v14mr4743453pga.182.1561656632225;
        Thu, 27 Jun 2019 10:30:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v4sm3579798pff.45.2019.06.27.10.30.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Jun 2019 10:30:31 -0700 (PDT)
Date:   Thu, 27 Jun 2019 10:30:30 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Jann Horn <jannh@google.com>, Borislav Petkov <bp@alien8.de>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 8/8] selftests/x86: Add a test for process_vm_readv()
 on the vsyscall page
Message-ID: <201906271030.C30D8CDEDA@keescook>
References: <cover.1561610354.git.luto@kernel.org>
 <0fe34229a9330e8f9de9765967939cc4f1cf26b1.1561610354.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fe34229a9330e8f9de9765967939cc4f1cf26b1.1561610354.git.luto@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 09:45:09PM -0700, Andy Lutomirski wrote:
> get_gate_page() is a piece of somewhat alarming code to make
> get_user_pages() work on the vsyscall page.  Test it via
> process_vm_readv().
> 
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Andy Lutomirski <luto@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  tools/testing/selftests/x86/test_vsyscall.c | 35 +++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/tools/testing/selftests/x86/test_vsyscall.c b/tools/testing/selftests/x86/test_vsyscall.c
> index 34a1d35995ef..4602326b8f5b 100644
> --- a/tools/testing/selftests/x86/test_vsyscall.c
> +++ b/tools/testing/selftests/x86/test_vsyscall.c
> @@ -18,6 +18,7 @@
>  #include <sched.h>
>  #include <stdbool.h>
>  #include <setjmp.h>
> +#include <sys/uio.h>
>  
>  #ifdef __x86_64__
>  # define VSYS(x) (x)
> @@ -459,6 +460,38 @@ static int test_vsys_x(void)
>  	return 0;
>  }
>  
> +static int test_process_vm_readv(void)
> +{
> +#ifdef __x86_64__
> +	char buf[4096];
> +	struct iovec local, remote;
> +	int ret;
> +
> +	printf("[RUN]\tprocess_vm_readv() from vsyscall page\n");
> +
> +	local.iov_base = buf;
> +	local.iov_len = 4096;
> +	remote.iov_base = (void *)0xffffffffff600000;
> +	remote.iov_len = 4096;
> +	ret = process_vm_readv(getpid(), &local, 1, &remote, 1, 0);
> +	if (ret != 4096) {
> +		printf("[OK]\tprocess_vm_readv() failed (ret = %d, errno = %d)\n", ret, errno);
> +		return 0;
> +	}
> +
> +	if (vsyscall_map_r) {
> +		if (!memcmp(buf, (const void *)0xffffffffff600000, 4096)) {
> +			printf("[OK]\tIt worked and read correct data\n");
> +		} else {
> +			printf("[FAIL]\tIt worked but returned incorrect data\n");
> +			return 1;
> +		}
> +	}
> +#endif
> +
> +	return 0;
> +}
> +
>  #ifdef __x86_64__
>  #define X86_EFLAGS_TF (1UL << 8)
>  static volatile sig_atomic_t num_vsyscall_traps;
> @@ -533,6 +566,8 @@ int main(int argc, char **argv)
>  	nerrs += test_vsys_r();
>  	nerrs += test_vsys_x();
>  
> +	nerrs += test_process_vm_readv();
> +
>  #ifdef __x86_64__
>  	nerrs += test_emulation();
>  #endif
> -- 
> 2.21.0
> 

-- 
Kees Cook
