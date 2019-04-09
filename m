Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55FF9C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 15:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 231B720833
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 15:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="S8OeXBkg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbfDIPGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 11:06:42 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:36560 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbfDIPGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 11:06:42 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 07C8C5C049E;
        Tue,  9 Apr 2019 17:06:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1554822399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mFcQankGcxlTRtVWL5OghSI7av78saWyFI9XAL/gLqk=;
        b=S8OeXBkg9kxEAMZdDWioKqkliPMZD81MaWGBFqCCkATp2X0RdZ69WyDcwyLme3hz1rRvNy
        w7oZJgov9kwSZsFBPQ/68t8HoFN5IoEs6vLaO1naS39+aI4LRvym9EtQp+/VFaEDmK48Qx
        4yty/CFzjmbRLNB3BQsJFbCrpndMEE0=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Date:   Tue, 09 Apr 2019 17:06:38 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     =?UTF-8?Q?M=C3=A5ns_Rullg=C3=A5rd?= <mans@mansr.com>
Cc:     arm@kernel.org, linux@armlinux.org.uk, arnd@arndb.de,
        ard.biesheuvel@linaro.org, robin.murphy@arm.com,
        nicolas.pitre@linaro.org, f.fainelli@gmail.com, rjui@broadcom.com,
        sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        kgene@kernel.org, krzk@kernel.org, robh@kernel.org,
        ssantosh@kernel.org, jason@lakedaemon.net, andrew@lunn.ch,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        tony@atomide.com, marc.w.gonzalez@free.fr, ndesaulniers@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] ARM: use arch_extension directive instead of arch
 argument
In-Reply-To: <yw1xk1g3xt4o.fsf@mansr.com>
References: <7b3b9d2150d491b5cb3761d96b215749ea63175f.1554757135.git.stefan@agner.ch>
 <yw1xk1g3xt4o.fsf@mansr.com>
Message-ID: <398fb21bc96007bac89dce25ed2eb79e@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.04.2019 14:25, Måns Rullgård wrote:
> Stefan Agner <stefan@agner.ch> writes:
> 
>> The LLVM Target parser currently does not allow to specify the security
>> extension as part of -march (see also LLVM Bug 40186 [0]). When trying
>> to use Clang with LLVM's integrated assembler, this leads to build
>> errors such as this:
>>   clang-8: error: the clang compiler does not support '-Wa,-march=armv7-a+sec'
>>
>> Use ".arch_extension sec" to enable the security extension in a more
>> portable fasion. Also make sure to use ".arch armv7-a" in case a v6/v7
>> multi-platform kernel is being built.
>>
>> Note that this is technically not exactly the same as the old code
>> checked for availabilty of the security extension by calling as-instr.
>> However, there are already other sites which use ".arch_extension sec"
>> unconditionally, hence de-facto we need an assembler capable of
>> ".arch_extension sec" already today (arch/arm/mm/proc-v7.S). The
>> arch extension "sec" is available since binutils 2.21 according to
>> its documentation [1].
>>
>> [0] https://bugs.llvm.org/show_bug.cgi?id=40186
>> [1] https://sourceware.org/binutils/docs-2.21/as/ARM-Options.html
>>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> Acked-by: Mans Rullgard <mans@mansr.com>
>> Acked-by: Arnd Bergmann <arnd@arndb.de>
>> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
>> ---
>> Changes since v1:
>> - Explicitly specify assembler architecture as armv7-a to avoid
>>   build issues when bulding v6/v7 multi arch kernel.
>>
>>  arch/arm/mach-bcm/Makefile         | 3 ---
>>  arch/arm/mach-bcm/bcm_kona_smc.c   | 2 --
>>  arch/arm/mach-exynos/Makefile      | 4 ----
>>  arch/arm/mach-exynos/exynos-smc.S  | 3 ++-
>>  arch/arm/mach-exynos/sleep.S       | 3 ++-
>>  arch/arm/mach-highbank/Makefile    | 3 ---
>>  arch/arm/mach-highbank/smc.S       | 3 ++-
>>  arch/arm/mach-keystone/Makefile    | 3 ---
>>  arch/arm/mach-keystone/smc.S       | 1 +
>>  arch/arm/mach-omap2/Makefile       | 8 --------
>>  arch/arm/mach-omap2/omap-headsmp.S | 2 ++
>>  arch/arm/mach-omap2/omap-smc.S     | 3 ++-
>>  arch/arm/mach-omap2/sleep33xx.S    | 1 +
>>  arch/arm/mach-omap2/sleep34xx.S    | 2 ++
>>  arch/arm/mach-omap2/sleep43xx.S    | 2 ++
>>  arch/arm/mach-omap2/sleep44xx.S    | 2 ++
>>  arch/arm/mach-tango/Makefile       | 3 ---
>>  arch/arm/mach-tango/smc.S          | 1 +
>>  18 files changed, 19 insertions(+), 30 deletions(-)
> 
> [...]
> 
>> diff --git a/arch/arm/mach-bcm/bcm_kona_smc.c b/arch/arm/mach-bcm/bcm_kona_smc.c
>> index a55a7ecf146a..541e850a736c 100644
>> --- a/arch/arm/mach-bcm/bcm_kona_smc.c
>> +++ b/arch/arm/mach-bcm/bcm_kona_smc.c
>> @@ -125,9 +125,7 @@ static int bcm_kona_do_smc(u32 service_id, u32 buffer_phys)
>>  		__asmeq("%2", "r4")
>>  		__asmeq("%3", "r5")
>>  		__asmeq("%4", "r6")
>> -#ifdef REQUIRES_SEC
>>  		".arch_extension sec\n"
>> -#endif
>>  		"	smc    #0\n"
>>  		: "=r" (ip), "=r" (r0)
>>  		: "r" (r4), "r" (r5), "r" (r6)
> 
> [...]
> 
>> diff --git a/arch/arm/mach-keystone/smc.S b/arch/arm/mach-keystone/smc.S
>> index d15de8179fab..ec03dc499270 100644
>> --- a/arch/arm/mach-keystone/smc.S
>> +++ b/arch/arm/mach-keystone/smc.S
>> @@ -21,6 +21,7 @@
>>   *
>>   * Return: Non zero value on failure
>>   */
>> +	.arch_extension sec
>>  ENTRY(keystone_cpu_smc)
>>  	stmfd   sp!, {r4-r11, lr}
>>  	smc	#0
> 
> [...]
> 
>> diff --git a/arch/arm/mach-tango/smc.S b/arch/arm/mach-tango/smc.S
>> index 361a8dc89804..cf2d21e5226c 100644
>> --- a/arch/arm/mach-tango/smc.S
>> +++ b/arch/arm/mach-tango/smc.S
>> @@ -1,6 +1,7 @@
>>  /* SPDX-License-Identifier: GPL-2.0 */
>>  #include <linux/linkage.h>
>>
>> +	.arch_extension sec
>>  ENTRY(tango_smc)
>>  	push	{lr}
>>  	mov	ip, r1
> 
> Is there some reason these three don't need the .arch directive?

They all do not use a memory barrier instruction (e.g. dmb) which caused
issues on the other files.

--
Stefan
