Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0095EC282E3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 05:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDC39217FA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 05:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbfDYFaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 01:30:12 -0400
Received: from namei.org ([65.99.196.166]:35708 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbfDYFaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 01:30:12 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x3P5U7pC024926;
        Thu, 25 Apr 2019 05:30:07 GMT
Date:   Thu, 25 Apr 2019 15:30:07 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Kees Cook <keescook@chromium.org>
cc:     Tycho Andersen <tycho@tycho.ws>, stable@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] selftests/seccomp: Prepare for exclusive seccomp
 flags
In-Reply-To: <20190424163756.40001-2-keescook@chromium.org>
Message-ID: <alpine.LRH.2.21.1904251530010.26472@namei.org>
References: <20190424163756.40001-1-keescook@chromium.org> <20190424163756.40001-2-keescook@chromium.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Apr 2019, Kees Cook wrote:

> Some seccomp flags will become exclusive, so the selftest needs to
> be adjusted to mask those out and test them individually for the "all
> flags" tests.
> 
> Cc: stable@vger.kernel.org # v5.0+
> Signed-off-by: Kees Cook <keescook@chromium.org>


Acked-by: James Morris <jamorris@linux.microsoft.com>

> ---
>  tools/testing/selftests/seccomp/seccomp_bpf.c | 34 ++++++++++++++-----
>  1 file changed, 25 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
> index f69d2ee29742..5019cdae5d0b 100644
> --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
> +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
> @@ -2166,11 +2166,14 @@ TEST(detect_seccomp_filter_flags)
>  				 SECCOMP_FILTER_FLAG_LOG,
>  				 SECCOMP_FILTER_FLAG_SPEC_ALLOW,
>  				 SECCOMP_FILTER_FLAG_NEW_LISTENER };
> -	unsigned int flag, all_flags;
> +	unsigned int exclusive[] = {
> +				SECCOMP_FILTER_FLAG_TSYNC,
> +				SECCOMP_FILTER_FLAG_NEW_LISTENER };
> +	unsigned int flag, all_flags, exclusive_mask;
>  	int i;
>  	long ret;
>  
> -	/* Test detection of known-good filter flags */
> +	/* Test detection of individual known-good filter flags */
>  	for (i = 0, all_flags = 0; i < ARRAY_SIZE(flags); i++) {
>  		int bits = 0;
>  
> @@ -2197,16 +2200,29 @@ TEST(detect_seccomp_filter_flags)
>  		all_flags |= flag;
>  	}
>  
> -	/* Test detection of all known-good filter flags */
> -	ret = seccomp(SECCOMP_SET_MODE_FILTER, all_flags, NULL);
> -	EXPECT_EQ(-1, ret);
> -	EXPECT_EQ(EFAULT, errno) {
> -		TH_LOG("Failed to detect that all known-good filter flags (0x%X) are supported!",
> -		       all_flags);
> +	/*
> +	 * Test detection of all known-good filter flags combined. But
> +	 * for the exclusive flags we need to mask them out and try them
> +	 * individually for the "all flags" testing.
> +	 */
> +	exclusive_mask = 0;
> +	for (i = 0; i < ARRAY_SIZE(exclusive); i++)
> +		exclusive_mask |= exclusive[i];
> +	for (i = 0; i < ARRAY_SIZE(exclusive); i++) {
> +		flag = all_flags & ~exclusive_mask;
> +		flag |= exclusive[i];
> +
> +		ret = seccomp(SECCOMP_SET_MODE_FILTER, flag, NULL);
> +		EXPECT_EQ(-1, ret);
> +		EXPECT_EQ(EFAULT, errno) {
> +			TH_LOG("Failed to detect that all known-good filter flags (0x%X) are supported!",
> +			       flag);
> +		}
>  	}
>  
> -	/* Test detection of an unknown filter flag */
> +	/* Test detection of an unknown filter flags, without exclusives. */
>  	flag = -1;
> +	flag &= ~exclusive_mask;
>  	ret = seccomp(SECCOMP_SET_MODE_FILTER, flag, NULL);
>  	EXPECT_EQ(-1, ret);
>  	EXPECT_EQ(EINVAL, errno) {
> 

-- 
James Morris
<jmorris@namei.org>

