Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 380E7C282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06CFD204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555698733;
	bh=owc1ZCAlZCsHRrRjwr7Nta/6hlbvBOZalUXIxXVId7w=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=PwpPJAS2ux2r/4SRwb8ynMcWOGx92lhB7xC8AjOSjQzuzsN8Y44ArColFbUy4bH7I
	 F3VBDxydzQTtyOHgQ0U259yD/TH+OpK3kwBMwOMEOLAh/8fh/8XQg+L3CnKYDDbkWs
	 ineMoPEk3BDj0TEJ+623ABKWD/U60IY2gwj2uJ7I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbfDSScM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:32:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:53888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727851AbfDSS3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:29:17 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1DEB222C6;
        Fri, 19 Apr 2019 14:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555682677;
        bh=owc1ZCAlZCsHRrRjwr7Nta/6hlbvBOZalUXIxXVId7w=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=huDBDC8uRbHcul3zKeeVGXDJsuGFupuezZj4718MMGLJKvq7zDTvBOiewCxAa+jtS
         GPAtoo4GITmw8djlLj36wBMgdZbsw/B63GHuJSfY/mZ9/shNoP0HDuPfvxzPD4dlSm
         zJjEuAvOL6Utqym3IH6D4/78QSbubgIqHNCwmnHU=
Subject: Re: [PATCH v3] selftests/x86: Support Atom for syscall_arg_fault test
To:     Tong Bo <bo.tong@intel.com>, luto@kernel.org, x86@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, shuah@kernel.org
References: <1555657855-31855-1-git-send-email-bo.tong@intel.com>
From:   shuah <shuah@kernel.org>
Message-ID: <263afb6f-48dc-fbe7-5b13-13ce3f322ecc@kernel.org>
Date:   Fri, 19 Apr 2019 08:04:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1555657855-31855-1-git-send-email-bo.tong@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/19/19 1:10 AM, Tong Bo wrote:
> Atom-based CPUs trigger stack fault when invoke 32-bit SYSENTER instruction
> with invalid register values. So we also need SIGBUS handling in this case.
> 
> Following is assembly when the fault exception happens.
> 
> (gdb) disassemble $eip
> Dump of assembler code for function __kernel_vsyscall:
>     0xf7fd8fe0 <+0>:     push   %ecx
>     0xf7fd8fe1 <+1>:     push   %edx
>     0xf7fd8fe2 <+2>:     push   %ebp
>     0xf7fd8fe3 <+3>:     mov    %esp,%ebp
>     0xf7fd8fe5 <+5>:     sysenter
>     0xf7fd8fe7 <+7>:     int    $0x80
> => 0xf7fd8fe9 <+9>:     pop    %ebp
>     0xf7fd8fea <+10>:    pop    %edx
>     0xf7fd8feb <+11>:    pop    %ecx
>     0xf7fd8fec <+12>:    ret
> End of assembler dump.
> 
> According to Intel SDM, this could also be a Stack Segment Fault(#SS, 12),
> except a normal Page Fault(#PF, 14). Especially, in section 6.9 of Vol.3A,
> both stack and page faults are within the 10th(lowest priority) class, and
> as it said, "exceptions within each class are implementation-dependent and
> may vary from processor to processor". It's expected for processors like
> Intel Atom to trigger stack fault(SIGBUS), while we get page fault(SIGSEGV)
> from common Core processors.
> 
> Signed-off-by: Tong Bo <bo.tong@intel.com>
> Acked-by: Andy Lutomirski <luto@kernel.org>
> ---
>   tools/testing/selftests/x86/syscall_arg_fault.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/x86/syscall_arg_fault.c b/tools/testing/selftests/x86/syscall_arg_fault.c
> index 7db4fc9..d2548401 100644
> --- a/tools/testing/selftests/x86/syscall_arg_fault.c
> +++ b/tools/testing/selftests/x86/syscall_arg_fault.c
> @@ -43,7 +43,7 @@ static sigjmp_buf jmpbuf;
>   
>   static volatile sig_atomic_t n_errs;
>   
> -static void sigsegv(int sig, siginfo_t *info, void *ctx_void)
> +static void sigsegv_or_sigbus(int sig, siginfo_t *info, void *ctx_void)
>   {
>   	ucontext_t *ctx = (ucontext_t*)ctx_void;
>   
> @@ -73,7 +73,13 @@ int main()
>   	if (sigaltstack(&stack, NULL) != 0)
>   		err(1, "sigaltstack");
>   
> -	sethandler(SIGSEGV, sigsegv, SA_ONSTACK);
> +	sethandler(SIGSEGV, sigsegv_or_sigbus, SA_ONSTACK);
> +	/*
> +	 * The actual exception can vary.  On Atom CPUs, we get #SS
> +	 * instead of #PF when the vDSO fails to access the stack when
> +	 * ESP is too close to 2^32, and #SS causes SIGBUS.
> +	 */
> +	sethandler(SIGBUS, sigsegv_or_sigbus, SA_ONSTACK);
>   	sethandler(SIGILL, sigill, SA_ONSTACK);
>   
>   	/*
> 

In case there is a dependency on x86 tree, here is my Ack

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
