Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 430A8C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 16:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1697B20692
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 16:32:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tessares-net.20150623.gappssmtp.com header.i=@tessares-net.20150623.gappssmtp.com header.b="cI5GhUFA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfKUQcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 11:32:47 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34169 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfKUQcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 11:32:47 -0500
Received: by mail-wm1-f65.google.com with SMTP id j18so8132340wmk.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 08:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NQxtDcltG16uG1uS9wamfGd4yutfyPnnxbr+AjuLUAM=;
        b=cI5GhUFAm0E84FvqsurqwXZ2PTpfPLTDEBEN4BTQHPAETIZonjrn3V2Re572L5Z7WZ
         rPdNCcbzFm9XNm6ITcrbeR2Yofw25xbtS6truDenPKi644jLuU1CmDuhT/9qZBr89Ypq
         uWYlH3MKkCVQG1N3rzsBn8RhA0MqB2RXjwvs49Xy7gL8xWcyp9vC01NSEqVIC8ZWDXB0
         rLZkALZW4UD49fjYQo0H71Hit/36ZDI9PNKRj39O2kqvUsKo2pPyMDbRVS92lPTzYSfI
         8faJj7wSG266tAc0RiveJhSpwZy5o12t5AdVo5DShGGYWC/DAz5LrZLWjxn1EsVfSwvE
         qFfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NQxtDcltG16uG1uS9wamfGd4yutfyPnnxbr+AjuLUAM=;
        b=SLDr0e07WY6xrqh6cEVorYMXype0U3C0ZLLGzGIlxnuBc/ltFdphqq/R9RsR3q1o01
         vkxD8edwf6u8JLgyw6GkyGqJcUVowi4SfBpjKvLqX4dA2EvubIUnze8BnduhZQ/o6ecf
         53pMGdTtUFNo6AbIpbtrHQxt7tghN4IFhhxNk70rz8Q1ufkXLmadnIEbW+BQAhjvB5zE
         VwZsEa7T12aSl/JPjJHnw/ZKvPxJx6ZK2xsFRf6ITp0giglmH3oqB4AxCm9Tr1d9E0tw
         PhZB/KgH/JFfOvIUH6ZIFaTHUvHAfL4TlCDq0CNoUVhUFQ2ExGudxIMLUklcqz+sk9VS
         r5qw==
X-Gm-Message-State: APjAAAVIlvvWcnkS5IA9gqf679x5mDOvu9AS3jbemuflICsTHFAXPWB0
        rVxRZYTZEet0btRW9g5LsXGwNc12kG2a9Q==
X-Google-Smtp-Source: APXvYqyhX3P6aJ0eBeiUHi+lNIMXMOPRcx29eHnfiokfxYjutI8j2DDb2UTjkGeqfIJW6fDnnPrkzg==
X-Received: by 2002:a7b:c7d3:: with SMTP id z19mr11321336wmk.98.1574353964502;
        Thu, 21 Nov 2019 08:32:44 -0800 (PST)
Received: from tsr-lap-08.nix.tessares.net (hag0-main.tessares.net. [87.98.252.165])
        by smtp.gmail.com with ESMTPSA id w11sm4353502wra.83.2019.11.21.08.32.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2019 08:32:43 -0800 (PST)
Subject: Re: [PATCH] selftests: settings: tests can be in subsubdirs
To:     Shuah Khan <shuah@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191022171223.27934-1-matthieu.baerts@tessares.net>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <c9ce5016-9e83-67c0-ae22-2d3c46427b25@tessares.net>
Date:   Thu, 21 Nov 2019 17:32:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191022171223.27934-1-matthieu.baerts@tessares.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shuah,

First, thank you for maintaining the Kernel Selftest framework!

On 22/10/2019 19:12, Matthieu Baerts wrote:
> Commit 852c8cbf34d3 (selftests/kselftest/runner.sh: Add 45 second
> timeout per test) adds support for a new per-test-directory "settings"
> file. But this only works for tests not in a sub-subdirectories, e.g.
> 
>   - tools/testing/selftests/rtc (rtc) is OK,
>   - tools/testing/selftests/net/mptcp (net/mptcp) is not.
> 
> We have to increase the timeout for net/mptcp tests which are not
> upstreamed yet but this fix is valid for other tests if they need to add
> a "settings" file, see the full list with:
> 
>    tools/testing/selftests/*/*/**/Makefile
> 
> Note that this patch changes the text header message printed at the end
> of the execution but this text is modified only for the tests that are
> in sub-subdirectories, e.g.
> 
>    ok 1 selftests: net/mptcp: mptcp_connect.sh
> 
> Before we had:
> 
>    ok 1 selftests: mptcp: mptcp_connect.sh
> 
> But showing the full target name is probably better, just in case a
> subsubdir has the same name as another one in another subdirectory.
> 
> Fixes: 852c8cbf34d3 (selftests/kselftest/runner.sh: Add 45 second timeout per test)
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Sorry to bother you again with this but by chance, did you have a look 
at the patch below? :)

It doesn't only fix an issue with MPTCP, not in the kernel yet. But it 
also fixes the issue of taking the right "settings" file (if available) 
for any other tests in a sub-directory, e.g.:

   drivers/dma-buf
   filesystems/binderfs
   net/forwarding
   networking/timestamping

But I guess all tests in powerpc/* dirs and others.

Cheers,
Matt

> ---
>   tools/testing/selftests/kselftest/runner.sh | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
> index 84de7bc74f2c..0d7a89901ef7 100644
> --- a/tools/testing/selftests/kselftest/runner.sh
> +++ b/tools/testing/selftests/kselftest/runner.sh
> @@ -90,7 +90,7 @@ run_one()
>   run_many()
>   {
>   	echo "TAP version 13"
> -	DIR=$(basename "$PWD")
> +	DIR="${PWD#${BASE_DIR}/}"
>   	test_num=0
>   	total=$(echo "$@" | wc -w)
>   	echo "1..$total"
> 

-- 
Matthieu Baerts | R&D Engineer
matthieu.baerts@tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
