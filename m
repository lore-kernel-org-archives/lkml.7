Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8216BC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 10:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E39B2070D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 10:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbfG2KQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 06:16:53 -0400
Received: from foss.arm.com ([217.140.110.172]:41462 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbfG2KQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 06:16:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1384E344;
        Mon, 29 Jul 2019 03:16:53 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 526EC3F694;
        Mon, 29 Jul 2019 03:16:52 -0700 (PDT)
Subject: Re: build error
To:     Will Deacon <will@kernel.org>, Matteo Croce <mcroce@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <CAGnkfhySwXY7YwuQezyx6cEpemZW4Hox1_4fQJm3-5hvM3G6gw@mail.gmail.com>
 <20190729095047.k45isr7etq3xkyvr@willie-the-truck>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <1cfad84e-5a98-99bd-07c2-9db0cf37292b@arm.com>
Date:   Mon, 29 Jul 2019 11:16:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190729095047.k45isr7etq3xkyvr@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matteo and Will,

On 29/07/2019 10:50, Will Deacon wrote:
> Hi Matteo,
> 
> On Sun, Jul 28, 2019 at 10:08:06PM +0200, Matteo Croce wrote:
>> I get this build error with 5.3-rc2"
>>
>> # make
>> arch/arm64/Makefile:58: gcc not found, check CROSS_COMPILE_COMPAT.  Stop.
>>
>> I didn't bisect the tree, but I guess that this kconfig can be related
>>
>> # grep CROSS_COMPILE_COMPAT .config
>> CONFIG_CROSS_COMPILE_COMPAT_VDSO=""
>>
>> Does someone have any idea? Am I missing something?
> 
> Can you try something like the below?
> 
> Will
> 
> --->8
> 
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index bb1f1dbb34e8..d35ca0aee295 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -52,7 +52,7 @@ ifeq ($(CONFIG_GENERIC_COMPAT_VDSO), y)
>  
>    ifeq ($(CONFIG_CC_IS_CLANG), y)
>      $(warning CROSS_COMPILE_COMPAT is clang, the compat vDSO will not be built)
> -  else ifeq ($(CROSS_COMPILE_COMPAT),)
> +  else ifeq ("$(CROSS_COMPILE_COMPAT)","")
>      $(warning CROSS_COMPILE_COMPAT not defined or empty, the compat vDSO will not be built)
>    else ifeq ($(shell which $(CROSS_COMPILE_COMPAT)gcc 2> /dev/null),)
>      $(error $(CROSS_COMPILE_COMPAT)gcc not found, check CROSS_COMPILE_COMPAT)
> 

If I try to build a fresh kernel on my machine with the standard "make mrproper
&& make defconfig && make" I do not see the reported issue (Please see below
scissors).

At this point would be interesting to know more about how Matteo is building the
kernel, and try to reproduce the issue here.

@Matteo, could you please provide the full .config and the steps you used to
generate it? Is it an 'oldconfig'?

--->8---

Message of detection of empty compat compiler:
----------------------------------------------

arch/arm64/Makefile:56: CROSS_COMPILE_COMPAT not defined or empty, the compat
vDSO will not be built


Generated .config:
------------------

$ cat .config | grep COMPAT
CONFIG_COMPAT=y
...
CONFIG_GENERIC_COMPAT_VDSO=y
CONFIG_CROSS_COMPILE_COMPAT_VDSO=""


-- 
Regards,
Vincenzo
