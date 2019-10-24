Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F92CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 23:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76FF920650
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 23:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Bv5nspXZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732214AbfJXXey (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 19:34:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47080 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727446AbfJXXex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 19:34:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OJw5ZmjGXAsA3sm9+sitk/amoBIrD9+6eN7vsgzpRII=; b=Bv5nspXZoUneRGQhj6pwSf/NB
        wHanD+G8xtrEdxoLpdS4ujDhnbewXxhtblHghT3lqLR5GBhCaNCO2n/WSkGAYoJXdtLvsEYeC+SUx
        qGILMiiDQQ38Ad+fBPNVY1DWQ0QeuAHlW7Xu5VlSIymdhkmJUXOkRBZ2cYbv46coIPdSEIrcCKS2B
        Udpo1lMWrUAIrQDrRU7A+9w+X3qrbnsI1DoNLahrbL9birpNGja+rO1GodiMI2AFr8EOJg6yyBNiN
        zM2YPrMTacxKZTGFPA+gQt8dpT5dGMU03idEKTcdmAP+VxMYAd57CtKazSFQTyeIK86uSWdCMYAhr
        gSNnywJ7A==;
Received: from [2601:1c0:6280:3f0::9ef4]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iNmcw-0007S0-JD; Thu, 24 Oct 2019 23:34:46 +0000
Subject: Re: mlockall(MCL_CURRENT) blocking infinitely
To:     Robert Stupp <snazy@snazy.de>, linux-kernel@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>
References: <4576b336-66e6-e2bb-cd6a-51300ed74ab8@snazy.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Potyra, Stefan" <Stefan.Potyra@elektrobit.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b8ff71f5-2d9c-7ebb-d621-017d4b9bc932@infradead.org>
Date:   Thu, 24 Oct 2019 16:34:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <4576b336-66e6-e2bb-cd6a-51300ed74ab8@snazy.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[adding linux-mm + people]

I see only one change in the last 4 years:

commit dedca63504a204dc8410d98883fdc16dffa8cb80
Author: Potyra, Stefan <Stefan.Potyra@elektrobit.com>
Date:   Thu Jun 13 15:55:55 2019 -0700

    mm/mlock.c: mlockall error for flag MCL_ONFAULT


On 10/24/19 12:36 AM, Robert Stupp wrote:
> Hi guys,
> 
> I've got an issue with `mlockall(MCL_CURRENT)` after upgrading Ubuntu 19.04 to 19.10 - i.e. kernel version change from 5.0.x to 5.3.x.
> 
> The following simple program hangs forever with one CPU running at 100% (kernel):
> 
> #include <stdio.h>
> #include <sys/mman.h>
> int main(char** argv) {
>   printf("Before mlockall(MCL_CURRENT)\n");
>   // works in 5.0
>   // hangs forever w/ 5.1 and newer
>   mlockall(MCL_CURRENT);
>   printf("After mlockall(MCL_CURRENT)\n");
> }
> 
> All kernel versions since 5.1 (tried 5.1.0, 5.1.21, 5.2.21, 5.3.0-19, 5.3.7, 5.4-rc4) show the same symptom (hanging in mlockall(MCL_CURRENT) with 100% kernel-CPU). 5.0 kernel versions (5.0.21) are fine.
> 
> First, I thought, that it's something generic, so I tried the above program in a fresh install of Ubuntu eoan (5.3.x) in a VM in virtualbox, but it works fine there. So I suspect, that it has to do with something that's specific to my machine.
> 
> My first suspicion was that some library "hijacks" mlockall(), but calling the test program with `LD_DEBUG=all` shows that glibc gets called directly:
>      12248:    symbol=mlockall;  lookup in file=./test [0]
>      12248:    symbol=mlockall;  lookup in file=/lib/x86_64-linux-gnu/libc.so.6 [0]
>      12248:    binding file ./test [0] to /lib/x86_64-linux-gnu/libc.so.6 [0]: normal symbol `mlockall' [GLIBC_2.2.5]
> An `strace` doesn't show anything meaningful (beside that mlockall's been called but never returns). dmesg and syslog don't show anything obvious (to me) as well.
> 
> Some information about the machine:
> - Intel(R) Core(TM) i7-6900K, Intel X99 chipset
> - NVMe 1.1b
> - 64GB RAM (4x 16GB)
> 
> I've also reverted all changes for sysctl and ld.conf and checked for other suspicious software without any luck.
> 
> I also tried a bunch of variations of the above program, but only `mlockall(MCL_CURRENT)` or `mlockall(MCL_FUTURE | MCL_CURRENT)` hang.
> 
> A `git diff v5.0..v5.1 mm/` doesn't show anything obvious (to me).
> 
> It seems, there's no debug/trace information that would help to find out what exactly it's doing.
> 
> I'm kinda lost at the moment.
> 
> 
> PS: Variations of the above test program:
> 
> #include <stdio.h>
> #include <sys/mman.h>
> char foo[65536];
> int main(char** argv) {
>   printf("Before mlock()\n");
>   int e = mlock(foo, 8192); // works in 5.0, 5.1, 5.2, 5.3, 5.4
>   printf("After mlock()=%d\n", e);
> }
> 
> 
> #include <stdio.h>
> #include <stdlib.h>
> #include <sys/mman.h>
> int main(char** argv) {
>   printf("Before mlockall(MCL_FUTURE)\n");
>   int e = mlockall(MCL_FUTURE); // works in 5.0, 5.1, 5.2, 5.3, 5.4
>   printf("After mlockall(MCL_FUTURE) = %d\n", e);
>   void* mem = malloc(1024 * 1024 * 1024);
>   printf("After malloc()\n");
>   mem = malloc(1024 * 1024 * 1024);
>   printf("After malloc()\n");
>   mem = malloc(1024 * 1024 * 1024);
>   printf("After malloc()\n");
>   // works in 5.0, 5.1, 5.2, 5.3, 5.4
> }
> 
> 
> #include <stdio.h>
> #include <sys/mman.h>
> int main(char** argv) {
>   printf("Before munlockall()\n");
>   int e = munlockall(); // works in 5.0, 5.1, 5.2, 5.3, 5.4
>   printf("After munlockall() = %d\n", e);
> }
> 
> 
> #include <stdio.h>
> #include <sys/mman.h>
> int main(char** argv) {
>   printf("Before mlockall(MCL_CURRENT|MCL_FUTURE)\n");
>   // works in 5.0
>   // hangs forever w/ 5.1 and newer
>   int e = mlockall(MCL_CURRENT|MCL_FUTURE);
>   printf("After mlockall(MCL_CURRENT|MCL_FUTURE) = %d\n", e);
> }
> 
> PPS: Kernel version images installed from https://kernel.ubuntu.com/~kernel-ppa/mainline/?C=N;O=D
> 


-- 
~Randy

