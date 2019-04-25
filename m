Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 366FEC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 944CF2088F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556210189;
	bh=kKR2dRBCHpCOwcQSUqDDfOdrUBjh21hmC5tW34b7iUs=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=sIH4F730rJwLxrAKtifWkEKi5vxg4s/+pL7AYCL+kofp/MgP0ifUwGUgXxc7N6Dza
	 14tuM8PLpVm11tONj1s8oK2PuQK/ZnE1KwQbxw4R519AZuEryvYQv6x1m6IWZ7HBVx
	 js9k+D7i8p3GX7r+Nfo16YgWjcFpZILRoHgyQ4x4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbfDYQg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 12:36:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:36502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbfDYQg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 12:36:27 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 785B120717;
        Thu, 25 Apr 2019 16:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556210187;
        bh=kKR2dRBCHpCOwcQSUqDDfOdrUBjh21hmC5tW34b7iUs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=oRmOHwMKpEwwuLwLLpybFVL3d0MYy5lgLREGudlAb6hUGy1Ul+E/1YMBXbVVK+vuQ
         08mvRwgxf41ud2WgBwnIcb4tuQOk4Kxi2tHkBZnYrE8Q0DbmegYZR2UbB5WuWXKhR8
         ZHhvQPMSKXqgU0qLzHRIUd5T3AskPTXlSe4ZTWlM=
Subject: Re: [PATCH v2 7/8] selftests: Remove KSFT_TAP_LEVEL
To:     Kees Cook <keescook@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Christian Brauner <christian@brauner.io>,
        Tycho Andersen <tycho@tycho.ws>,
        Serge Hallyn <serge@hallyn.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <20190424231237.14776-1-keescook@chromium.org>
 <20190424231237.14776-8-keescook@chromium.org>
From:   shuah <shuah@kernel.org>
Message-ID: <1ca5ee52-ab07-9142-2e45-44df1e94276e@kernel.org>
Date:   Thu, 25 Apr 2019 10:36:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190424231237.14776-8-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/19 5:12 PM, Kees Cook wrote:
> Since sub-testing can now be detected by indentation level, this removes
> KSFT_TAP_LEVEL so that subtests report their TAP header for later parsing.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>   tools/testing/selftests/Makefile            | 6 ------
>   tools/testing/selftests/kselftest/runner.sh | 1 -
>   2 files changed, 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index 64699f59b95f..9f05448e5e4b 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -86,12 +86,6 @@ else
>   	endif
>   endif
>   
> -# KSFT_TAP_LEVEL is used from KSFT framework to prevent nested TAP header
> -# printing from tests. Applicable to run_tests case where run_tests adds
> -# TAP header prior running tests and when a test program invokes another
> -# with system() call. Export it here to cover override RUN_TESTS defines.
> -export KSFT_TAP_LEVEL=`echo 1`
> -
>   # Prepare for headers install
>   top_srcdir ?= ../../..
>   include $(top_srcdir)/scripts/subarch.include
> diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
> index b9f74e5a2ee5..eff3ee303d0d 100644
> --- a/tools/testing/selftests/kselftest/runner.sh
> +++ b/tools/testing/selftests/kselftest/runner.sh
> @@ -2,7 +2,6 @@
>   # SPDX-License-Identifier: GPL-2.0
>   #
>   # Runs a set of tests in a given subdirectory.
> -export KSFT_TAP_LEVEL=1
>   export skip_rc=4
>   export logfile=/dev/stdout
>   export per_test_logging=
> 

Does this take into ksft_print_header() getenv logic to avoid printing
TAP headers from tests when they fork? e.g timers tests do that a lot.

thanks,
-- Shuah


