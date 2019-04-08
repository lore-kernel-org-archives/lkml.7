Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE7DEC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 17:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACF962087F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 17:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554745908;
	bh=1orv67/nJvj831HmkEmwh44HkEEEt0WHiWIAul4l4FE=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=x15b3ag+HB6zq2Dz36jqx8iJJnhyijJee+4/H9O1Cgs618ROEl7VOg2CPCQkEsKSE
	 XbHVfkRupjOK1uE1YsFS1wzpf+yA0rBKF+GjVsdMguvlPcV4wkiyRYm5D/dCiBRKOH
	 WhounJOUkjdkIy1Ssn4bcZNT1aImTiq9Ma1K3+HQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbfDHRvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 13:51:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:40662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726373AbfDHRvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 13:51:47 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1120820863;
        Mon,  8 Apr 2019 17:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554745906;
        bh=1orv67/nJvj831HmkEmwh44HkEEEt0WHiWIAul4l4FE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=eH0Ec1LtDxjUG28GC1NmqfuGSKc9FG7i/Q2dx9vFjucnYamqgCgPgYPcjMtlAxYCH
         a+eAcGwu0lhekxJW/KMCqaCo/ItV6z9fp7mwRQtoJGd/7gMqExf6YYRVJJdm/jcE4j
         TdNv+pedIgmhDNMwh46/T1KJZfpu0eegDaK58/iw=
Subject: Re: [PATCH linux-next v9 7/7] selftests/ptrace: add a test case for
 PTRACE_GET_SYSCALL_INFO
To:     "Dmitry V. Levin" <ldv@altlinux.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190408174036.GA11889@altlinux.org>
 <20190408174236.GH11889@altlinux.org>
From:   shuah <shuah@kernel.org>
Message-ID: <f2f015da-35d4-7207-cd57-e6589cd9d2c4@kernel.org>
Date:   Mon, 8 Apr 2019 11:51:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190408174236.GH11889@altlinux.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/19 11:42 AM, Dmitry V. Levin wrote:
> Check whether PTRACE_GET_SYSCALL_INFO semantics implemented in the kernel
> matches userspace expectations.
> 
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Elvira Khabirova <lineprinter@altlinux.org>
> Cc: Eugene Syromyatnikov <esyr@redhat.com>
> Cc: linux-kselftest@vger.kernel.org
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> ---
> 
> Notes:
>      v9: unchanged
>      v8: unchanged
>      v7: unchanged
>      v6: made PTRACE_GET_SYSCALL_INFO return value checks strict
>      v5: initial revision
> 
>   tools/testing/selftests/ptrace/.gitignore     |   1 +
>   tools/testing/selftests/ptrace/Makefile       |   2 +-
>   .../selftests/ptrace/get_syscall_info.c       | 271 ++++++++++++++++++
>   3 files changed, 273 insertions(+), 1 deletion(-)
>   create mode 100644 tools/testing/selftests/ptrace/get_syscall_info.c
> 
> diff --git a/tools/testing/selftests/ptrace/.gitignore b/tools/testing/selftests/ptrace/.gitignore
> index b3e59d41fd82..cfcc49a7def7 100644
> --- a/tools/testing/selftests/ptrace/.gitignore
> +++ b/tools/testing/selftests/ptrace/.gitignore
> @@ -1 +1,2 @@
> +get_syscall_info
>   peeksiginfo
> diff --git a/tools/testing/selftests/ptrace/Makefile b/tools/testing/selftests/ptrace/Makefile
> index 8a2bc5562179..4bc550b6b845 100644
> --- a/tools/testing/selftests/ptrace/Makefile
> +++ b/tools/testing/selftests/ptrace/Makefile
> @@ -1,5 +1,5 @@
>   CFLAGS += -iquote../../../../include/uapi -Wall
>   
> -TEST_GEN_PROGS := peeksiginfo
> +TEST_GEN_PROGS := get_syscall_info peeksiginfo
>   
>   include ../lib.mk
> diff --git a/tools/testing/selftests/ptrace/get_syscall_info.c b/tools/testing/selftests/ptrace/get_syscall_info.c
> new file mode 100644
> index 000000000000..28e972825b74
> --- /dev/null
> +++ b/tools/testing/selftests/ptrace/get_syscall_info.c
> @@ -0,0 +1,271 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later
> + *

This should be just GPL-2.0+

The rest looks good to me. Assuming this patch has dependency on the
rest of the patches in this series and once the above change is made:

Acked-by: Shuah Khan <shuah@kernel.org>

thnaks,
-- Shuah

