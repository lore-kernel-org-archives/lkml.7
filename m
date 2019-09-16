Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E8FC4CECD
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 16:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B41D8214D9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 16:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568652257;
	bh=/vl4XZg36JrNwZ/5nnvRHDpnQMM8DhYL3wkGfsRhiYw=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=FjFprgy0jS8cpDVG3YshxOOov3ko0ezJ9Dq5ako7hGFimA3Rb+dqFAw1t4trhElny
	 SwPMlB+1ipPNE/96URQsoruIPDuDCX3BpogSqlbPe6HS15fBVk2CK+T4ixpnYLeSqP
	 FIuuMPIxGeU62S7kU3v25W5ppHQuWAzv6d5Z9CwY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390119AbfIPQoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 12:44:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:37594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727981AbfIPQoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 12:44:16 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DED4214D9;
        Mon, 16 Sep 2019 16:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568652255;
        bh=/vl4XZg36JrNwZ/5nnvRHDpnQMM8DhYL3wkGfsRhiYw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Z1iPweTk2tyNn3UJWaQveE4CYMrl5iWTSI5+RDXQ4uSDADz2njmZhF4Zl1v+uvBFt
         LrDvlicis7rQjjvOd1qBc5a7JC1mIaYNK23y/QlhrsMgIiDB1i1V+zJZOSCgcYX0lW
         tOy1/jPlE5bbffBFdBg8QtMwP4BU1v/TOQ1NaVJ4=
Subject: Re: [PATCH 5/6] selftests/clone3: enable clone3 self-tests on all
 architectures
To:     Eugene Syromiatnikov <esyr@redhat.com>,
        linux-kernel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        linux-kselftest@vger.kernel.org
Cc:     Adrian Reber <areber@redhat.com>, shuah <shuah@kernel.org>
References: <cover.1568116761.git.esyr@redhat.com>
 <d1a101897be9ee31b11f13ec61384f004dafd40c.1568116761.git.esyr@redhat.com>
From:   shuah <shuah@kernel.org>
Message-ID: <5d140570-765d-2bab-4f46-d45e9cfc0944@kernel.org>
Date:   Mon, 16 Sep 2019 10:44:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <d1a101897be9ee31b11f13ec61384f004dafd40c.1568116761.git.esyr@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/10/19 6:03 AM, Eugene Syromiatnikov wrote:
> clone3() is available on most architectures, so there's no reason to
> restrict the respective self-tests to x86_64.
> 

Is it missing on any? Please key off of the return value and exit with
skip if unsupported.

> * tools/testing/selftests/clone3/Makefile (TEST_GEN_PROGS): Set always,
> not only ifeq ($(ARCH),x86_64).
> 

Please - no file names in commit log.

> Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
> ---
>   tools/testing/selftests/clone3/Makefile | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/clone3/Makefile b/tools/testing/selftests/clone3/Makefile
> index 4efcf45..faa069c 100644
> --- a/tools/testing/selftests/clone3/Makefile
> +++ b/tools/testing/selftests/clone3/Makefile
> @@ -4,8 +4,6 @@ ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/i386/)
>   
>   CFLAGS += -I../../../../usr/include/
>   
> -ifeq ($(ARCH),x86_64)
> -	TEST_GEN_PROGS := clone3 clone3_set_tid
> -endif
> +TEST_GEN_PROGS := clone3 clone3_set_tid
>   
>   include ../lib.mk
> 

This is fine. Where is the code to handle unsupported case?

thanks,
-- Shuah
