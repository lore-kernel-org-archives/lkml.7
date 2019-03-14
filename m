Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9739C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 15:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78A66217F5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 15:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mathtm.de header.i=@mathtm.de header.b="cmNMzxUp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbfCNP3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 11:29:46 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.23]:23449 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbfCNP3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 11:29:46 -0400
X-Greylist: delayed 361 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Mar 2019 11:29:44 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1552577382;
        s=strato-dkim-0002; d=mathtm.de;
        h=Date:Message-ID:Subject:From:To:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=+qCoVkBUNb7Qtjbr7Xoeoygsd8IzlvK03GshbbNEq5Y=;
        b=cmNMzxUpDqg+/4V0thtRxP6inEqSn+kwFhZ94NAg+XibpDVh802qzGQwtlT2BCY7bP
        zkQYs4y8OxhOeRWFHosk3etgJGv5s1l48qXxeJHpcyjF/e+ZKsOoJhyC+V0nDR32LAPp
        X5sOlpHnPvLI4SNaL6/tZdis6Zhl4nc51O66UbrbaTPvCXoePGeC2peqYNhWmp8gp70h
        wWW1zC6NDBX2n8+KxPthenZiHA/80EWY3rTkOsf2dFyoJQ4GArKPSWGsrUGNOik2N5z8
        HleI4Ou415RmD6N+mnoF5Qx4mz7XFhC6OyFKFT1UAwP41f6I7+hfRb4y/pwNzN66p0lV
        GPTA==
X-RZG-AUTH: ":OGQLeEG7W/KAXU7xLV2hdHgxFRdqbfEqQfblTbv8grSYpDW1Ean4C8uHphsoybv57wpo"
X-RZG-CLASS-ID: mo00
Received: from [10.9.21.31]
        by smtp.strato.de (RZmta 44.16 AUTH)
        with ESMTPSA id N09c5bv2EFHS17m
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 14 Mar 2019 16:17:28 +0100 (CET)
To:     peterz@infradead.org, linux-kernel@vger.kernel.org
From:   =?UTF-8?Q?Thomas_M=c3=bcller?= <thomas@mathtm.de>
Subject: disabling secondary CPU hangs / system fails to suspend with kernel
 4.19+
Openpgp: preference=signencrypt
Autocrypt: addr=thomas@mathtm.de; prefer-encrypt=mutual; keydata=
 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
Message-ID: <5c48095e-028a-404f-aaa1-964f83c83817@mathtm.de>
Date:   Thu, 14 Mar 2019 16:17:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

starting with kernel 4.19 my Lenovo ThinkPad X1 Carbon 5th no longer properly suspends.

This is 100% reproducible and git bisect points to the following commit:
> [be45bf5395e0886a93fc816bbe41a008ec2e42e2] watchdog/softlockup: Fix cpu_stop_queue_work() double-queue bug
> be45bf5395e0886a93fc816bbe41a008ec2e42e2 is the first bad commit
> commit be45bf5395e0886a93fc816bbe41a008ec2e42e2
> Author: Peter Zijlstra <peterz@infradead.org>
> Date:   Fri Jul 13 12:42:08 2018 +0200
> 
>     watchdog/softlockup: Fix cpu_stop_queue_work() double-queue bug
>     
>     When scheduling is delayed for longer than the softlockup interrupt
>     period it is possible to double-queue the cpu_stop_work, causing list
>     corruption.
>     
>     Cure this by adding a completion to track the cpu_stop_work's
>     progress.
>     
>     Reported-by: kernel test robot <lkp@intel.com>
>     Tested-by: Rong Chen <rong.a.chen@intel.com>
>     Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>     Cc: Linus Torvalds <torvalds@linux-foundation.org>
>     Cc: Peter Zijlstra <peterz@infradead.org>
>     Cc: Thomas Gleixner <tglx@linutronix.de>
>     Fixes: 9cf57731b63e ("watchdog/softlockup: Replace "watchdog/%u" threads with cpu_stop_work")
>     Link: http://lkml.kernel.org/r/20180713104208.GW2494@hirez.programming.kicks-ass.net
>     Signed-off-by: Ingo Molnar <mingo@kernel.org>
> 
> :040000 040000 6aca2dbb84bc33fe442b18b3d0a135c27adff7b9 2710af12d32e4b98df07768716689b213bce45fc M      kernel

The bugzilla reports have some additional details:
* https://bugzilla.redhat.com/show_bug.cgi?id=1671504
* https://bugzilla.kernel.org/show_bug.cgi?id=202679
* https://bugzilla.kernel.org/show_bug.cgi?id=202137

I'm happy to provide additional information or test a patch or two (as long as it doesn't
eat up my notebook ;))


Best regards
Thomas
