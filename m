Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8015EC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 599CB20885
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729493AbfKTPRm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 10:17:42 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:12128 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729006AbfKTPRm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 10:17:42 -0500
Received: from localhost (mailhub1-ext [192.168.12.233])
        by localhost (Postfix) with ESMTP id 47J5sY6tDmz9v2Xl;
        Wed, 20 Nov 2019 16:17:37 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id b9WuW4-B4Uio; Wed, 20 Nov 2019 16:17:37 +0100 (CET)
Received: from vm-hermes.si.c-s.fr (vm-hermes.si.c-s.fr [192.168.25.253])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47J5sY5ysFz9v2Xk;
        Wed, 20 Nov 2019 16:17:37 +0100 (CET)
Received: by vm-hermes.si.c-s.fr (Postfix, from userid 33)
        id 49EB08D6; Wed, 20 Nov 2019 16:17:41 +0100 (CET)
Received: from 37-172-92-181.coucou-networks.fr
 (37-172-92-181.coucou-networks.fr [37.172.92.181]) by messagerie.si.c-s.fr
 (Horde Framework) with HTTP; Wed, 20 Nov 2019 16:17:41 +0100
Date:   Wed, 20 Nov 2019 16:17:41 +0100
Message-ID: <20191120161741.Horde.zNDnbMKk_BJpkUOkWeRMsQ1@messagerie.si.c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v3 2/8] powerpc/vdso32: Add support for
 CLOCK_{REALTIME/MONOTONIC}_COARSE
References: <cover.1572342582.git.christophe.leroy@c-s.fr>
 <4644ccc9b4da78639ae9424db878c48711abf05a.1572342582.git.christophe.leroy@c-s.fr>
 <87eey2btxi.fsf@mpe.ellerman.id.au>
In-Reply-To: <87eey2btxi.fsf@mpe.ellerman.id.au>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.3)
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Ellerman <mpe@ellerman.id.au> a écrit :

> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>> This is copied and adapted from commit 5c929885f1bb ("powerpc/vdso64:
>> Add support for CLOCK_{REALTIME/MONOTONIC}_COARSE")
>> from Santosh Sivaraj <santosh@fossix.org>
>>
>> Benchmark from vdsotest-all:
>> clock-gettime-realtime: syscall: 3601 nsec/call
>> clock-gettime-realtime:    libc: 1072 nsec/call
>> clock-gettime-realtime:    vdso: 931 nsec/call
>> clock-gettime-monotonic: syscall: 4034 nsec/call
>> clock-gettime-monotonic:    libc: 1213 nsec/call
>> clock-gettime-monotonic:    vdso: 1076 nsec/call
>> clock-gettime-realtime-coarse: syscall: 2722 nsec/call
>> clock-gettime-realtime-coarse:    libc: 805 nsec/call
>> clock-gettime-realtime-coarse:    vdso: 668 nsec/call
>> clock-gettime-monotonic-coarse: syscall: 2949 nsec/call
>> clock-gettime-monotonic-coarse:    libc: 882 nsec/call
>> clock-gettime-monotonic-coarse:    vdso: 745 nsec/call
>>
>> Additional test passed with:
>> 	vdsotest -d 30 clock-gettime-monotonic-coarse verify
>
> This broke on 64-bit big endian, which uses the 32-bit VDSO, with errors
> like:
>
>   clock-gettime-monotonic-coarse/verify: 10 failures/inconsistencies  
> encountered
>   timestamp obtained from libc/vDSO not normalized:
>   	[-1574202155, 1061008673]
>   timestamp obtained from libc/vDSO predates timestamp
>   previously obtained from kernel:
>   	[74, 261310747] (kernel)
>   	[-1574202155, 1061008673] (vDSO)
>   timestamp obtained from libc/vDSO not normalized:
>   	[-1574202155, 1061008673]
>   timestamp obtained from libc/vDSO predates timestamp
>   previously obtained from kernel:
>   	[74, 261310747] (kernel)
>   	[-1574202155, 1061008673] (vDSO)
>   timestamp obtained from libc/vDSO not normalized:
>   	[-1574202155, 1061008673]
>   timestamp obtained from libc/vDSO predates timestamp
>   previously obtained from kernel:
>   	[74, 261310747] (kernel)
>   	[-1574202155, 1061008673] (vDSO)
>   timestamp obtained from libc/vDSO not normalized:
>   	[-1574202155, 1061008673]
>   timestamp obtained from libc/vDSO predates timestamp
>   previously obtained from kernel:
>   	[74, 261310747] (kernel)
>   	[-1574202155, 1061008673] (vDSO)
>   timestamp obtained from libc/vDSO not normalized:
>   	[-1574202155, 1061008673]
>   timestamp obtained from libc/vDSO predates timestamp
>   previously obtained from kernel:
>   	[74, 261310747] (kernel)
>   	[-1574202155, 1061008673] (vDSO)
>   Failure threshold (10) reached; stopping test.
>
>
> The diff below seems to fix it, but I'm not sure it's correct. ie. we
> just ignore the top part of the values, how does that work?

Your change makes sense, it is consistent with other functions using  
STAMP_XTIME.

It works because nanoseconds are max 999999999, it fits 32 bits regs.

Christophe

